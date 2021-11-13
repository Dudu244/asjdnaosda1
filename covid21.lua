local yawjitter = {ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")}
local variance = ui.reference("AA", "Fake lag", "Variance")
local fakelag = ui.reference("AA", "Fake lag", "Limit")
local checkbox_reference, hotkey_reference = ui.reference("AA", "Other", "Slow motion")
local math_sqrt = math.sqrt
local limit_reference = ui.new_slider("AA", "Fake Lag", "KvasiboFL", 1, 60, 37, 60)
local function modify_velocity(cmd, goalspeed)
    if goalspeed <= 0 then
        return
    end
    local minimalspeed = math_sqrt((cmd.forwardmove * cmd.forwardmove) + (cmd.sidemove * cmd.sidemove))
    if minimalspeed <= 0 then
        return
    end
    if cmd.in_duck == 1 then
        goalspeed = goalspeed * 2.94117647 
    end
    if minimalspeed <= goalspeed then
        return
    end
    local speedfactor = goalspeed / minimalspeed
    cmd.forwardmove = cmd.forwardmove * speedfactor
    cmd.sidemove = cmd.sidemove * speedfactor
end
local mordann = ui.new_label("AA", "Anti-aimbot angles", "-------------------KvasiboSlow-----------")
local min = ui.new_slider("AA", "anti-aimbot angles", "Slow min", 1, 60, 30, 60, "", 1, {[30] = "30 (Kvasibo)"})
local max = ui.new_slider("AA", "anti-aimbot angles", "Slow max", 1, 60, 50, 60, "", 1, {[50] = "50 (Kvasibo)"})
local testt = ui.new_label("AA", "Anti-aimbot angles", "-------------------KvasiboSlow-----------")
local function on_setup_cmd(cmd)
    local checkbox = ui.get(checkbox_reference)
    local hotkey = ui.get(hotkey_reference)
    local limit = ui.get(limit_reference)
    local min_g = ui.get(min)
    local max_g = ui.get(max)
    if ui_get(checkbox_reference) then
        ui_set(
            limit_reference,
            math.floor(math.random(min_g < max_g and min_g or max_g, min_g < max_g and max_g or min_g))
        )
    end
    if limit >= 57 then
        return
    end
    if checkbox and hotkey then
        modify_velocity(cmd, limit)
    end
end
client.set_event_callback("setup_command", on_setup_cmd)
local function is_crouching(player)
    local flags = entity_get_prop(player, "m_fFlags")
    if bit_band(flags, 4) == 4 then
        return true
    end
    return false
end
local function in_air(player)
    local flags = entity_get_prop(player, "m_fFlags")
    if bit_band(flags, 1) == 0 then
        return true
    end
    return false
end
local function on_ground(player)
    local flags = entity_get_prop(player, "m_fFlags")
    if bit_band(flags, 1) == 1 then
        return true
    end
    return false
end
local aa, fake_walk = ui_reference("AA", "other", "slow motion")
local aa_body_limit = ui_reference("AA", "Anti-aimbot angles", "fake yaw limit")
local aa_yaw, aa_yaw_offset = ui_reference("AA", "Anti-aimbot angles", "Yaw")
local freestanding_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local freestand = {ui.reference("AA", "Anti-aimbot angles", "Freestanding")}
local fs_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local aa_fake_yaw, aa_fake_yaw_slider = ui_reference("AA", "Anti-aimbot angles", "body yaw")
local aa_yaw_jitter, aa_yaw_jitter_offset = ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")
legit_e_key = ui.new_checkbox("AA", "Anti-aimbot angles", "Legit anti-aim")
freestanding_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local sexkey = ui.new_hotkey("AA", "Anti-aimbot angles", "Legit anti-aim", true)
local fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
client.set_event_callback(
    "setup_command",
    function(e)
        local weaponn = entity.get_player_weapon()
        if ui.get(legit_e_key) then
            if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
                if e.in_attack == 1 then
                    e.in_attack = 0
                    e.in_use = 1
                end
            else
                if e.chokedcommands == 0 then
                    e.in_use = 0
                end
            end
            ui.set(freestanding_body_yaw, true)
        end
    end
)
local check = ui.new_checkbox("AA", "Anti-aimbot angles", "Edge yaw")
local hotkey = ui.new_hotkey("AA", "Anti-aimbot angles", "Edge yaw", true)
local edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
local function set_og_menu(state)
            ui_set_visible(aa_pitch, state)
            ui_set_visible(aa_yaw, state)
            ui_set_visible(aa_yaw_offset, state)
            ui_set_visible(aa_yaw_jitter, state)
            ui_set_visible(aa_yaw_jitter_offset, state)
            ui_set_visible(aa_fake_yaw, state)
            ui_set_visible(aa_fake_yaw_slider, state)
            ui_set_visible(aa_fs_byaw, state)
            ui_set_visible(aa_fake_limit, state)
            ui_set_visible(aa_yaw_base, state)
            ui_set_visible(variance, state)
            ui_set_visible(fakelag, state)
            ui_set_visible(edge, state)
end
set_og_menu(false)
client_set_event_callback(
    "setup_command",
    function(c)
	
        local crouching_ct =
            is_crouching(entity_get_local_player()) and entity_get_prop(entity_get_local_player(), "m_iTeamNum") == 3
        local crouching_t =
            is_crouching(entity_get_local_player()) and entity_get_prop(entity_get_local_player(), "m_iTeamNum") == 2
        local DT = ui.reference("RAGE", "Other", "Double Tap")
        if ui_get(fake_walk) then
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Pitch"), "Down")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw Base"), "at targets")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw"), "180")
            ui_set(aa_yaw_offset, 0)
            ui_set(aa_yaw_jitter_offset, 0)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw jitter"), "Off")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Body Yaw"), "Static")
            ui_set(aa_fake_yaw_slider, 180)
            ui_set(aa_body_limit, math.random(7, 17))
            ui_set(freestanding_body_yaw, false)
            ui_set(variance, math.random(5, 12))
            ui_set(fakelag, math.random(13, 14))
            set_og_menu(false)
        elseif in_air(entity_get_local_player()) then
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Pitch"), "Down")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw Base"), "at targets")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw"), "180")
            ui_set(aa_yaw_offset, 0)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw jitter"), "Random")
            ui_set(aa_yaw_jitter_offset, 20)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Body Yaw"), "Static")
            ui_set(aa_fake_yaw_slider, 60)
            ui_set(aa_body_limit, math.random(58, 60))
            ui_set(freestanding_body_yaw, false)
            ui_set(variance, 2)
            ui_set(fakelag, math.random(12, 14))
            set_og_menu(false)
               elseif ui.get(fakeduck) then
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Pitch"), "Down")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw Base"), "at targets")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw"), "180")
            ui_set(aa_yaw_offset, 0)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw jitter"), "Random")
            ui_set(aa_yaw_jitter_offset, 20)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Body Yaw"), "Static")
            ui_set(aa_fake_yaw_slider, 60)
            ui_set(aa_body_limit, math.random(58, 60))
            ui_set(freestanding_body_yaw, false)
            ui_set(variance, 2)
            ui_set(fakelag, 14)
            set_og_menu(false)
        elseif crouching_t or crouching_ct then
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Pitch"), "Down")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw Base"), "at targets")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw"), "180")
            ui_set(aa_yaw_offset, 0)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw jitter"), "Offset")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Body Yaw"), "Static")
            ui_set(aa_fake_yaw_slider, math.random(-5, 2))
            ui_set(aa_body_limit, math.random(0, 2))
            ui_set(aa_yaw_jitter_offset, math.random(-1, 1))
            ui_set(freestanding_body_yaw, false)
            ui_set(variance, 0)
            ui_set(fakelag, 14)
            set_og_menu(false)
        elseif not crouching_t or crouching_ct and not in_air(entity_get_local_player()) then
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Pitch"), "Down")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw Base"), "at targets")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw"), "180")
            ui_set(aa_yaw_offset, 0)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw jitter"), "Offset")
            ui_set(aa_yaw_jitter_offset, 0)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Body Yaw"), "Opposite")
            ui_set(aa_fake_yaw_slider, 1)
            ui_set(aa_body_limit, math.random(21, 26))
            ui_set(freestanding_body_yaw, true)
            ui_set(variance, 11)
            ui_set(fakelag, math.random(12, 14))
            set_og_menu(false)
        end
    end
)
local sx, sy = client_screen_size()
local cx, cy = sx / 2, sy / 2 - 2
function round(num, numDecimalPlaces)
    local mult = 1 ^ (numDecimalPlaces or 50)
    return math.floor(num * mult + 0.8) / mult
