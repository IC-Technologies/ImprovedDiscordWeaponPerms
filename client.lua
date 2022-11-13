-------------------------------
-- ImprovedDiscordWeaponPerms -
--------IC-Technologies--------
-------------------------------

restrictedWeapons = Config.WeaponRestrictions;
myRoles = nil;

RegisterNetEvent('ImprovedDiscordWeaponPerms:CheckPerms:Return')
AddEventHandler('ImprovedDiscordWeaponPerms:CheckPerms:Return', function(roles)
	myRoles = roles;
end)

Citizen.CreateThread(function()
	TriggerServerEvent("ImprovedDiscordWeaponPerms:CheckPerms")
    while true do
        Citizen.Wait(Config.updateTime)
		local PlayerPED = PlayerPedId()
		local playerWeapon = GetSelectedPedWeapon(PlayerPED)
		local playerComponentHash = nil;
		local playerComponentName = nil;
		local playerWeaponName = nil;
		local requiredPerm = nil;
		hasPerm = false;

		for role, val in pairs(myRoles) do
			if (val == true) then
				local weapons = Config.WeaponRestrictions[role];
				for i = 1, #weapons do
					if (weapons[i] ~= nil) then
						if (playerWeapon == GetHashKey(tostring(weapons[i]))) then
							requiredPerm = true;
							hasPerm = true;
						elseif HasPedGotWeaponComponent(PlayerPED, playerWeapon, GetHashKey(tostring(weapons[i]))) then 
							requiredPerm = true;
							hasPerm = true;
						end
					end
				end
			end
		end

		if not hasPerm then
			local weapons = Config.WeaponRestrictions;
			for role, weaponList in pairs(weapons) do
				for i = 1, #weaponList do
					if (playerWeapon == GetHashKey(tostring(weaponList[i]))) then
						requiredPerm = true;
						playerWeaponName = weaponList[i];
					elseif HasPedGotWeaponComponent(PlayerPED, playerWeapon, GetHashKey(tostring(weaponList[i]))) then 
						requiredPerm = true;
						playerComponentHash = GetHashKey(tostring(weaponList[i]));
						playerComponentName = tostring(weaponList[i]);
					end
				end
			end
		end

		-- If doesn't have permission, it's a restricted weapon/component to them
		if not hasPerm and (requiredPerm ~= nil) then
			if playerComponentHash ~= nil then
				RemoveWeaponComponentFromPed(PlayerPED, playerWeapon, playerComponentHash)
				if Config.showWeaponOrComponentName then
					DisplayNotification(Config.ComponentRestrictedMessage .. " (" .. playerComponentName .. ")")
				else
					DisplayNotification(Config.ComponentRestrictedMessage)
				end
			else
				if (playerWeapon ~= nil) and (playerWeapon ~= 0) then
					RemoveWeaponFromPed(PlayerPED, playerWeapon)
					if Config.showWeaponOrComponentName then
						DisplayNotification(Config.WeaponRestrictedMessage .. " (" .. playerWeaponName .. ")")
					else
						DisplayNotification(Config.WeaponRestrictedMessage)
					end
				end
			end
		end
	end
end)

function DisplayNotification( text )
	if Config.usingTnotify then
		exports['t-notify']:Alert({
			style = 'error',
			message = text
		})
	else
		SetNotificationTextEntry( "STRING" )
		AddTextComponentString( text )
		DrawNotification( false, false )
	end
end