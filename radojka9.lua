--ULTRA XTREME PRIBATE SKRIPT DON'T LEEK
local screenx, screeny = client.screen_size()
local double_tap, double_tap_key = ui.reference("Rage","Other","Double tap")
local fakeducking = ui.reference("RAGE", "Other", "Duck peek assist")
local amount = ui.reference("aa", "Fake lag", "Amount")
local limit = ui.reference("aa", "Fake lag", "Limit")
local box, key = ui.reference( "Rage", "Other", "Quick peek assist" )
local exploit = ui.new_checkbox("LUA", "A", "ideal tick")
local exploit_key = ui.new_hotkey("LUA", "A", "ideal tick key", true)

local function setup()

    if not entity.is_alive(entity.get_local_player()) then
        return
    end

    local getstate = ui.get(exploit) and ui.get(exploit_key) and not ui.get(fakeducking)

    ui.set(key, getstate and 'Always on' or 'On hotkey')
    ui.set(double_tap_key, getstate and 'Always on' or 'toggle')
    ui.set(limit, getstate and 1 or 14)

    renderer.text(screenx/2-20, screeny/2+15, 255, 255, 255, getstate and 255 or 0, "-", nil, "IDEALTICK")
end

client.set_event_callback("paint", setup)
