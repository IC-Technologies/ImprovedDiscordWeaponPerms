-------------------------------
-- ImprovedDiscordWeaponPerms -
--------IC-Technologies--------
-------------------------------

RegisterNetEvent("ImprovedDiscordWeaponPerms:CheckPerms")
AddEventHandler("ImprovedDiscordWeaponPerms:CheckPerms", function()
	local src = source
	local userRoles = {}

	for k, v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("discord:")) == "discord:" then
			identifierDiscord = v
		end
	end

	if identifierDiscord then
		local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)

		if not (roleIDs == false) then
			for i = 1, #roleIDs do
				for role, PEDs in pairs(Config.WeaponRestrictions) do
					if exports.Badger_Discord_API:CheckEqual(role, roleIDs[i]) then
						userRoles[role] = true;
						print("[ImprovedDiscordWeaponPerms] " .. GetPlayerName(src) .. " has received permission for role: " .. tostring(role) );
						if Config.InheritanceEnabled then
							local inheritedRoles = Config.Inheritances[role];
							if inheritedRoles ~= nil then
								--There are inherited roles
								for j = 1, #inheritedRoles do
									userRoles[ inheritedRoles[j] ] = true;
									print("[ImprovedDiscordWeaponPerms] " .. GetPlayerName(src) .. " has inherited role: " .. tostring(inheritedRoles[j]));
								end
							end
						end
					end
				end
			end
		else
		print("[ImprovedDiscordWeaponPerms] " .. GetPlayerName(src) .. " has not gotten their permissions because roleIDs == false")
		end
	elseif identifierDiscord == nil then
		print("[ImprovedDiscordWeaponPerms] " .. "identifierDiscord == nil")
	end
	TriggerClientEvent('ImprovedDiscordWeaponPerms:CheckPerms:Return', src, userRoles)
end)
