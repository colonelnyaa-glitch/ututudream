local function notify(message)
    if type(message) ~= 'string' or message == '' then
        return
    end

    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, false)
end

RegisterCommand(Config.Command, function()
    notify(Config.Messages.RequestSent)
    TriggerServerEvent('msc_esx_job_check_test:server:checkJob')
end, false)

RegisterNetEvent('msc_esx_job_check_test:client:showJobMessage', function(message)
    notify(message)
end)
