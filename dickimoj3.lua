local double_tap, double_tap_key = ui.reference("RAGE", "Other", "Double tap")
local double_tap_mode = ui.reference("RAGE", "Other", "Double tap mode")
local double_tap_fake_lag_limit = ui.reference("RAGE", "Other", "Double tap fake lag limit")
local fake_lag = ui.reference("AA", "Fake lag", "Limit")
local sv_maxusrcmdprocessticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")
local increase_speed = ui.new_checkbox("RAGE", "Other", "Increase double tap speed")
local increase_speed_mode = ui.new_combobox("RAGE", "Other", "Increase double tap speed mode", {"Safe (Slower)", "Unsafe (Kvasibo)"})

ui.set_visible(sv_maxusrcmdprocessticks, true)

local function do_shit()
	ui.set(fake_lag, math.min(14, ui.get(fake_lag)))

	if ui.get(increase_speed) then
		ui.set(double_tap, true)
		ui.set(double_tap_fake_lag_limit, 1)
		ui.set(double_tap_mode, "Offensive")
		
		if ui.get(increase_speed_mode) == "Unsafe (Kvasibo)" then
			ui.set(sv_maxusrcmdprocessticks, 20)
			cvar.cl_clock_correction:set_int(0)
			return
		end
	end
	
	ui.set(sv_maxusrcmdprocessticks, 16)
	cvar.cl_clock_correction:set_int(1)
end
ctoptions = {"tick correction", "fortify shot", "force fire", "fast charge"}
safeoptions = {"tick correction", "fortify shot"}
usoptions = {"fire on ticks", "speed boost"}
local script = {
    version = entity.get_player_name(entity.get_local_player()),
    debug = false,
    reference = {},
    interface = {
        master_trigger = ui.new_multiselect("RAGE", "Other", "Trigger\ndt", ctoptions),
    }
}

ui.set_callback(increase_speed, do_shit)
ui.set_callback(increase_speed_mode, do_shit)
ui.set_callback(fake_lag, do_shit)

client.set_event_callback("shutdown", function()
	ui.set(increase_speed, false)
	do_shit()
end)
