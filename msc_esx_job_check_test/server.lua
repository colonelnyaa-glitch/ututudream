local ESX = nil
local lastCheckAt = {}

local function getESXObject()
    if ESX then
        return ESX
    end

    if GetResourceState('es_extended') ~= 'started' then
        return nil
    end

    local success, object = pcall(function()
        return exports['es_extended']:getSharedObject()
    end)

    if not success or type(object) ~= 'table' then
        return nil
    end

    ESX = object
    return ESX
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

    TriggerClientEvent('msc_esx_job_check_test:client:showJobMessage', src, message)
end

RegisterNetEvent('msc_esx_job_check_test:server:checkJob', function()
    local src = source
    local now = os.time()
    local cooldown = getCooldownSeconds()

    if lastCheckAt[src] and now - lastCheckAt[src] < cooldown then
        sendMessage(src, Config.Messages.Cooldown)
        return
    end

    lastCheckAt[src] = now

    local esx = getESXObject()

    if not esx or type(esx.GetPlayerFromId) ~= 'function' then
        print('[msc_esx_job_check_test] Warning: es_extended is unavailable or GetPlayerFromId is missing.')
        sendMessage(src, Config.Messages.ESXUnavailable)
        return
    end

    local xPlayer = esx.GetPlayerFromId(src)

    if not xPlayer then
        sendMessage(src, Config.Messages.PlayerNotFound)
        return
    end

    local job = nil

    if type(xPlayer.getJob) == 'function' then
        job = xPlayer.getJob()
    elseif type(xPlayer.job) == 'table' then
        job = xPlayer.job
    end

    if type(job) ~= 'table' then
        sendMessage(src, Config.Messages.NoJobData)
        return
    end

    local jobName = tostring(job.name or 'unknown')
    local jobLabel = tostring(job.label or jobName)
    local gradeLevel = tostring(job.grade or 'unknown')
    local gradeName = tostring(job.grade_label or job.grade_name or 'unknown')

    local message = Config.Messages.JobDisplay:format(jobLabel, jobName, gradeLevel, gradeName)
    sendMessage(src, message)

    if Config.Debug then
        print(('[msc_esx_job_check_test] Job check completed for source %s'):format(src))
    end
end)

AddEventHandler('playerDropped', function()
    lastCheckAt[source] = nil
end)
