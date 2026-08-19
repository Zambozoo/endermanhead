# {axis: string}

# calculate the vector from source to dest
$scoreboard players operation dir.$(axis) ehead2.math = dest.$(axis) ehead2.math
$scoreboard players operation dir.$(axis) ehead2.math -= src.$(axis) ehead2.math

# calculate sign of dir vector
$scoreboard players set step.$(axis) ehead2.math 0
$execute if score dir.$(axis) ehead2.math matches 1.. run scoreboard players set step.$(axis) ehead2.math 1
$execute if score dir.$(axis) ehead2.math matches ..-1 run scoreboard players set step.$(axis) ehead2.math -1

# srcblock = floor(src.axis). MC scoreboard division floors toward -inf, so this is a true floor for
# both signs — no correction needed. (tmax adds the +1 for positive steps to find the next boundary.)
$scoreboard players operation floor.$(axis) ehead2.math = src.$(axis) ehead2.math
$scoreboard players operation floor.$(axis) ehead2.math /= #scale ehead2.math
$scoreboard players operation floor.$(axis) ehead2.math *= #scale ehead2.math

# tDelta.axis = abs(1 / dir.axis) if dir.axis != 0 else inf
$scoreboard players operation tDelta.$(axis) ehead2.math = #inf ehead2.math
$execute if score step.$(axis) ehead2.math matches 0 run return 0
$scoreboard players operation tDelta.$(axis) ehead2.math = #scale ehead2.math
$scoreboard players operation tDelta.$(axis) ehead2.math *= #scale ehead2.math
$scoreboard players operation tDelta.$(axis) ehead2.math /= dir.$(axis) ehead2.math
$scoreboard players operation tDelta.$(axis) ehead2.math *= step.$(axis) ehead2.math

$scoreboard players operation step.$(axis) ehead2.math *= #scale ehead2.math
