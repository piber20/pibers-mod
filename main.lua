if not REPENTOGON then
	print("piber mod need repentogon :(")
	return
end

PibersMod = RegisterMod("Piber's Mod", 1)
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

include("pibersmod.items.holyshield")
include("pibersmod.items.vanillaitems")
include("pibersmod.items.vanillapickups")
include("pibersmod.items.vanillaslots")
include("pibersmod.items.items")
include("pibersmod.items.runes")
include("pibersmod.items.pickups")

include("pibersmod.npcs.vanillamonsters")
include("pibersmod.npcs.vanillabosses")

include("pibersmod.compat")
