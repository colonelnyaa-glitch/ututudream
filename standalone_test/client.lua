local function notify(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, false)
end

RegisterCommand(Config.Command, function()
    notify(Config.ClientMessage)

    if Config.EnableServerPing then
        TriggerServerEvent('standalone_test:server:ping')
    end
end, false)

RegisterNetEvent('standalone_test:client:pong', function(message)
    if type(message) ~= 'string' or message == '' then
        return
    end

    notify(message)
end)
