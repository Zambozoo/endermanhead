# runs as a player each tick. keep the invert post-process shader in sync with whether they wear an
# enderman head in the helmet slot. the worn head flips to the angry texture while the wearer is seen,
# so accept either the calm OR angry texture as "wearing a head" (a scratch tag ORs the two checks).
# ehead2.wearing_head tracks the last-known worn state, so each posteffect command fires once on the
# put-on / take-off edge rather than every tick.
tag @s remove ehead2.head_slot
execute if items entity @s armor.head minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}] run tag @s add ehead2.head_slot
execute if items entity @s armor.head minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}] run tag @s add ehead2.head_slot
execute unless entity @s[tag=ehead2.wearing_head] if entity @s[tag=ehead2.head_slot] run function ehead:ehead2/head/wear_on
execute if entity @s[tag=ehead2.wearing_head] unless entity @s[tag=ehead2.head_slot] run function ehead:ehead2/head/wear_off
