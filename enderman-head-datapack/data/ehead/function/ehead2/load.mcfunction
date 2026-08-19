# scratch objective for the raycast (DDA), radius math, and scan cursors
scoreboard objectives remove ehead2.math
scoreboard objectives add ehead2.math dummy

# raycast constants (#maxDist is set per-cast by ehead2/raycast/start from its max_dist arg)
scoreboard players set #inf ehead2.math 2147483647
scoreboard players set #scale ehead2.math 1000

# divisor for the seen-detection radius narrowing (halves the bracket each recursion)
scoreboard players set #two ehead2.math 2

# per-player pumpkin flag so these players don't activate looked at eheads
scoreboard objectives remove ehead2.wears_pumpkin
scoreboard objectives add ehead2.wears_pumpkin dummy

# per-enderman head marker reaction latch — set while a head is mid-reaction so it doesn't re-trigger
# until its cooldown elapses and re-arms it.
scoreboard objectives remove ehead2.ehead_looked_at
scoreboard objectives add ehead2.ehead_looked_at dummy

# per-enderman head marker reaction cooldown (ticks remaining). set when the head is first looked at and
# counted down each tick; when it hits 0 the head calms and re-arms. mirrors the worn-head eye cooldown.
scoreboard objectives remove ehead2.ehead_cd
scoreboard objectives add ehead2.ehead_cd dummy

# scratch for reading each enderman's AngerTime NBT each tick (selectors can't range-match NBT).
scoreboard objectives remove ehead2.anger
scoreboard objectives add ehead2.anger dummy

# per-wearer open-eye reaction cooldown (ticks remaining). set when a wearer is first seen and counted
# down each tick; when it hits 0 the eye resets to closed. transient (the eye post effect resets on
# reload anyway), so remove+add wipes any stale value.
scoreboard objectives remove ehead2.eye_cd
scoreboard objectives add ehead2.eye_cd dummy

# the angered flag persists in enderman NBT — clear it so a currently-angry enderman re-fires the
# angered edge on the next tick rather than being silently treated as already handled.
tag @e[type=minecraft:enderman] remove ehead2.angered

# the eye post effect resets on reload, but ehead2.wearing_head persists in entity NBT — clear it so any
# wearer (player or mob) still wearing a head re-triggers the put-on edge (re-applying the effect) next
# tick. ehead2.eye_open tracks which eye variant is applied; clear it too so the state can't go stale.
tag @e remove ehead2.wearing_head
tag @e remove ehead2.eye_open

# seen-detection tags also persist in entity NBT — clear them so a stale state from before the reload
# can't linger; the tick pass re-derives seen every tick (the observer/probe tags are transient).
tag @e remove ehead2.seen
tag @e remove ehead2.seen_observer
tag @e remove ehead2.seen_probe
tag @e remove ehead2.seen_tested