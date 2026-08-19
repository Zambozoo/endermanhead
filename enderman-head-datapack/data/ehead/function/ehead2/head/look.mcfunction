# runs as a player, at their feet — raycast from the eyes for an enderman head they look at.
# the eye is always at the hitbox's x/z center, so origin never needs a horizontal offset. for height,
# `anchored eyes` reads the pose-correct eye for upright/sneaking (1.62 / 1.27) but MISREADS the
# crawl/swim/glide pose (it resolves to feet/standing instead of the real 0.4 crawl eye), which starts
# the ray ~0.4 too low and misses the top half of a head block. so detect a prone pose via its short
# hitbox and cast it from the real 0.4 eye height manually; keep anchored eyes for the tall poses.
data modify storage ehead:ehead2 rc set value {target:"#ehead:heads",max_dist:32,exclude:"#ehead:opaque"}

# prone hitbox is only 0.6 tall, so it doesn't reach the feet+1..1.5 probe box; tall poses do.
scoreboard players set #prone ehead2.math 1
execute positioned ~ ~1 ~ if entity @s[dy=0.5] run scoreboard players set #prone ehead2.math 0

execute if score #prone ehead2.math matches 0 anchored eyes run function ehead:ehead2/raycast/start with storage ehead:ehead2 rc
execute if score #prone ehead2.math matches 1 positioned ~ ~0.4 ~ run function ehead:ehead2/raycast/start with storage ehead:ehead2 rc

execute if data storage ehead:ehead2 rc{hit:1b} run function ehead:ehead2/head/head_hit with storage ehead:ehead2 rc
