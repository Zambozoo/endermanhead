# run this AS the head-wearer, with the observer tagged dbg_obs and looking straight at you.
# CONTROL: does the observer's looking_at match the wearer's PERSISTENT wearing_head tag? this proves
# the observer is actually aimed at the wearer right now (rules out a bad-aim false negative).
scoreboard players set #ctrl ehead2.math 0
execute as @a[tag=dbg_obs] if predicate ehead:zdebug/look_tagged run scoreboard players set #ctrl ehead2.math 1

# FRESH: tag self THIS tick, then ask the observer's looking_at to see that fresh tag, same tick.
tag @s add dbg_fresh
scoreboard players set #fresh ehead2.math 0
execute as @a[tag=dbg_obs] if predicate ehead:zdebug/look_fresh run scoreboard players set #fresh ehead2.math 1
tag @s remove dbg_fresh

execute if score #ctrl ehead2.math matches 1 run say CONTROL ok: observer is aimed at wearer
execute if score #ctrl ehead2.math matches 0 run say CONTROL fail: observer NOT aimed - fix aim, ignore fresh
execute if score #fresh ehead2.math matches 1 run say FRESH: looking_at SEES same-tick tag
execute if score #fresh ehead2.math matches 0 run say FRESH: looking_at does NOT see same-tick tag
