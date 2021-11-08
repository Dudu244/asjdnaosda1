local a = {
	DoubleTap = {ui.reference("RAGE", "OTHER", "Double tap")},
    fakelag_enable = ui.reference("AA", "Fake lag", "Enabled"),
    fakelag_type = ui.reference("AA", "Fake lag", "Amount"),
    fakelag_limit = ui.reference("AA", "Fake lag", "Limit"),
    fakelag_variance = ui.reference("AA", "Fake lag", "Variance"),
    Fakeduck = ui.reference("RAGE", "OTHER", "Duck peek assist"),
    pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch"),
    yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base"),
    yaw = {ui.reference("AA", "Anti-aimbot angles", "Yaw")},
    yaw_jitter = {ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")},
    body = {ui.reference("AA", "Anti-aimbot angles", "Body yaw")},
    limit = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit"),
    autodirection = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")},
    edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw"),
    FreestandingBodyYaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw"),
    Enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled"),
    body_slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw"),
    slowmotion_type = ui.reference("AA", "Other", "Slow motion type"),
    Onshot = {ui.reference("AA", "Other", "On shot anti-aim")},
    DoubleTap = {ui.reference("RAGE", "OTHER", "Double tap")}
}
local b = {
    main_toggle = ui.new_checkbox("AA", "Other", "[kvasibo] Flick"),
    mAAEPeekFreestand = ui.new_hotkey("AA", "Other", "Enable"),
    mAAEPeekInvert = ui.new_hotkey("AA", "Other", "Inverter"),
    EPeekCombo = ui.new_combobox("AA", "Other", "Mode", "Flick")
}
local c = require "gamesense/surface"
local d = c.draw_text
local e = c.create_font("Tahoma", 12, 700, {0x200})
local f = c.create_font("Tahoma", 15, 700, {0x200})
local function g()
    local h = ui.get(b.main_toggle)
    ui.set_visible(b.mAAEPeekInvert, h)
    ui.set_visible(b.mAAEPeekFreestand, h)
    ui.set_visible(b.EPeekCombo, h)
end
client.set_event_callback("pre_render", g)
local function i()
    local j = globals.tickcount() % 19
    local k, l = client.screen_size()
    local m = {k / 2, l / 2}
    local n = ui.get(a.yaw[2])
    local o = {255 - (n + 212) / j * 2.29824561404, (n + 212) / j * 3.42105263158, (n + 212) / j * 0.22807017543}
    local p = ui.get(b.mAAEPeekFreestand)
    if p and ui.get(a.DoubleTap[2]) then
        if ui.get(b.mAAEPeekInvert) then
            d(m[1] - 48, m[2] + 13, o[1], o[2], o[3], 255, f, "<-")
        end
        if not ui.get(b.mAAEPeekInvert) then
            d(m[1] + 41, m[2] + 13, o[1], o[2], o[3], 255, f, "->")
        end
        if not p then
            ui.set(a.yaw[2], "0")
        end
        if j == 5 and ui.get(a.DoubleTap[2]) and p or j == 10 and ui.get(a.DoubleTap[2]) and p then
            ui.set(a.yaw[1], "180")
            if ui.get(b.mAAEPeekInvert) then
                ui.set(a.yaw[2], "-90")
            end
            if not ui.get(b.mAAEPeekInvert) then
                ui.set(a.yaw[2], "90")
            end
            client.exec("-use")
        else
            if ui.get(b.EPeekCombo) == "Flick" then
                ui.set(a.yaw[2], "0")
            elseif ui.get(b.EPeekCombo) == "Legit" then
                ui.set(a.yaw[2], "180")
            end
        end
    end
end
client.set_event_callback("paint", i)

