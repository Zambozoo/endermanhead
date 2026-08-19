# {target: block-predicate string, max_dist: int (blocks), exclude: block-predicate string}
# exclude blocks the ray (miss) if hit before the target — prevents seeing through walls. pass a
# predicate that never occurs (e.g. minecraft:jigsaw) for a cast that should pass through everything.
# Reusable DDA voxel raycast. Casts from the current execution position toward local ^ ^ ^1
# (so the caller controls origin/facing, e.g. `execute anchored eyes run function .../raycast/start`).
# Reads target/max_dist from storage ehead:ehead2 rc; writes results back to the same object:
#   rc.hit  (0b/1b), rc.x rc.y rc.z (hit block coords, valid when hit), rc.dist (scaled distance).

# one reusable marker for both position reads. summoning is silent, but killing a marker next to a
# sculk sensor emits a vibration — so we summon once, snap it to each read point, then remove it via
# kill_marker (which flings it skyward before killing so no sensor is in range of its death).
summon minecraft:marker ~ ~ ~ {Tags:["ehead2.rc_marker"]}

# src = here, dest = one block forward along the current facing
execute positioned ^ ^ ^ run function ehead:ehead2/raycast/setpos {variable_name:"src",scale:1000}
execute positioned ^ ^ ^1 run function ehead:ehead2/raycast/setpos {variable_name:"dest",scale:1000}

# positions are now captured into scores — retire the marker safely
execute as @n[type=marker,tag=ehead2.rc_marker] run function ehead:ehead2/kill_marker

# per-axis DDA setup: tDelta.axis, step.axis, tMax.axis
function ehead:ehead2/raycast/tdelta {axis:"x"}
function ehead:ehead2/raycast/tdelta {axis:"y"}
function ehead:ehead2/raycast/tdelta {axis:"z"}
function ehead:ehead2/raycast/tmax {axis:"x"}
function ehead:ehead2/raycast/tmax {axis:"y"}
function ehead:ehead2/raycast/tmax {axis:"z"}

# max distance (scaled) and fresh outputs
$scoreboard players set #maxDist ehead2.math $(max_dist)
scoreboard players operation #maxDist ehead2.math *= #scale ehead2.math
scoreboard players set dist ehead2.math 0
scoreboard players set #hit ehead2.math 0
scoreboard players set #blocked ehead2.math 0
data modify storage ehead:ehead2 rc.hit set value 0b

# walk the voxels
function ehead:ehead2/raycast/iter
