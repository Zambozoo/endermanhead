# runs each tick as an enderman head marker, at its position. cull the marker if its block is gone;
# otherwise, while the head is mid-reaction, count its cooldown down and — when it elapses — calm the
# head and re-arm it so a later look re-triggers. mirrors the worn-head eye cooldown (head/eye.mcfunction).

# cull the marker if its head block is gone
execute unless block ~ ~ ~ minecraft:player_head unless block ~ ~ ~ minecraft:player_wall_head run return run function ehead:ehead2/kill_marker

# not reacting -> nothing to tick
execute unless score @s ehead2.ehead_looked_at matches 1 run return 0

# reacting: tick the cooldown down; keep the head angry until it elapses
scoreboard players remove @s ehead2.ehead_cd 1
execute if score @s ehead2.ehead_cd matches 1.. run return 0

# cooldown elapsed: restore the calm texture (guarded to the angry -> calm transition, preserving
# rotation/facing since only the profile changes) and re-arm so the next look re-triggers the reaction
execute if data block ~ ~ ~ {profile:{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}} run data modify block ~ ~ ~ profile set value {properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}
scoreboard players set @s ehead2.ehead_looked_at 0
