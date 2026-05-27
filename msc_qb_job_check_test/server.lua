local QBCore = nil
local lastCheckAt = {}

local function getQBCoreObject()
    if QBCore then
        return QBCore
    end

    if GetResourceState('qb-core') ~= 'started' then
        return nil
    end

    local success, core = pcall(function()
        return exports['qb-core']:GetCoreObject()
    end)

    if not success or type(core) ~= 'table' then
        return nil
    end

    QBCore = core
    return QBCore
end

local function getCooldownSeconds()
    local cooldown = Config.ServerCooldownSeconds

    if type(cooldown) ~= 'number' or cooldown < 0 then
        return 5
    end

    return cooldown
end

local function sendMessage(src, message)
    if type(message) ~= 'string' or message == '' then
        return
    end

    TriggerClientEvent('msc_qb_job_check_test:client:showJobMessage', src, message)
end

RegisterNetEvent('msc_qb_job_check_test:server:checkJob', function()
    local src = source
    local now = os.time()
    local cooldown = getCooldownSeconds()

    if lastCheckAt[src] and now - lastCheckAt[src] < cooldown then
        sendMessage(src, Config.Messages.Cooldown)
        return
    end

    lastCheckAt[src] = now

    local core = getQBCoreObject()

    if not core or type(core.Functions) ~= 'table' or type(core.Functions.GetPlayer) ~= 'function' then
        print('[msc_qb_job_check_test] Warning: qb-core is unavailable or GetPlayer is missing.')
        sendMessage(src, 'QBCore is not available. Please make sure qb-core is started before this resource.')
        return
    end

    local Player = core.Functions.GetPlayer(src)

    if not Player or type(Player) ~= 'table' then
        sendMessage(src, Config.Messages.PlayerNotFound)
        return
    end

    local playerData = Player.PlayerData
    local job = playerData and playerData.job

    if type(job) ~= 'table' then
        sendMessage(src, Config.Messages.NoJobData)
        return
    end

    local jobName = tostring(job.name or 'unknown')
    local jobLabel = tostring(job.label or jobName)
    local gradeData = job.grade
    local gradeLevel = 'unknown'
    local gradeName = 'unknown'

    if type(gradeData) == 'table' then
        gradeLevel = tostring(gradeData.level or 'unknown')
        gradeName = tostring(gradeData.name or 'unknown')
    end

    local message = Config.Messages.JobDisplay:format(jobLabel, jobName, gradeLevel, gradeName)
    sendMessage(src, message)

    if Config.Debug then
        print(('[msc_qb_job_check_test] Job check completed for source %s'):format(src))
    end
end)

AddEventHandler('playerDropped', function()
    lastCheckAt[source] = nil
end)
