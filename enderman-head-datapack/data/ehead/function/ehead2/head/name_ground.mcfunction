# runs as a dropped item entity that is an enderman head.
# a head on the ground should show the standard yellow "Enderman Head". only name it when it's
# unnamed (e.g. a name we stripped while it was framed); a present name — the give default or a
# player's anvil rename — is left untouched. italic:false so it renders upright, not slanted.
execute unless data entity @s Item.components."minecraft:custom_name" run data modify entity @s Item.components."minecraft:custom_name" set value {text:"Enderman Head",color:"yellow",italic:false}
