local enable = ui.new_checkbox("AA", "Other", "[beta] Kvasibo Resolver")

local angles = { [0] = -58, [1] = 58, [2] = -48, [3] = 48, [4] = -40, [5] = 40, [6] = -15, [7] = 15, [8] = -30, [9] = 30, [10] = -19, [11] = 19, [12] = 0 } -- magic values
local last_angle = 0
local new_angle = 0

local function resolve(player)
    plist.set(player, "Correction active", false) -- disable default correction because i have a superiority complex
    plist.set(player, "Force body yaw", true) -- enable the forcing of the body yaw
    new_angle = angles[math.random(0, 10)]
    client.color_log(0, 255, 204, "[Kvasibo Resolver] missed player: " .. entity.get_player_name(player) .. ", at angle: " .. last_angle .. ", bruteforced to: " .. new_angle)
    plist.set(player, "Force body yaw value", new_angle) -- force yaw value to random
    last_angle = new_angle
end

client.set_event_callback("aim_miss", function(info)
    if not ui.get(enable) or info.reason ~= "?" then -- make sure we missed due to resolver :o
        return
    end
    resolve(info.target) -- resolve that noob
end)

local chat = require "gamesense/chat"
local hitgroup_names = {"generic", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear"}

client.set_event_callback("player_hurt", function(e)
	if e.userid ~= e.attacker and client.userid_to_entindex(e.attacker) == entity.get_local_player() then
		local dmg, hp = e.dmg_health, e.health
		local name = entity.get_player_name(client.userid_to_entindex(e.userid))
		local hitgroup = hitgroup_names[e.hitgroup+1] or "gear"

		chat.print("{darkred}Kvasibo {white}- {lightgreen}Hit {darkred}", name, "{lightgreen} in the {darkred}", hitgroup, "{lightgreen} for {darkred}", dmg, "{lightgreen} damage (", hp, " health remaining)")
		
	end
end)
