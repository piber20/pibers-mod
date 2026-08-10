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

include("pibersmod.roomsstages.specialrooms")
include("pibersmod.roomsstages.cathedral")
include("pibersmod.roomsstages.darkroom")
include("pibersmod.roomsstages.fakewalls")
include("pibersmod.roomsstages.home")
include("pibersmod.roomsstages.grids")
include("pibersmod.roomsstages.teledimension")
include("pibersmod.roomsstages.optionalhardmode")
include("pibersmod.roomsstages.greedmode")
include("pibersmod.roomsstages.bluewomb")

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
