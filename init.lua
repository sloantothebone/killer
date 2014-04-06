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
	chance = 5,
	interval = 5,
	action = function(pos)
		local p = {
			x=pos.x+(math.random(1, 2)*math.random(-1, 1)),
			y=pos.y+(math.random(1, 2)*math.random(-1, 1)),
			z=pos.z+(math.random(1, 2)*math.random(-1, 1)),
		}
		if minetest.get_node(p).name ~= "killer:killer" then
			minetest.set_node(p, {name="killer:killer"})
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
