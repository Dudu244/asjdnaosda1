local surface = require 'gamesense/surface'
local anti_aim = require 'gamesense/antiaim_funcs'

local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local aa_yaw, aa_yaw_offset = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local aa_yaw_jitter, aa_yaw_jitter_offset = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local aa_yaw_base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local aa_fake_yaw, aa_fake_yaw_slider = ui.reference("AA", "Anti-aimbot angles", "body yaw")
local aa_fs_byaw = ui.reference("AA", "Anti-aimbot angles", "Freestanding body yaw")
local aa_fs_triggers = ui.reference("AA", "Anti-aimbot angles", "Freestanding")
local aa_body_limit = ui.reference("AA", "Anti-aimbot angles", "fake yaw limit")
local aa_edge = ui.reference("AA", "Anti-aimbot angles", "Edge yaw")
local misc_legs = ui.reference("AA", "other", "leg movement")
local aa, fake_walk = ui.reference("AA", "other", "slow motion")
local misc_doubletap, doubletap = ui.reference("rage", "other", "double tap")
local misc_onshot, misc_onshot_aa = ui.reference("AA", "Other", "On shot anti-aim")
local misc_fakeduck = ui.reference("RAGE", "Other", "Duck peek assist")
local fl_amount = ui.reference("AA", "fake lag", "amount")
local fl_limit = ui.reference("AA", "fake lag", "limit")
local fl_var = ui.reference("AA", "fake lag", "variance")
local _, slowmotion = ui.reference("AA", "other", "slow motion")
local silentaa = ui.reference("RAGE", "Aimbot", "Silent aim")
local fl_enabled = ui.reference("AA", "Fake lag", "Enabled")


local ref_dt, ref_dt_key = ui.reference("RAGE", "Other", "Double tap")
local ref_fd = ui.reference("RAGE", "Other", "Duck peek assist")

local label = ui.new_label("Lua", "B", "---------------------[KVASIBO]---------------------")

local label = ui.new_label("Lua", "B", "                           ~~ [TAB] ~~         ")
local masterswitch = ui.new_checkbox("Lua", "B", "Indicators")
local selectbox = ui.new_combobox("Lua", "B", "Choice tab", "INDICATORS")

local function setTableVisibility(table, state)
    for i=1, #table do
    end
end

----------------------------------------------------------------------------- Add stuff from here ----------------------------------------------------------

local version = "V2.0"

--------------AIMBOT NOT ONLY DT STARTS HERE---------------------------
local label = ui.new_label("Lua", "B", "                           ~~ [DT] ~~         ")
local dtcheckbox = ui.new_checkbox("Lua", "B", "Improve DT")
local dtselectbox = ui.new_combobox("Lua", "B", "DT Modes", "Normal", "Safe (Slow)", "Unsafe (Fast)", "Beta")
local ticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local damage = ui.reference("Rage", "Aimbot", "Minimum damage")


local function handleDT()
    if ui.get(dtselectbox) == "Beta" and ui.get(dtcheckbox) and ui.get(selectbox) == "RAGE" and ui.get(masterswitch) then
        setTableVisibility({dtBeta}, true)
   else
        setTableVisibility({dtBeta}, false)
    end
end

client.set_event_callback("paint_ui", function(dtspeed)
    if ui.get(dtcheckbox) and ui.get(masterswitch) then
        if ui.get(dtselectbox) == "Normal" then
            ui.set(ticks, 16)
        elseif ui.get(dtselectbox) == "Safe (Slow)" then
            ui.set(ticks, 14)
        elseif ui.get(dtselectbox) == "Unsafe (Fast)" then
            ui.set(ticks, 25)
        elseif ui.get(dtselectbox) == "Beta" then
            ui.set(ticks, 62)
        elseif ref_fd == true then
            ui.set(ticks, 16)
            return
        end
    end
end)

------------------------------------------------------------- DT and RAGE ENDS HERE ---------------------------------------------------------
----------------------------------------------------------------------------------------------

local function handleMenu()
    if ui.get(masterswitch) then
        setTableVisibility({selectbox}, true)
    else
        setTableVisibility({selectbox}, false)
    end
end

------------------------------------------------------------- Fake Flick---------------------------------------------------------
----------------------------------------------------------------------------------------------
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



-------------------------------------MISC STARTS HERE-------------------------------------------
require 'bit'
local label = ui.new_label("Lua", "B", "                           ~~ [MISC] ~~         ")
local enable = ui.new_checkbox("Lua", "B", "Old animation fix")
local enable2 = ui.new_checkbox("Lua", "B", "Pitch on land")
local fakelag = ui.reference("AA", "Fake lag", "Limit")
local misc_clantag_enabled = ui.new_checkbox("Lua", "B", "Clantag")
local ground_ticks, end_time = 1, 0

