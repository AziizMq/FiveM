local QBCore = exports['qb-core']:GetCoreObject()
local coords = Config.coords
local KeysList = {}

RegisterNUICallback('NUICB', function(data, cb) 
   SetNuiFocus(false, false)
   if data.plate then 
        TriggerServerEvent("3z-plate:setplate", data.plate)	
   end
end)

RegisterNetEvent('3z-Notify', function(text, state)
    QBCore.Functions.Notify(text, state)
end)

RegisterNetEvent('3z-notThere', function(cbplate)
    local vehplate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
    SetVehicleNumberPlateText(vehplate, cbplate)
    TriggerEvent("vehiclekeys:client:SetOwner", cbplate)
    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId()), false, false, false)   
end)

Citizen.CreateThread(function()
	while true do
        local distance = #(GetEntityCoords(PlayerPedId()) - coords)
        sec = 2000
        if distance <= 8.0 then
            sec = 5
            DrawText3D(coords.x , coords.y  , coords.z , Lang:t('enter.massage', {value = Config.ChangePlateCosts}) )
            if IsControlJustPressed(1, 38)   then
                QBCore.Functions.TriggerCallback('3z-plate:checkOwned', function(data)
                    if data == true then 
                        SetNuiFocus(true, true)
                        SendNUIMessage({ type = "ui"  })
                        Wait(1000)
                    end
                end)
            end
        end
        Citizen.Wait(sec)
	end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.30, 0.30)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 250
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

