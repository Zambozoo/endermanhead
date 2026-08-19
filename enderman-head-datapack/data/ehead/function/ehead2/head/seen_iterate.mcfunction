# runs as the observer, positioned at the small base sphere on the view ray that holds the target. only
# a handful of wearers sit within $(radius) of here, so test them one at a time: tag the nearest untested
# wearer alone, ask looking_at from the observer's eyes, and the one that matches is the target - tag it
# ehead2.seen. mark each candidate tested so the next pass advances, and recurse until we match or run
# out. seen_tested is cleared back in seen.mcfunction once the whole search unwinds.
$execute as @e[tag=ehead2.wearing_head,tag=!ehead2.seen_observer,tag=!ehead2.seen_tested,distance=..$(radius),limit=1,sort=nearest] run tag @s add ehead2.seen_probe
scoreboard players set #looking ehead2.math 0
execute if predicate ehead:looking_at/target run scoreboard players set #looking ehead2.math 1
execute if score #looking ehead2.math matches 1 run tag @e[tag=ehead2.seen_probe] add ehead2.seen
tag @e[tag=ehead2.seen_probe] add ehead2.seen_tested
tag @e[tag=ehead2.seen_probe] remove ehead2.seen_probe
$execute if score #looking ehead2.math matches 0 if entity @e[tag=ehead2.wearing_head,tag=!ehead2.seen_observer,tag=!ehead2.seen_tested,distance=..$(radius)] run function ehead:ehead2/head/seen_iterate with storage ehead:ehead2 seen
