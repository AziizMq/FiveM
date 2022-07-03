
local QBCore = exports['qb-core']:GetCoreObject()
local SpawnedObjects = {}
local flag = false
local zcoords
local ObjectName = 'prop_barrier_wat_03b'

function loadModel(model)
    if type(model) == 'number' then
        model = model
    else
        model = GetHashKey(model)
    end
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
end

LoadModel = function(model)
    local Timer = GetGameTimer() + 5000
    while not HasModelLoaded(model) do
        Wait(0)
        RequestModel(model)
        if GetGameTimer() >= Timer then
            return false
        end
    end
    return model
end

local function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

local function RayCastGamePlayCamera(distance)
	local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, -1, 1))
	return b, c, e
end

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)

		local hit, coords, entity = RayCastGamePlayCamera(1000.0)

        zcoords = coords

		if flag then
			local position = GetEntityCoords(GetPlayerPed(-1))
			DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, 255, 0, 0, 255)
		end
	end
end)

CreateThread(function()
    Citizen.CreateThread(function()
        while true do
            if IsControlJustPressed(0, 126) then
                PlaySoundFrontend(-1, "Hit_1", "LONG_PLAYER_SWITCH_SOUNDS", 0)
                add()
            end
            if IsControlJustPressed(0, 123) then
                PlaySoundFrontend(-1, "Hit_1", "LONG_PLAYER_SWITCH_SOUNDS", 0)
                removed()
            end
            if IsControlJustPressed(0, 124) then
                PlaySoundFrontend(-1, "Hit_1", "LONG_PLAYER_SWITCH_SOUNDS", 0)
                if flag then
                    flag = false
                    QBCore.Functions.Notify( "Flag Off" , 'error')
                else
                    flag = true
                    QBCore.Functions.Notify( "Flag On" , 'success')
                end
                
            end
            Citizen.Wait(sleep)
        end
    end)    
end)



function removed() 
    local sOL = #SpawnedObjects
    if sOL == 0 then
        QBCore.Functions.Notify("nothing to Remove", 'error')
    else
        obj = SpawnedObjects[sOL]
        DeleteObject(obj)
        table.remove(SpawnedObjects, sOL)
        QBCore.Functions.Notify("Remove", 'success') 
    end
end


function add()    
    local cameraCoord = GetGameplayCamCoord()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local trolley = GetClosestObjectOfType(zcoords, 0.3, GetHashKey(ObjectName), false)
    if not DoesEntityExist(trolley) then
        trolley = CreateObject(LoadModel(GetHashKey(ObjectName)), zcoords, false)
        NetworkRegisterEntityAsNetworked(trolley)
        SetNetworkIdCanMigrate(ObjToNet(trolley))
        SetNetworkIdExistsOnAllMachines(ObjToNet(trolley))
        FreezeEntityPosition(trolley, true)
        SetEntityRotation(trolley, 0)            
        table.insert(SpawnedObjects, trolley) 
    end  
    QBCore.Functions.Notify("Add", 'success')           
end

RegisterCommand("zZ", function(source, args, raw)
	ObjectName = string.sub(raw,4,-1)
end)