local lastPingAt = {}

RegisterNetEvent('standalone_test:server:ping', function()
    local src = source
    local now = os.time()
    local cooldown = Config.ServerPingCooldownSeconds

    if type(cooldown) ~= 'number' or cooldown < 0 then
        cooldown = 3
    end

    if lastPingAt[src] and now - lastPingAt[src] < cooldown then
        return
    end

    lastPingAt[src] = now
    local message = Config.ServerMessage

    if type(message) ~= 'string' or message == '' then
        message = 'Standalone test server ping is working.'
    end

    TriggerClientEvent('standalone_test:client:pong', src, message)

    if Config.Debug then
        print(('[standalone_test] Ping received from player %s'):format(src))
    end
end)

AddEventHandler('playerDropped', function()
    lastPingAt[source] = nil
end)
