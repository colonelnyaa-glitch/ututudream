RegisterCommand('consumernotify', function()
    exports['msc_notify_adapter_test']:notify({
        title = 'Consumer Test',
        description = 'This notification was called from another resource.',
        type = 'inform'
    })
end, false)
