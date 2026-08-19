# runs as this enderman head's marker, at its position, when a player is looking at it

# rising edge: react only if the head isn't already mid-reaction (latched by a running cooldown)
execute if score @s ehead2.ehead_looked_at matches 0 run playsound minecraft:entity.enderman.scream hostile @a ~ ~ ~ 2 1

# turn the head angry while it reacts. only the block entity profile changes, so the head's
# rotation/facing is preserved. the cooldown pass restores the calm texture once it elapses.
execute if score @s ehead2.ehead_looked_at matches 0 run data modify block ~ ~ ~ profile set value {properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}

# rising edge only: trigger every nearby sensor once, as this head goes from calm to looked-at
execute if score @s ehead2.ehead_looked_at matches 0 run function ehead:ehead2/head/activate

# every tick it's looked at: pin the reaction cooldown at 10 so a continuous stare holds the head angry
# and never lets head/head_tick reach 0 mid-stare (which would calm + re-scream, causing a flicker). the
# countdown only makes progress once the head is no longer being looked at.
scoreboard players set @s ehead2.ehead_cd 10

# latch the head as reacting; the cooldown pass clears this once it elapses so a later look re-triggers
scoreboard players set @s ehead2.ehead_looked_at 1
