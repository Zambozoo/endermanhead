# runs as the observer, with the execution position sitting on the view ray at this node's probe center.
# tag every candidate wearer within $(radius) of here, ask looking_at once from the observer's eyes, then
# clear the tags. #looking==1 means the looked-at wearer's feet are inside this sphere.
$tag @e[tag=ehead2.wearing_head,tag=!ehead2.seen_observer,distance=..$(radius)] add ehead2.seen_probe
scoreboard players set #looking ehead2.math 0
execute if predicate ehead:looking_at/target run scoreboard players set #looking ehead2.math 1
tag @e remove ehead2.seen_probe

# nothing more to do on a miss. on a hit: iterate if the sphere is small, else split the ray segment.
scoreboard players set #radius ehead2.math 0
$scoreboard players set #radius ehead2.math $(radius)
execute if score #looking ehead2.math matches 1 if score #radius ehead2.math matches ..4 run function ehead:ehead2/head/seen_iterate with storage ehead:ehead2 seen

# prepare the child radius (half) and the caret step (+half forward / -half back) for the split.
scoreboard players operation #half ehead2.math = #radius ehead2.math
scoreboard players operation #half ehead2.math /= #two ehead2.math
scoreboard players set #neg ehead2.math 0
scoreboard players operation #neg ehead2.math -= #half ehead2.math
execute store result storage ehead:ehead2 seen.radius int 1 run scoreboard players get #half ehead2.math
execute store result storage ehead:ehead2 seen.step int 1 run scoreboard players get #half ehead2.math
execute store result storage ehead:ehead2 seen.negstep int 1 run scoreboard players get #neg ehead2.math
execute if score #looking ehead2.math matches 1 if score #radius ehead2.math matches 5.. run function ehead:ehead2/head/seen_split with storage ehead:ehead2 seen
