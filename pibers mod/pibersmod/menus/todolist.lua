PibersMod.TodoListSprite = Sprite("gfx/ui/main menu/todo.anm2", true)
PibersMod.TodoListSprite:Play("Idle")
PibersMod.TodoListFont = Font("font/teammeatex/teammeatex12.fnt")
PibersMod.TodoListTasks = {
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
PibersMod.TodoListVisibleTasks = {}
PibersMod.TodoListPos = Vector(0,125)
PibersMod.TodoListTextPos = Vector(-24,152)
PibersMod.WinStreakFont = Font("font/teammeatex/teammeatex12.fnt")
PibersMod.WinStreakPos = Vector(-82,180)
PibersMod.WinStreakTextPos = Vector(-90,200)
function PibersMod:TodoListSetVisibleBossTask(bossType, bossName, seen, reqUnlock, lastUnlock, counter)
	local gamedata = Isaac.GetPersistentGameData()
	if gamedata:IsBossKilled(bossType) then
		seen = true
	end
	if reqUnlock ~= false and (reqUnlock == nil or reqUnlock == true or seen or gamedata:Unlocked(reqUnlock)) then
		if not seen then
			PibersMod.TodoListVisibleTasks["Find" .. bossName] = true
			return "Find" .. bossName
		elseif not gamedata:IsBossKilled(bossType) then
			PibersMod.TodoListVisibleTasks["Kill" .. bossName] = true
			return "Kill" .. bossName
		elseif lastUnlock and (lastUnlock == true or not gamedata:Unlocked(lastUnlock)) then
			PibersMod.TodoListVisibleTasks["Kill" .. bossName .. "Again"] = true
			return "Kill" .. bossName .. "Again"
		end
	end
	if type(counter) == "number" then
		return counter + 1
	end
	return false
end

function PibersMod:OnMainMenuRenderToDoList()

	local gamedata = Isaac.GetPersistentGameData()
	local currentActive = MenuManager:GetActiveMenu()

	--todo list
	if CharacterMenu.GetActiveStatus() ~= CharacterMenuStatus.SEED then
		local taskCounter = 0
		for i,v in pairs(PibersMod.TodoListVisibleTasks) do
			if v == true and PibersMod.TodoListTasks[i] then
				taskCounter = taskCounter + 1
			end
		end
		if taskCounter >= 1 then
			PibersMod.TodoListSprite:Render(Isaac.WorldToMenuPosition(MainMenuType.CHARACTER, PibersMod.TodoListPos))
		end
	end

	--move win streak to stats
	local winstreakSprite = CharacterMenu.GetWinStreakPageSprite()
	if not StatsMenu.IsSecretsMenuVisible() then
		winstreakSprite.Scale = Vector.One
		winstreakSprite:Render(Isaac.WorldToMenuPosition(MainMenuType.STATS, PibersMod.WinStreakPos))
	end
	winstreakSprite.Scale = Vector.Zero

	--shift stats camera a bit to fit win streak
	if currentActive == MainMenuType.STATS then
		if StatsMenu.IsSecretsMenuVisible() then
			--MenuManager.SetViewPosition(Isaac.WorldToMenuPosition(MainMenuType.STATS, PibersMod.SecretViewPos))
		else
			MenuManager.SetViewPosition(Isaac.WorldToMenuPosition(MainMenuType.STATS, PibersMod.StatViewPos))
		end
	end

	--todo list
	if PibersMod.SaveGood and CharacterMenu.GetActiveStatus() ~= CharacterMenuStatus.SEED then
		local difficulty = CharacterMenu.GetDifficulty()
		local persistentSave = PibersMod.SaveManager.GetPersistentSave()
		local bossesDone = 0
		local isMainMode = difficulty == Difficulty.DIFFICULTY_NORMAL or difficulty == Difficulty.DIFFICULTY_HARD
		local isGreedMode = difficulty == Difficulty.DIFFICULTY_GREED or difficulty == Difficulty.DIFFICULTY_GREEDIER
		PibersMod.TodoListVisibleTasks = {}

		--final bosses
		if isMainMode then
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.MOM, "Mom", persistentSave.SeenMom, nil, nil, bossesDone)
			if gamedata:IsBossKilled(BossType.MOM) then
				if not gamedata:Unlocked(Achievement.HALO) then
					PibersMod.TodoListVisibleTasks["KillMomBible"] = true
				end
			end
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.MOMS_HEART, "Heart", persistentSave.SeenHeart, gamedata:IsBossKilled(BossType.MOM), Achievement.IT_LIVES, bossesDone)
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.IT_LIVES, "ItLives", persistentSave.SeenItLives, Achievement.IT_LIVES, Achievement.SCARRED_WOMB, bossesDone)
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.SATAN, "Satan", persistentSave.SeenSatan, gamedata:IsBossKilled(BossType.IT_LIVES), Achievement.THE_NEGATIVE, bossesDone)
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.ISAAC, "Isaac", persistentSave.SeenIsaac, gamedata:IsBossKilled(BossType.IT_LIVES), Achievement.THE_POLAROID, bossesDone)
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.THE_LAMB, "Lamb", persistentSave.SeenLamb, Achievement.THE_NEGATIVE, nil, bossesDone)
			if gamedata:IsBossKilled(BossType.THE_LAMB) then
				if not gamedata:Unlocked(Achievement.ZIP) then
					PibersMod.TodoListVisibleTasks["KillLamb20Mins"] = true
				elseif not gamedata:Unlocked(Achievement.ITS_THE_KEY) then
					PibersMod.TodoListVisibleTasks["KillLambLowPickup"] = true
				end
			end
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.BLUE_BABY, "BlueBaby", persistentSave.SeenBlueBaby, Achievement.THE_POLAROID, nil, bossesDone)
			if gamedata:Unlocked(Achievement.ANGELS) then
				if not gamedata:Unlocked(Achievement.DADS_KEY) then
					PibersMod.TodoListVisibleTasks["Key"] = true
				else
					PibersMod:TodoListSetVisibleBossTask(BossType.MEGA_SATAN, "MegaSatan", persistentSave.SeenMegaSatan, nil, nil, bossesDone)
				end
			end
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.HUSH, "Hush", persistentSave.SeenHush, Achievement.BLUE_WOMB, Achievement.SECRET_EXIT, bossesDone)
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.DELIRIUM, "Delirium", persistentSave.SeenDelirium, Achievement.THE_VOID, nil, bossesDone)
			if gamedata:Unlocked(Achievement.SECRET_EXIT) then
				if not gamedata:Unlocked(Achievement.ROTTEN_HEARTS) then
					PibersMod.TodoListVisibleTasks["Knife"] = true
				else
					PibersMod:TodoListSetVisibleBossTask(BossType.MOTHER, "Mother", persistentSave.SeenMother, nil, nil, bossesDone)
				end
			end
			bossesDone = PibersMod:TodoListSetVisibleBossTask(BossType.DOGMA, "Dogma", persistentSave.SeenDogma, Achievement.STRANGE_DOOR, nil, bossesDone)
			if gamedata:GetEventCounter(EventCounter.DONATION_MACHINE_COUNTER) > 0 and not gamedata:Unlocked(Achievement.STOP_WATCH) then
				PibersMod.TodoListVisibleTasks["Donate"] = true
			end
		elseif isGreedMode then
			--if not PibersMod:TodoListSetVisibleBossTask(BossType.ULTRA_GREED, "Greed", persistentSave.SeenGreed) then
				bossesDone = 12
			--end
			if gamedata:GetEventCounter(EventCounter.GREED_DONATION_MACHINE_COUNTER) > 0 and not gamedata:Unlocked(Achievement.KEEPER) then
				PibersMod.TodoListVisibleTasks["Donate"] = true
			end
		end

		if gamedata:GetEventCounter(EventCounter.BLOOD_DONATION_MACHINE_USED) > 0 and not gamedata:Unlocked(Achievement.BLOOD_BAG) then
			PibersMod.TodoListVisibleTasks["DonateBlood"] = true
		end

		--extra stuff to show if final bosses are done
		if type(bossesDone) == "number" then
			local needMoreBosses = false
			if isMainMode then
				if not gamedata:Unlocked(Achievement.THE_BOOK_OF_SIN) then
					PibersMod.TodoListVisibleTasks["KillSins"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.THE_BOOK_OF_REVELATIONS) then
					PibersMod.TodoListVisibleTasks["KillHarbinger"] = true
				elseif not gamedata:Unlocked(Achievement.SEVEN_SEALS) then
					PibersMod.TodoListVisibleTasks["KillHarbingerAll"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.CELLAR) then
					PibersMod.TodoListVisibleTasks["Chapter1Bosses"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.CATACOMBS) then
					PibersMod.TodoListVisibleTasks["Chapter2Bosses"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.NECROPOLIS) then
					PibersMod.TodoListVisibleTasks["Chapter3Bosses"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.DROSS) then
					PibersMod.TodoListVisibleTasks["Chapter1BossesAlt"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.ASHPIT) then
					PibersMod.TodoListVisibleTasks["Chapter2BossesAlt"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.GEHENNA) then
					PibersMod.TodoListVisibleTasks["Chapter3BossesAlt"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.LITTLE_GISH) then
					PibersMod.TodoListVisibleTasks["KillGish"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.LITTLE_STEVEN) then
					PibersMod.TodoListVisibleTasks["KillSteven"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.LITTLE_CHAD) then
					PibersMod.TodoListVisibleTasks["KillChad"] = true
					needMoreBosses = true
				end
				if gamedata:Unlocked(Achievement.SOMETHING_WICKED) then
					if not gamedata:Unlocked(Achievement.FAST_BOMBS) then
						if not gamedata:IsBossKilled(BossType.LITTLE_HORN) then
							PibersMod.TodoListVisibleTasks["KillLittleHorn"] = true
						else
							PibersMod.TodoListVisibleTasks["KillLittleHornAgain"] = true
						end
						needMoreBosses = true
					end
				end
				if gamedata:Unlocked(Achievement.SOMETHING_WICKED_2) then
					if not gamedata:Unlocked(Achievement.PLUM_FLUTE) then
						PibersMod.TodoListVisibleTasks["SparePlum"] = true
						needMoreBosses = true
					end
					if not gamedata:Unlocked(Achievement.FRUITY_PLUM) then
						if not gamedata:IsBossKilled(BossType.BABY_PLUM) then
							PibersMod.TodoListVisibleTasks["KillPlum"] = true
						else
							PibersMod.TodoListVisibleTasks["KillPlumAgain"] = true
						end
						needMoreBosses = true
					end
				end
				if not gamedata:Unlocked(Achievement.BRIMSTONE_BOMBS) then
					PibersMod.TodoListVisibleTasks["KillHornfel"] = true
				end
				if not gamedata:IsBossKilled(BossType.THE_SIREN) then
					PibersMod.TodoListVisibleTasks["KillSiren"] = true
					needMoreBosses = true
				elseif not gamedata:Unlocked(Achievement.FORGOTTEN_LULLABY) then
					PibersMod.TodoListVisibleTasks["KillSirenSong"] = true
					needMoreBosses = true
				end
				if not gamedata:Unlocked(Achievement.ANGELIC_PRISM) then
					PibersMod.TodoListVisibleTasks["KillAngelAgain"] = true
				end
				if not gamedata:Unlocked(Achievement.BLACK_HOLE) then
					PibersMod.TodoListVisibleTasks["KillPortals"] = true
				end
				if not gamedata:Unlocked(Achievement.OLD_CAPACITOR) then
					PibersMod.TodoListVisibleTasks["KillBatteryBum"] = true
				end
			end
			if not gamedata:Unlocked(Achievement.SACRIFICAL_ALTAR) then
				if gamedata:GetEventCounter(EventCounter.DEVIL_DEALS_TAKEN) > 1 then
					PibersMod.TodoListVisibleTasks["DevilDealAgain"] = true
				else
					PibersMod.TodoListVisibleTasks["DevilDeal"] = true
				end
			elseif not gamedata:Unlocked(Achievement.KRAMPUS) then
				PibersMod.TodoListVisibleTasks["KillKrampus"] = true
				needMoreBosses = true
			end
			if not gamedata:Unlocked(Achievement.ANGELIC_PRISM) then
				if gamedata:GetEventCounter(EventCounter.ANGEL_DEALS_TAKEN) > 1 then
					PibersMod.TodoListVisibleTasks["AngelDealAgain"] = true
				else
					PibersMod.TodoListVisibleTasks["AngelDeal"] = true
				end
			end
			local chaptersDone = 0
			if isMainMode then
				if not gamedata:Unlocked(Achievement.STEVEN) then
					PibersMod.TodoListVisibleTasks["Chapter1Again"] = true
					chaptersDone = chaptersDone + 1
				elseif not gamedata:Unlocked(Achievement.BASEMENT_BOY) then
					PibersMod.TodoListVisibleTasks["Chapter1NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.CHAD) then
					PibersMod.TodoListVisibleTasks["Chapter2Again"] = true
					chaptersDone = chaptersDone + 1
				elseif not gamedata:Unlocked(Achievement.SPELUNKER_BOY) then
					PibersMod.TodoListVisibleTasks["Chapter2NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.GISH) then
					PibersMod.TodoListVisibleTasks["Chapter3Again"] = true
					chaptersDone = chaptersDone + 1
				elseif not gamedata:Unlocked(Achievement.DARK_BOY) then
					PibersMod.TodoListVisibleTasks["Chapter3NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.MAMAS_BOY) then
					PibersMod.TodoListVisibleTasks["Chapter4NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.DEAD_BOY) then
					PibersMod.TodoListVisibleTasks["Chapter6NoDmg"] = true
				end
				if not gamedata:Unlocked(Achievement.LIVING_ON_THE_EDGE) then
					PibersMod.TodoListVisibleTasks["LowHealth"] = true
				end
				if not gamedata:Unlocked(Achievement.THE_LOST) then
					PibersMod.TodoListVisibleTasks["MissingPoster"] = true
				end
				if not gamedata:Unlocked(Achievement.THE_FORGOTTEN) then
					if not persistentSave.LastForgottenState then
						persistentSave.LastForgottenState = "ForgottenBoss"
					end
					PibersMod.TodoListVisibleTasks[persistentSave.LastForgottenState] = true
				end
			end

			--extra stuff if chapter tasks are done
			if chaptersDone >= 3 and not needMoreBosses then
				if not gamedata:Unlocked(Achievement.LUCKY_TOE) then
					PibersMod.TodoListVisibleTasks["KillShopkeeper"] = true
				end
				if not gamedata:Unlocked(Achievement.GAMEKID) then
					if gamedata:GetEventCounter(EventCounter.ARCADES_ENTERED) > 1 then
						PibersMod.TodoListVisibleTasks["ArcadeAgain"] = true
					else
						PibersMod.TodoListVisibleTasks["Arcade"] = true
					end
				else
					if not gamedata:Unlocked(Achievement.COUNTERFEIT_PENNY) then
						if gamedata:GetEventCounter(EventCounter.SHELLGAMES_PLAYED) > 1 then
							PibersMod.TodoListVisibleTasks["ShellGameAgain"] = true
						else
							PibersMod.TodoListVisibleTasks["ShellGame"] = true
						end
					end
					if gamedata:GetEventCounter(EventCounter.SLOT_MACHINES_BROKEN) > 0 and not gamedata:Unlocked(Achievement.D4) then
						PibersMod.TodoListVisibleTasks["SlotMachineBreak"] = true
					end
				end
				if not gamedata:Unlocked(Achievement.MYSTERY_GIFT) then
					PibersMod.TodoListVisibleTasks["RocksAgain"] = true
				elseif not gamedata:Unlocked(Achievement.A_SMALL_ROCK) then
					PibersMod.TodoListVisibleTasks["TintedRocksAgain"] = true
				end
				if not gamedata:Unlocked(Achievement.BUTTER_BEAN) then
					PibersMod.TodoListVisibleTasks["PoopsAgain"] = true
				elseif not gamedata:Unlocked(Achievement.BOZO) then
					PibersMod.TodoListVisibleTasks["RainbowPoopsAgain"] = true
				end
				if not gamedata:Unlocked(Achievement.DOOR_STOP) then
					PibersMod.TodoListVisibleTasks["BlowUpDoors"] = true
				end

				local hasAllItemUnlocks = true
				if not gamedata:Unlocked(Achievement.SUPER_MEAT_BOY) then
					PibersMod.TodoListVisibleTasks["MeatBoy"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.SUPER_BANDAGE) then
					PibersMod.TodoListVisibleTasks["BandageGirl"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.THE_PARASITE) then
					PibersMod.TodoListVisibleTasks["DeadItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.MOMS_CONTACT) then
					PibersMod.TodoListVisibleTasks["MomItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.GUPPYS_HAIRBALL) then
					PibersMod.TodoListVisibleTasks["GuppyItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.LITTLE_BAGGY) then
					PibersMod.TodoListVisibleTasks["SyringeItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.BECAME_LORD_OF_THE_FLIES) then
					PibersMod.TodoListVisibleTasks["FlyItems"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.BUDDY_IN_A_BOX) then
					PibersMod.TodoListVisibleTasks["Familiars"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.MYSTERY_EGG) then
					PibersMod.TodoListVisibleTasks["Friendly"] = true
					end
				if not gamedata:Unlocked(Achievement.ROTTEN_PENNY) then
					PibersMod.TodoListVisibleTasks["FriendlyFlies"] = true
				end
				if not gamedata:Unlocked(Achievement.HAIRPIN) then
					PibersMod.TodoListVisibleTasks["Batteries"] = true
					hasAllItemUnlocks = false
				elseif not gamedata:Unlocked(Achievement.JUMPER_CABLES) or not gamedata:Unlocked(Achievement.EXTENSION_CORD) then
					PibersMod.TodoListVisibleTasks["BatteriesBig"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.ERA_WALK) then
					PibersMod.TodoListVisibleTasks["Watches"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.TECHNOLOGY_ZERO) then
					PibersMod.TodoListVisibleTasks["Tech"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.MR_ME) then
					PibersMod.TodoListVisibleTasks["UnlockChests"] = true
					hasAllItemUnlocks = false
				end
				if not gamedata:Unlocked(Achievement.COUPON) then
					if gamedata:GetEventCounter(EventCounter.SHOP_ITEMS_BOUGHT) > 1 then
						PibersMod.TodoListVisibleTasks["BuyItemsAgain"] = true
					else
						PibersMod.TodoListVisibleTasks["BuyItems"] = true
					end
					hasAllItemUnlocks = false
				elseif not gamedata:Unlocked(Achievement.SCHOOLBAG) then
					PibersMod.TodoListVisibleTasks["ShopsAll"] = true
				end
				if not gamedata:Unlocked(Achievement.MEMBER_CARD) then
					PibersMod.TodoListVisibleTasks["Spend40"] = true
				end
				if not gamedata:Unlocked(Achievement.GOLDEN_RAZOR) then
					PibersMod.TodoListVisibleTasks["Spend99"] = true
				end
				if not gamedata:Unlocked(Achievement.HAEMOLACRIA) then
					PibersMod.TodoListVisibleTasks["Clots"] = true
				end
				if not gamedata:Unlocked(Achievement.FLAT_STONE) then
					PibersMod.TodoListVisibleTasks["RubberCements"] = true
				end
				if hasAllItemUnlocks and not gamedata:Unlocked(Achievement.U_BROKE_IT) then
					PibersMod.TodoListVisibleTasks["MoreItems"] = true
				end
				if not gamedata:Unlocked(Achievement.ANCIENT_RECALL) then
					PibersMod.TodoListVisibleTasks["Cards"] = true
				end
				if not gamedata:Unlocked(Achievement.MOVING_BOX) then
					PibersMod.TodoListVisibleTasks["Pandora"] = true
				end
				if not gamedata:Unlocked(Achievement.MARBLES) then
					PibersMod.TodoListVisibleTasks["Gulp"] = true
				end
				if not gamedata:Unlocked(Achievement.RED_KEY) then
					PibersMod.TodoListVisibleTasks["RedKey"] = true
				end
				if not gamedata:Unlocked(Achievement.CHARGED_PENNY) then
					PibersMod.TodoListVisibleTasks["BatteryBum"] = true
				end

				if not gamedata:Unlocked(Achievement.HUGE_GROWTH) then
					PibersMod.TodoListVisibleTasks["Big"] = true
				end
				if isMainMode then
					if not gamedata:Unlocked(Achievement.ONCE_MORE_WITH_FEELING) then
						PibersMod.TodoListVisibleTasks["VictoryLap"] = true
					elseif not gamedata:Unlocked(Achievement.RERUNS) then
						PibersMod.TodoListVisibleTasks["VictoryLapAgain"] = true
					end
				end

				if not gamedata:Unlocked(Achievement.LACHRYPHAGY) then
					PibersMod.TodoListVisibleTasks["TearsUp"] = true
				end
				if not gamedata:Unlocked(Achievement.MR_RESETTER) then
					PibersMod.TodoListVisibleTasks["Reset"] = true
				end
				if not gamedata:Unlocked(Achievement.BLANKET) then
					if gamedata:GetEventCounter(EventCounter.BEDS_USED) > 1 then
						PibersMod.TodoListVisibleTasks["SleepAgain"] = true
					else
						PibersMod.TodoListVisibleTasks["Sleep"] = true
					end
				end
				if not gamedata:Unlocked(Achievement.LIL_SPEWER) then
					PibersMod.TodoListVisibleTasks["DieExplosion"] = true
				elseif not gamedata:Unlocked(Achievement.SCISSORS) then
					if gamedata:GetEventCounter(EventCounter.DEATHS) > 1 then
						PibersMod.TodoListVisibleTasks["DieAgain"] = true
					else
						PibersMod.TodoListVisibleTasks["Die"] = true
					end
				end
				if not gamedata:Unlocked(Achievement.PLANETARIUMS) then
					PibersMod.TodoListVisibleTasks["Stars"] = true
				end
				if not gamedata:Unlocked(Achievement.BABY_BENDER) then
					PibersMod.TodoListVisibleTasks["Homing"] = true
				end
				if not gamedata:Unlocked(Achievement.BLINDING_BABY) then
					PibersMod.TodoListVisibleTasks["Blinding"] = true
				end
			end
		end

		local taskCounter = 0
		for i,v in pairs(PibersMod.TodoListVisibleTasks) do
			if v == true and PibersMod.TodoListTasks[i] then
				local tasktextpos = Isaac.WorldToMenuPosition(MainMenuType.CHARACTER, PibersMod.TodoListTextPos)
				PibersMod.TodoListFont:DrawStringScaledUTF8(tostring(taskCounter+1) .. ". " .. PibersMod.TodoListTasks[i],tasktextpos.X+(taskCounter*1.5),tasktextpos.Y+(taskCounter*8),0.5,0.5, KColor.Black)
				taskCounter = taskCounter + 1
			end
		end

		--manually render win streak text at new position
		if not StatsMenu.IsSecretsMenuVisible() then
			local textpos = Isaac.WorldToMenuPosition(MainMenuType.STATS, PibersMod.WinStreakTextPos)
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
			PibersMod.WinStreakFont:DrawString(streakString,textpos.X,textpos.Y,KColor.Black,100,true)
		end
	end
end
--PibersMod:AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, PibersMod.OnMainMenuRenderToDoList)

function PibersMod:OnNewRoomToDoList()

	local game = Game()
	local level = game:GetLevel()
	local persistentSave = PibersMod.SaveManager.GetPersistentSave()
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
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PibersMod.OnNewRoomToDoList)
