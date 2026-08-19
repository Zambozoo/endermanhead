# runs as this enderman head's marker, at its position, on the rising edge of a look. emit one
# vibration here by summoning a marker and killing it in place; vanilla sculk sensors/shriekers within
# range detect it, with vanilla handling distance falloff and wool occlusion.
summon minecraft:marker ~ ~ ~ {Tags:["ehead2.pulse"]}
kill @e[type=marker,tag=ehead2.pulse]
