# {x:int, y:int, z:int, target: block-predicate, exclude: block-predicate}
# test the current voxel. matching the target records the hit and stops the walk. otherwise, matching
# an excluded block blocks the ray (stop as a miss) so we can't see through walls. callers that should
# never be blocked pass a predicate that won't occur in world, e.g. minecraft:jigsaw.
$execute positioned $(x) $(y) $(z) if block ~ ~ ~ $(target) run function ehead:ehead2/raycast/hit
$execute positioned $(x) $(y) $(z) if score #hit ehead2.math matches 0 if block ~ ~ ~ $(exclude) run scoreboard players set #blocked ehead2.math 1
