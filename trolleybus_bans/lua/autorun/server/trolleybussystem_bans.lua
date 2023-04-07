Trolleybus_Bans = Trolleybus_Bans or {}

hook.Add("InitPostEntity", "Trolleybus_Bans.CheckDirectory", function( ply )

    if !file.Exists("trolleybussystem/bans/","DATA") then
    
        file.CreateDir("trolleybussystem/bans/","DATA")

    end

end)

function Trolleybus_Bans.GetUser(steamid)

    if !file.Exists("trolleybussystem/bans/player_" .. steamid ..".json","DATA") then 

        return null

    elseif file.Time("trolleybussystem/bans/player_"..steamid..".json", "DATA") + 60 < os.time() then
            
        file.Delete("trolleybussystem/bans/player_"..steamid..".json", "DATA")
        return null

    else

        return util.JSONToTable(file.Read("trolleybussystem/bans/player_" .. steamid ..".json","DATA"))

    end

end

function Trolleybus_Bans.RegisterUser(steamid,data)

    file.Write("trolleybussystem/bans/player_" .. steamid ..".json", data)

end

function Trolleybus_Bans.KickUser(steamid, reason)

    game.KickID(util.SteamIDFrom64(steamid), "Вы заблокированы глобальной системой банов по причине "..reason..". Подробнее на сайте https://trolleybussystem.ru/")

end

hook.Add( "CheckPassword", "Trolleybus_Bans.Check", function(steamID64)

    local Trolleybus_Bans_Data = Trolleybus_Bans.GetUser(steamID64 )

    if Trolleybus_Bans_Data and Trolleybus_Bans_Data['result'] == true then

        Trolleybus_Bans.KickUser(steamID64, Trolleybus_Bans_Data['reason'])

    else  
    
        http.Fetch( "https://trolleybussystem.ru/api/check/".. steamID64,
        
        function( body, length, headers, code )
            
            if (code == 200) then 

                local Trolleybus_Bans_Data = util.JSONToTable(body)

                Trolleybus_Bans.RegisterUser(steamID64,util.TableToJSON(Trolleybus_Bans_Data))

                if Trolleybus_Bans_Data['result'] == true then

                    Trolleybus_Bans.KickUser(steamID64, Trolleybus_Bans_Data['reason'])

                end

            end
            
        end)

    end

end)