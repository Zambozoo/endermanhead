# safely remove the marker running this function: fling it far skyward first, then kill it. a marker's
# death is a vibration a sculk sensor detects, so killing it in place next to sensors spuriously trips
# them (and neighbors) — killing it 20000 blocks up puts the death out of every sensor's range.
# run as the marker to remove (its own position is irrelevant after the teleport).
tp @s ~ 20000 ~
kill @s