end
local state = false
local last_state = false
local function on_setup_command(c)
    state = ui.get(hotkey)
    if state ~= last_state then
        ui.set(edge, state)
        last_state = state
    end
end
----
local aa_enabled = ui.reference("AA", "Anti-aimbot angles", "Enabled")
local math_max, math_floor, math_sqrt, math_exp, math_min, math_abs, math_fmod  = math.max, math.floor, math.sqrt, math.exp, math.min, math.abs, math.fmod
local table_sort, table_remove, table_concat, table_insert, next, table_unpack, tostring = table.sort, table.remove, table.concat, table.insert, next, table.unpack, tostring
local ipairs, assert, pairs, pcall, error = ipairs, assert, pairs, pcall, error
local string_match, string_gsub, string_format = string.match, string.gsub, string.formatv
local yaw = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local main_enabled = ui.new_checkbox("VISUALS", "Other ESP", "Fake indicator")
local x_slider = ui.new_slider("VISUALS", "Other ESP", "Fake indicator X offset", 0, 400, 87)
local y_slider = ui.new_slider("VISUALS", "Other ESP", "Fake indicator Y offset", 0, 400, 20)
local function get_color_by_float(float, ...)
    local args = {...}
    local color_table_size = 0
    local color_table = {}
    for i=1, #args, 4 do
        color_table_size = color_table_size + 1
        local color_float = (i - 1) / (#args - 4)
        color_table[color_table_size] = {color_float, args[i], args[i + 1], args[i + 2], args[i + 3]}
    end
    
    local color_lower 
    local color_higher 
    local distance_lower = 1
    local distance_higher = 1
 
    for i=1, #color_table do 
        local color = color_table[i]
        local color_float = color[1]
        if color_float == float then 
            return color[2], color[3], color[4], color[5]
        elseif color_float > float then 
            local distance = color_float - float 
            if distance < distance_higher then 
                color_higher = color 
                distance_higher = distance
            end
        elseif color_float < float then 
            local distance = float - color_float
            if distance < distance_lower then 
                color_lower = color 
                distance_lower = distance
            end
        end
    end
    local distance_difference = distance_lower + distance_higher
    local red = (color_lower[2] * distance_higher + color_higher[2] * distance_lower) / distance_difference
    local green = (color_lower[3] * distance_higher + color_higher[3] * distance_lower) / distance_difference
    local blue = (color_lower[4] * distance_higher + color_higher[4] * distance_lower) / distance_difference
    local alpha = (color_lower[5] * distance_higher + color_higher[5] * distance_lower) / distance_difference
 
    return red, green, blue, alpha
end
local angle = 0
client.set_event_callback("setup_command", function(c)
    if c.chokedcommands == 0 then
        if c.in_use == 1 then
            angle = 0
        else
            angle = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))
        end
    end