local function handleMISC()
    if ui.get(selectbox) == "MISC" and ui.get(masterswitch) then
        setTableVisibility({enable, enable2, misc_clantag_enabled}, true)
    else 
        setTableVisibility({enable, enable2, misc_clantag_enabled}, false)
    end
end



client.set_event_callback("pre_render", function()

    if ui.get(enable) then 
        entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 6) 
    end
	
	if entity.is_alive(entity.get_local_player()) then
	
    if ui.get(enable2) then
        local on_ground = bit.band(entity.get_prop(entity.get_local_player(), "m_fFlags"), 1)

        if on_ground == 1 then
            ground_ticks = ground_ticks + 1
        else
            ground_ticks = 0
            end_time = globals.curtime() + 1
        end 
    
        if ground_ticks > ui.get(fakelag)+1 and end_time > globals.curtime() then
            entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 0.5, 12)
        end
    end
end end)

local taganims = { 
    " ",
    "%",
    "k",
    "k$",
    "kv",
    "kv^",
    "kva",
    "kva@",
    "kvas",
    "kvas&",
    "kvasi",
    "kvasi$",
    "kvasib",
    "kvasib%",
    "kvasibo",
    "kvasibo*",
    "kvasibo",
    "kvasibo.",
    "kvasibo.<",
    "kvasibo.l",
    "kvasibo.l<",
    "kvasibo.lu",
    "kvasibo.lu<",
    "kvasibo.lua",
    "kvasibo.lu<",
    "kvasibo.lu",
    "kvasibo.l<",
    "kvasibo.l",
    "kvasibo.<",
    "kvasibo.",
    "kvasibo",
    "kvasibo*",
    "kvasibo",
    "kvasib%",
    "kvasib",
    "kvasi$",
    "kvasi",
    "kvas&",
    "kvas",
    "kva@",
    "kva",
    "kv^",
    "kv",
    "k$",
    "k",
    "%",
    " ",
}

local prev_tag 

local no_tag = { }

local function time_to_ticks( time )
    return 0.5 + time / globals.tickinterval()
end  

