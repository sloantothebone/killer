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

minetest.register_abm({
	nodenames = {"killer:waterkiller"},
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
                local is_2 = false
                for k, v in pairs(p) do
                        if (minetest.get_node(v).name == "default:water_source" or minetest.get_node(v).name == "default:water_flowing") and not killall then
                                minetest.set_node(v, {name="killer:waterkiller"})
                                is_2 = true
                        end
                end
                if not is_2 then
                        minetest.remove_node(pos)
                end
	end,
})
