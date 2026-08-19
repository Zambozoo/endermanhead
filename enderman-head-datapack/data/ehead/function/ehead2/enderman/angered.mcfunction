# runs as an enderman the tick it becomes angered, at its feet. flag it so we never fire again, then
# emit a marker-death vibration at its head. this is the deliberate opposite of kill_marker: we WANT
# the death event a sculk sensor detects, and we want it originating from the enderman's head, so we
# summon the marker at the eye (head) position and kill it in place the same tick.
tag @s add ehead2.angered
execute anchored eyes positioned ^ ^ ^ run summon minecraft:marker ~ ~ ~ {Tags:["ehead2.anger_marker"]}
kill @e[type=minecraft:marker,tag=ehead2.anger_marker]
