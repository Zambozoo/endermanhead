# runs as an item_frame / glow_item_frame holding an enderman head.
# a framed head should show no name — so strip the name only if it's our standard "Enderman Head"
# (the give default). Any other custom_name means a player renamed it in an anvil; leave it be.
# match a subset of keys (no italic) so it holds whether or not the client keeps default-valued keys.
execute if data entity @s Item{components:{"minecraft:custom_name":{text:"Enderman Head",color:"yellow"}}} run data remove entity @s Item.components."minecraft:custom_name"
