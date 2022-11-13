# ImprovedDiscordWeaponPerms

## What is it?
ImprovedDiscordWeaponPerms is a Discord based weapon restriction script. It is a fork of [JaredScar's original DiscordWeaponPerms](https://github.com/JaredScar/DiscordWeaponPerms) - I have rewritten it and added inheritances for roles and also added t-notify integration, as well as more config options and seperate messages for components and weapons with model names.

## Requirement
https://forum.cfx.re/t/release-badger-discord-api/1698464

## Configuration
* It should be noted that for `Config.Inheritances`, the roleNames and roleIDs should match up with the ones specified in `Config.WeaponRestrictions`.

* Also, inheritance only inherits the role groups listed. Inheriting `RoleName2` which inherits `RoleName1` would not be inherited for `RoleName3`.
```lua
Config = {
	WeaponRestrictedMessage = "~r~This Weapon is restricted",
	ComponentRestrictedMessage = "~r~This Component is restricted",
	InheritanceEnabled = true,
	-- Set to true if you use the t-notify plugin for notifications.
	usingTnotify = false,
	-- How often the script checks for restricted weapons (in milliseconds)
	updateTime = 2000,
	-- Whether or not the script shows the name of the model being restricted. If true, it will append the weapon/component name to the end of the message.
	showWeaponOrComponentName = true
}

--[[
Weapon components list: https://wiki.rage.mp/index.php?title=Weapons_Components
Weapon list: https://runtime.fivem.net/doc/natives/#_0xBF0FD6E56C964FCB
]]--

-- This Script uses the nicknames for roles listed in Badger_Discord_API. 
Config.WeaponRestrictions = {
	--['RoleName or ID'] = {
	--	"Weapon1/Component1",
	--	"Weapon2/Component2",
	--	"Weapon3/Component3",
	--	"Weapon4/Component4"
	--},

	['RoleName1'] = {
		""
	},
	['RoleName2'] = {
		""
	},
	['RoleName3'] = {
		""
	},
	['RoleName4'] = {
		""
	}
}

-- Requires Config.InheritanceEnabled to be = true
Config.Inheritances = {
	--['RoleName or ID'] = {'RoleName2', 'RoleName3', 'RoleName4'},
	['RoleName1'] = {'RoleName2', 'RoleName3', 'RoleName4'},
	['RoleName2'] = {'RoleName3', 'RoleName4'},
	['RoleName3'] = {'RoleName4'},
	['RoleName4'] = {}
}
```
## Download
https://github.com/IC-Technologies/ImprovedDiscordWeaponPerms