end)
client.set_event_callback("paint", function()
    if ui.get(main_enabled) and ui.get(aa_enabled) and ui.get(yaw) ~= "Off" and entity.is_alive(entity.get_local_player()) then
        local color = {get_color_by_float(math_max(0, math_min(1, angle / 58)), 255, 0, 0, 255, 255, 255, 0, 255, 123, 194, 21, 255)}
        local y = renderer.indicator(color[1], color[2], color[3], 255, "FAKE")+ui.get(y_slider)
        local x = ui.get(x_slider)
    end
end)
local indicators = ui.new_checkbox("AA", "Anti-aimbot angles", "Indicators")
local function on_paint()
    local plocal = entity_get_local_player()
    if not entity_is_alive(plocal) then
        return
    end
    local sx, sy = client_screen_size()
    local cx, cy = sx / 2, sy / 2 - 2
    local crouching_ct =
        is_crouching(entity_get_local_player()) and entity_get_prop(entity_get_local_player(), "m_iTeamNum") == 3
    local crouching_t =
        is_crouching(entity_get_local_player()) and entity_get_prop(entity_get_local_player(), "m_iTeamNum") == 2
    local body_yaw = ui_reference("AA", "Anti-aimbot angles", "Body yaw")
    local alpha = math.sin(math.abs(-3.14 + (globals_curtime() * (1 / .75)) % (3.14 * 2))) * 255
    r, g, b, a = ui.get(color)
    renderer_text(cx + 925, cy + 535, 255, 255, 255, 255, "c-", nil, "Kvasibo")
    renderer_text(cx + 935, cy + 525, 255, 255, 255, 255, "c-", nil, "USER: REGULAR")
    local edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
    if ui_get(indicators) then
        if ui_get(fake_walk) then
            renderer_text(cx - 21, cy + 38, r, g, b, alpha, "a", nil, "Kvasibo")
        elseif state and ui_get(sexkey) then
            renderer_text(cx - 22, cy + 38, r, g, b, alpha, "a", nil, "LEGIT-AA")
        elseif ui_get(freestand[1] and freestand[2]) and state and ui_get(sexkey) then
            renderer_text(cx - 22, cy + 38, r, g, b, alpha, "a", nil, "LEGIT-AA")
        elseif ui_get(freestand[1] and freestand[2]) and state then
            renderer_text(cx - 13, cy + 48, r, g, b, alpha, "a", nil, "EDGE") --
            renderer_text(cx - 24, cy + 38, r, g, b, alpha, "a", nil, "AUTO-DIR")
        elseif state then
            renderer_text(cx - 13, cy + 38, r, g, b, alpha, "a", nil, "EDGE") --
        elseif ui_get(sexkey) then
            renderer_text(cx - 22, cy + 38, r, g, b, alpha, "a", nil, "LEGIT-AA")
        elseif ui_get(freestand[1] and freestand[2]) then
            renderer_text(cx - 24, cy + 38, r, g, b, alpha, "a", nil, "AUTO-DIR")
        else
            renderer_text(cx - 20, cy + 38, r, g, b, alpha, "a", nil, "Kvasibo")
        end
    end
    local local_player = entity.get_local_player()
    if not entity.is_alive(local_player) then
        return
    end
    local body_yaw =
        math.min(57, math.abs(round((entity.get_prop(local_player, "m_flPoseParameter", 11) or 0) * 120 - 60, 1)))
    r, g, b, a = ui.get(color)
    if ui_get(indicators) then
        renderer.text(cx, cy + 20, r, g, b, 255, "c", 0, body_yaw .. "")
        renderer.gradient(cx, cy + 30, -body_yaw, 2.5, r, g, b, a, r, g, b, 25, true)
        renderer.gradient(cx, cy + 30, body_yaw, 2.5, r, g, b, a, r, g, b, 25, true)
        if body_yaw > 9 then
            renderer.text(cx + 5.5, cy + 9, r, g, b, 255, "a", 0, ".")
        else
            renderer.text(cx + 3, cy + 9, r, g, b, 255, "a", 0, ".")
        end
    end
end
client.set_event_callback("paint", on_paint)
slidewalk = ui.reference("AA", "other", "leg movement")
enable = ui.new_checkbox("AA", "Anti-aimbot angles", "Break Movement Legs")
client.set_event_callback(
    "net_update_end",
    function()
        if ui.get(enable) then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
        end
    end
)
client.set_event_callback(
    "run_command",
    function(ctx)
        if ui.get(enable) then
            p = client.random_int(1, 3)
            if p == 1 then
                ui.set(slidewalk, "Off")
            elseif p == 2 then
                ui.set(slidewalk, "Always slide")
            elseif p == 3 then
                ui.set(slidewalk, "Off")
            end
            ui.set_visible(slidewalk, false)
        else
            ui.set_visible(slidewalk, true)
        end
    end
)
    client_set_event_callback("shutdown", function()
        set_og_menu(true)
    end)
