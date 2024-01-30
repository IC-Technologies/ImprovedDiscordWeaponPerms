-------------------------------
-- ImprovedDiscordWeaponPerms -
--------IC-Technologies--------
-------------------------------

RegisterNetEvent("ImprovedDiscordWeaponPerms:CheckPerms")
AddEventHandler("ImprovedDiscordWeaponPerms:CheckPerms", function()
	local src = source
	local userRoles = nil

	for k, v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("discord:")) == "discord:" then
			identifierDiscord = v
		end
	end

	if identifierDiscord then
		local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)

		if not (roleIDs == false) then
			userRoles = {}
			for i = 1, #roleIDs do
				for role, PEDs in pairs(Config.WeaponRestrictions) do
					if exports.Badger_Discord_API:CheckEqual(role, roleIDs[i]) then
						userRoles[role] = true;
						DebugPrint(GetPlayerName(src) .. " has received permission for role: " .. tostring(role) );
						if Config.InheritanceEnabled then
							local inheritedRoles = Config.Inheritances[role];
							if inheritedRoles ~= nil then
								--There are inherited roles
								for j = 1, #inheritedRoles do
									userRoles[ inheritedRoles[j] ] = true;
									DebugPrint(GetPlayerName(src) .. " has inherited role: " .. tostring(inheritedRoles[j]));
								end
							end
						end
					end
				end
			end
		else
			DebugPrint(GetPlayerName(src) .. " has not gotten their permissions because roleIDs == false")
		end
	elseif identifierDiscord == nil then
		DebugPrint(GetPlayerName(src) .. " did not recieve permissions because they do not have a discord identifier.")
	end
	TriggerClientEvent('ImprovedDiscordWeaponPerms:CheckPerms:Return', src, userRoles)
end)

function DebugPrint(message)
	if Config.debugMode then
		print("[ImprovedDiscordWeaponPerms] " .. message)
	end
end
