-- api
local checkbox = ui.new_checkbox('AA', 'Fake lag', '[Kvasibo Ideal Tick]')
local key = ui.new_hotkey('AA', 'Fake Lag', 'Ideal Tick Key')
local edgeyawonideal = ui.new_checkbox('AA', 'Fake lag', 'Edge Yaw Ideal Tick')
local fakelagslider = ui.new_slider('AA', 'Fake lag', 'Limit', 1, 14, 1, true, 't')
local edgeyaw = ui.reference('AA', 'Anti-aimbot angles', 'Edge yaw')
local limit = ui.reference('AA', 'Fake lag', 'Limit')
local dtlimit = ui.reference('Rage','Other','Double tap fake lag limit')
local sv_maxusrcmdprocessticks   = ui.reference('Misc', 'Settings', 'sv_maxusrcmdprocessticks')
local label1 = ui.new_label('AA', 'Fake lag', 'Ideal Tick Color')
local color = ui.new_color_picker('AA', 'Fake lag', 'Ideal Tick Color', 255, 90, 90, 255)
local width, height = client.screen_size()
local center_width = width/2
local center_height = height/2

local function idealtickha(e)
	shot = true

    if ui.get(key) then
        ui.set(dtlimit, 1)
        ui.set(dtlimit, 5)
        ui.set(dtlimit, 1)
        if shot then
            tick = globals.tickcount()

            shot = false
        else

            if globals.tickcount() > tick + 4 then
                ui.set(limit, 1)
            else
                ui.set(limit, 14)
            end
        end
    end

    if ui.get(key) then
        ui.set(limit, 1)
    else
        ui.set(limit, ui.get(fakelagslider))
    end

    if ui.get(edgeyawonideal) then
        if ui.get(key) then
            ui.set(edgeyaw, true)
        else
            ui.set(edgeyaw, false)
        end
    end
end
client.set_event_callback('setup_command', idealtickha)

local function hideshit()
	if ui.get(checkbox) == false then
		ui.set_visible(key, false)
		ui.set_visible(fakelagslider, false)
		ui.set_visible(edgeyawonideal, false)
		ui.set_visible(color, false)
		ui.set_visible(label1, false)
	elseif ui.get(checkbox) == true then
		ui.set_visible(key, true)
		ui.set_visible(fakelagslider, true)
		ui.set_visible(edgeyawonideal, true)
		ui.set_visible(color, true)
		ui.set_visible(label1, true)
	end
end
client.set_event_callback('setup_command', hideshit)

-- all of this besides the actual text rendering, local player, and activeweap is credited to zprism
local function indicators(setup)
	local local_player = entity.get_local_player()
	local active_weapon = entity.get_prop(local_player, "m_hActiveWeapon")
	local nextAttack = entity.get_prop(local_player,"m_flNextAttack") 
	local nextShot = entity.get_prop(active_weapon,"m_flNextPrimaryAttack")
	local nextShotSecondary = entity.get_prop(active_weapon,"m_flNextSecondaryAttack")

	local color1 = {ui.get(color)}
	if ui.get(checkbox) == true then

		if entity.is_alive(entity.get_local_player()) then
			if active_weapon == nil then
        return
    end
    if nextAttack == nil or nextShot == nil or nextShotSecondary == nil then
        return
    end
    nextAttack = nextAttack + 0.5
	nextShot = nextShot + 0.5
	nextShotSecondary = nextShotSecondary + 0.5
		if ui.get(key) then
			if math.max(nextShot,nextShotSecondary) - globals.curtime() > 0.00  then
				renderer.text(center_width, center_height+20, 255, 255, 255, 255, '-', nil, 'IDEAL TICK: CHARGING')
			elseif math.max(nextShot,nextShotSecondary) - globals.curtime() < 0.00  then
            	renderer.text(center_width, center_height-20, color1[1], color1[2], color1[3],  255, '-', nil,'IDEAL TICK: CHARGED')
            elseif math.max(nextShot,nextShotSecondary) < nextAttack then
            	if nextAttack - globals.curtime() > 0.00 then
            	renderer.text(center_width, center_height+20, 255, 50, 50, 255, '-', nil, 'IDEAL TICK: SWAPPING')
            end
		else
			return
		end
		end
	end
