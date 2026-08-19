# runs as the observer flagged by looking_at/player: this player (no carved pumpkin) is looking right at
# some enderman-head wearer, but the predicate can't say which. find the exact wearer by binary-searching
# the view ray. probe a sphere centered on a point along the ray, tag every wearer inside it, and ask
# looking_at once from the observer's eyes: since looking_at resolves to the entity actually under the
# crosshair, a match means the target's feet sit inside this sphere. split the ray segment into near/far
# halves and recurse until the sphere is small, then iterate the few wearers left to tag the exact one.
#
# the moving execution position only restricts which wearers we tag; looking_at is always evaluated from
# the observer's real eyes. because the final sphere is centered on the ray next to the target, it
# contains the whole target hitbox (feet included) without any distance fudging.
#
# the gate calls this with `execute as @s` (executor set, position/rotation NOT), so we must `at @s` here
# to pin the caret probe to the observer's real position and facing — otherwise ^ ^ ^ marches from the
# tick function's context and the spheres never land on the target.
tag @s add ehead2.seen_observer
data modify storage ehead:ehead2 seen set value {radius:32}
execute at @s anchored eyes positioned ^ ^ ^32 run function ehead:ehead2/head/seen_search with storage ehead:ehead2 seen
tag @e remove ehead2.seen_tested
tag @e remove ehead2.seen_probe
tag @s remove ehead2.seen_observer
