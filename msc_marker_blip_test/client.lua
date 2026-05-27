local markerBlip = nil

local function showHelpNotification(message)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

local function createConfiguredBlip()
    if not Config.Blip.Enabled then
        return
    end

    markerBlip = AddBlipForCoord(Config.Blip.Position.x, Config.Blip.Position.y, Config.Blip.Position.z)

    SetBlipSprite(markerBlip, Config.Blip.Sprite)
    SetBlipDisplay(markerBlip, Config.Blip.Display)
    SetBlipScale(markerBlip, Config.Blip.Scale)
    SetBlipColour(markerBlip, Config.Blip.Color)
    SetBlipAsShortRange(markerBlip, Config.Blip.ShortRange)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(Config.Blip.Name)
    EndTextCommandSetBlipName(markerBlip)
end

CreateThread(function()
    createConfiguredBlip()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    if markerBlip and DoesBlipExist(markerBlip) then
        RemoveBlip(markerBlip)
        markerBlip = nil
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - Config.Marker.Position)

        if distance <= Config.Marker.DrawDistance then
            sleep = 0

            DrawMarker(
                Config.Marker.Type,
                Config.Marker.Position.x,
                Config.Marker.Position.y,
                Config.Marker.Position.z,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                Config.Marker.Size.x,
                Config.Marker.Size.y,
                Config.Marker.Size.z,
                Config.Marker.Color.r,
                Config.Marker.Color.g,
                Config.Marker.Color.b,
                Config.Marker.Color.a,
                false,
                true,
                2,
                false,
                nil,
                nil,
                false
            )

            if distance <= Config.Marker.InteractDistance then
                showHelpNotification(Config.Marker.HelpText)
            end
        end

        Wait(sleep)
    end
end)