local function paint()
    if ui.get(misc_clantag_enabled) == false then
        client.set_clan_tag(no_tag) 
    end

    local lp = entity.get_local_player()

    if ui.get(misc_clantag_enabled) then 
        local tickcount = globals.tickcount() + time_to_ticks(client.latency()) 
        local idx = tickcount / time_to_ticks(0.325) 
        local FinalTag = taganims[math.floor(idx % #taganims ) + 1] 
        FinalTag = " " .. FinalTag .. " " 
        if prev_tag ~= FinalTag then 
            client.set_clan_tag(FinalTag) 
            prev_tag = FinalTag 
        end
    end
end
client.set_event_callback("paint", paint)

-----------------------------------------------MISC ENDS HERE----------------------------------------------------

local function handleSKEETAA() 
    if ui.get(masterswitch) then
    else 
    end
end

-------------------------------AA STARTS HERE-----------------------------------
local ent = entity.get_local_player()
local label = ui.new_label("Lua", "B", "                             ~~ [AA] ~~         ")
local aa_unba = ui.new_checkbox("Lua", "B", "Enable kvasibo")
local aa_unba_mode = ui.new_combobox("Lua", "B", "AA Mode", "Default", "Low Delta", "Idealyaw", "Static", "Experimental")
local _, slider = ui.reference("AA", "Anti-aimbot angles", "Body yaw")
local check = ui.new_checkbox("Lua", "B", "Anti-bruteforce")
local combo = ui.new_combobox("Lua", "B", "Anti-bruteforce mode", { "Side", "Random", "Gradual" })
local ab_range = ui.new_slider("Lua", "B", "Anti-bruteforce range", 1, 100, 32)
local yaw_base_select = ui.new_combobox("Lua", "B", "Yaw base", {"Static", "At targets"})
local anti_onshot_select = ui.new_combobox("AA", "Other", "Anti-onshot mode", {"Normal", "Step", "Opposite", "Random"})
local legs_c = ui.new_checkbox("AA", "Other", "Leg Breaker")
local legit_e_key = ui.new_checkbox("Lua", "B", "Legit AA on E")
--local balance = ui.new_checkbox("Lua", "B", "Force Balance Adjustment")
local fr_byaw = ui.new_checkbox("Lua", "B", "Improved Body Yaw Freestanding")
local low_delta_c = ui.new_checkbox("Lua", "B", "Delta On Hotkey")
local low_delta = ui.new_hotkey("Lua", "B", " ", true)
local low_delta_slider = ui.new_slider("Lua", "B", "\ncolor", 1, 60)
local aa_unba_manual = ui.new_checkbox("Lua", "B", "Manual AA")
local back = ui.new_hotkey("Lua", "B", "Back keybind")
local left = ui.new_hotkey("Lua", "B", "Left keybind")
local right = ui.new_hotkey("Lua", "B", "Right keybind")
local fl_c = ui.new_checkbox("AA", "Fake lag", "Fakelag Breaker")
local edge_c = ui.new_checkbox("Lua", "B", "Improved Edge Yaw")
local match = ui.new_checkbox("Lua", "B", "Matchmaking mode")


local last = 0
local last1 = 0
local last2 = 0
local last3 = 0
local last4 = 0
local last5 = 0
local state = true

client.set_event_callback("paint_ui", function(handleAA2)
    if ui.get(selectbox) == "AA" and ui.get(masterswitch) then
        setTableVisibility({yaw_base_select, anti_onshot_select}, true)
    else
        setTableVisibility({yaw_base_select, anti_onshot_select}, false)
    end
end)

local function handleMAA()
    if ui.get(selectbox) == "AA" and ui.get(masterswitch) then
        ui.set_visible(aa_unba_manual, true)
    else
        ui.set_visible(aa_unba_manual, false)
    end
end

client.set_event_callback("setup_command", function(fakelag)
    if entity.is_alive(ent) and ui.get(masterswitch) and ui.get(fl_enabled) then
      fakelag.allow_send_packet = fakelag.chokedcommands >= (ui.get(fl_limit))
    end
end)

client.set_event_callback("paint", function(yawstate)
    if ui.get(masterswitch) and entity.is_alive(ent) then
        if ui.get(yaw_base_select) == "Static" then
            ui.set(aa_yaw_base, "Local view")
        elseif ui.get(yaw_base_select) == "At targets" then
            ui.set(aa_yaw_base, "At targets")
        end
    end
end)

client.set_event_callback("paint", function(aastates)
    local cur = globals.curtime()
    if ui.get(masterswitch) and entity.is_alive(ent) then
        if ui.get(aa_unba) and ui.get(aa_unba_mode) == "Default" then
            local negative = math.random(-50, -10)
            local positive = math.random(50, 10)
            local timer = math.random(5, 10)
            local type = math.random(1, 3)
            local divider = math.random(7, 9)
            if cur > last1 then
                if (negative * math.pi) < -80 and 80 > (positive * math.pi) then
                    if type == 1 and state == true then
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.85))
                        ui.set(pitch, "default")
                        last1 = cur + (timer / divider)
                        state = not state
                    else
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    end
                else
                    if type == 1 and state == not state then
                        ui.set(aa_fake_yaw, "jitter")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.7))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    else
                        ui.set(aa_fake_yaw, "jitter")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "down")
                        last1 = cur + (timer / 20)
                        state = not state
                    end
                end
            end

            if ui.get(aa_fake_yaw_slider) < 0 then
                ui.set(aa_body_limit, -(ui.get(aa_fake_yaw_slider) / 3.0))
            elseif ui.get(aa_fake_yaw_slider) > 0 then
                ui.set(aa_body_limit, (ui.get(aa_fake_yaw_slider) / 3.4))
            end
            
            if ui.get(aa_unba) and ui.get(aa_unba_mode) == "Default" then
                if cur > last then
                    local positive = math.random(4, 10)
                    local negative = math.random(-10, -4)
                    local time = math.random(1, 4)
                    local type = math.random(1, 2)
                    if (negative * 1.5) > -8 and 8 > (positive * 1.5) then
                      if type == 1 and state == true then
                        ui.set(aa_yaw_jitter, "offset")
                        ui.set(aa_yaw_jitter_offset, positive)
                        last = cur + (time / 10)
                        state = not state
                      else
                        ui.set(aa_yaw_jitter, "offset")
                        ui.set(aa_yaw_jitter_offset, negative)
                        last = cur + (time / 10)
                        state = true
                      end
                    else
                      if type == 2 and state == true then
                        ui.set(aa_yaw_jitter, "random")
                        ui.set(aa_yaw_jitter_offset, positive)
                        last = cur + (time / 10)
                        state = not state
                      else
                        ui.set(aa_yaw_jitter, "center")
                        ui.set(aa_yaw_jitter_offset, negative)
                        last = cur + (time / 10)
                        state = true
                      end
                    end
                end
            end
        end

