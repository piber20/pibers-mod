if not REPENTOGON then
	print("piber mod need repentogon :(")
	return
end

local modname = "Piber's Mod"
PibersMod = {}
PibersMod.Mod = RegisterMod(modname, 1)

function PibersMod.AddCallback(callbackId, callbackFn, entityId)
	newFn = function(...)
		local args = {...}
		return callbackFn(table.unpack(args,2))
	end
	return PibersMod.Mod:AddCallback(callbackId, newFn, entityId)
end
function PibersMod.AddPriorityCallback(callbackId, priority, callbackFn, entityId)
	newFn = function(...)
		local args = {...}
		return callbackFn(table.unpack(args,2))
	end
	return PibersMod.Mod:AddPriorityCallback(callbackId, priority, newFn, entityId)
end
function PibersMod.HasData()
	return PibersMod.Mod:HasData()
end
function PibersMod.LoadData()
	return PibersMod.Mod:LoadData()
end
function PibersMod.RemoveCallback(callbackId, callbackFn)
	newFn = function(...)
		local args = {...}
		return callbackFn(table.unpack(args,2))
	end
	return PibersMod.Mod:RemoveCallback(callbackId, newFn)
end
function PibersMod.RemoveData()
	return PibersMod.Mod:RemoveData()
end
function PibersMod.SaveData(data)
	return PibersMod.Mod:SaveData(data)
end
PibersMod.Name = modname

PibersMod.SaveManager = include("pibersmod.libs.save_manager")
PibersMod.SaveManager.Init(PibersMod.Mod)
Options.MouseControl = true

include("pibersmod.enums")
include("pibersmod.helperfuncs")

include("pibersmod.menus.mainmenu")
include("pibersmod.menus.todolist")
include("pibersmod.menus.secrets")
include("pibersmod.menus.collectionpage")
include("pibersmod.menus.options")
include("pibersmod.modes.optionalhardmode")
include("pibersmod.modes.greedmode")

include("pibersmod.stages.cathedral")
include("pibersmod.stages.darkroom")
include("pibersmod.stages.home")
include("pibersmod.stages.teledimension")
include("pibersmod.stages.bluewomb")

include("pibersmod.rooms.specialrooms")
include("pibersmod.rooms.fakewalls")
include("pibersmod.rooms.grids")

include("pibersmod.items.data")
include("pibersmod.items.holyshield")
include("pibersmod.items.vanillaitems")
include("pibersmod.items.vanillapickups")
include("pibersmod.items.vanillaslots")
include("pibersmod.items.items")
include("pibersmod.items.runes")
include("pibersmod.items.pickups")

include("pibersmod.npcs.vanillamonsters")
include("pibersmod.npcs.vanillabosses")

include("pibersmod.xml")
include("pibersmod.compat")
