# runs as a player on the tick they take off an enderman head. drop the enderman-head vision by removing
# whichever eye variant is currently applied, and clear the variant-tracking tag and reaction cooldown
# (so a cooldown running when the head comes off can't linger into the next time they wear one).
posteffect remove @s ehead:eye_closed
posteffect remove @s ehead:eye_open
tag @s remove ehead2.wearing_head
tag @s remove ehead2.eye_open
scoreboard players set @s ehead2.eye_cd 0
