# runs each tick as a player currently wearing an enderman head. the eye is a latched reaction, not a
# live mirror of the seen state: when the wearer is first seen (rising edge, tracked by the absence of
# ehead2.eye_open) the eye opens and the head screams. while the wearer stays seen the eye is held open
# and the cooldown is pinned at 10, so it never re-triggers or re-screams mid-stare. only once the
# wearer is no longer seen does the 10-tick cooldown count down; when it elapses the eye resets to
# closed. the ehead2.seen tag is set by the look-at-player pass.
execute if entity @s[tag=ehead2.seen,tag=!ehead2.eye_open] run function ehead:ehead2/head/eye_open
execute if entity @s[tag=ehead2.seen,tag=ehead2.eye_open] run scoreboard players set @s ehead2.eye_cd 10
execute if entity @s[tag=!ehead2.seen,tag=ehead2.eye_open] run scoreboard players remove @s ehead2.eye_cd 1
execute if entity @s[tag=ehead2.eye_open] if score @s ehead2.eye_cd matches ..0 run function ehead:ehead2/head/eye_closed
