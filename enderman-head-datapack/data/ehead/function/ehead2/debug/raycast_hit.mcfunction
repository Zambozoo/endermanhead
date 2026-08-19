# {x:int, y:int, z:int} — DEBUG: boom at the block the ray struck and print its coords
$particle minecraft:explosion_emitter $(x) $(y) $(z)
$tellraw @s [{"text":"raycast hit: ","color":"gray"},{"text":"$(x) $(y) $(z)","color":"green"}]
