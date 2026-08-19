# {axis: string}
$scoreboard players operation floor.$(axis) ehead2.math += step.$(axis) ehead2.math
$scoreboard players operation dist ehead2.math = tMax.$(axis) ehead2.math
$scoreboard players operation tMax.$(axis) ehead2.math += tDelta.$(axis) ehead2.math
function ehead:ehead2/raycast/iter