----------------------------

        if ui.get(aa_unba) and ui.get(aa_unba_mode) == "Low Delta" then
            local negative = math.random(-50, -10)
            local positive = math.random(50, 10)
            local timer = math.random(5, 10)
            local type = math.random(1, 3)
            local divider = math.random(7, 9)
            if cur > last1 then
                if (negative * math.pi) < -80 and 80 > (positive * math.pi) then
                    if type == 1 and state == true then
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.85))
                        ui.set(pitch, "default")
                        last1 = cur + (timer / divider)
                        state = not state
                    else
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    end
                else
                    if type == 1 and state == not state then
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.7))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    else
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "down")
                        last1 = cur + (timer / 20)
                        state = not state
                    end
                end
                ui.set(aa_yaw_jitter_offset, 0)
            end
            if ui.get(aa_fake_yaw_slider) < 0 then
                ui.set(aa_body_limit, -(ui.get(aa_fake_yaw_slider) / 3.0))
            elseif ui.get(aa_fake_yaw_slider) > 0 then
                ui.set(aa_body_limit, (ui.get(aa_fake_yaw_slider) / 3.4))
            end
        end

----------------------------

        if ui.get(aa_unba) and ui.get(aa_unba_mode) == "Idealyaw" then
            local negative = math.random(-50, -10)
            local positive = math.random(50, 10)
            local timer = math.random(5, 10)
            local type = math.random(1, 3)
            local divider = math.random(7, 9)
            if cur > last1 then
                if (negative * math.pi) < -80 and 80 > (positive * math.pi) then
                    if type == 1 and state == true then
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.85))
                        ui.set(pitch, "default")
                        last1 = cur + (timer / divider)
                        state = not state
                    else
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    end
                else
                    if type == 1 and state == not state then
                        ui.set(aa_fake_yaw, "jitter")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.7))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    else
                        ui.set(aa_fake_yaw, "jitter")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "down")
                        last1 = cur + (timer / 20)
                        state = not state
                    end
                end
            end
            if ui.get(aa_fake_yaw_slider) < 0 then
                ui.set(aa_body_limit, -(ui.get(aa_fake_yaw_slider) / 3.0))
            elseif ui.get(aa_fake_yaw_slider) > 0 then
                ui.set(aa_body_limit, (ui.get(aa_fake_yaw_slider) / 3.4))
            end
            
            if ui.get(aa_unba) and ui.get(aa_unba_mode) == "Idealyaw" then
                if cur > last then
                    local positive = math.random(4, 10)
                    local negative = math.random(-10, -4)
                    local time = math.random(1, 4)
                    local type = math.random(1, 2)
                    if (negative * 1.5) > -8 and 8 > (positive * 1.5) then
                      if type == 1 and state == true then
                        ui.set(aa_yaw_jitter, "offset")
                        ui.set(aa_yaw_jitter_offset, positive)
                        last = cur + (time / 10)
                        state = not state
                      else
                        ui.set(aa_yaw_jitter, "offset")
                        ui.set(aa_yaw_jitter_offset, negative)
                        last = cur + (time / 10)
                        state = true
                      end
                    else
                      if type == 2 and state == true then
                        ui.set(aa_yaw_jitter, "center")
                        ui.set(aa_yaw_jitter_offset, positive)
                        last = cur + (time / divider)
                        state = not state
                      else
                        ui.set(aa_yaw_jitter, "center")
                        ui.set(aa_yaw_jitter_offset, negative)
                        last = cur + (time / 10)
                        state = true
                      end
                    end
                end
            end
        end

----------------------------

        if ui.get(aa_unba) and ui.get(aa_unba_mode) == "Static" then
            local negative = math.random(-50, -10)
            local positive = math.random(50, 10)
            local timer = math.random(5, 10)
            local type = math.random(1, 3)
            local divider = math.random(7, 9)
            if cur > last1 then
                ui.set(aa_yaw_jitter, "off")
                if (negative * math.pi) < -80 and 80 > (positive * math.pi) then
                    if type == 1 and state == true then
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.85))
                        ui.set(pitch, "default")
                        last1 = cur + (timer / divider)
                        state = not state
                    else
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    end
                else
                    if type == 1 and state == not state then
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.7))
                        ui.set(pitch, "minimal")
                        last1 = cur + (timer / divider)
                        state = true
                    else
                        ui.set(aa_fake_yaw, "static")
                        ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.9))
                        ui.set(pitch, "down")
                        last1 = cur + (timer / divider)
                        state = not state
                    end
                end
            end
            if ui.get(aa_fake_yaw_slider) < 0 then
                ui.set(aa_body_limit, -(ui.get(aa_fake_yaw_slider) / 3.0))
            elseif ui.get(aa_fake_yaw_slider) > 0 then
                ui.set(aa_body_limit, (ui.get(aa_fake_yaw_slider) / 3.4))
            end
        end
    end

