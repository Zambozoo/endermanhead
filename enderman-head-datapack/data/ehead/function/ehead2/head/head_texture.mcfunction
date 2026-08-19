# runs as any enderman-head wearer (player or mob). flip the worn head to the angry texture while seen
# and back to calm while not, writing only on the actual transition by guarding on the head's current
# texture (item modify preserves other components).
execute if entity @s[tag=ehead2.seen] if items entity @s armor.head minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}] run item modify entity @s armor.head ehead:head_angry
execute unless entity @s[tag=ehead2.seen] if items entity @s armor.head minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}] run item modify entity @s armor.head ehead:head_calm
