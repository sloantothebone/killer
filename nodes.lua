minetest.register_node("killer:killer", {
                tiles = {"killer_killer.png"},
                groups = {crumbly=1},
                description = "[!] Killer [!]",
                light_source = 5,
})

minetest.register_node("killer:antikiller", {
        tiles = {"killer_antikiller.png"},
        groups = {crumbly=1},
        description = "Antikiller",
})

minetest.register_node("killer:killall", {
        tiles = {"killer_killall.png"},
        groups = {crumbly=1},
        description = "Killall (Kill all virus blocks)",
        on_punch = function(pos, node, player, itemstack, pointed_thing)
                if not killall then   
                        killall = true
                        minetest.chat_send_player(player:get_player_name(), "Killall on")
                else
                        killall = false
                        minetest.chat_send_player(player:get_player_name(), "Killall off")
                end
        end,
        after_destruct = function(pos, oldnode)
                killall = false
        end,
})

minetest.register_node("killer:protector", {
        tiles = {"killer_protector.png"},   
        groups = {crumbly=1},
        description = "Protector (Range:5)",
})
  
minetest.register_node("killer:novirusblock", {
        tiles = {"killer_novirusblock.png"},   
        groups = {cracky=1},
        description = "Virus Protection Block",
})

minetest.register_node("killer:waterkiller", {
	tiles = {"killer_waterkiller.png"},
	groups = {cracky=1},
	description = "Watervirus",
})