end
end
client.set_event_callback('paint', indicators)
local bit_band,
    client_camera_angles,
    client_color_log,
    client_create_interface,
    client_delay_call,
    client_exec,
    client_eye_position,
    client_key_state,
    client_log,
    client_random_int,
    client_scale_damage,
    client_screen_size,
    client_set_event_callback,
    client_trace_bullet,
    client_userid_to_entindex,
    database_read,
    database_write,
    entity_get_local_player,
    entity_get_player_weapon,
    entity_get_players,
    entity_get_prop,
    entity_hitbox_position,
    entity_is_alive,
    entity_is_enemy,
    math_abs,
    math_atan2,
    require,
    error,
    globals_absoluteframetime,
    globals_curtime,
    globals_realtime,
    math_atan,
    math_cos,
    math_deg,
    math_floor,
    math_max,
    math_min,
    math_rad,
    math_sin,
    math_sqrt,
    print,
    renderer_circle_outline,
    renderer_gradient,
    renderer_measure_text,
    renderer_rectangle,
    renderer_text,
    renderer_triangle,
    string_find,
    string_gmatch,
    string_gsub,
    string_lower,
    table_insert,
    table_remove,
    ui_get,
    ui_new_checkbox,
    ui_new_color_picker,
    ui_new_hotkey,
    ui_new_multiselect,
    ui_reference,
    tostring,
    ui_is_menu_open,
    ui_mouse_position,
    ui_new_combobox,
    ui_new_slider,
    ui_set,
    ui_set_callback,
    ui_set_visible,
    tonumber,
    pcall =
    bit.band,
    client.camera_angles,
    client.color_log,
    client.create_interface,
    client.delay_call,
    client.exec,
    client.eye_position,
    client.key_state,
    client.log,
    client.random_int,
    client.scale_damage,
    client.screen_size,
    client.set_event_callback,
    client.trace_bullet,
    client.userid_to_entindex,
    database.read,
    database.write,
    entity.get_local_player,
    entity.get_player_weapon,
    entity.get_players,
    entity.get_prop,
    entity.hitbox_position,
    entity.is_alive,
    entity.is_enemy,
    math.abs,
    math.atan2,
    require,
    error,
    globals.absoluteframetime,
    globals.curtime,
    globals.realtime,
    math.atan,
    math.cos,
    math.deg,
    math.floor,
    math.max,
    math.min,
    math.rad,
    math.sin,
    math.sqrt,
    print,
    renderer.circle_outline,
    renderer.gradient,
    renderer.measure_text,
    renderer.rectangle,
    renderer.text,
    renderer.triangle,
    string.find,
    string.gmatch,
    string.gsub,
    string.lower,
    table.insert,
    table.remove,
    ui.get,
    ui.new_checkbox,
    ui.new_color_picker,
    ui.new_hotkey,
    ui.new_multiselect,
    ui.reference,
    tostring,
    ui.is_menu_open,
    ui.mouse_position,
    ui.new_combobox,
    ui.new_slider,
    ui.set,
    ui.set_callback,
    ui.set_visible,
    tonumber,
    pcall
local ui_menu_position,
    ui_menu_size,
    math_pi,
    renderer_indicator,
    entity_is_dormant,
    client_set_clan_tag,
    client_trace_line,
    entity_get_all,
    entity_get_classname =
    ui.menu_position,
    ui.menu_size,
    math.pi,
    renderer.indicator,
    entity.is_dormant,
    client.set_clan_tag,
    client.trace_line,
    entity.get_all,
    entity.get_classname
