# {x:int, y:int, z:int} — runs as the looking player
# raycast found a head block at (x,y,z).

# only the enderman head is castable, and it flips to an angry texture while looked at — so accept
# either the calm OR angry texture. Reject any other player head the ray struck.
$execute unless data block $(x) $(y) $(z) {profile:{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}} unless data block $(x) $(y) $(z) {profile:{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}} run return 0

# lazily create this head's marker on the first ever look, then register the look
$execute positioned $(x) $(y) $(z) unless entity @e[type=marker,tag=ehead2.ehead,distance=..0.5] run function ehead:ehead2/head/head_create
$execute positioned $(x) $(y) $(z) as @n[type=marker,tag=ehead2.ehead,distance=..0.5] at @s run function ehead:ehead2/head/head_looked
