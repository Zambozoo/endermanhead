# fire the angered edge for endermen: read each un-flagged enderman's AngerTime (a selector can't
# range-match NBT, so store it into a score), then flag+fire any whose timer just went positive. the
# flag makes this a one-shot per enderman so we stop re-checking it once it has been handled.
scoreboard players set @e[type=minecraft:enderman,tag=!ehead2.angered] ehead2.anger 0
execute as @e[type=minecraft:enderman,tag=!ehead2.angered] store result score @s ehead2.anger run data get entity @s AngerTime
execute as @e[type=minecraft:enderman,tag=!ehead2.angered,scores={ehead2.anger=1..}] at @s run function ehead:ehead2/enderman/angered

# refresh the pumpkin exemption: a carved pumpkin lets you look at an enderman head safely
scoreboard players set @a[type=minecraft:player] ehead2.wears_pumpkin 0
execute as @a[type=minecraft:player] if items entity @s armor.head minecraft:carved_pumpkin run scoreboard players set @s ehead2.wears_pumpkin 1

# a head broken while it was angry drops as an angry-textured item — revert it to the calm texture,
# so the head only ever looks angry while placed and being looked at. runs before the naming pass
# below so the reverted (now calm) drop is matched and named this same tick.
execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:profile":{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}}}}] run data modify entity @s Item.components."minecraft:profile" set value {properties:[{name:"textures",value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}

# keep the enderman head's name contextual (matched by its unique texture): none while framed, yellow
# "Enderman Head" while dropped — but never touch a name a player set in an anvil. see head/name_*.
execute as @e[type=minecraft:item_frame,nbt={Item:{components:{"minecraft:profile":{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}}}}] run function ehead:ehead2/head/name_frame
execute as @e[type=minecraft:glow_item_frame,nbt={Item:{components:{"minecraft:profile":{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}}}}] run function ehead:ehead2/head/name_frame
execute as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:profile":{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}}}}] run function ehead:ehead2/head/name_ground

# toggle the invert post-process shader as each player puts on / takes off an enderman head helmet
execute as @a[type=minecraft:player] run function ehead:ehead2/head/wear

# non-player mobs can wear an enderman head too. re-derive ehead2.wearing_head for them each tick from
# their helmet slot (calm or angry texture) so they become seen-candidates and get the texture flip —
# they skip the player-only invert shader and crosshair overlay, so no put-on / take-off edge is needed.
tag @e[type=!minecraft:player,tag=ehead2.wearing_head] remove ehead2.wearing_head
execute as @e[type=!minecraft:player] if items entity @s armor.head minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvN2E1OWJiMGE3YTMyOTY1YjNkOTBkOGVhZmE4OTlkMTgzNWY0MjQ1MDllYWRkNGU2YjcwOWFkYTUwYjljZiJ9fX0="}]}] run tag @s add ehead2.wearing_head
execute as @e[type=!minecraft:player] if items entity @s armor.head minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}] run tag @s add ehead2.wearing_head

# revert any activated (angry) enderman head a player carries outside the helmet slot: it can only get
# there by moving a worn head while seen, and nothing else would ever calm it. gated on holding an angry
# head so the per-slot scan is skipped for the common case. a bare `*` slot is invalid, and for a player
# container.* is only the hotbar + main inventory (slots 0-35) — the offhand (99) sits outside it — so
# we check both, with `unless` on the second so a head in both places can't run the scan twice.
execute as @a[type=minecraft:player] if items entity @s container.* minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}] run function ehead:ehead2/head/deactivate_carried
execute as @a[type=minecraft:player] unless items entity @s container.* minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}] if items entity @s weapon.offhand minecraft:player_head[minecraft:profile~{properties:[{value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTIwYmFmMmVkN2YyMzI2ODAzMTY1YWQ4MDFmYzA1NmQwMDIyNDNiZThjY2YyZDg3ZWEyNmI5Yzc2ZGMzZmE2ZSJ9fX0="}]}] run function ehead:ehead2/head/deactivate_carried

# a stashed head can also hide inside a bundle. calm any activated head in a bundle a player carries
# (heads in a bundle can never be the worn helmet, so this whole-inventory scan is always safe).
execute as @a[type=minecraft:player] run function ehead:ehead2/head/deactivate_bundles

# a head-wearer (player or mob) looked at by another player (who isn't wearing a carved pumpkin) becomes
# "seen". clear last tick's result, then let each observer the looking_at/player predicate flags — a
# non-pumpkin player looking at some head-wearer — pinpoint and tag the exact wearer they're looking at.
# the native looking_at predicate handles view alignment, line of sight, and range. seen drives the eye
# overlay and worn-head texture below.
tag @e remove ehead2.seen
execute as @a[type=minecraft:player] if predicate ehead:looking_at/player run function ehead:ehead2/head/seen

# flip every wearer's worn head to the angry/calm texture based on whether they're seen
execute as @e[tag=ehead2.wearing_head] run function ehead:ehead2/head/head_texture

# drive each wearer's seen reaction: the scream + cooldown fires for any wearer (player or mob); the
# eye post effect (closed = unseen, open = seen) is applied inside only for players.
execute as @e[tag=ehead2.wearing_head] run function ehead:ehead2/head/eye

# each eligible player raymarches from their eyes to find an enderman head they are looking at
execute as @a[type=minecraft:player,scores={ehead2.wears_pumpkin=0}] at @s run function ehead:ehead2/head/look

# tick every head marker: count down an active reaction (calming + re-arming it when the cooldown
# elapses) and cull markers whose head block is gone
execute as @e[type=marker,tag=ehead2.ehead] at @s run function ehead:ehead2/head/head_tick
