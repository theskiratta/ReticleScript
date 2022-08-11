-- ================================================================--
--                          NoReticle 1.0                          --
--                  by Skirata#1227 / theskiratta                  --
-- License: Attribution-NonCommercial-ShareAlike 4.0 International --
-- ================================================================--

-- FUNCTIONS
function IsValidVehicle(val) -- Checks if value is listed in config
    for _, value in ipairs(Skirata.VehicleList) do
        if value == val then
            return true
        end
    end
    return false
end

function IsValidWeapon(val) -- Checks if value is listed in config
    for _, value in ipairs(Skirata.WeaponList) do
        if value == val then
			print("Was found in values")
            return true
        end
    end
    return false
end

function IsInAllowedVehicle() -- Checks if conditions are met for reticle allowed
	PedID = GetPlayerPed(-1)
	CurrentVehicle = GetVehiclePedIsIn(PedID, false)
	if CurrentVehicle == "0" then
		return false
	elseif IsValidVehicle(CurrentVehicle) then
		return true
	else
		return false
	end
end

function IsAllowedWeapon() -- Checks if conditions are met for reticle allowed
	PedID = GetPlayerPed(-1)
	Weapon = GetSelectedPedWeapon(PedID)
	if IsValidWeapon(Weapon) then
		print("IsAllowed returns true")
		return true
	else
		print("IsAllowed returns false")
		return false
	end
end

-- CHECKS IF RETICLE ALLOWED
Citizen.CreateThread(function()
	local ReticleAllowed = false
	while true do
		Citizen.Wait(5)
    	--local ped = GetPlayerPed(-1)
		
		-- print(GetHashKey("WEAPON_SNIPERRIFLE"))
		-- local currentWeaponHash = GetSelectedPedWeapon(ped)
		-- if currentWeaponHash == 100416529 then
		-- 	isSniper = true
		-- elseif currentWeaponHash == 205991906 then
		-- 	isSniper = true
		-- elseif currentWeaponHash == -952879014 then
		-- 	isSniper = true
		if IsAllowedWeapon() then
			ReticleAllowed = true
			print("Weapon allowed")
		elseif IsInAllowedVehicle() then
			ReticleAllowed = true
		end

		if not ReticleAllowed then
			HideHudComponentThisFrame(14)
		end
	end
end)