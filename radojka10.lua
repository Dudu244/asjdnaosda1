local a = ui.new_checkbox("lua", "a", "Anti defensive")

local function spec()
    client.exec("jointeam 1 1")
end

local function anti_exploit()
    client.exec("cl_lagcompensation 0")
    -- cvar.cl_lagcompensation:set_raw_int(0) if the client.exec won't work
    print("Anti defensive is ready!")
end

client.set_event_callback("player_connect_full", function(e)
    if ui.get(a) then
        if client.userid_to_entindex(e.userid) == entity.get_local_player() then
            client.delay_call(0.1, spec)
            client.delay_call(0.2, anti_exploit)
        end
    end
end)

client.set_event_callback("shutdown", function()
    client.exec("cl_lagcompensation 1")
    -- cvar.cl_lagcompensation:set_raw_int(1) if the client.exec won't work
end)
