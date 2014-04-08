minetest.register_node("killer:killer", {
		tiles = {"killer_killer.png"},
		groups = {crumbly=1},
		description = "[!] Killer [!]",
		light_source = 14,
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

killall = false

local contain = function(t, s)
	for k, v in ipairs(t) do
		if v == s then
			return true
		else
			return false
		end
	end
end

minetest.register_abm({
	nodenames = {"killer:protector"},
	chance = 1,
	interval = 5,
	action = function(pos)
		for i=0, 5, 1 do
			if minetest.find_node_near(pos, 5, {"killer:killer"}) then
				minetest.remove_node(minetest.find_node_near(pos, 5, {"killer:killer"}))
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"killer:antikiller"},
	chance = 1,
	interval = 1,
	action = function(pos)
		local p = {
			pos1 = {x=pos.x, y=pos.y+1, z=pos.z},
			pos2 = {x=pos.x, y=pos.y-1, z=pos.z},
			pos3 = {x=pos.x+1, y=pos.y, z=pos.z},
			pos4 = {x=pos.x-1, y=pos.y, z=pos.z},
			pos5 = {x=pos.x, y=pos.y, z=pos.z+1},
			pos6 = {x=pos.x, y=pos.y, z=pos.z-1},
			}
		local is = false
		for k, v in pairs(p) do
			if minetest.get_node(v).name == "killer:killer" then
				minetest.set_node(v, {name="killer:antikiller"})
				is = true
			end
		end
		if not is then
			minetest.remove_node(pos)
		end
	end,
})

minetest.register_abm({
	nodenames = {"killer:killer"},
	chance = 1,
	interval = 5,
	action = function(pos)
		if killall then
			minetest.remove_node(pos)
		end
		if math.random(1, 5) == 1 then
			local p = {
				x=pos.x+math.random(-1, 1),
				y=pos.y+math.random(-1, 1),
				z=pos.z+math.random(-1, 1),
			}
			local t = {
				"killer:novirusblock",
				}
			if minetest.get_node(p).name ~= "killer:killer" and not contain(t, minetest.get_node(p).name) then
				minetest.set_node(p, {name="killer:killer"})
			end
		end
	end,
})

minetest.register_craft({
	output="killer:killer 1",
	recipe={
		{"default:gold_ingot", "default:steel_ingot", "default:gold_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:gold_ingot", "default:steel_ingot", "default:gold_ingot"},
	},
})

minetest.register_craft({
	output="killer:antikiller 1",
	recipe = {
		{"", "default:dirt", ""},
		{"default:dirt", "", "default:dirt"},
		{"", "default:dirt", ""},
		},
})

minetest.register_craft({
	output="killer:protector 2",
	recipe = {
		{"default:steel_ingot", "default:cobble", "default:steel_ingot"},
		{"default:cobble", "", "default:cobble"},
		{"default:steel_ingot", "default:cobble", "default:steel_ingot"},
		},
})

minetest.register_craft({
	output="killer:novirusblock 2",
	recipe = {
		{"default:stone", "default:obsidian", "default:stone"},
		{"", "", ""},
		{"", "", ""},
	},
})