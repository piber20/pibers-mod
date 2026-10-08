local modname = "Desecration"

if not REPENTOGON then
	print(modname .. " needs Repentogon to function.")
	return
end

Desecration = {}
Desecration.Mod = RegisterMod(modname, 1)

Desecration.AddedCallbacks = {}
function Desecration.AddCallback(callbackId, callbackFn, entityId)
	Desecration.AddedCallbacks[callbackId] = Desecration.AddedCallbacks[callbackId] or {}
	Desecration.AddedCallbacks[callbackId][#Desecration.AddedCallbacks[callbackId]+1] = {callbackFn}
	Desecration.AddedCallbacks[callbackId][#Desecration.AddedCallbacks[callbackId]][2] = function(...)
		local args = {...}
		return callbackFn(table.unpack(args,2))
	end
	return Desecration.Mod:AddCallback(callbackId, Desecration.AddedCallbacks[callbackId][#Desecration.AddedCallbacks[callbackId]][2], entityId)
end
function Desecration.AddPriorityCallback(callbackId, priority, callbackFn, entityId)
	Desecration.AddedCallbacks[callbackId] = Desecration.AddedCallbacks[callbackId] or {}
	Desecration.AddedCallbacks[callbackId][#Desecration.AddedCallbacks[callbackId]+1] = {callbackFn}
	Desecration.AddedCallbacks[callbackId][#Desecration.AddedCallbacks[callbackId]][2] = function(...)
		local args = {...}
		return callbackFn(table.unpack(args,2))
	end
	return Desecration.Mod:AddPriorityCallback(callbackId, priority, Desecration.AddedCallbacks[callbackId][#Desecration.AddedCallbacks[callbackId]][2], entityId)
end
function Desecration.HasData()
	return Desecration.Mod:HasData()
end
function Desecration.LoadData()
	return Desecration.Mod:LoadData()
end
function Desecration.RemoveCallback(callbackId, callbackFn)
	if Desecration.AddedCallbacks[callbackId] then
		for index,funcs in ipairs(Desecration.AddedCallbacks[callbackId]) do
			if type(funcs) == "table" and funcs[1] == callbackFn then
				return Desecration.Mod:RemoveCallback(callbackId, funcs[2])
			end
		end
	end
end
function Desecration.RemoveData()
	return Desecration.Mod:RemoveData()
end
function Desecration.SaveData(data)
	return Desecration.Mod:SaveData(data)
end
Desecration.Name = modname

Desecration.SaveManager = include("desecration.libs.save_manager")
Desecration.SaveManager.Init(Desecration.Mod)

Desecration.xml2lua = require("desecration.libs.xml2lua")

Desecration.itempools = require("desecration.libs.xmlhandler.tree")
Desecration.itempoolsparser = Desecration.xml2lua.parser(Desecration.itempools)
Desecration.itempoolsparser:parse(include("desecration.libs.xmls.itempools"))
Desecration.itempoolsparser:parse(include("desecration.libs.xmls.itempoolsdesecration"))
Desecration.itempoolsparser:parse(include("desecration.libs.xmls.itempoolsrestoredcollection"))

Options.MouseControl = true

include("desecration.enums")
include("desecration.helperfuncs")

include("desecration.menus.mainmenu")
include("desecration.menus.todolist")
include("desecration.menus.secrets")
include("desecration.menus.collectionpage")
include("desecration.menus.options")
include("desecration.modes.optionalhardmode")
include("desecration.modes.greedmode")

include("desecration.stages.cathedral")
include("desecration.stages.darkroom")
include("desecration.stages.home")
include("desecration.stages.teledimension")
include("desecration.stages.bluewomb")

include("desecration.rooms.specialrooms")
include("desecration.rooms.grids")
include("desecration.rooms.shading")

include("desecration.items.data")
include("desecration.items.itempools")
include("desecration.items.holyshield")
include("desecration.items.vanillaitems")
include("desecration.items.vanillapickups")
include("desecration.items.vanillaslots")
include("desecration.items.items")
include("desecration.items.runes")
include("desecration.items.pickups")

include("desecration.npcs.vanillamonsters")
include("desecration.npcs.vanillabosses")

include("desecration.xml")
include("desecration.rooms")
include("desecration.compat")