----------------------------

    if ui.get(aa_unba) and ui.get(aa_unba_mode) == "Experimental" then
        local negative = math.random(-50, -10)
        local positive = math.random(50, 10)
        local timer = math.random(5, 10)
        local type = math.random(1, 3)
        local divider = math.random(7, 9)
        if cur > last1 then
            ui.set(aa_yaw_jitter, "off")
            if (negative * math.pi) < -80 and 80 > (positive * math.pi) then
                if type == 1 and state == true then
                    ui.set(aa_fake_yaw, "static")
                    ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.75))
                    ui.set(pitch, "default")
                    last1 = cur + (timer / divider)
                    state = not state
                else
                    ui.set(aa_fake_yaw, "static")
                    ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.83))
                    ui.set(pitch, "minimal")
                    last1 = cur + (timer / divider)
                    state = true
                end
            else
                if type == 1 and state == not state then
                    ui.set(aa_fake_yaw, "static")
                    ui.set(aa_fake_yaw_slider, math.ceil(negative * math.pi * 0.72))
                    ui.set(pitch, "minimal")
                    last1 = cur + (timer / divider)
                    state = true
                else
                    ui.set(aa_fake_yaw, "jitter")
                    ui.set(aa_fake_yaw_slider, math.ceil(positive * math.pi * 0.87))
                    ui.set(pitch, "down")
                    last1 = cur + (timer / 20)
                    state = not state
                end
            end
        end
        if ui.get(aa_fake_yaw_slider) < 0 then
           ui.set(aa_body_limit, -(ui.get(aa_fake_yaw_slider) / 3.7))
        elseif ui.get(aa_fake_yaw_slider) > 0 then
            ui.set(aa_body_limit, (ui.get(aa_fake_yaw_slider) / 3.6))
        end
    end
end)

---------------------------- jitters above ----------------------------------

client.set_event_callback("paint", function(delta_on_key)
    if ui.get(masterswitch) and entity.is_alive(ent) then
        if ui.get(low_delta) == true and ui.get(low_delta_c) then
            ui.set(aa_body_limit, (ui.get(low_delta_slider) + ui.get(low_delta_slider)) / 2.5)
        end
    end
end)

client.set_event_callback("setup_command",function(e)
    local weaponn = entity.get_player_weapon()
    if ui.get(legit_e_key) then
        if weaponn ~= nil and entity.get_classname(weaponn) == "CC4" then
            if e.in_attack == 1 then
                e.in_attack = 0 
                e.in_use = 1
                ui.set(aa_fs_byaw, true)
                ui.set(aa_body_limit, 25)
            end
        else
            if e.chokedcommands == 0 then
                e.in_use = 0
            end
        end
    end
end)

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
    if ui.get(check) and entity.is_alive(entity.get_local_player()) then
        local ent = client.userid_to_entindex(c.userid)
        if not entity.is_dormant(ent) and entity.is_enemy(ent) then
            local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
            ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
            local player_head = { entity.hitbox_position(entity.get_local_player(), 0) }
            local closest = GetClosestPoint(ent_shoot, { c.x, c.y, c.z }, player_head)
            local delta = { player_head[1]-closest[1], player_head[2]-closest[2] }
            local delta_2d = math.sqrt(delta[1]^2+delta[2]^2)

            if math.abs(delta_2d) < ui.get(ab_range) then
                it = it + 1
                should_swap = true
            end
        end
    end
end)

client.set_event_callback("player_spawn", function(c)
    if ui.get(masterswitch) and ui.get(check) then
        ui.set(aa_yaw_offset, 0)
        return
    end
end)



client.set_event_callback("bullet_impact", function(onshot)
    if ui.get(check) and entity.is_alive(entity.get_local_player()) and entity.get_local_player(ent) then
        local ent = client.userid_to_entindex(onshot.userid)
        local ent_shoot = { entity.get_prop(ent, "m_vecOrigin") }
        ent_shoot[3] = ent_shoot[3] + entity.get_prop(ent, "m_vecViewOffset[2]")
        should_swap = true
        it = it + 1
    end
end)

client.set_event_callback("run_command", function(c)
    if ui.get(masterswitch) and entity.is_alive(ent) and not ui.get(anti_onshot_select) == "normal" then
        if should_swap then
            if ui.get(anti_onshot_select) == "step" then
                ui.set(aa_fake_yaw_slider, (math.random(30, -30)[(it%3)+1]))
                return
            end
            if ui.get(anti_onshot_select) == "opposite" then
                ui.set(aa_fake_yaw_slider, -ui.get(aa_fake_yaw_slider))
                return
            end
            if ui.get(anti_onshot_select) == "random" then
                ui.set(aa_fake_yaw_slider, math.random(180, -180))
                return
            end
            should_swap = false
            print(ui.get(aa_yaw_jitter_offset))
            return
        end
    end
end)

client.set_event_callback("run_command", function(c)
    if ui.get(check) and should_swap then
        local _combo = ui.get(combo)
        if _combo == "Side" then
            ui.set(aa_yaw_offset, (-ui.get(slider)) / 3)
        elseif _combo == "Random" then
            ui.set(aa_yaw_offset, (math.random(-60, 60)) / 3)
        elseif _combo == "Gradual" then
            ui.set(aa_yaw_offset, (angles[(it%3)+1]) / 3)
        end
        should_swap = false
    end
end)

