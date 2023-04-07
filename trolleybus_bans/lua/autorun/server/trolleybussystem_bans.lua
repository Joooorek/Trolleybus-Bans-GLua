Trolleybus_Bans = Trolleybus_Bans or {}

hook.Add("InitPostEntity", "Trolleybus_Bans.CheckDirectory", function( ply )

    if !file.Exists("trolleybussystem/bans/","DATA") then
    
        file.CreateDir("trolleybussystem/bans/","DATA")

    end

end)

function Trolleybus_Bans.GetUser(steamid)

    if !file.Exists("trolleybussystem/bans/player_" .. steamid ..".json","DATA") then 

        return null

    else

        return util.JSONToTable(file.Read("trolleybussystem/bans/player_" .. steamid ..".json","DATA"))

    end

end

function Trolleybus_Bans.RegisterUser(steamid,data)

    file.Write("trolleybussystem/bans/player_" .. steamid ..".json", data)

end

function Trolleybus_Bans.KickUser(steamid, reason)

    game.KickID(steamid, "Вы заблокировани системой банов по причине "..reason..". Подробнее на https://trolleybussystem.ru/")

end

hook.Add( "PlayerAuthed", "Trolleybus_Bans.Check", function(ply, steamid)

    local Trolleybus_Bans_Data = Trolleybus_Bans.GetUser(util.SteamIDTo64(steamid))

    if Trolleybus_Bans_Data['result'] == true then

        Trolleybus_Bans.KickUser(util.SteamIDTo64(steamid), Trolleybus_Bans_Data['reason'])

    else  
    
        http.Fetch( "https://trolleybussystem.ru/api/check/".. util.SteamIDTo64(steamid),
        
        function( body, length, headers, code )
            
            if (code == 200) then 

                local Trolleybus_Bans_Data = util.JSONToTable(body)

                Trolleybus_Bans.RegisterUser(util.SteamIDTo64(steamid),Trolleybus_Bans_Data)

                if Trolleybus_Bans_Data['result'] == true then

                    Trolleybus_Bans.KickUser(util.SteamIDTo64(steamid), Trolleybus_Bans_Data['reason'])

                end

            end
            
        end)

    end

end)