local vector = require("vector")
local ffi = require("ffi")
local ffi_cast = ffi.cast
--[[
local bombp = false
local planter = false
client.set_event_callback(
    "enter_bombzone",
    function(...)
        if (entity.get_prop(entity.get_local_player(), "m_iTeamNum") == 2 and not bombp and planter) then
            client.exec("-use")
            client.exec("unbind e")
        end
    end
)
client.set_event_callback(
    "exit_bombzone",
    function(...)
        client.exec("-use")
        client.exec("bind e +use")
    end
)
client.set_event_callback(
    "bomb_planted",
    function(...)
        bombp = true
        client.exec("-use")
        client.exec("bind e +use")
    end
)
client.set_event_callback(
    "bomb_defused",
    function(...)
        bombp = false
        client.exec("-use")
        client.exec("bind e +use")
    end
)
client.set_event_callback(
    "bomb_exploded",
    function(...)
        bombp = false
        client.exec("-use")
        client.exec("bind e +use")
    end
)
client.set_event_callback(
    "bomb_pickup",
    function(e)
        if client.userid_to_entindex(e.userid) == entity.get_local_player() then
            planter = true
        end
    end
)
client.set_event_callback(
    "bomb_dropped",
    function(e)
        planter = false
        client.exec("-use")
        client.exec("bind e +use")
    end
)
]]
---- menu -----------------------------------------------------------------------------------------------------------------
local testtttttt = ui.new_label("AA", "Anti-aimbot angles", " ")
local testtttt = ui.new_label("AA", "Anti-aimbot angles", " KvasiboAA")
local testttt = ui.new_label("AA", "Anti-aimbot angles", " ")
local testt = ui.new_label("AA", "Anti-aimbot angles", "---------------------------------------------")
local test = ui.new_label("AA", "Anti-aimbot angles", "Color")
local aa_pitch = ui_reference("AA", "Anti-aimbot angles", "Pitch")
local aa_yaw, aa_yaw_offset = ui_reference("AA", "Anti-aimbot angles", "Yaw")
local aa_yaw_jitter, aa_yaw_jitter_offset = ui_reference("AA", "Anti-aimbot angles", "Yaw jitter")
local aa_yaw_base = ui_reference("AA", "Anti-aimbot angles", "Yaw base")
local aa_fake_yaw, aa_fake_yaw_slider = ui_reference("AA", "Anti-aimbot angles", "body yaw")
local aa_fs_byaw = ui_reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local aa_fs_triggers = ui_reference("AA", "Anti-aimbot angles", "Freestanding")
local aa_fake_limit = ui_reference("AA", "Anti-aimbot angles", "fake yaw limit")
--local aa_lby = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target")
-----
----
local color = ui.new_color_picker("AA", "Anti-aimbot angles", "color", 255, 255, 255, 255)
r, g, b, a = ui.get(color)
----
local whitelistcolor = ui.new_label("PLAYERS", "Adjustments", "WhiteList Color Indicator")
local kolor = ui.new_color_picker("PLAYERS", "Adjustments", "WhiteList Color Indicator", 255, 255, 255, 255)
r1, g2, b3, a4 = ui.get(kolor)
------
local playerlist = ui.reference("PLAYERS", "Players", "Player list")
local high_priority = ui.reference("PLAYERS", "Adjustments", "Add to whitelist")
local high_priority_ents = {}
client.set_event_callback(
    "run_command",
    function(c)
        if not ui.is_menu_open() then
            high_priority_ents = {}
            client.update_player_list()
            for _, v in pairs(entity.get_players(true)) do
                ui.set(playerlist, v)
                if ui.get(high_priority) then
                    table.insert(high_priority_ents, v)
                    entity.set_prop(v, "m_flDetectedByEnemySensorTime", 0)
                end
            end
        end
    end
)
client.set_event_callback(
    "paint",
    function()
        for _, v in pairs(high_priority_ents) do
            local bounding_box = {entity.get_bounding_box(v)}
            if #bounding_box == 5 and bounding_box[5] ~= 0 then
                r1, g2, b3, a4 = ui.get(kolor)
                local center = bounding_box[1] + (bounding_box[3] - bounding_box[1]) / 2
                renderer.text(
                    center,
                    bounding_box[2] - 18,
                    r1,
                    g2,
                    b3,
                    255 * bounding_box[5],
                    "c",
                    0,
                    "!! WHITELIST !!"
                )
            end
        end
    end
)
------------------------------------------------------------------------------------------------------------------------------
local enabled = ui_reference("AA", "Anti-aimbot angles", "Enabled")
local pitch = ui_reference("AA", "Anti-aimbot angles", "pitch")
local yawbase = ui_reference("AA", "Anti-aimbot angles", "Yaw base")
local yaw = {ui_reference("AA", "Anti-aimbot angles", "Yaw")}
local fakeyawlimit = ui_reference("AA", "anti-aimbot angles", "Fake yaw limit")
--local lowerbodyyaw = ui_reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local fs = ui_reference("AA", "anti-aimbot angles", "Freestanding body yaw")
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
        goalspeed = goalspeed * 2.94117647 -- gowno liczba jakas z forum zajebana xd
    end
    if minimalspeed <= goalspeed then
        return
    end
    local speedfactor = goalspeed / minimalspeed
    cmd.forwardmove = cmd.forwardmove * speedfactor
    cmd.sidemove = cmd.sidemove * speedfactor