client.set_event_callback("paint_ui", function(fl)
    local cur = globals.curtime()
    local int = client.random_int(7, 13)
    local int1 = client.random_int(1, 3)
    if ui.get(fl_c) and entity.is_alive(ent) and ui.get(misc_fakeduck) == false and ui.get(masterswitch) then
        if cur > last5 then
            ui.set(fakelag, int)
            if int1 == 1 then
                ui.set(fl_amount, "maximum")
            elseif int1 == 2 then
                ui.set(fl_amount, "fluctuate")
            else
                ui.set(fl_amount, "dynamic")
            end
            last5 = cur + 0.08
        end
    elseif ui.get(misc_fakeduck) == true then
        ui.set(fakelag, 14)
    end
end)

if not entity.is_alive(ent) then
    client.unset_event_callback("paint_ui", function(fl)
    end)
end

client.set_event_callback("paint_ui", function(mNm)
    if ui.get(masterswitch) and ui.get(match) then
        ui.set(fl_c, false)
        ui.set(legs_c, false)
        ui.set(ticks, 9)
    else
        return
    end
end)

local function handleMM()
    if ui.get(selectbox) == "AA" and ui.get(masterswitch) and not ui.get(match) then
        setTableVisibility({fl_c, legs_c}, true)
    else
        setTableVisibility({fl_c, legs_c}, false)
        return
    end
end


client.set_event_callback("paint", function(edgy)
    if ui.get(edge_c) and ui.get(masterswitch) then
        ui.set(aa_edge, true)
    else
        ui.set(aa_edge, false)
    end
end)
--------------manual aa section-------------

local function handleMAA2()
    if ui.get(selectbox) == "AA" and ui.get(masterswitch) and ui.get(aa_unba_manual) then
        setTableVisibility({back, left, right, arrow_colors, arrow_label}, true)
    else
        setTableVisibility({back, left, right, arrow_colors, arrow_label}, false)
    end
end

local leftReady = false
local rightReady = false
local mode = "back"

local function runCommand()
    if ui.get(aa_unba) and ui.get(aa_unba_manual) and ui.get(masterswitch) then
        if ui.get(aa_unba_manual) then
            if ui.get(back) then
                mode = "back"
            elseif ui.get(left) and leftReady then
                if mode == "left" then
                    mode = "back"
                else
                    mode = "left"
                end
                leftReady = false
            elseif ui.get(right) and rightReady then
                if mode == "right" then
                    mode = "back"
                else
                    mode = "right"
                end
                rightReady = false
            end

            if ui.get(left) == false then
                leftReady = true
            end

            if ui.get(right) == false then
                rightReady = true
            end

            if mode == "back" then                    
                ui.set(aa_yaw_offset, 0)
            elseif mode == "left" then
                ui.set(aa_yaw_offset, -110)
            elseif mode == "right" then
                ui.set(aa_yaw_offset, 110)
            end
        end
    end
end 

if not ui.get(aa_unba_manual) and not entity.is_alive(ent) then
    client.set_event_callback("paint_ui", function(drawarrow)
    end)
end

client.set_event_callback("net_update_end", function()
	if ui.get(legs_c) then
		entity.set_prop(entity.get_local_player(), "m_flPoseParameter", 1, 0)
	end
end)

client.set_event_callback("run_command", function(ctx)
    if ui.get(legs_c) then
	p = client.random_int(1, 3)
	if p == 1 then
		ui.set(misc_legs, "off")
	elseif p == 2 then
       ui.set(misc_legs, "Always slide")
    elseif p == 3 then
		ui.set(misc_legs, "Never slide")
    end
    ui.set_visible(misc_legs, false)
else
    ui.set_visible(misc_legs, true)
end
end)

-------------------AA ends here-----------------------------------

--------------------------------------INDICATORSSSSSSS----------------------------------------------
local w, h = client.screen_size()
local center = { w/2, h/2 }
local offset = 0
local r, g, b, a
local indicators = {}
local text_flags = "b"
local watermark = "KVASIBO"
local ub_space = 0
local extra_space = 0

local label = ui.new_label("Lua", "B", "                         ~~ [Indicators] ~~         ")
local menu = {
    ind_enable = ui.new_checkbox("Lua", "B", "Indicators"),
    ind_offset = ui.new_slider("Lua", "B", "\nHitlog offset", -500, 500, -15, true, "px"),
    ind_extra = ui.new_checkbox("Lua", "B", "Extra indicators"),
    ind_color = ui.new_color_picker("Lua", "B", "Extra indicator color", 252, 127, 3, 255),
    ind_option = ui.new_combobox("Lua", "B", "Text type", {"Normal", "Centered normal"})

}

