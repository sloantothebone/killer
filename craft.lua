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

minetest.register_craft({
	output="killer:waterkiller 1",
	recipe = {
		{"default:sand", "default:stone", "default:sand"},
		{"", "" ,""},
		{"", "", ""},
		},
})