end
local mordann = ui.new_label("AA", "Anti-aimbot angles", "---------------------------------------------")
local min = ui.new_slider("AA", "anti-aimbot angles", "Slow min", 1, 60, 30, 60, "", 1, {[30] = "30 (Kvasibo)"})
local max = ui.new_slider("AA", "anti-aimbot angles", "Slow max", 1, 60, 50, 60, "", 1, {[50] = "50 (Kvasibo)"})
local testt = ui.new_label("AA", "Anti-aimbot angles", "---------------------------------------------")
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
           -- ui_set_visible(aa_lby, state)
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
    --[[
    local anti_aim = require 'gamesense/antiaim_funcs'
    local body_yaw = { ui.reference('AA', 'Anti-aimbot angles', 'Body yaw') }

        if c.chokedcommands ~= 0 then
        return
    end
    if anti_aim.get_overlap() > 0.615 then
        ui.set(body_yaw[1], 'Static')
        ui.set(body_yaw[2], anti_aim.get_desync(1) > 0 and -180 or 180)
    end
    ]]
        local crouching_ct =
            is_crouching(entity_get_local_player()) and entity_get_prop(entity_get_local_player(), "m_iTeamNum") == 3
        local crouching_t =
            is_crouching(entity_get_local_player()) and entity_get_prop(entity_get_local_player(), "m_iTeamNum") == 2
        local DT = ui.reference("RAGE", "Other", "Double Tap")
       -- local YawTarget = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
        if ui_get(fake_walk) then
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Pitch"), "Down")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw Base"), "at targets")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw"), "180")
            ui_set(aa_yaw_offset, 0)
            ui_set(aa_yaw_jitter_offset, 0)
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Yaw jitter"), "Off")
            ui_set(ui_reference("AA", "Anti-aimbot angles", "Body Yaw"), "Static")
            ui_set(aa_fake_yaw_slider, 180)
          --  ui_set(ui_reference("AA", "Anti-aimbot angles", "Lower Body Yaw Target"), "Eye yaw")
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
          --  ui_set(ui_reference("AA", "Anti-aimbot angles", "Lower Body Yaw Target"), "Eye yaw")
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
           -- ui_set(ui_reference("AA", "Anti-aimbot angles", "Lower Body Yaw Target"), "Eye yaw")
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
           -- ui_set(ui_reference("AA", "Anti-aimbot angles", "Lower Body Yaw Target"), "Eye Yaw")
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
        --renderer.circle_outline(x, y, 0, 0, 0, 155, 10, 0, 1, 4)
        --renderer.circle_outline(x, y, color[1], color[2], color[3], 255, 9, 0, angle*0.01754385964, 3)
    end
