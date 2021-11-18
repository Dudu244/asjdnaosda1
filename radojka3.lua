----------------------------------------------------------------------------
local main_enabled = ui.new_checkbox("VISUALS", "Other ESP", "Min Damage Indicator")
local color = ui.new_color_picker("VISUALS", "Other ESP", "Color", 255, 255, 255, 255)
local function get_MinDMG()
    local dmgMin = ui.reference("rage", "aimbot", "Minimum damage")
    local dmg = ui.get(dmgMin)
    if dmg == nil then return 0 end
     if dmg > 0 then
         return dmg
     end
     return 0
 end

----------------------------------------------------------------------------
client.set_event_callback("paint", function()
    local minDmg = get_MinDMG( )

    if ui.get(main_enabled) and entity.is_alive(entity.get_local_player()) then
        if(minDmg == 0) then
            return
        end
        local r, g, b, a = ui.get(color)
        local indicator = renderer.indicator(r, g, b, a , "" .. minDmg .. "")
    end
end)

--------------MADE BY TWIST & AGERA-------------------------------------------
