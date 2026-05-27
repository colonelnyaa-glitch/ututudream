local function getNotifyProvider()
    if Config.NotifyProvider == 'ox_lib' then
        return 'ox_lib'
    end

    return 'native'
end

local function getTestNotification()
    if type(Config.TestNotification) ~= 'table' then
        return {
            title = 'Notify Adapter Test',
            description = 'This is a test notification.',
            type = 'inform'
        }
    end

    return Config.TestNotification
end

local function getCommandName()
    if type(Config.Command) ~= 'string' or Config.Command == '' then
        return 'testnotify'
    end

    return Config.Command
end

local function getNotificationData(notification)
    if type(notification) ~= 'table' then
        return {}
    end

    return notification
end

local function getNotificationTitle(notification)
    notification = getNotificationData(notification)

    local title = notification.title

    if type(title) ~= 'string' or title == '' then
        return 'Notify Adapter Test'
    end

    return title
end

local function getNotificationDescription(notification)
    notification = getNotificationData(notification)

    local description = notification.description

    if type(description) ~= 'string' or description == '' then
        return 'Notification triggered.'
    end

    return description
end

local function getNotificationType(notification)
    notification = getNotificationData(notification)

    if type(notification.type) ~= 'string' or notification.type == '' then
        return 'inform'
    end

    return notification.type
end

local function getNativeMessage(notification)
    return ('%s: %s'):format(getNotificationTitle(notification), getNotificationDescription(notification))
end

local function showNativeNotification(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, false)
end

local function canUseOxLibNotify()
    return type(_G.lib) == 'table' and type(_G.lib.notify) == 'function'
end

local function showOxLibNotification(notification)
    _G.lib.notify({
        title = getNotificationTitle(notification),
        description = getNotificationDescription(notification),
        type = getNotificationType(notification)
    })
end

local function notify(notification)
    local provider = getNotifyProvider()

    if provider == 'ox_lib' and canUseOxLibNotify() then
        showOxLibNotification(notification)
        return
    end

    showNativeNotification(getNativeMessage(notification))
end

RegisterCommand(getCommandName(), function()
    notify(getTestNotification())
end, false)
