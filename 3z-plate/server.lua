local QBCore = exports['qb-core']:GetCoreObject()

local src = nil
local ped = nil
local vehicle = nil
local plate = nil
local Id = nil
local IsThere = nil



QBCore.Functions.CreateCallback('3z-plate:checkOwned', function(source, cb)
    src = source
    ped = GetPlayerPed(src)
    vehicle = GetVehiclePedIsIn(ped, false)
    plate = GetVehicleNumberPlateText(vehicle)
    Id = MySQL.Sync.fetchScalar('SELECT id FROM player_vehicles WHERE plate = ?', {plate})
    IsThere = MySQL.Sync.fetchAll('SELECT plate FROM player_vehicles WHERE balance = ?', {""})
    if Id then
        cb(true)
    else
        TriggerClientEvent('3z-Notify',source ,Lang:t('error.ownermassage'), 'error')
        cb(false)
    end
end)

RegisterServerEvent('3z-plate:setplate')
AddEventHandler('3z-plate:setplate', function(vehplate)
    local pData = QBCore.Functions.GetPlayer(source)
    local flag = false
    for i = 1, #IsThere do 
        --TriggerClientEvent('3z-Notify', source, IsThere[i].plate , 'success')
        if IsThere[i].plate == vehplate then
            flag = true
        end
    end
    if flag then 
        TriggerClientEvent('3z-Notify',source ,Lang:t('error.plate'), 'error')         
    else
        TriggerClientEvent('3z-notThere',source, vehplate)
        if pData.Functions.GetMoney('cash') > Config.ChangePlateCosts then
            pData.Functions.RemoveMoney('cash', Config.ChangePlateCosts )
            TriggerClientEvent('3z-Notify', source, Lang:t('Costs.massage'), 'success')
            Wait(500)
            local NewPlate = vehplate
            if Id then
                SetVehicleNumberPlateText(vehicle, NewPlate)
                MySQL.Async.execute('UPDATE player_vehicles SET plate = ? WHERE id = ?', {NewPlate, Id})
                TriggerClientEvent('3z-Notify', source ,Lang:t('success.massage'), "success")
            else
                TriggerClientEvent('3z-Notify',source ,Lang:t('error.massage'), 'error')
            end 
        elseif pData.Functions.GetMoney('bank') > Config.ChangePlateCosts then
            pData.Functions.RemoveMoney('bank', Config.ChangePlateCosts , Lang:t('Costs.massage'))
            local NewPlate = vehplate
            if Id then
                SetVehicleNumberPlateText(vehicle, NewPlate)
                SetVehicleNeedsToBeHotwired(vehicle, false)
                MySQL.Async.execute('UPDATE player_vehicles SET plate = ? WHERE id = ?', {NewPlate, Id})
                TriggerClientEvent('3z-Notify', source ,Lang:t('success.massage'), "success")
            else
                TriggerClientEvent('3z-Notify',source ,Lang:t('error.massage'), 'error')
            end 
        else
            TriggerClientEvent('3z-Notify',source ,Lang:t('Costs.emassage'), 'error')
        end
    end
    --Reset
    src = nil
    ped = nil
    vehicle = nil
    plate = nil
    Id = nil  
    IsThere = nil
end)

