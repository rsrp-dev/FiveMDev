local emotes = {}
emotes['cop'] = {name = 'cop', anim = 'WORLD_HUMAN_COP_IDLES'}
emotes['binoculars'] = {name = 'binoculars', anim = 'WORLD_HUMAN_BINOCULARS'}
emotes['cheer'] = {name = 'cheer', anim = 'WORLD_HUMAN_CHEERING'}
emotes['drink'] = {name = 'drink', anim = 'WORLD_HUMAN_DRINKING'}
emotes['smoke'] = {name = 'smoke', anim = 'WORLD_HUMAN_SMOKING'}
emotes['film'] = {name = 'film', anim = 'WORLD_HUMAN_MOBILE_FILM_SHOCKING'}
emotes['plant'] = {name = 'plant', anim = 'WORLD_HUMAN_GARDENER_PLANT'}
emotes['guard'] = {name = 'guard', anim = 'WORLD_HUMAN_GUARD_STAND'}
emotes['hammer'] = {name = 'hammer', anim = 'WORLD_HUMAN_HAMMERING'}
emotes['hangout'] = {name = 'hangout', anim = 'WORLD_HUMAN_HANG_OUT_STREET'}
emotes['hiker'] = {name = 'hiker', anim = 'WORLD_HUMAN_HIKER_STANDING'}
emotes['statue'] = {name = 'statue', anim = 'WORLD_HUMAN_HUMAN_STATUE'}
emotes['jog'] = {name = 'jog', anim = 'WORLD_HUMAN_JOG_STANDING'}
emotes['lean'] = {name = 'lean', anim = 'WORLD_HUMAN_LEANING'}
emotes['flex'] = {name = 'flex', anim = 'WORLD_HUMAN_MUSCLE_FLEX'}
emotes['camera'] = {name = 'camera', anim = 'WORLD_HUMAN_PAPARAZZI'}
emotes['sit'] = {name = 'sit', anim = 'WORLD_HUMAN_PICNIC'}
emotes['sitchair'] = {name = 'sitchair', anim = 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'}
emotes['hoe'] = {name = 'hoe', anim = 'WORLD_HUMAN_PROSTITUTE_HIGH_CLASS'}
emotes['hoe2'] = {name = 'hoe2', anim = 'WORLD_HUMAN_PROSTITUTE_LOW_CLASS'}
emotes['pushups'] = {name = 'pushups', anim = 'WORLD_HUMAN_PUSH_UPS'}
emotes['situps'] = {name = 'situps', anim = 'WORLD_HUMAN_SIT_UPS'}
emotes['fish'] = {name = 'fish', anim = 'WORLD_HUMAN_STAND_FISHING'}
emotes['impatient'] = {name = 'impatient', anim = 'WORLD_HUMAN_STAND_IMPATIENT'}
emotes['mobile'] = {name = 'mobile', anim = 'WORLD_HUMAN_STAND_MOBILE'}
emotes['diggit'] = {name = 'diggit', anim = 'WORLD_HUMAN_STRIP_WATCH_STAND'}
emotes['sunbath'] = {name = 'sunbath', anim = 'WORLD_HUMAN_SUNBATHE_BACK'}
emotes['sunbath2'] = {name = 'sunbath2', anim = 'WORLD_HUMAN_SUNBATHE'}
emotes['weld'] = {name = 'weld', anim = 'WORLD_HUMAN_WELDING'}
emotes['yoga'] = {name = 'yoga', anim = 'WORLD_HUMAN_YOGA'}
emotes['kneel'] = {name = 'kneel', anim = 'CODE_HUMAN_MEDIC_KNEEL'}
emotes['crowdcontrol'] = {name = 'crowdcontrol', anim = 'CODE_HUMAN_POLICE_CROWD_CONTROL'}
emotes['investigate'] = {name = 'investigate', anim = 'CODE_HUMAN_POLICE_INVESTIGATE'}
emotes['donut'] = {name = 'donut', anim = 'CODE_HUMAN_WANDER_EATING_DONUT'}

playing_emote = false

local Keys = { ["W"] = 32, ["A"] = 34, ["S"] = 8, ["D"] = 9 }

RegisterCommand('emote', function(source, args)
	ped = GetPlayerPed(-1)
	name = args[1]
	if emotes[name] then
		if playing_emote == false then
			if emotes[name].name == "sitchair" then
				pos = GetEntityCoords(ped)
				head = GetEntityHeading(ped)
				TaskStartScenarioAtPosition(ped, emotes[name].anim, pos['x'], pos['y'], pos['z'] - 1, head, 0, 0, false)
			else
				TaskStartScenarioInPlace(ped, emotes[name].anim, 0, true)
			end
			playing_emote = true
		end
	end
	print(args[1])
end)

RegisterCommand('showEmotes', function(source, args)
	TriggerEvent('chatMessage', "^2Emotes", {255, 0, 0}, " (Example: /emote sit)")
	local emoteslist = ""
	for k in pairs(emotes) do
		emoteslist = k .. " ".. emoteslist
	end
	TriggerEvent('chatMessage', "", {255, 0, 0}, emoteslist)
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
		if playing_emote == true then
			if IsControlPressed(1, Keys["W"]) or IsControlPressed(1, Keys["A"]) or IsControlPressed(1, Keys["S"]) or IsControlPressed(1, Keys["D"])  then
				ClearPedTasks(ped)
				playing_emote = false
			end
		end
    end
end)

---------- Cross arms
----------------------------------------------------------------------------------------------------------------------
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
    local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, Keys["G"]) and IsControlPressed(1, Keys["LEFTALT"]) then --Start holding G
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

---------- Finger Point
----------------------------------------------------------------------------------------------------------------------
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)

---------- Rag Doll
----------------------------------------------------------------------------------------------------------------------
local ragdoll = false
function setRagdoll(flag)
  ragdoll = flag
end
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if ragdoll then
      SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
    end
  end
end)

ragdol = true
RegisterNetEvent("Ragdoll")
AddEventHandler("Ragdoll", function()
	if ( ragdol ) then
		setRagdoll(true)
		ragdol = false
	else
		setRagdoll(false)
		ragdol = true
	end
end)

Citizen.CreateThread(function()
 	while true do
 		Citizen.Wait(0)
		if IsControlJustPressed(1, Keys["U"]) and IsControlPressed(1, Keys["LEFTSHIFT"]) then
 			TriggerEvent("Ragdoll", source)
 		end
 	end
 end)
 
 
---------- Gardening
----------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local dict = "amb@world_human_gardener_plant@male@base"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, Keys["H"]) and IsControlPressed(1, Keys["LEFTSHIFT"]) and IsControlPressed(1, Keys["LEFTALT"])then --Start holding H
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

---------- Mime!
----------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local dict = "special_ped@mime@base"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, Keys["Y"]) and IsControlPressed(1, Keys["LEFTALT"]) then --Start holding H
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

---------- Low lean
----------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local dict = "special_ped@impotent_rage@base"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, Keys["U"]) and IsControlPressed(1, Keys["LEFTALT"]) then --Start holding H
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

---------- test
----------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    local dict = "anim@mp_player_intcelebrationpaired@f_f_manly_handshake"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, Keys["L"]) and IsControlPressed(1, Keys["LEFTALT"]) then --Start holding J
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)