local states = {
    { { ui.reference("AA", "Anti-aimbot angles", "Freestanding") }, "FS" },
    { { ui.reference("AA", "Other", "On shot anti-aim") }, "HIDE" },
    { { ui.reference("RAGE", "Other", "Force body aim") }, "BAIM" },
    { { ui.reference("RAGE", "Aimbot", "Force safe point") }, "SP" },
    { { ui.reference("AA", "Other", "Fake peek") }, "FAKE PEEK"},
}

ui.set_visible(menu.ind_offset, false)

local function handleINDMENU()
    if ui.get(selectbox) == "INDICATORS" and ui.get(masterswitch) then
        ui.set_visible(menu.ind_enable, true)
    else
        ui.set_visible(menu.ind_enable, false)
    end
end

local function handleINDMENU1()
    if ui.get(selectbox) == "INDICATORS" and ui.get(masterswitch) and ui.get(menu.ind_enable) then
        setTableVisibility({menu.ind_extra, menu.ind_color, menu.ind_option}, true)
    else
        setTableVisibility({menu.ind_extra, menu.ind_color, menu.ind_option}, false)
    end
end

local bodyyawind = ui.new_checkbox("Lua", "B", "Body yaw indicator")
local bodylabel1 = ui.new_label("Lua", "B", "Primary gradient color")
local primary_gradient = ui.new_color_picker("Lua", "B", "Primary gradient", 252, 127, 3)
local bodylabel2 = ui.new_label("Lua", "B", "Secondary gradient color")
local secondary_gradient = ui.new_color_picker("Lua", "B", "Secondary gradient", 252, 127, 3, 0)

local function handleGradient()
    if ui.get(masterswitch) and ui.get(menu.ind_enable) and ui.get(bodyyawind) and ui.get(selectbox) == "INDICATORS" then
        setTableVisibility({bodylabel1, bodylabel2, primary_gradient, secondary_gradient}, true)
    else
        setTableVisibility({bodylabel1, bodylabel2, primary_gradient, secondary_gradient}, false)
    end
end

client.set_event_callback("paint", function(on_move_ub)
    if ui.get(menu.ind_option) ==  "Normal" and ui.get(bodyyawind) then
        ub_space = 30
    elseif ui.get(menu.ind_option) == "Centered normal" and ui.get(bodyyawind) then
        ub_space =  35
    end

    if ui.get(menu.ind_option) ==  "Normal" and not ui.get(bodyyawind) then
        ub_space = 25
    elseif ui.get(menu.ind_option) == "Centered normal" and not ui.get(bodyyawind) then
        ub_space = 20
    end
end)

local function on_activation()
    if ui.get(masterswitch) then
        renderer.text(center[1], center[2] + ub_space, r, g, b, 255, text_flags, 0, watermark)
    end
end

local function on_option()
    if ui.get(menu.ind_option) == "Normal" then
        text_flags = "b"
    elseif ui.get(menu.ind_option) == "Centered normal" then
        text_flags = "cb"
    end
end


local function bool_to_number(value)
    return value and 1 or 0
end

client.set_event_callback("paint", function(on_move_extra)
    if ui.get(menu.ind_option) ==  "Normal" and ui.get(bodyyawind) then
        extra_space = 15
    elseif ui.get(menu.ind_option) == "Centered normal" and ui.get(bodyyawind) then
        extra_space =  20
    end

    if ui.get(menu.ind_option) ==  "Normal" and not ui.get(bodyyawind) then
        extra_space = 10
    elseif ui.get(menu.ind_option) == "Centered normal" and not ui.get(bodyyawind) then
        extra_space = 5
    end
end)

local function doubletap_charged()
    if not ui.get(ref_dt) or not ui.get(ref_dt_key) or ui.get(ref_fd) then return false end    
    local me = entity.get_local_player()

    if me == nil or not entity.is_alive(me) then return false end
    local weapon = entity.get_prop(me, "m_hActiveWeapon")
    if weapon == nil then return false end

    local next_attack = entity.get_prop(me, "m_flNextAttack") + 0.25
    local next_primary_attack = entity.get_prop(weapon, "m_flNextPrimaryAttack") + 0.5
    
    if next_attack == nil or next_primary_attack == nil then return false end
    return next_attack - globals.curtime() < 0 and next_primary_attack - globals.curtime() < 0
end

local function on_doubletap()
    if ui.get(menu.ind_enable) and ui.get(masterswitch) then
        if doubletap_charged() then
            renderer.text(center[1], center[2] + ub_space + 12, 51, 255, 0, 255, text_flags, 0, "DT")
        else
            renderer.text(center[1], center[2] + ub_space + 12, 255, 0, 0, 255, text_flags, 0, "DT")
        end
    end 
end

