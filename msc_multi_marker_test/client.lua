local createdBlips = {}

local function showHelpNotification(message)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

local function showNotification(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, false)
end

local function getInteractionConfig()
    if type(Config.Interaction) ~= 'table' then
        return {}
    end

    return Config.Interaction
end

local function formatHelpMessage(message)
    if type(message) ~= 'string' or message == '' then
        message = 'Press {key} to interact with this marker.'
    end

    local interactionConfig = getInteractionConfig()
    local keyLabel = interactionConfig.KeyLabel or 'E'

    if type(keyLabel) ~= 'string' or keyLabel == '' then
        keyLabel = 'E'
    end

    return message:gsub('{key}', keyLabel)
end

local function getInteractionControl()
    local control = getInteractionConfig().Control

    if type(control) ~= 'number' then
        return 38
    end

    return control
end

local function getNotificationMessage()
    local message = getInteractionConfig().NotificationMessage

    if type(message) ~= 'string' or message == '' then
        return 'Marker interaction triggered.'
    end

    return message
end

local function getLocations()
    if type(Config.Locations) ~= 'table' then
        return {}
    end

    return Config.Locations
end

local function hasValidCoords(location)
    if type(location) ~= 'table' or not location.coords then
        return false
    end

    local success, x, y, z = pcall(function()
        return location.coords.x, location.coords.y, location.coords.z
    end)

    return success and type(x) == 'number' and type(y) == 'number' and type(z) == 'number'
end

local function getMarkerConfig(location)
    return location.marker or {}
end

local function getBlipConfig(location)
    return location.blip or {}
end

local function createLocationBlip(location)
    if not hasValidCoords(location) then
        return
    end

    local blipConfig = getBlipConfig(location)

    if not blipConfig.enabled then
        return
    end

    local blip = AddBlipForCoord(location.coords.x, location.coords.y, location.coords.z)

    SetBlipSprite(blip, blipConfig.sprite or 280)
    SetBlipDisplay(blip, blipConfig.display or 4)
    SetBlipScale(blip, blipConfig.scale or 0.85)
    SetBlipColour(blip, blipConfig.color or 3)
    SetBlipAsShortRange(blip, blipConfig.shortRange ~= false)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(location.name or 'Marker')
    EndTextCommandSetBlipName(blip)

    createdBlips[#createdBlips + 1] = blip
end

local function createConfiguredBlips()
    for _, location in ipairs(getLocations()) do
        createLocationBlip(location)
    end
end

local function removeCreatedBlips()
    for index, blip in ipairs(createdBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end

        createdBlips[index] = nil
    end
end

local function drawConfiguredMarker(location, markerConfig)
    local size = markerConfig.size or {}
    local color = markerConfig.color or {}

    DrawMarker(
        markerConfig.type or 1,
        location.coords.x,
        location.coords.y,
        location.coords.z,
        0.0, 0.0, 0.0,
        0.0, 0.0, 0.0,
        size.x or 1.5,
        size.y or 1.5,
        size.z or 1.0,
        color.r or 0,
        color.g or 150,
        color.b or 255,
        color.a or 150,
        false,
        true,
        2,
        false,
        nil,
        nil,
        false
    )
end

CreateThread(function()
    createConfiguredBlips()
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then
        return
    end

    removeCreatedBlips()
end)

CreateThread(function()
    while true do
        local sleep = Config.FarWait or 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        local closestHelpMessage = nil
        local closestHelpDistance = nil
        local closestLocation = nil

        for _, location in ipairs(getLocations()) do
            if hasValidCoords(location) then
                local markerConfig = getMarkerConfig(location)

                if markerConfig.enabled ~= false then
                    local drawDistance = markerConfig.drawDistance or Config.DefaultDrawDistance or 25.0
                    local distance = #(playerCoords - location.coords)

                    if distance <= drawDistance then
                        sleep = Config.NearWait or 0
                        drawConfiguredMarker(location, markerConfig)

                        local interactDistance = markerConfig.interactDistance or Config.DefaultInteractDistance or 2.0

                        if distance <= interactDistance then
                            local helpMessage = formatHelpMessage(location.helpMessage)

                            if not closestHelpDistance or distance < closestHelpDistance then
                                closestHelpDistance = distance
                                closestHelpMessage = helpMessage
                                closestLocation = location
                            end
                        end
                    end
                end
            end
        end

        if closestHelpMessage then
            showHelpNotification(closestHelpMessage)

            if closestLocation and IsControlJustReleased(0, getInteractionControl()) then
                showNotification(getNotificationMessage())
            end
        end

        Wait(sleep)
    end
end)
