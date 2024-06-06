-- Car Spawn

function spawnVehicle(vehicleHash)
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)

    if IsModelInCdimage(vehicleHash) and IsModelAVehicle(vehicleHash) then
        RequestModel(vehicleHash)
        while not HasModelLoaded(vehicleHash) do
            Citizen.Wait(0)
        end

        local vehicle = CreateVehicle(vehicleHash, playPos.x, playerPox.y, playerPos.z, GetEntityHeading(playerPed), true, false)

        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

        SetModelAsNoLongerNeeded(vehicleHash)

        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"Me", "Vehicle spawned successfully!"}
        })
    else

        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"Me", "Invalid Vehicle Model."}
        })
    end
end

RegisterCommand('car', function(source, args)
    if #args > 0 then
        local vehicleHash = GetHashKey(args[1])
        spawnVehicle(vehicleHash)
    else
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"Me", "Please Provide a vehicle model name or hash"}
        })
    end

end, false)