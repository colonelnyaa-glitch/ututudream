Config = {}

Config.Command = 'esxjobcheck'
Config.ServerCooldownSeconds = 5
Config.Debug = false

Config.Messages = {
    RequestSent = 'Checking your ESX job on the server...',
    Cooldown = 'Please wait before checking your job again.',
    ESXUnavailable = 'ESX is not available. Please make sure es_extended is started before this resource.',
    PlayerNotFound = 'Unable to find your ESX player data.',
    NoJobData = 'Your ESX job data is not available.',
    JobDisplay = 'Your job is %s (%s), grade %s (%s).'
}
