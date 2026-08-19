# DEBUG: run as yourself while looking at an enderman head. Prints the measured distance to the head.
data modify storage ehead:ehead2 rc set value {target:"#ehead:heads",max_dist:32,exclude:"#ehead:opaque"}
execute anchored eyes run function ehead:ehead2/raycast/start with storage ehead:ehead2 rc
execute unless data storage ehead:ehead2 rc{hit:1b} run return run tellraw @s [{"text":"look: ","color":"gray"},{"text":"no enderman head in range","color":"red"}]

# rc.dist is scaled by #scale; unscale it back to blocks
execute store result score #d ehead2.math run data get storage ehead:ehead2 rc.dist
scoreboard players operation #d ehead2.math /= #scale ehead2.math
tellraw @s [{"text":"look: dist=","color":"gray"},{"score":{"name":"#d","objective":"ehead2.math"},"color":"yellow"},{"text":" blocks","color":"gray"}]
