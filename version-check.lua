function GetCurrentVersion()
	return GetResourceMetadata(GetCurrentResourceName(), "version")
end 

PerformHttpRequest("https://raw.githubusercontent.com/IC-Technologies/ImprovedDiscordWeaponPerms/main/version.txt", function(error, updatedVersion, headers)
	Citizen.Wait(2500)
	local currentVersion = GetCurrentVersion()
	if (updatedVersion ~= nil) and (currentVersion ~= nil) then 
		print("Current Version: " .. currentVersion)
		print("Latest Version: " .. updatedVersion)
		if (updatedVersion ~= currentVersion) then
			print('ImprovedDiscordWeaponPerms is outdated, go to https://github.com/IC-Technologies/RP_Commands/releases to get the latest version.')
		else
			print('ImprovedDiscordWeaponPerms is up to date!')
		end
	else 
		print('There was an error in the checks for the latest version, if the issue persists open an issue @ https://github.com/IC-Technologies/ImprovedDiscordWeaponPerms/issues.')
	end 
end)