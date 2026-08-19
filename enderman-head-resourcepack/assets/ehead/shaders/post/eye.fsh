#version 330
#extension GL_ARB_separate_shader_objects : require

// Enderman-head vision: invert the whole screen, then draw an eye at the crosshair and cancel the
// vanilla crosshair so the eye reads cleanly. EyeOpen picks the shape: an OPEN eye (almond lid +
// pupil) while the wearer is seen, or a CLOSED eye (lash arc) otherwise. Crosshair position and
// size derive from Minecraft's own GUI-scale formula (from the framebuffer size), so this tracks
// Auto GUI Scale and any window size with no hardcoded knob.

uniform sampler2D InSampler;

layout(location = 0) in vec2 texCoord;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

layout(std140) uniform EyeConfig {
    float InverseAmount;
    float EyeOpen;
};

layout(location = 0) out vec4 fragColor;

// Effective GUI scale, matching vanilla Window.calculateScale (grow while width/(s+1) >= 320 and
// height/(s+1) >= 240). GUI_SETTING 0 = Auto; set it to 2/3/4 to pin a fixed scale.
const float GUI_SETTING = 0.0;
float guiScale() {
    float s = 1.0;
    for (int k = 0; k < 16; k++) {
        if (s == GUI_SETTING) break;
        float n = s + 1.0;
        if (OutSize.x / n >= 320.0 && OutSize.y / n >= 240.0) s = n; else break;
    }
    return s;
}

void main() {
    vec4 src = texture(InSampler, texCoord);

    // base enderman vision (whole-screen invert)
    vec3 base = mix(src.rgb, 1.0 - src.rgb, InverseAmount);
    vec3 outColor = base;

    // pixel offset from screen center (+x right, +y up)
    vec2 p = (texCoord - 0.5) * OutSize;

    float S = guiScale();

    // Vanilla crosshair: a 15px sprite blitted at ((guiW-15)/2, (guiH-15)/2) (integer division),
    // so its center sits at that top-left + 7.5. Convert to pixel offset from framebuffer center.
    float gw = ceil(OutSize.x / S);
    float gh = ceil(OutSize.y / S);
    float cxl = floor((gw - 15.0) / 2.0) + 7.5;
    float cyl = floor((gh - 15.0) / 2.0) + 7.5;
    vec2 center = vec2(cxl * S - OutSize.x * 0.5, OutSize.y * 0.5 - cyl * S);
    vec2 q = p - center;

    float eye = 0.0;

    if (EyeOpen > 0.5) {
        // OPEN eye: almond lid outline (top/bottom curves meeting at the corners) + filled pupil.
        float EYE_W  = 7.0 * S; // half-width of the eye
        float EYE_H  = 4.0 * S; // half-height of the eye (lid opening)
        float STROKE = 1.0 * S; // outline thickness
        float PUPIL  = 2.0 * S; // pupil radius
        if (abs(q.x) <= EYE_W) {
            float lid = EYE_H * (1.0 - (q.x / EYE_W) * (q.x / EYE_W));
            if (abs(abs(q.y) - lid) <= STROKE * 0.5) eye = 1.0;
        }
        if (length(q) <= PUPIL) eye = 1.0;
    } else {
        // CLOSED eye: a shallow downward lash arc, y = EYE_H*((x/EYE_W)^2 - 1) (dips at center).
        float EYE_W  = 7.0 * S; // half-width of the arc
        float EYE_H  = 3.0 * S; // arc depth (how far it dips)
        float STROKE = 1.0 * S; // line thickness
        if (abs(q.x) <= EYE_W) {
            float t = q.x / EYE_W;
            float lid = EYE_H * (t * t - 1.0);
            if (abs(q.y - lid) <= STROKE * 0.5) eye = 1.0;
        }
    }

    // vanilla crosshair footprint: a plus with 4.5px half-arms, 0.5px half-thickness (1px arms)
    float ARM   = 4.5 * S;
    float THICK = 0.5 * S;
    bool onXhair = (abs(q.x) <= ARM && abs(q.y) <= THICK) || (abs(q.y) <= ARM && abs(q.x) <= THICK);

    // The eye draws as non-inverted src against the inverted screen. Under the crosshair (which the
    // HUD later renders as 1-outColor) pre-invert so 1-outColor equals the eye either way, making
    // the crosshair vanish: visible = eye?src:base everywhere.
    if (onXhair)          outColor = (eye > 0.5) ? base : src.rgb;
    else if (eye > 0.5)   outColor = src.rgb;

    fragColor = vec4(outColor, 1.0);
}
