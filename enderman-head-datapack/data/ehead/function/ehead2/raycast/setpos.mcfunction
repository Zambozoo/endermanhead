# stores the position of the command's execution under $(variable_name).xyz at $(scale), using the
# reusable rc_marker that start summoned once for this cast (no per-read summon/kill).
# {variable_name : string, scale: int}

$execute as @n[type=marker,tag=ehead2.rc_marker] run function ehead:ehead2/raycast/setpos_marker {variable_name:$(variable_name),scale:$(scale)}
