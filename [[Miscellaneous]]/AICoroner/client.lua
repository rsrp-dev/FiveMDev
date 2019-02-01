-- Config --
local companyName = "CountyCoroner"
local spawnDistance = 20
local drivingStyle = 786603
--  **786603  - "Normal" - Default**
--  **1074528293 - "Rushed"**
--  **2883621 - "Ignore Lights"**
--  **5 - "Sometimes Overtake Traffic"**
--  **Customize Driving Style: https://vespura.com/drivingstyle/
local CoronerQuote = {"I'll scoop em' up","Who dropped a red paintcan"}
local distanceToCheck = 5.0 --Checks in front of player

-- Setup--

--sets commands
RegisterCommand("coroner", function(source, args, raw)
TriggerEvent("callcoroner")
end, false)

RegisterCommand("cancelcoroner", function(source, args, raw)
TriggerEvent("cancelcoroner")
end, false)

--Register a network event
RegisterNetEvent{"callcoroner"}
RegisterNetEvent{"cancelcoroner"}

--Gets Models
enroute = false
onscene = false
cleartask = false
AddEventHandler( "callcoroner", function()
local player = GetPlayerPed(-1)
local playerPos = GetEntityCoords(player)
local pmodels = {"s_m_m_paramedic_01"}
local vehicles = {"ambulance"}
local driver = GetHashKey(pmodels[math.random(#pmodels)])
local vehiclehash = GetHashKey(vehicles[math.random(#vehicles)])
local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, distanceToCheck, 0.0)
RequestModel(vehiclehash)
RequestModel(driver)



while not HasModelLoaded(vehiclehash) and RequestModel(driver) do


  RequestModel(vehiclehash)
  RequestModel(driver)
  Citizen.Wait(0)
end

--check for dead peds in radius and sets as target
local foundped, checkped = GetEntityPlayerIsFreeAimingAt(PlayerId())
if foundped then
  if DoesEntityExist(checkped) and IsEntityAPed(checkped) and IsPedFatallyInjured(checkped, 1) and not IsPedAPlayer(checkped) then
    ShowNotification("AI Body Detected")
    targetPed = checkped
  elseif DoesEntityExist(checkped) and IsEntityAPed(checkped) and IsPedAPlayer(checkped) and IsPedDeadOrDying(checkped, 1) then
    ShowNotification("Player Body Detected")
    targetPed = checkped
  end
end

--Tells driver to go to location if everything is correct
if DoesEntityExist(targetPed) then
  TriggerEvent("radio")
  Wait(math.random(2000, 6000))

  local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
  local heading, vector = GetNthClosestVehicleNode(x, y, z, spawnDistance, 0, 0, 0)
  local sX, sY, sZ = table.unpack(vector)
  vehicle = CreateVehicle(vehiclehash, sX, sY, sZ, heading, true, true)

  local vehiclehash = GetHashKey(vehicle)

  driver = CreatePedInsideVehicle(vehicle, 26, driver, -1, true, false)
  local pedpos = GetEntityCoords(targetPed)
  TaskVehicleDriveToCoord(driver, vehicle, pedpos.x, pedpos.y, pedpos.z, 17.0, 0, vehiclehash, drivingStyle, 1.0, true)
  SetVehicleFixed(vehicle)
  SetVehicleOnGroundProperly(vehicle)
  if DoesEntityExist(driver) and DoesEntityExist(vehicle) then
    SetEntityAsMissionEntity(driver, true, true)
    towblip = AddBlipForEntity(vehicle)
    SetBlipColour(towblip, 29)
    SetBlipFlashes(towblip, true)

    --Sets ETA
    local distanceToScene = GetDistanceBetweenCoords(GetEntityCoords(vehicle), GetEntityCoords(targetPed))

    if distanceToScene < 100 then
      eta = '~g~1 Mike'
    elseif distanceToScene < 300 then
      eta = '~g~2 Mikes'
    elseif distanceToScene < 500 then
      eta = '~o~3 Mikes'
    elseif distanceToScene > 500 then
      eta = '~r~5 Mikes'
    end
    ShowNotification("A coroner has been dispatched to your location. Thanks for using ~y~" .. companyName .. "~w~\nETA: " .. eta)

    --Starts enroute
    enroute = true
    while (enroute) do
      Citizen.Wait(300)
      local distanceToScene = GetDistanceBetweenCoords(GetEntityCoords(vehicle), GetEntityCoords(targetPed), 1)
      SetEntityInvincible(vehicle, true)
      SetEntityInvincible(driver, true)
      if distanceToScene <= 15 then
        SetVehicleIndicatorLights(vehicle, 1, true)
        SetVehicleIndicatorLights(vehicle, 2, true)
        TaskVehicleTempAction(driver, vehicle, 27, 5000)
        Wait(5000)
          if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) and IsPedFatallyInjured(targetPed, 1) and not IsPedAPlayer(targetPed) then
            DeleteEntity(targetPed)
          elseif DoesEntityExist(targetPed) and IsEntityAPed(targetPed) and IsPedAPlayer(targetPed) and IsPedFatallyInjured(targetPed, 1) then
            respawnPed(targetPed, coords)
          end
        SetDriveTaskDrivingStyle(vehicle, 786603)
        TaskVehicleDriveWander(driver, vehicle, 17.0, drivingStyle)
        SetVehicleSiren(vehicle, false)
        ShowNotification("~o~Coroner:~w~ " .. CoronerQuote[math.random(#Coroner)])
        SetEntityAsNoLongerNeeded(vehicle)
        enroute = false
        towblip = RemoveBlip(towblip)
        SetVehicleIndicatorLights(vehicle, 1, false)
        SetVehicleIndicatorLights(vehicle, 2, false)
        SetEntityInvincible(vehicle, false)
        SetEntityInvincible(driver, false)
        SetEntityAsNoLongerNeeded(vehicle)
        SetEntityAsNoLongerNeeded(driver)
        SetEntityAsNoLongerNeeded(targetPed)
        wait(20000)
        DeleteEntity(vehicle)
        DeleteEntity(driver)
      end
    end
  end
else
  ShowNotification("~o~No Bodies Found")
end
end)

AddEventHandler( "cancelcoroner", function()
if enroute == true then
  ShowNotification("Coroner request has been canceled. Thank you for using ~y~" .. companyName)

  SetEntityAsMissionEntity(vehicle)
  SetEntityAsMissionEntity(driver)

  DeleteEntity(vehicle)
  DeleteEntity(driver)
  enroute = false
end
end)

RegisterNetEvent("radio")
AddEventHandler("radio", function()
Citizen.CreateThread(function()
TaskPlayAnim(player, "random@arrests", "generic_radio_enter", 1.5, 2.0, -1, 50, 2.0, 0, 0, 0 )
Citizen.Wait(6000)
ClearPedTasks(player)
end)
end)

function loadAnimDict( dict )
  while ( not HasAnimDictLoaded( dict ) ) do
    RequestAnimDict( dict )
    Citizen.Wait( 0 )
  end
end

-- Shows a notification on the player's screen
function ShowNotification( text )
  SetNotificationTextEntry( "STRING" )
  AddTextComponentString( text )
  DrawNotification( false, false )
end

--- Respawn Shit ---
function respawnPed(targetPed, coords)
  SetEntityCoordsNoOffset(targetPed, coords.x, coords.y, coords.z, false, false, false, true)
  NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false) 

  SetPlayerInvincible(targetPed, false) 

  TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
  ClearPedBloodDamage(targetPed)
end

local allowRespawn = false


  function createSpawnPoint(x1,x2,y1,y2,z,heading)
    local xValue = math.random(x1,x2) + 0.0001
    local yValue = math.random(y1,y2) + 0.0001
    
    local spawnPoints = {}
    local newObject = {
      x = xValue,
      y = yValue,
      z = z + 0.0001,
      heading = heading + 0.0001
    }
    table.insert(spawnPoints,newObject)
  end

  createSpawnPoint(-448, -448, -340, -329, 35.5, 0) -- Mount Zonah
  createSpawnPoint(372, 375, -596, -594, 30.0, 0)   -- Pillbox Hill
  createSpawnPoint(335, 340, -1400, -1390, 34.0, 0) -- Central Los Santos
  createSpawnPoint(1850, 1854, 3700, 3704, 35.0, 0) -- Sandy Shores
  createSpawnPoint(-247, -245, 6328, 6332, 33.5, 0) -- Paleto
  --createSpawnPoint(1152, 1156, -1525, -1521, 34.9, 0) -- St. Fiacre

  local coords = spawnPoints[math.random(1,#spawnPoints)]
