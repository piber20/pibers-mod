if not REPENTOGON then
	print("piber mod need repentogon :(")
	return
end

local modname = "Piber's Mod"
PibersMod = RegisterMod(modname, 1)
for funcname, func in pairs(PibersMod) do
	if type(func) == "function" and not PibersMod["old"..funcname] then
		PibersMod["old"..funcname] = func
		PibersMod[funcname] = function(...)
			local args = {...}
			if not args or type(args[1]) ~= "table" or not args[1].Name or args[1].Name ~= modname then
				PibersMod["old"..funcname](PibersMod,table.unpack(args))
			else
				PibersMod["old"..funcname](PibersMod,table.unpack(args, 2))
			end
		end
	end
end

PibersMod.SaveManager = include("pibersmod.libs.save_manager")
PibersMod.SaveManager.Init(PibersMod)
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