client.set_event_callback("paint", on_doubletap)
	
local function on_paint()   
    if ui.get(menu.ind_extra) then
        local total_states = 0
        for i = 1, #states do 
            local active = 0
            local cur_check = states[i][1]

            for n = 1, #cur_check do 
                local value = ui.get(cur_check[n])
                local type = type(value)
                if type == "boolean" then
                    active = active + bool_to_number(value)
                elseif type == "table" and value[1] ~= nil then 
                    active = active + 1
                end
            end
            
            if active >= #cur_check then
                total_states = total_states + 1
                local y = (offset >= 0) and (center[2] - offset - (total_states * 12)) or (center[2] - offset + (total_states * 12))
                renderer.text(center[1], y + extra_space + 12 , r, g, b, a, text_flags, 0, states[i][2])
            end
        end
    end
    indicators = {}
end

local function cbx_toggle()
    local state = ui.get(menu.ind_enable)
    local update_callback = state and client.set_event_callback or client.unset_event_callback
    update_callback("paint", on_paint)
    update_callback("paint_ui", on_option)
end

do
    ui.set_callback(menu.ind_enable, cbx_toggle)
    cbx_toggle()

    ui.set_callback(menu.ind_color, function(self)
        r, g, b, a = ui.get(self)
    end)
    r, g, b, a = ui.get(menu.ind_color)

    ui.set_callback(menu.ind_offset, function(self)
        offset = ui.get(self)
    end)
    offset = ui.get(menu.ind_offset)
end

local function draw()
    if ui.get(menu.ind_enable) and ui.get(bodyyawind) and ui.get(masterswitch) then

    local w, h = client.screen_size()
    local center = { w/2, h/2 }

    local p_r, p_g, p_b, p_a = ui.get(primary_gradient)
    local a_r, a_g, a_b, a_a = ui.get(secondary_gradient)
    local m_r, m_g, m_b, m_a = ui.get(menu.ind_color)

    local desync_strength = math.floor(math.min(58, math.abs(entity.get_prop(entity.get_local_player(), "m_flPoseParameter", 11)*120-60)))

    renderer.gradient(center[1] - desync_strength, center[2] + 23, desync_strength, 3, a_r, a_g, a_b, a_a, p_r, p_g, p_b, p_a, true)
    renderer.gradient(center[1], center[2] + 23, desync_strength, 3, p_r, p_g, p_b, p_a, a_r, a_g, a_b, a_a, true)
    end
end

client.set_event_callback("paint", draw)


-------------------------- aa circle -------------------------------

local aaind = ui.new_checkbox("Lua", "B", "AA Circle")
local r1, g1, b1
local circle_color = ui.new_color_picker("Lua", "B", "AA Circle color", 252, 127, 3, 255)
local side = 0



client.set_event_callback("paint", function(circleaa)
    if ui.get(aaind) and ui.get(masterswitch) and ui.get(menu.ind_enable) then
        r1, g1, b1 = ui.get(circle_color)

        local circleangle = anti_aim.get_body_yaw(2) - 120

        if circleangle >= 1 then
            side = 90
        elseif circleangle <= -1 then
            side = 270
        end

        renderer.circle_outline(center[1], center[2], 15, 15, 15, 200, 11, side, 1, 7)
        renderer.circle_outline(center[1], center[2], r1, g1, b1, 255, 9, side, 0.5, 3)
    end
end)

local function handleINDICATORS()
    if ui.get(selectbox) == "INDICATORS" and ui.get(masterswitch) and ui.get(menu.ind_enable) then
        setTableVisibility({menu_watermark, wm_color, bodyyawind, aaind, circle_color}, true)
    else
        setTableVisibility({menu_watermark, wm_color, bodyyawind, aaind, circle_color}, false)
    end
end
local label = ui.new_label("Lua", "B", "                     ~~ [release 14.11.2021] ~~         ")
local h_label1 = ui.new_label("Lua", "B", "KVASIBO")
local h_label2 = ui.new_label("Lua", "B", "Current version: "..version.." ")
-------------------------------indicators ends here--------------------

client.set_event_callback("paint_ui", handleSKEETAA)
client.set_event_callback("paint_ui", handleMAA)
client.set_event_callback("paint_ui", handleMAA2)
client.set_event_callback("paint_ui", handleMenu)
client.set_event_callback("paint_ui", handleDT)
client.set_event_callback("paint_ui", handleINDMENU)
client.set_event_callback("paint_ui", handleINDMENU1)
client.set_event_callback("paint_ui", handleINDICATORS)
client.set_event_callback("paint_ui", handleGradient)
client.set_event_callback("paint_ui", handleMM)
client.set_event_callback("run_command", runCommand)
client.set_event_callback("paint", on_activation)
client.set_event_callback("paint", doubletap_charged)
