local http = require("gamesense/http")
local strumlua2 = 0
local strumlua3 = 0
local strumlua4 = 0
---------------------------------------------------
---------------*******Help*******-------------------
-----------------steam1d3_check---------------------
----local Player2 = someones steamid3
----if (playersteamid == Player1 or playersteamid == Player2) then
--------------------steamid3------------------------
whitelistsucess = false
local Player1 =  107312312312198628  --username--
------^^steamID3^^-------
local playerid = entity.get_local_player()
if (playerid == nil) then return end
local playersteamid = entity.get_steam64(playerid)
local client_log, client_set_event_callback, entity_get_player_name, entity_get_players, entity_get_steam64, json_parse, panorama_open, ui_reference, print = client.log, client.set_event_callback, entity.get_player_name, entity.get_players, entity.get_steam64, json.parse, panorama.open
local js = panorama_open()
local GameStateAPI = js.GameStateAPI
local api = js.MyPersonaAPI
local name = api.GetName()
----add player------------------------------
if (playersteamid == Player1) then
--------------------------------------------
whitelistsucess = true
client.color_log(180, 238, 0, '       <---<[\0')
client.color_log(180, 0, 0, 'Kvasibo\0')
client.color_log(180, 238, 0, '.\0')
client.color_log(180, 0, 0, 'AA\0')
client.color_log(180, 238,0, '>--->')
client.color_log(180, 238, 0, '          Welcome\0' )
client.color_log(255, 77, 44, ' '.. name .. '\0                     ')
client.color_log(180, 238, 0, '!')
----------------------
	local strumlua2 = ui.new_button("config", "Presets", "Kvasibo.AA", function()
    http.get("https://raw.githubusercontent.com/Dudu244/asjdnaosda1/main/kurcina123.lua", function(success, response) 
    if not success or response.status ~= 200 then
        return
    end
    if strumlua2 == 0 then
        loadstring(response.body)()
    end
    strumlua2 = 1
	client.color_log(180, 238,0, 'Kvasibo anti-aim loaded')
        end)
    end)
	-----------------------
	-----------------------
else
whitelistsucess = false
client.color_log(180, 238, 0, '                <---<[\0')
client.color_log(180, 0, 0, 'Kvasibo\0')
client.color_log(180, 238, 0, '.\0')
client.color_log(180, 0, 0, 'AA\0')
client.color_log(180, 238,0, '>--->')
client.color_log(180, 238,0, 'user not Whitelisted contact to: \0')
client.color_log(255, 10, 249, 'https://discord.gg/tGgkUUXUM9\0')
client.color_log(180, 238,0, ' get whitelistet!!')
client.delay_call(10, function()
  client.color_log(255, 200, 0, '            close game after 30 second')
  end)
  client.delay_call(40, function()
  client.exec("quit")
  end)
end
-------------------
    
    -------
