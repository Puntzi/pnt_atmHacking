Config = Config or {}

Config.PoliceNameDatabase = 'police'
Config.MinPolice = 1

Config.HackingDevice = 'hack_device'

Config.Payment = {
    type = 'money', -- money, black_money
    quantity = math.random(2000, 3000),
}

Config.ModelATM = {
    'prop_atm_01',
    'prop_atm_02',
    'prop_atm_03',
    'prop_fleeca_atm'
}

Config.BlipRob = {
    sprite = 161,
    scale = 0.6,
    color = 1,
    timeToDelete = 40, -- Time to delete the blip created in seconds
}

-- If u activate both minigames it will choose random 1 minigame everytime
Config.MiniGames = {
    Thermite = {
        active = true,
        timeToFail = 10, -- In Seconds
        gridSize = 5,
        incorrectBlocks = 3
    },

    Scrambler = {
        active = true,
        type = 'numeric', -- alphabet, numeric, alphanumeric, greek, braille, runes
        timeToFail = 10,  -- In Seconds
        mirrored = 0, -- 0:Normal, 1:Normal + Mirrored, 2:Mirrored only
    }
}



