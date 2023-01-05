local ox_target = exports.ox_target
local ox_inventory = exports.ox_inventory
local MiniGames = Config.MiniGames

ox_target:addModel(Config.ModelATM, {
    {
        name = 'hack_atm',
        event = 'pnt_atmHacking:startHacking',
        icon = 'fa-solid fa-sack-dollar',
        label = _U('hack_atm'),
        distance = 2.5,
        canInteract = function()
            local count = ox_inventory:Search('count', Config.HackingDevice)
            if count > 0 then 
                return true 
            end
        end
    },
})

local function startThermite()
    Wait(1000)
    exports['ps-ui']:Thermite(function(success)
        TriggerServerEvent('pnt_atmHacking:rob', success)
        FreezeEntityPosition(cache.ped, false)
        Clearcache.pedTasks(cache.ped)
    end, MiniGames.Thermite.timeToFail, MiniGames.Thermite.gridSize, MiniGames.Thermite.incorrectBlocks)
end

local function startScrambler()
    Wait(1000)
    exports['ps-ui']:Scrambler(function(success)
        TriggerServerEvent('pnt_atmHacking:rob', success)
        FreezeEntityPosition(cache.ped, false)
        Clearcache.pedTasks(cache.ped)
    end, MiniGames.Scrambler.type, MiniGames.Scrambler.timeToFail, MiniGames.Scrambler.mirrored)
end



RegisterNetEvent('pnt_atmHacking:msgPolice', function()
    local cache.pedCoords = GetEntityCoords(cache.ped)
    local streetName, crossingRoad = GetStreetNameFromHashKey(GetStreetNameAtCoord(cache.pedCoords.x, cache.pedCoords.y, cache.pedCoords.z, 0, 0))

    ESX.ShowNotification(_U("robbing_atm", ('%s')):format(streetName))

    local blip = AddBlipForCoord(cache.pedCoords.x, cache.pedCoords.y, cache.pedCoords.z)

	SetBlipSprite(blip, Config.BlipRob.sprite)
	SetBlipScale(blip, Config.BlipRob.scale)
	SetBlipColour(blip, Config.BlipRob.color)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U("atm_robbing"))
	EndTextCommandSetBlipName(blip)

    Wait(Config.BlipRob.timeToDelete * 1000)

    RemoveBlip(blip)
end)

RegisterCommand('test', function()
    TriggerServerEvent('pnt_atmHacking:msgPolice')
end)

local function chooseMinigame()
    if MiniGames.Thermite and MiniGames.Scrambler then
        local random = math.random(1, 2)
        if random == 1 then
            return startThermite()
        elseif random == 2 then 
            return startScrambler()
        end
    elseif MiniGames.Thermite then 
        return startThermite()
    elseif MiniGames.Scrambler then 
        return startScrambler()
    else
        return print(_U('error_minigame_not_active'))
    end
end


RegisterNetEvent('pnt_atmHacking:startHacking', function()
    ESX.TriggerServerCallback('pnt_atmHacking:checkPolice', function(police)
        if police then
            FreezeEntityPosition(cache.ped, true)
            TaskStartScenarioAtPosition(cache.ped, "WORLD_HUMAN_STAND_MOBILE", GetEntityCoords(cache.ped), GetEntityHeading(cache.ped), 0, 0, 0)
            lib.showTextUI(_U("start_hacking_or_not"))
            CreateThread(function()
                while true do 
                    if IsControlJustPressed(0, 38) then
                        TriggerServerEvent('pnt_atmHacking:msgPolice')
                        FreezeEntityPosition(cache.ped, false)
                        chooseMinigame()
                        lib.hideTextUI()
                        break
                    elseif IsControlJustPressed(0, 74) then 
                        FreezeEntityPosition(cache.ped, false)
                        Clearcache.pedTasks(cache.ped)
                        lib.hideTextUI()
                        break
                    end
                    Wait(0)
                end
            end)
        else
            ESX.ShowNotification(_U('noth_enough_police'))
        end
    end)
end)







