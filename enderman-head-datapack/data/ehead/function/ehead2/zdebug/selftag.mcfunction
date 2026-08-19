# run this AS a player. tag self, then read the tag back three ways in the same tick.
tag @s add dbg_selftag

execute if entity @s[nbt={Tags:["dbg_selftag"]}] run say 1 self nbt: SEES TAG
execute unless entity @s[nbt={Tags:["dbg_selftag"]}] run say 1 self nbt: MISSING

execute if entity @a[nbt={Tags:["dbg_selftag"]}] run say 2 all-players nbt scan: SEES TAG
execute unless entity @a[nbt={Tags:["dbg_selftag"]}] run say 2 all-players nbt scan: MISSING

execute if entity @e[type=player,nbt={Tags:["dbg_selftag"]}] run say 3 all-entities nbt scan: SEES TAG
execute unless entity @e[type=player,nbt={Tags:["dbg_selftag"]}] run say 3 all-entities nbt scan: MISSING

tag @s remove dbg_selftag
