local notifyAdapterResource = 'msc_notify_adapter_test'

local function showNativeNotification(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, false)
end

RegisterCommand('consumernotify', function()
    if GetResourceState(notifyAdapterResource) ~= 'started' then
        local message = 'Notify adapter is not started.'

        showNativeNotification(message)
        print(('[msc_notify_consumer_test] %s Start %s before using /consumernotify.'):format(message, notifyAdapterResource))
        return
    end

    exports[notifyAdapterResource]:notify({
        title = 'Consumer Test',
        description = 'This notification was called from another resource.',
        type = 'inform'
    })
end, false)
