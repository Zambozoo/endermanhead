# {variable_name: string, scale: int} — @s is the reusable rc_marker; the execution position is the
# point we want to capture. snap the marker onto it, then read its Pos into scaled scores. no kill
# here: start retires the marker skyward and kills it once, away from any sensor.
tp @s ~ ~ ~

# store scaled position
$execute store result score $(variable_name).x ehead2.math run data get entity @s Pos[0] $(scale)
$execute store result score $(variable_name).y ehead2.math run data get entity @s Pos[1] $(scale)
$execute store result score $(variable_name).z ehead2.math run data get entity @s Pos[2] $(scale)
