Config = {}

Config.DefaultDrawDistance = 25.0
Config.DefaultInteractDistance = 2.0
Config.FarWait = 1000
Config.NearWait = 0

Config.Locations = {
    {
        name = 'Legion Square Test Marker',
        coords = vector3(215.76, -810.12, 30.73),
        helpMessage = 'Press ~INPUT_CONTEXT~ to test the Legion Square marker.',
        marker = {
            enabled = true,
            drawDistance = 25.0,
            interactDistance = 2.0,
            type = 1,
            size = {
                x = 1.5,
                y = 1.5,
                z = 1.0
            },
            color = {
                r = 0,
                g = 150,
                b = 255,
                a = 150
            }
        },
        blip = {
            enabled = true,
            sprite = 280,
            display = 4,
            scale = 0.85,
            color = 3,
            shortRange = true
        }
    },
    {
        name = 'Sandy Shores Test Marker',
        coords = vector3(1853.62, 3688.79, 34.27),
        helpMessage = 'Press ~INPUT_CONTEXT~ to test the Sandy Shores marker.',
        marker = {
            enabled = true,
            drawDistance = 30.0,
            interactDistance = 2.5,
            type = 1,
            size = {
                x = 1.75,
                y = 1.75,
                z = 1.0
            },
            color = {
                r = 255,
                g = 180,
                b = 0,
                a = 150
            }
        },
        blip = {
            enabled = true,
            sprite = 280,
            display = 4,
            scale = 0.85,
            color = 5,
            shortRange = true
        }
    },
    {
        name = 'Paleto Bay Test Marker',
        coords = vector3(-103.49, 6477.59, 31.63),
        helpMessage = 'Press ~INPUT_CONTEXT~ to test the Paleto Bay marker.',
        marker = {
            enabled = true,
            drawDistance = 30.0,
            interactDistance = 2.5,
            type = 1,
            size = {
                x = 1.75,
                y = 1.75,
                z = 1.0
            },
            color = {
                r = 90,
                g = 220,
                b = 120,
                a = 150
            }
        },
        blip = {
            enabled = false,
            sprite = 280,
            display = 4,
            scale = 0.85,
            color = 2,
            shortRange = true
        }
    }
}
