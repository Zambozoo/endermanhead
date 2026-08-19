execute if score dist ehead2.math >= #maxDist ehead2.math run return 0

execute store result storage ehead:ehead2 rc.x int 0.001 run scoreboard players get floor.x ehead2.math
execute store result storage ehead:ehead2 rc.y int 0.001 run scoreboard players get floor.y ehead2.math
execute store result storage ehead:ehead2 rc.z int 0.001 run scoreboard players get floor.z ehead2.math
function ehead:ehead2/raycast/check with storage ehead:ehead2 rc

# stop the walk once we have hit the target block
execute if score #hit ehead2.math matches 1 run return 0

# ...or once the ray runs into an excluded block (blocked line of sight) — leaves rc.hit at 0
execute if score #blocked ehead2.math matches 1 run return 0

# step to the next voxel along the smallest tMax axis
execute if score tMax.x ehead2.math < tMax.y ehead2.math if score tMax.x ehead2.math < tMax.z ehead2.math run return run function ehead:ehead2/raycast/axis {axis:"x"}
execute if score tMax.y ehead2.math < tMax.x ehead2.math if score tMax.y ehead2.math < tMax.z ehead2.math run return run function ehead:ehead2/raycast/axis {axis:"y"}
execute if score tMax.z ehead2.math < tMax.x ehead2.math if score tMax.z ehead2.math < tMax.y ehead2.math run return run function ehead:ehead2/raycast/axis {axis:"z"}
