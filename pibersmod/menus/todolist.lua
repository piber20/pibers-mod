local mod = PibersMod

mod.TodoListSprite = Sprite("gfx/ui/main menu/todo.anm2", true)
mod.TodoListSprite:Play("Idle")
mod.TodoListFont = Font("font/teammeatex/teammeatex12.fnt")
mod.TodoListTasks = {
	FindMom = "Descend the Depths",
	KillMom = "Kill Mom!",
	KillMomAgain = "Kill Mom... Again!",
	KillMomBible = "Kill Mom with the Bible!",
	FindHeart = "Get in the Womb",
	KillHeart = "Kill Mom's Heart!",
	KillHeartAgain = "Kill Mom's Heart... Again!",
	FindItLives = "Kill Mom's Heart?",
	KillItLives = "Kill It Lives!",
	KillItLivesAgain = "Kill It Lives... Again!",
	FindSatan = "Go to hell",
	KillSatan = "Kill Satan!",
	KillSatanAgain = "Kill Satan... Again!",
	FindIsaac = "Go to heaven",
	KillIsaac = "Kill Isaac!",
	KillIsaacAgain = "Kill Isaac... Again!",
	Negative = "Get the Negative",
	FindLamb = "Go to hell",
	KillLamb = "Kill the Lamb!",
	KillLamb20Mins = "Kill the Lamb in under 20 minutes!",
	KillLambLowPickup = "Kill the Lamb without hearts, coins, or bombs!",
	KillLambAgain = "Kill the Lamb... Again!",
	Polaroid = "Get the Polaroid",
	FindBlueBaby = "Get in the box",
	KillBlueBaby = "Kill ???",
	KillBlueBabyAgain = "Kill ???... Again!",
	Key = "Repair the key",
	FindMegaSatan = "Open the golden door",
	KillMegaSatan = "Kill Mega Satan!",
	KillMegaSatanAgain = "Kill Mega Satan... Again!",
	FindHush = "Get in the Blue Womb",
	KillHush = "Kill Hush!",
	KillHushAgain = "Kill Hush... Again!",
	FindDelirium = "Enter the Void",
	KillDelirium = "Kill Delirium!",
	KillDeliriumAgain = "Kill Delirium... Again!",
	SecretExit = "Find the Secret Exit",
	Knife = "Repair the Knife",
	FindMother = "Cut open the Corpse",
	KillMother = "Kill Mother...",
	KillMotherAgain = "Kill Mother... Again!",
	StrangeDoor = "Open the Strange Door",
	FindDogma = "Ascend...",
	KillDogma = "Kill Dogma",
	KillBeast = "Kill the Beast",
	RedKey = "Open Mom's Chest...",
	FindTainted = "Go back home...",
	KillGreed = "Kill Ultra Greed!",
	KillGreedAgain = "Kill Ultra Greed... Again!",
	KillGreedier = "Kill Ultra Greedier!",
	KillGreedierAgain = "Kill Ultra Greedier... Again!",
	Donate = "Donate to charity",
	Die = "Die",
	DieAgain = "Die again!",
	DieExplosion = "Blow myself up",
	Chapter1Bosses = "Kill all Basement bosses!",
	Chapter2Bosses = "Kill all Caves bosses!",
	Chapter3Bosses = "Kill all Depths bosses!",
	Chapter4Bosses = "Kill all Womb bosses!",
	Chapter1BossesAlt = "Kill all Downpour bosses!",
	Chapter2BossesAlt = "Kill all Mines bosses!",
	Chapter3BossesAlt = "Kill all Mausoleum bosses!",
	Chapter4BossesAlt = "Kill all Corpse bosses!",
	Chapter1Again = "Clear the Basement... Again!",
	Chapter2Again = "Clear the Caves... Again!",
	Chapter3Again = "Clear the Depths... Again!",
	Chapter4Again = "Clear the Womb... Again!",
	Chapter5Again = "Clear Sheol or the Cathedral... Again!",
	Chapter6Again = "Clear the Dark Room or Chest... Again!",
	Chapter1NoDmg = "Clear the Basement... without taking damage!",
	Chapter2NoDmg = "Clear the Caves... without taking damage!",
	Chapter3NoDmg = "Clear the Depths... without taking damage!",
	Chapter4NoDmg = "Clear the Womb... without taking damage!",
	Chapter5NoDmg = "Clear Sheol or the Cathedral... without taking damage!",
	Chapter6NoDmg = "Clear the Dark Room or Chest... without taking damage!",
	RocksAgain = "Destroy more rocks",
	TintedRocksAgain = "Destroy more marked rocks",
	BandageGirl = "Build a Super Bandage Girl!",
	MeatBoy = "Build a Super Meat Boy!",
	KillSins = "Kill all 7 Deadly Sins!",
	KillGish = "Kill Gish!",
	KillSteven = "Kill Steven!",
	KillChad = "Kill C.H.A.D.!",
	Arcade = "Visit the Arcade!",
	ArcadeAgain = "Visit more Arcades!",
	DeadItems = "Collect dead things",
	MomItems = "Collect mom's things",
	KillShopkeeper = "Kill Shopkeepers!",
	ShellGame = "Play the Shell Game!",
	ShellGameAgain = "Play the Shell Game again!",
	GuppyItems = "Find Guppy",
	MissingPoster = "Go missing...",
	DevilDeal = "Take a Devil Deal",
	DevilDealAgain = "Take more Devil Deals",
	AngelDeal = "Take an angel's gift",
	AngelDealAgain = "Take more of the angel's gifts",
	KillKrampus = "Kill Krampus!",
	PoopsAgain = "Destroy more poop!",
	SyringeItems = "Collect Syringes!",
	BloodMachine = "Donate blood",
	SlotMachineBreak = "Destroy slot machines",
	FlyItems = "Collect Flies",
	VictoryLap = "Complete a Victory Lap",
	VictoryLapAgain = "Complete more Victory Laps!",
	Reset = "Reset a lot",
	LowHealth = "Clear a chapter with only half a heart!",
	MoreItems = "Collect a TON of stuff!",
	KillPortals = "Destroy portals!",
	RainbowPoopsAgain = "Destroy more rainbow poop!",
	Familiars = "Collect some friends",
	Friendly = "Make some friends",
	FriendlyFlies = "Make friends with some flies",
	KillLittleHorn = "Kill Little Horn!",
	KillLittleHornAgain = "Kill Little Horn... Again!",
	Batteries = "Collect more batteries",
	BatteriesBig = "Collect some bigger batteries",
	Sleep = "Get some sleep",
	SleepAgain = "Get some more sleep",
	Big = "Get bigger",
	Cards = "Use more cards and runes",
	Watches = "Collect a few watches",
	BuyItems = "Buy some stuff",
	BuyItemsAgain = "Buy more stuff",
	Pandora = "Open the box in the Dark Room",
	Tech = "Collect some technology!",
	KillHarbinger = "Kill a Harbinger",
	KillHarbingerAll = "Kill all the Harbingers!",
	UnlockChests = "Unlock more chests",
	KillAngelAgain = "Kill more angels",
	BlowUpDoors = "Blow up more doors and walls",
	Clots = "Get more blood clots",
	TearsUp = "Cry a lot",
	ShopsAll = "Check out all the shops",
	RubberCements = "Get more rubber cement",
	Gulp = "Gulp a bunch",
	Blinding = "It's so bright",
	Homing = "Look beyond",
	Stars = "Look to the stars",
	ForgottenBoss = "Defeat the first boss in under a minute!",
	ForgottenBrokenShovel = "Find the shovel...",
	ForgottenGetShovel = "Bring the broken shovel to Mom...",
	ForgottenDarkRoom = "Descend with Mom's Shovel...",
	ForgottenDigGrave = "Dig the grave with Mom's Shovel...",
	KillSiren = "Kill the Siren",
	KillSirenSong = "Get that song out of her head",
	KillPlum = "Kill Baby Plum!",
	KillPlumAgain = "Kill Baby Plum... Again!",
	SparePlum = "Hang out with Baby Plum",
	BatteryBum = "Donate to the Battery Bum",
	KillBatteryBum = "Kill Battery Bums",
	KillHornfel = "Kill Hornfel before he escapes!",
	Spend40 = "Spend 40 cents in one shop",
	Spend99 = "Collect 99 cents and then spend it all"
}
mod.TodoListVisibleTasks = {}
mod.TodoListPos = Vector(0,125)
mod.TodoListTextPos = Vector(-24,152)
mod.WinStreakFont = Font("font/teammeatex/teammeatex12.fnt")
mod.WinStreakPos = Vector(-82,180)
mod.WinStreakTextPos = Vector(-90,200)
function mod.TodoListSetVisibleBossTask(bossType, bossName, seen, reqUnlock, lastUnlock, counter)
	local gamedata = Isaac.GetPersistentGameData()
	if gamedata:IsBossKilled(bossType) then
		seen = true
	end
	if reqUnlock ~= false and (reqUnlock == nil or reqUnlock == true or seen or gamedata:Unlocked(reqUnlock)) then
		if not seen then
			mod.TodoListVisibleTasks["Find" .. bossName] = true
			return "Find" .. bossName
		elseif not gamedata:IsBossKilled(bossType) then
			mod.TodoListVisibleTasks["Kill" .. bossName] = true
			return "Kill" .. bossName
		elseif lastUnlock and (lastUnlock == true or not gamedata:Unlocked(lastUnlock)) then
			mod.TodoListVisibleTasks["Kill" .. bossName .. "Again"] = true
			return "Kill" .. bossName .. "Again"
		end
	end
	if type(counter) == "number" then
		return counter + 1
	end
	return false