end)
local indicators = ui.new_checkbox("AA", "Anti-aimbot angles", "Indicators")
local function on_paint()
    local plocal = entity_get_local_player()
    if not entity_is_alive(plocal) then
        return
    end
    --- screen
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
    --- indicators
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
---local ui_set_visible = ui.set_visible
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
--- edge yaw
--[[
local label_text = ui.new_label("AA", "Other", "        [----Anti-Bruteforce----]")
local combo = ui.new_combobox("AA", "Other", "\ncombo1", { "-", "Enable"})
local body_yaw_default = ui.new_slider("AA", "Other", "Body Yaw Reset Value", -180, 180, 60)
local fake_yaw_default = ui.new_slider("AA", "Other", "Fake Yaw Reset Value", 0, 60, 60)
local logs_indic = ui.new_checkbox("AA", "Other", "Log")
local color_logs = ui.new_color_picker("AA", "Other", "Log", 0, 204 , 255, 255)
local label_text1 = ui.new_label("AA", "Other", "Indicator")
local combo_indicator = ui.new_multiselect("AA", "Other", "\ncombo2", {"Anti-Bruteforce"})
--timer
local reset_timer = ui.new_slider("AA", "Other", "Reset AA after X seconds", 0, 6, 3)
local reset_time = 0
local timer_indicator = 0
--reference
local _, slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local slider2 = ui.reference("AA", "Anti-aimbot angles", "Fake yaw limit")
local bodyyaw, yaw = ui.reference("AA", "Anti-aimbot angles", "Body Yaw")
local yawbase = ui.reference("AA", "Anti-aimbot angles", "Yaw Base")
local freestanding_body_yaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local angle = 0
client.set_event_callback("setup_command", function(c)
    if c.chokedcommands == 0 then
        if c.in_use == 1 then
            --angle = 0 
            angle = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))
        else
            angle = math.min(57, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60))
        end
    end
end)
local function includes( table, key )
    local state = false
    for i=1, #table do
        if table[i] == key then
            state = true
            break
        end
    end 
    return state
end
local function contains(table, val)
    for i=1, #table do
        
        if table[i] == val then 
            
            return true
            
        end
        
    end
    
    return false
    
end
local function hsv_to_rgb(h, s, v)
    local r, g, b
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
    i = i % 6
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
    return r * 255, g * 255, b * 255
end
local function rgb_rainbow(frequency, rgb_split_ratio)
    local r, g, b, a = hsv_to_rgb(globals.realtime() * frequency, 1, 1, 1)
    r = r * rgb_split_ratio
    g = g * rgb_split_ratio
    b = b * rgb_split_ratio
    return r, g, b
end
local function GetClosestPoint(A, B, P)
    local a_to_p = { P[1] - A[1], P[2] - A[2] }
    local a_to_b = { B[1] - A[1], B[2] - A[2] }
    local atb2 = a_to_b[1]^2 + a_to_b[2]^2
    local atp_dot_atb = a_to_p[1]*a_to_b[1] + a_to_p[2]*a_to_b[2]
    local t = atp_dot_atb / atb2
    
    return { A[1] + a_to_b[1]*t, A[2] + a_to_b[2]*t }
end
local should_swap = false
local it = 0
local angles = { 60, 20, -60 }
client.set_event_callback("bullet_impact", function(c)
      if ui.get(combo) == "Enable" and entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)
        
            if math.abs(delta_2d) < 40 then
                it = it + 1
                should_swap = true
            end
        end
    end
end)
local function on_prestart() -- reset angles when round restart
    if  ui.get(logs_indic) and ui.get(combo) == "Anti-Bruteforce" then 
        local r_bg, g_bg, b_bg, a_bg = ui.get(color_logs)
        client.color_log(r_bg, g_bg , b_bg, "[Anti-Bruteforce] Reset angles...")
    end

    reset_time = -1
    timer_indicator = -1
    if ui.get(combo) == "Anti-Bruteforce" then
            ui.set(slider, ui.get(body_yaw_default))
            ui.set(slider2, ui.get(fake_yaw_default))
    end
