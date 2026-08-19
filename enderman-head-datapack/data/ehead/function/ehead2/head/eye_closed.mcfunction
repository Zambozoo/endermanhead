# reset the reaction (the cooldown has elapsed) and clear it so the next sighting re-triggers cleanly.
# the post effect swap is player-only (guarded); mobs just drop the latch.
execute if entity @s[type=minecraft:player] run posteffect remove @s ehead:eye_open
execute if entity @s[type=minecraft:player] run posteffect add @s ehead:eye_closed
tag @s remove ehead2.eye_open
scoreboard players set @s ehead2.eye_cd 0
