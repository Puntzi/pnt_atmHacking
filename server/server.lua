local ox_inventory = exports.ox_inventory
local license, discord

ESX.RegisterServerCallback('pnt_atmHacking:checkPolice', function(source, cb)
    local xPlayers = ESX.GetExtendedPlayers('job', Config.PoliceNameDatabase)
    if #xPlayers >= Config.MinPolice then 
        return cb(true)
    end
    return cb(false)
end)

RegisterNetEvent('pnt_atmHacking:callPolice', function()
    for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('robbery_started'))
	end
end)

RegisterNetEvent('pnt_atmHacking:msgPolice', function()
    local xPlayers = ESX.GetExtendedPlayers('job', Config.PoliceNameDatabase)
    
    for _, xPlayer in pairs(xPlayers) do 
        TriggerClientEvent('pnt_atmHacking:msgPolice', xPlayer.source)
    end
end)

RegisterNetEvent('pnt_atmHacking:rob', function(success)
    local xPlayer = ESX.GetPlayerFromId(source)
    local remove  = ox_inventory:RemoveItem(source, Config.HackingDevice, 1)
    if remove then
        if success then
            ox_inventory:AddItem(source, Config.Payment.type, Config.Payment.quantity)
            xPlayer.showNotification(_U('money_earned', ('%s'):format(Config.Payment.quantity)))
        else
            xPlayer.showNotification(_U('hacking_failed'))
        end
    else
        for k,v in pairs(GetPlayerIdentifiers(source)) do
            if string.sub(v, 1, string.len("license:")) == "license:" then
                license = v 
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            end
        end

        print(string.format("Player with FiveM License: %s and discord ID: %s was trying to do some exploit", license, discord))
    end
end)