end
local function indicator(c)
    local screen = {client.screen_size()}
    local center = {screen[1]/2, screen[2]/2}
    local speed = 45

    if should_swap == true then
        timer_indicator = globals.curtime() + ui.get(reset_timer)
    end

    --Set Static bodyyaw and freestanding
    if ui.get(combo) == "Enable" then
        ui.set(bodyyaw, "Static")
        ui.set(freestanding_body_yaw, true)
    end

    --Reset angles after X seconds
    if ui.get(combo) == "Enable" and globals.curtime() > timer_indicator then     
            ui.set(slider, ui.get(body_yaw_default))
            ui.set(slider2, ui.get(fake_yaw_default))
    end

    --Anti-Bruteforce indicator
    if includes(ui.get(combo_indicator), "Anti-Bruteforce") and ui.get(combo) == "Enable" and entity.is_alive(entity.get_local_player()) and globals.curtime() < timer_indicator then
    local r2, g2, b2 = rgb_rainbow(speed / 100, 1)    
      renderer.text(center[1], center[2] + 25, r2, g2, b2, 255, "cb", 0, "ANTI-BRUTEFORCE" ) 
    elseif includes(ui.get(combo_indicator), "Anti-Bruteforce") and ui.get(combo) == "Enable" and entity.is_alive(entity.get_local_player()) and globals.curtime() > timer_indicator then     
      renderer.text(center[1], center[2] + 25, 217, 217, 217, 255, "cb", 0, "ANTI-BRUTEFORCE" )
    end
end 
client.set_event_callback("round_prestart", on_prestart)
client.set_event_callback("paint", indicator)
client.set_event_callback("paint", function() --Indicator
    if ui.get(combo) and should_swap then
        local table = {"-60","60", "20","-20","30","-30"} -- random bodyyaw value
        local value2 = math.random(1,#table)
        local picked_value2 = table[value2]
        
        local table = {"17","7","58","42","35"} -- random fakeyaw value
        local value3 = math.random(1,#table) 
        local picked_value3 = table[value3]
        
        local actualbodyyaw = picked_value2
        local actualfakeyaw = picked_value3
        
        if ui.get(logs_indic) and should_swap then
            local r_bg, g_bg, b_bg, a_bg = ui.get(color_logs)
            client.color_log(r_bg, g_bg , b_bg, "[Anti-Bruteforce] ", 'Set body Y: ', actualbodyyaw, '° and fake Y: ', actualfakeyaw,'°')
        end

        if ui.get(combo) == "Enable" then
            ui.set(slider, actualbodyyaw)
            ui.set(slider2, actualfakeyaw) 
        end
        should_swap = false
    end
end)
]] 
--[[- paint
local monolith = ui.new_checkbox("AA", "Anti-aimbot angles", "Monolith Clantag")
local label = ui.new_label("AA", "Anti-aimbot angles", "UID?? ")
local textbox = ui.new_textbox("AA", "Anti-aimbot angles", "Clantag name")
ui.set(textbox)
local text = ui.get(textbox)
local entity_get_prop = entity.get_prop
local client_set_clan_tag = client.set_clan_tag
local Gowno = globals.tickcount()
local cur = 1.3333444
local predkosc = 28.1 -- im wiecej tym wolniej
local clantag_prev
local function pierdziolith(e)
    local text = ui.get(textbox)
    local clantags = {
        "[--------]",
        "[--------]",
        "[M-------]",
        "[Mo------]",
        "[Mon-----]",
        "[Mono----]",
        "[Monol---]",
        "[Monoli--]",
        "[Monolit-]",
        "[Monolith]",
        "[Monolith]",
        "[Monolith]",
        "[<" .. text .. ">olith]",
        "[-<" .. text .. ">olith]",
        "[--<" .. text .. ">lith]",
        "[---<" .. text .. ">ith]",
        "[----<" .. text .. ">th]",
        "[-----<" .. text .. ">h]",
        "[-----<" .. text .. ">]",
        "[------<" .. text .. "]",
        "[-------<]",
        "[--------]",
        "[--------]"
    }
    local cur = math.floor(globals.tickcount() / predkosc) % #clantags
    local clantag = clantags[cur + 1]
    if (ui.get(monolith)) then
        ui.set_visible(textbox, true)
        ui.set_visible(label, true)
        clantag_prev = clantag
        client.set_clan_tag(clantag)
        Gowno = globals.tickcount()
    else
        client_set_clan_tag("\0")
        ui.set_visible(textbox, false)
        ui.set_visible(label, false)
    end
end
client.set_event_callback(
    "player_connect_full",
    function(e)
        Gowno = globals.tickcount()
    end
)
client.set_event_callback("paint", pierdziolith)
]]
