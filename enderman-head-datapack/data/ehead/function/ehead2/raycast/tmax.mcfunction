# {axis: string}

$scoreboard players operation tMax.$(axis) ehead2.math = #inf ehead2.math
$execute if score step.$(axis) ehead2.math matches 0 run return 0

$scoreboard players operation tMax.$(axis) ehead2.math = floor.$(axis) ehead2.math
$scoreboard players operation tMax.$(axis) ehead2.math /= #scale ehead2.math
$execute if score step.$(axis) ehead2.math matches 1.. run scoreboard players add tMax.$(axis) ehead2.math 1
$scoreboard players operation tMax.$(axis) ehead2.math *= #scale ehead2.math
$scoreboard players operation tMax.$(axis) ehead2.math -= src.$(axis) ehead2.math
$scoreboard players operation tMax.$(axis) ehead2.math *= #scale ehead2.math
$scoreboard players operation tMax.$(axis) ehead2.math /= dir.$(axis) ehead2.math
