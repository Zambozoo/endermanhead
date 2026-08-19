# fire the reaction as any wearer (player or mob) is first seen: the head screams and a 10-tick cooldown
# starts (counted down by the eye pass, which resets to closed at 0). the open-eye post effect is
# player-only — mobs have no shader/crosshair — so it's guarded, but the scream fires for everyone.
execute if entity @s[type=minecraft:player] run posteffect remove @s ehead:eye_closed
execute if entity @s[type=minecraft:player] run posteffect add @s ehead:eye_open
tag @s add ehead2.eye_open
scoreboard players set @s ehead2.eye_cd 10
# the eye pass runs `as @s` without a position, so pin the sound to the wearer with `at @s` — otherwise
# `~ ~ ~` resolves to the tick function's origin and the scream is inaudible.
execute at @s run playsound minecraft:entity.enderman.scream hostile @a ~ ~ ~ 2 1
