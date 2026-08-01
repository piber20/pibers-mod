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

--[[
add unlocks and items:
Spider Bite - Beat Chapter 1 (replaces monstro tooth unlock)
Monstro's Tooth - Beat Monstro
Spelunker Hat - Beat Chapter 2 (replaces lil chubby unlock)
Lil Chubby - Beat Chub
I Killed Mom! - Beat mom (in addition to womb unlock, does nothign but is funny)
The Bean - Destroy 50 poops
Mom's Bottle of Pills - Use blood donation machines 20 times
Common Cold - Pick up 2 syringes
Little Baggy - Pick up 3 syringes
Mr. Mega - Destroy 30 tinted rocks
Mom's Contacts - Collect Mom's Eye and one other mom item
Scissors - Die 50 times
Pinking Shears - Die 100 times
Maggy's Wig - Unlock Maggy
Cain's Eyepatch - Unlock Cain
Judas' Fez - Unlock Judas
Dead Bird - Unlock Eve
The Wafer - Beat isaac twice
Money = Power - Beat greed mode twice
Robo-Baby - Collect a tech item
Monster Manual - Collect 3 familiars
Lump of Coal - Unlock krampus
Rainbow Baby - Collect 3 fruity items
Bloody Penny - Beat greedier mode twice
Guppy's Tail - Beat Mom's Heart with 9 lives, without dying once
Fish Head - Have 3 fly items
Spider Butt - Have 2 spider items
Daddy Longlegs - Have 3 spider items

Swap Bloody Lust and Lusty Blood
Increase damage on hurt item becomes Samson's Bandana
Increase damage on kill item becomes Bloody Lust
Bloody Lust becomes unlocked with ultra greed
Samson's Bandana becomes unlocked with isaac kill

]]

print("piber mod loaded correctly :)")
