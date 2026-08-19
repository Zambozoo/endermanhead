# the target block was found at the current voxel (rc.x/y/z already hold its coords).
# record the hit and its scaled distance, and flag the walk to stop.
scoreboard players set #hit ehead2.math 1
data modify storage ehead:ehead2 rc.hit set value 1b
execute store result storage ehead:ehead2 rc.dist int 1 run scoreboard players get dist ehead2.math
