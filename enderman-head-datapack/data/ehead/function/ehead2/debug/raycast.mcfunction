# DEBUG: run as yourself. Raycast from your eyes; explode at the block you hit, or report a miss.
# Swap target for any block or #block-tag you want to aim the ray at.
data modify storage ehead:ehead2 rc set value {target:"#ehead:heads",max_dist:32,exclude:"#ehead:opaque"}
execute anchored eyes run function ehead:ehead2/raycast/start with storage ehead:ehead2 rc

execute if data storage ehead:ehead2 rc{hit:1b} run function ehead:ehead2/debug/raycast_hit with storage ehead:ehead2 rc
execute unless data storage ehead:ehead2 rc{hit:1b} run tellraw @s [{"text":"raycast: ","color":"gray"},{"text":"miss","color":"red"}]
