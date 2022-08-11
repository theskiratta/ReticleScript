-- ================================================================--
--                          NoReticle 1.0                          --
--                  by Skirata#1227 / theskiratta                  --
-- License: Attribution-NonCommercial-ShareAlike 4.0 International --
-- ================================================================--

-- FUNCTIONS
function IsValidVehicle(current)
	for _, value in ipairs(Skirata.VehicleList) do
		if IsVehicleModel(current, value) then
		   return true
		end
	end
	return false
end

function IsValidWeapon(val) -- Checks if value is listed in config
    for _, value in ipairs(Skirata.WeaponList) do
        if value == val then
            return true
        end
    end
    return false
end

function IsInAllowedVehicle() -- Checks if conditions are met for reticle allowed
	PedID = GetPlayerPed(-1)
	CurrentVehicle = GetVehiclePedIsIn(PedID, true)
	if IsValidVehicle(CurrentVehicle) then
		return true
	else
		return false
	end
end

function IsAllowedWeapon() -- Checks if conditions are met for reticle allowed
	PedID = GetPlayerPed(-1)
	Weapon = GetSelectedPedWeapon(PedID)
	if IsValidWeapon(Weapon) then
		return true
	else
		return false
	end
end

-- CHECKS IF RETICLE ALLOWED
Citizen.CreateThread(function()
	local ReticleAllowed = false
	while true do
		Citizen.Wait(0)

		if IsAllowedWeapon() then
			ReticleAllowed = true
		elseif IsPedInAnyVehicle(PedID, false) then 
			if IsInAllowedVehicle() then
				ReticleAllowed = true
			else
				ReticleAllowed = false
			end
		else
			ReticleAllowed = false
		end

		if not ReticleAllowed then
			HideHudComponentThisFrame(14)
		end
	end
end)