end

function mod.OnMainMenuRenderToDoList()

	local gamedata = Isaac.GetPersistentGameData()
	local currentActive = MenuManager:GetActiveMenu()

	--todo list
	if CharacterMenu.GetActiveStatus() ~= CharacterMenuStatus.SEED then
		local taskCounter = 0
		for i,v in pairs(mod.TodoListVisibleTasks) do
			if v == true and mod.TodoListTasks[i] then
				taskCounter = taskCounter + 1
			end
		end
		if taskCounter >= 1 then
			mod.TodoListSprite:Render(Isaac.WorldToMenuPosition(MainMenuType.CHARACTER, mod.TodoListPos))
		end
	end

	--move win streak to stats
	local winstreakSprite = CharacterMenu.GetWinStreakPageSprite()
	if not StatsMenu.IsSecretsMenuVisible() then
		winstreakSprite.Scale = Vector.One
		winstreakSprite:Render(Isaac.WorldToMenuPosition(MainMenuType.STATS, mod.WinStreakPos))
	end
	winstreakSprite.Scale = Vector.Zero

	--shift stats camera a bit to fit win streak
	if currentActive == MainMenuType.STATS then
		if StatsMenu.IsSecretsMenuVisible() then
			--MenuManager.SetViewPosition(Isaac.WorldToMenuPosition(MainMenuType.STATS, mod.SecretViewPos))
		else
			MenuManager.SetViewPosition(Isaac.WorldToMenuPosition(MainMenuType.STATS, mod.StatViewPos))
		end
	end

	--todo list
	if currentActive > MainMenuType.SAVES and CharacterMenu.GetActiveStatus() ~= CharacterMenuStatus.SEED then
		local difficulty = CharacterMenu.GetDifficulty()
		local persistentSave = mod.SaveManager.GetPersistentSave()
		local bossesDone = 0
		local isMainMode = difficulty == Difficulty.DIFFICULTY_NORMAL or difficulty == Difficulty.DIFFICULTY_HARD
		local isGreedMode = difficulty == Difficulty.DIFFICULTY_GREED or difficulty == Difficulty.DIFFICULTY_GREEDIER
		mod.TodoListVisibleTasks = {}

		--final bosses
		if isMainMode then
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.MOM, "Mom", persistentSave.SeenMom, nil, nil, bossesDone)
			if gamedata:IsBossKilled(BossType.MOM) then
				if not gamedata:Unlocked(Achievement.HALO) then
					mod.TodoListVisibleTasks["KillMomBible"] = true
				end
			end
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.MOMS_HEART, "Heart", persistentSave.SeenHeart, gamedata:IsBossKilled(BossType.MOM), Achievement.IT_LIVES, bossesDone)
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.IT_LIVES, "ItLives", persistentSave.SeenItLives, Achievement.IT_LIVES, Achievement.SCARRED_WOMB, bossesDone)
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.SATAN, "Satan", persistentSave.SeenSatan, gamedata:IsBossKilled(BossType.IT_LIVES), Achievement.THE_NEGATIVE, bossesDone)
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.ISAAC, "Isaac", persistentSave.SeenIsaac, gamedata:IsBossKilled(BossType.IT_LIVES), Achievement.THE_POLAROID, bossesDone)
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.THE_LAMB, "Lamb", persistentSave.SeenLamb, Achievement.THE_NEGATIVE, nil, bossesDone)
			if gamedata:IsBossKilled(BossType.THE_LAMB) then
				if not gamedata:Unlocked(Achievement.ZIP) then
					mod.TodoListVisibleTasks["KillLamb20Mins"] = true
				elseif not gamedata:Unlocked(Achievement.ITS_THE_KEY) then
					mod.TodoListVisibleTasks["KillLambLowPickup"] = true
				end
			end
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.BLUE_BABY, "BlueBaby", persistentSave.SeenBlueBaby, Achievement.THE_POLAROID, nil, bossesDone)
			if gamedata:Unlocked(Achievement.ANGELS) then
				if not gamedata:Unlocked(Achievement.DADS_KEY) then
					mod.TodoListVisibleTasks["Key"] = true
				else
					mod.TodoListSetVisibleBossTask(BossType.MEGA_SATAN, "MegaSatan", persistentSave.SeenMegaSatan, nil, nil, bossesDone)
				end
			end
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.HUSH, "Hush", persistentSave.SeenHush, Achievement.BLUE_WOMB, Achievement.SECRET_EXIT, bossesDone)
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.DELIRIUM, "Delirium", persistentSave.SeenDelirium, Achievement.THE_VOID, nil, bossesDone)
			if gamedata:Unlocked(Achievement.SECRET_EXIT) then
				if not gamedata:Unlocked(Achievement.ROTTEN_HEARTS) then
					mod.TodoListVisibleTasks["Knife"] = true
				else
					mod.TodoListSetVisibleBossTask(BossType.MOTHER, "Mother", persistentSave.SeenMother, nil, nil, bossesDone)
				end
			end
			bossesDone = mod.TodoListSetVisibleBossTask(BossType.DOGMA, "Dogma", persistentSave.SeenDogma, Achievement.STRANGE_DOOR, nil, bossesDone)
			if gamedata:GetEventCounter(EventCounter.DONATION_MACHINE_COUNTER) > 0 and not gamedata:Unlocked(Achievement.STOP_WATCH) then
				mod.TodoListVisibleTasks["Donate"] = true
			end
		elseif isGreedMode then
			--if not mod.TodoListSetVisibleBossTask(BossType.ULTRA_GREED, "Greed", persistentSave.SeenGreed) then
				bossesDone = 12
			--end
			if gamedata:GetEventCounter(EventCounter.GREED_DONATION_MACHINE_COUNTER) > 0 and not gamedata:Unlocked(Achievement.KEEPER) then
				mod.TodoListVisibleTasks["Donate"] = true
			end
		end

		if gamedata:GetEventCounter(EventCounter.BLOOD_DONATION_MACHINE_USED) > 0 and not gamedata:Unlocked(Achievement.BLOOD_BAG) then
			mod.TodoListVisibleTasks["DonateBlood"] = true
		end

		--extra stuff to show if final bosses are done
		if type(bossesDone) == "number" then
			local needMoreBosses = false
			if isMainMode then
				if not gamedata:Unlocked(Achievement.THE_BOOK_OF_SIN) then
					mod.TodoListVisibleTasks["KillSins"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.THE_BOOK_OF_REVELATIONS) then
					mod.TodoListVisibleTasks["KillHarbinger"] = true
				elseif not gamedata:Unlocked(Achievement.SEVEN_SEALS) then
					mod.TodoListVisibleTasks["KillHarbingerAll"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.CELLAR) then
					mod.TodoListVisibleTasks["Chapter1Bosses"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.CATACOMBS) then
					mod.TodoListVisibleTasks["Chapter2Bosses"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.NECROPOLIS) then
					mod.TodoListVisibleTasks["Chapter3Bosses"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.DROSS) then
					mod.TodoListVisibleTasks["Chapter1BossesAlt"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.ASHPIT) then
					mod.TodoListVisibleTasks["Chapter2BossesAlt"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.GEHENNA) then
					mod.TodoListVisibleTasks["Chapter3BossesAlt"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.LITTLE_GISH) then
					mod.TodoListVisibleTasks["KillGish"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.LITTLE_STEVEN) then
					mod.TodoListVisibleTasks["KillSteven"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.LITTLE_CHAD) then
					mod.TodoListVisibleTasks["KillChad"] = true
					needMoreBosses = true
				end
				if gamedata:Unlocked(Achievement.SOMETHING_WICKED) then
					if not gamedata:Unlocked(Achievement.FAST_BOMBS) then
						if not gamedata:IsBossKilled(BossType.LITTLE_HORN) then
							mod.TodoListVisibleTasks["KillLittleHorn"] = true
						else
							mod.TodoListVisibleTasks["KillLittleHornAgain"] = true
						end
						needMoreBosses = true
					end
				end
				if gamedata:Unlocked(Achievement.SOMETHING_WICKED_2) then
					if not gamedata:Unlocked(Achievement.PLUM_FLUTE) then
						mod.TodoListVisibleTasks["SparePlum"] = true
						needMoreBosses = true
					end
					if not gamedata:Unlocked(Achievement.FRUITY_PLUM) then
						if not gamedata:IsBossKilled(BossType.BABY_PLUM) then
							mod.TodoListVisibleTasks["KillPlum"] = true
						else
							mod.TodoListVisibleTasks["KillPlumAgain"] = true
						end
						needMoreBosses = true
					end
				end
				if not gamedata:Unlocked(Achievement.BRIMSTONE_BOMBS) then
					mod.TodoListVisibleTasks["KillHornfel"] = true
				end
				if not gamedata:IsBossKilled(BossType.THE_SIREN) then
					mod.TodoListVisibleTasks["KillSiren"] = true
					needMoreBosses = true
				elseif not gamedata:Unlocked(Achievement.FORGOTTEN_LULLABY) then
					mod.TodoListVisibleTasks["KillSirenSong"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.ANGELIC_PRISM) then
					mod.TodoListVisibleTasks["KillAngelAgain"] = true
				end
				if not gamedata:Unlocked(Achievement.BLACK_HOLE) then
					mod.TodoListVisibleTasks["KillPortals"] = true
				end
				if not gamedata:Unlocked(Achievement.OLD_CAPACITOR) then
					mod.TodoListVisibleTasks["KillBatteryBum"] = true
				end
			end
			if not gamedata:Unlocked(Achievement.SACRIFICAL_ALTAR) then
				if gamedata:GetEventCounter(EventCounter.DEVIL_DEALS_TAKEN) > 1 then
					mod.TodoListVisibleTasks["DevilDealAgain"] = true
				else
					mod.TodoListVisibleTasks["DevilDeal"] = true
				end
			elseif not gamedata:Unlocked(Achievement.KRAMPUS) then
				mod.TodoListVisibleTasks["KillKrampus"] = true
				needMoreBosses = true
			end
			if not gamedata:Unlocked(Achievement.ANGELIC_PRISM) then
				if gamedata:GetEventCounter(EventCounter.ANGEL_DEALS_TAKEN) > 1 then
					mod.TodoListVisibleTasks["AngelDealAgain"] = true
				else
					mod.TodoListVisibleTasks["AngelDeal"] = true
				end
			end
			local chaptersDone = 0
			if isMainMode then
				if not gamedata:Unlocked(Achievement.STEVEN) then
					mod.TodoListVisibleTasks["Chapter1Again"] = true
					chaptersDone = chaptersDone + 1
				elseif not gamedata:Unlocked(Achievement.BASEMENT_BOY) then
					mod.TodoListVisibleTasks["Chapter1NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.CHAD) then
					mod.TodoListVisibleTasks["Chapter2Again"] = true
					chaptersDone = chaptersDone + 1
				elseif not gamedata:Unlocked(Achievement.SPELUNKER_BOY) then
					mod.TodoListVisibleTasks["Chapter2NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.GISH) then
					mod.TodoListVisibleTasks["Chapter3Again"] = true
					chaptersDone = chaptersDone + 1
				elseif not gamedata:Unlocked(Achievement.DARK_BOY) then
					mod.TodoListVisibleTasks["Chapter3NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.MAMAS_BOY) then
					mod.TodoListVisibleTasks["Chapter4NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.DEAD_BOY) then
					mod.TodoListVisibleTasks["Chapter6NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.LIVING_ON_THE_EDGE) then
					mod.TodoListVisibleTasks["LowHealth"] = true
				end
				if not gamedata:Unlocked(Achievement.THE_LOST) then
					mod.TodoListVisibleTasks["MissingPoster"] = true
				end
				if not gamedata:Unlocked(Achievement.THE_FORGOTTEN) then
					if not persistentSave.LastForgottenState then
						persistentSave.LastForgottenState = "ForgottenBoss"
					end
					mod.TodoListVisibleTasks[persistentSave.LastForgottenState] = true
				end
			end

			--extra stuff if chapter tasks are done
			if chaptersDone >= 3 and not needMoreBosses then
				if not gamedata:Unlocked(Achievement.LUCKY_TOE) then
					mod.TodoListVisibleTasks["KillShopkeeper"] = true
				end
				if not gamedata:Unlocked(Achievement.GAMEKID) then
					if gamedata:GetEventCounter(EventCounter.ARCADES_ENTERED) > 1 then
						mod.TodoListVisibleTasks["ArcadeAgain"] = true
					else
						mod.TodoListVisibleTasks["Arcade"] = true
					end
				else
					if not gamedata:Unlocked(Achievement.COUNTERFEIT_PENNY) then
						if gamedata:GetEventCounter(EventCounter.SHELLGAMES_PLAYED) > 1 then
							mod.TodoListVisibleTasks["ShellGameAgain"] = true
						else
							mod.TodoListVisibleTasks["ShellGame"] = true
						end
					end
					if gamedata:GetEventCounter(EventCounter.SLOT_MACHINES_BROKEN) > 0 and not gamedata:Unlocked(Achievement.D4) then
						mod.TodoListVisibleTasks["SlotMachineBreak"] = true
					end
				end
				if not gamedata:Unlocked(Achievement.MYSTERY_GIFT) then
					mod.TodoListVisibleTasks["RocksAgain"] = true
				elseif not gamedata:Unlocked(Achievement.A_SMALL_ROCK) then
					mod.TodoListVisibleTasks["TintedRocksAgain"] = true
				end
				if not gamedata:Unlocked(Achievement.BUTTER_BEAN) then
					mod.TodoListVisibleTasks["PoopsAgain"] = true
				elseif not gamedata:Unlocked(Achievement.BOZO) then
					mod.TodoListVisibleTasks["RainbowPoopsAgain"] = true
				end
				if not gamedata:Unlocked(Achievement.DOOR_STOP) then
					mod.TodoListVisibleTasks["BlowUpDoors"] = true
				end

				local hasAllItemUnlocks = true
				if not gamedata:Unlocked(Achievement.SUPER_MEAT_BOY) then
					mod.TodoListVisibleTasks["MeatBoy"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.SUPER_BANDAGE) then
					mod.TodoListVisibleTasks["BandageGirl"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.THE_PARASITE) then
					mod.TodoListVisibleTasks["DeadItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.MOMS_CONTACT) then
					mod.TodoListVisibleTasks["MomItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.GUPPYS_HAIRBALL) then
					mod.TodoListVisibleTasks["GuppyItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.LITTLE_BAGGY) then
					mod.TodoListVisibleTasks["SyringeItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.BECAME_LORD_OF_THE_FLIES) then
					mod.TodoListVisibleTasks["FlyItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.BUDDY_IN_A_BOX) then
					mod.TodoListVisibleTasks["Familiars"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.MYSTERY_EGG) then
					mod.TodoListVisibleTasks["Friendly"] = true
					end
				if not gamedata:Unlocked(Achievement.ROTTEN_PENNY) then
					mod.TodoListVisibleTasks["FriendlyFlies"] = true
				end
				if not gamedata:Unlocked(Achievement.HAIRPIN) then
					mod.TodoListVisibleTasks["Batteries"] = true
					hasAllItemUnlocks = false
				elseif not gamedata:Unlocked(Achievement.JUMPER_CABLES) or not gamedata:Unlocked(Achievement.EXTENSION_CORD) then
					mod.TodoListVisibleTasks["BatteriesBig"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.ERA_WALK) then
					mod.TodoListVisibleTasks["Watches"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.TECHNOLOGY_ZERO) then
					mod.TodoListVisibleTasks["Tech"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.MR_ME) then
					mod.TodoListVisibleTasks["UnlockChests"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.COUPON) then
					if gamedata:GetEventCounter(EventCounter.SHOP_ITEMS_BOUGHT) > 1 then
						mod.TodoListVisibleTasks["BuyItemsAgain"] = true
					else
						mod.TodoListVisibleTasks["BuyItems"] = true
					end
					hasAllItemUnlocks = false
				elseif not gamedata:Unlocked(Achievement.SCHOOLBAG) then
					mod.TodoListVisibleTasks["ShopsAll"] = true
				end
				if not gamedata:Unlocked(Achievement.MEMBER_CARD) then
					mod.TodoListVisibleTasks["Spend40"] = true
				end
				if not gamedata:Unlocked(Achievement.GOLDEN_RAZOR) then
					mod.TodoListVisibleTasks["Spend99"] = true
				end
				if not gamedata:Unlocked(Achievement.HAEMOLACRIA) then
					mod.TodoListVisibleTasks["Clots"] = true
				end
				if not gamedata:Unlocked(Achievement.FLAT_STONE) then
					mod.TodoListVisibleTasks["RubberCements"] = true
				end
				if hasAllItemUnlocks and not gamedata:Unlocked(Achievement.U_BROKE_IT) then
					mod.TodoListVisibleTasks["MoreItems"] = true
				end
				if not gamedata:Unlocked(Achievement.ANCIENT_RECALL) then
					mod.TodoListVisibleTasks["Cards"] = true
				end
				if not gamedata:Unlocked(Achievement.MOVING_BOX) then
					mod.TodoListVisibleTasks["Pandora"] = true
				end
				if not gamedata:Unlocked(Achievement.MARBLES) then
					mod.TodoListVisibleTasks["Gulp"] = true
				end
				if not gamedata:Unlocked(Achievement.RED_KEY) then
					mod.TodoListVisibleTasks["RedKey"] = true
				end
				if not gamedata:Unlocked(Achievement.CHARGED_PENNY) then
					mod.TodoListVisibleTasks["BatteryBum"] = true
				end

				if not gamedata:Unlocked(Achievement.HUGE_GROWTH) then
					mod.TodoListVisibleTasks["Big"] = true
				end
				if isMainMode then
					if not gamedata:Unlocked(Achievement.ONCE_MORE_WITH_FEELING) then
						mod.TodoListVisibleTasks["VictoryLap"] = true
					elseif not gamedata:Unlocked(Achievement.RERUNS) then
						mod.TodoListVisibleTasks["VictoryLapAgain"] = true
					end
				end

				if not gamedata:Unlocked(Achievement.LACHRYPHAGY) then
					mod.TodoListVisibleTasks["TearsUp"] = true
				end
				if not gamedata:Unlocked(Achievement.MR_RESETTER) then
					mod.TodoListVisibleTasks["Reset"] = true
				end
				if not gamedata:Unlocked(Achievement.BLANKET) then
					if gamedata:GetEventCounter(EventCounter.BEDS_USED) > 1 then
						mod.TodoListVisibleTasks["SleepAgain"] = true
					else
						mod.TodoListVisibleTasks["Sleep"] = true
					end
				end
				if not gamedata:Unlocked(Achievement.LIL_SPEWER) then
					mod.TodoListVisibleTasks["DieExplosion"] = true
				elseif not gamedata:Unlocked(Achievement.SCISSORS) then
					if gamedata:GetEventCounter(EventCounter.DEATHS) > 1 then
						mod.TodoListVisibleTasks["DieAgain"] = true
					else
						mod.TodoListVisibleTasks["Die"] = true
					end
				end
				if not gamedata:Unlocked(Achievement.PLANETARIUMS) then
					mod.TodoListVisibleTasks["Stars"] = true
				end
				if not gamedata:Unlocked(Achievement.BABY_BENDER) then
					mod.TodoListVisibleTasks["Homing"] = true
				end
				if not gamedata:Unlocked(Achievement.BLINDING_BABY) then
					mod.TodoListVisibleTasks["Blinding"] = true
				end
			end
		end

		local taskCounter = 0
		for i,v in pairs(mod.TodoListVisibleTasks) do
			if v == true and mod.TodoListTasks[i] then
				local tasktextpos = Isaac.WorldToMenuPosition(MainMenuType.CHARACTER, mod.TodoListTextPos)
				mod.TodoListFont:DrawStringScaledUTF8(tostring(taskCounter+1) .. ". " .. mod.TodoListTasks[i],tasktextpos.X+(taskCounter*1.5),tasktextpos.Y+(taskCounter*8),0.5,0.5, KColor.Black)
				taskCounter = taskCounter + 1
			end
		end

		--manually render win streak text at new position
		if not StatsMenu.IsSecretsMenuVisible() then
			local textpos = Isaac.WorldToMenuPosition(MainMenuType.STATS, mod.WinStreakTextPos)
			local currentStreak = gamedata:GetEventCounter(EventCounter.STREAK_COUNTER)
			local streakString = tostring(currentStreak)
			if currentStreak >= 2 then
				streakString = streakString .. "!"
				if winstreakSprite:GetAnimation() == "Idle" then
					winstreakSprite:Play("Good", false)
				end
			elseif currentStreak <= -2 then
				streakString = streakString .. "..."
				if winstreakSprite:GetAnimation() == "Idle" then
					winstreakSprite:Play("Bad", false)
				end
			else
				if winstreakSprite:GetAnimation() ~= "Idle" then
					winstreakSprite:Play("Idle", false)
				end
			end
			mod.WinStreakFont:DrawString(streakString,textpos.X,textpos.Y,KColor.Black,100,true)
		end
	end
end
--mod.AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, mod.OnMainMenuRenderToDoList)

function mod.OnNewRoomToDoList()

	local game = Game()
	local level = game:GetLevel()
	local persistentSave = mod.SaveManager.GetPersistentSave()
	if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_MOMS_SHOVEL) then
		if persistentSave.LastForgottenState ~= "ForgottenDigGrave" then
			local stage = level:GetStage()
			local stageType = level:GetStageType()
			if stage == LevelStage.STAGE6 and stageType == StageType.STAGETYPE_ORIGINAL then
				persistentSave.LastForgottenState = "ForgottenDigGrave"
			elseif persistentSave.LastForgottenState ~= "ForgottenDarkRoom" then
				persistentSave.LastForgottenState = "ForgottenDarkRoom"
			end
		end
	elseif PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_BROKEN_SHOVEL_1) then
		if not persistentSave.LastForgottenState or persistentSave.LastForgottenState == "ForgottenBrokenShovel" or persistentSave.LastForgottenState == "ForgottenBoss" then
			persistentSave.LastForgottenState = "ForgottenGetShovel"
		end
	elseif level:GetStateFlag(LevelStateFlag.STATE_SHOVEL_QUEST_TRIGGERED) then
		if not persistentSave.LastForgottenState or persistentSave.LastForgottenState == "ForgottenBoss" then
			persistentSave.LastForgottenState = "ForgottenBrokenShovel"
		end
	end

	local roomDescriptor = level:GetCurrentRoomDesc()
	local roomConfigRoom = roomDescriptor.Data
	if roomConfigRoom.Type == RoomType.ROOM_BOSS then
		local room = game:GetRoom()
		local bossID = room:GetBossID()
		if not persistentSave.SeenMom and bossID == BossType.MOM then
			persistentSave.SeenMom = true
		elseif not persistentSave.SeenHeart and bossID == BossType.MOMS_HEART then
			persistentSave.SeenHeart = true
		elseif not persistentSave.SeenItLives and bossID == BossType.IT_LIVES then
			persistentSave.SeenItLives = true
		elseif not persistentSave.SeenSatan and bossID == BossType.SATAN then
			persistentSave.SeenSatan = true
		elseif not persistentSave.SeenIsaac and bossID == BossType.ISAAC then
			persistentSave.SeenIsaac = true
		elseif not persistentSave.SeenLamb and bossID == BossType.THE_LAMB then
			persistentSave.SeenLamb = true
		elseif not persistentSave.SeenBlueBaby and bossID == BossType.BLUE_BABY then
			persistentSave.SeenBlueBaby = true
		elseif not persistentSave.SeenMegaSatan and bossID == BossType.MEGA_SATAN then
			persistentSave.SeenMegaSatan = true
		elseif not persistentSave.SeenHush and bossID == BossType.HUSH then
			persistentSave.SeenHush = true
		elseif not persistentSave.SeenDelirium and bossID == BossType.DELIRIUM then
			persistentSave.SeenDelirium = true
		elseif not persistentSave.SeenMother and bossID == BossType.MOTHER then
			persistentSave.SeenMother = true
		elseif not persistentSave.SeenDogma and bossID == BossType.DOGMA then
			persistentSave.SeenDogma = true
		elseif not persistentSave.SeenBeast and bossID == BossType.THE_BEAST then
			persistentSave.SeenBeast = true
		elseif not persistentSave.SeenGreed and bossID == BossType.ULTRA_GREED then
			persistentSave.SeenGreed = true
		elseif not persistentSave.SeenGreedier and bossID == BossType.ULTRA_GREEDIER then
			persistentSave.SeenGreedier = true
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomToDoList)
