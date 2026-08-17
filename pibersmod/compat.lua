local mod = PibersMod

function mod.PickupNotTouched(pickup)
	return not pickup:ToPickup().Touched
end

function mod.AddRuneCompat(runeID, pageFrame)
	if runeID and runeID > 0 then
		local runeXML = XMLData.GetEntryById(XMLNode.CARD, runeID)
		if runeXML and runeXML.pickup and tonumber(runeXML.pickup) then
			mod.CollectionPageIconOverridePickup[tonumber(runeXML.pickup)] = {mod.CollectionPagePickupCustom, 3}
		end
		local itemConfig = Isaac.GetItemConfig()
		local runeConfig = itemConfig:GetCard(runeID)
		if runeConfig.ModdedCardFront then
			runeConfig.ModdedCardFront:Load("gfx/ui/ui_runes.anm2",true)
		end
		mod.CollectionPageIconOverrideCard[runeID] = {mod.CollectionPageCardCustom, pageFrame}
	end
end

function mod.AddTrinketCompat(trinketID, pageFrame)
	if trinketID and trinketID > 0 then
		mod.CollectionPageIconOverrideTrinket[trinketID] = {mod.CollectionPageTrinketCustom, pageFrame}
	end
end

mod.ItemsAddedToPool = {}
mod.ItemsRemovedFromPool = {}
function mod.AddModItemToPool(collID, poolID, weight)
	if itemID and itemID > 0 and poolID and poolID > 0 then
		if mod.ItemsRemovedFromPool[poolID] and mod.ItemsAddedToPool[poolID][collID] then
			mod.ItemsRemovedFromPool[poolID][collID] = nil
		else
			weight = weight or 1.0
			local game = Game()
			local itemPool = game:GetItemPool()
			mod.ItemsAddedToPool[poolID] = mod.ItemsAddedToPool[poolID] or {}
			mod.ItemsAddedToPool[poolID][collID] = {itemID=collID,weight=weight,decreaseBy=0.5,removeOn=0.1}
			itemPool:AddCollectible(poolID, mod.ItemsAddedToPool[poolID][collID])
		end
	end
end
function mod.RemoveModItemFromPool(collID, poolID)
	if itemID and itemID > 0 and poolID and poolID > 0 then
		if mod.ItemsAddedToPool[poolID] and mod.ItemsAddedToPool[poolID][collID] then
			mod.ItemsAddedToPool[poolID][collID].weight = 0
		else
			mod.ItemsRemovedFromPool[poolID] = mod.ItemsRemovedFromPool[poolID] or {}
			mod.ItemsRemovedFromPool[poolID][collID] = true
		end
	end
end

function mod.OnGetCollectible(itemID, poolID, decrease, seed)
	local game = Game()
	local itemPool = game:GetItemPool()
	local lastPool = itemPool:GetLastPool()
	if not lastPool then
		lastPool = poolID
	end
	if mod.ItemsRemovedFromPool[poolID] and mod.ItemsRemovedFromPool[poolID][itemID] then
		local attempts = 0
		while attempts < 100 do
			local newID = itemPool:GetCollectible(poolID, decrease, seed+attempts)
			if newID and newID ~= itemID then
				return newID
			end
			attempts = attempts + 1
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, mod.OnGetCollectible)

mod.MinimapSprite = Sprite("gfx/ui/minimap_icons_pibersmod.anm2", true)
mod.MinimapSpriteDefault = Sprite("gfx/ui/minimapapi_icons.anm2", true)
mod.MinimapSpriteDogma = Sprite("gfx/ui/minimap_icons_pibersmod.anm2", true)
mod.MinimapSpriteDogma:SetRenderFlags(AnimRenderFlags.STATIC)
function mod.OnModsLoadedCompat()

	--External Item Descriptions
	if EID then
		EID:addCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE, "↑ {{Tears}} +1.5 Tears#↓ {{Range}} -1.5 Range#↓ {{Range}} x0.8 Range multiplier#Converts all range down pills into range up pills", nil, "en")
		EID:addCollectible(CollectibleType.COLLECTIBLE_HOLY_MANTLE, "↑ {{HolyMantleSmall}} +1 Holy Shield#If lost, restores the shield in the next room", nil, "en")
		EID:addCollectible(CollectibleType.COLLECTIBLE_TOXIC_SHOCK, "{{Poison}} Killing an enemy has a 15% chance to poison all enemies#Chance scales by 2% for each point of luck#Enemies killed leave a puddle of creep#The creep deals 30 damage per second", nil, "en")
		EID:addCollectible(CollectibleType.COLLECTIBLE_BLANKET, "{HealingRed}} Heals 1 heart#{{SoulHeart}} +1 Soul Heart#↑ {{HolyMantleSmall}} +1 Holy Shield when entering a boss room", nil, "en")
		EID:addCollectible(CollectibleType.COLLECTIBLE_DOGMA, "↑ {{Speed}} +0.1 Speed#↑ {{Damage}} +2 Damage#↑ {{HolyMantleSmall}} +1 Holy Shield#Flight#{{Heart}} Heals Isaac with Red and Soul Hearts if he has less than 6 hearts", nil, "en")
		EID:addCollectible(CollectibleType.MIXED_VEGGIES, "↑ {{Damage}} +0.15 Damage#↑ {{Heart}} +1 Health#{{HealingRed}} Heals 1 heart", nil, "en")
		EID:addCollectible(CollectibleType.BLOODY_FEATHER, "{{Tears}} +0.5 Tears#Taking damage spawns a holy light effect#The holy light effect has a 60% chance to spawn on an enemy#Chance scales with luck", nil, "en")
		EID:addCollectible(CollectibleType.COUNTERFEIT_DOLLAR, "{{Coin}} +100 Coins#↑ {{Damage}} +0.2 Damage#↓ {{Luck}} -1 Luck#After clearing a room, chance to remove coins#Only coins added by this item will be removed#Chance is affected by luck", nil, "en")
		EID:addCollectible(CollectibleType.BIRTHDAY_CAKE, "↑ {{Tears}} +0.1 Tears#↑ {{Heart}} +1 Health#{{HealingRed}} Heals 1 heart", nil, "en")

		for index, descData in pairs(EID.DescriptionConditions["5.100." .. CollectibleType.COLLECTIBLE_TOXIC_SHOCK]) do
			if descData and descData.modifierText and descData.modifierText == "No Effect (Copies)" then
				table.remove(EID.DescriptionConditions["5.100." .. CollectibleType.COLLECTIBLE_TOXIC_SHOCK],index)
				break
			end
		end
		EID:addSelfCondition(CollectibleType.COLLECTIBLE_TOXIC_SHOCK, "Each stack adds an extra attempt to proc the poison", "en", nil, true)

		EID:AddItemConditional(CollectibleType.BLOODY_FEATHER, {CollectibleType.COLLECTIBLE_HOLY_MANTLE, CollectibleType.COLLECTIBLE_BLANKET, CollectibleType.COLLECTIBLE_DOGMA, "5.350." .. TrinketType.TRINKET_WOODEN_CROSS, "5.300." .. Card.CARD_HOLY}, "{1} Holy Shields also trigger this effect when lost")

		EID:addTrinket(TrinketType.TRINKET_WOODEN_CROSS, "↑ {{HolyMantleSmall}} +1 Holy Shield#If lost, restores the shield on the next floor", nil, "en")
		EID:addTrinket(TrinketType.ORTHODOX_CROSS, "{{AngelChance}} 100% Angel Room chance#{{DevilChance}} Devil rooms never appear", nil, "en")

		EID:addCard(Card.CARD_HOLY, "↑ {{HolyMantleSmall}} +1 Holy Shield", nil, "en")
		EID:addCard(Card.RUNE_ISAZ, "{{Slow}} Chills the entire room, slowing enemies#{{Freezing}} Enemies freeze upon being killed", nil, "en")
		EID:addCard(Card.RUNE_WUNJO, "{{EternalHeart}} +1 Eternal Heart", nil, "en")

		EID:addBFFSCondition(FamiliarVariant.LOST_SOUL, "Gives the Lost Soul a {{HolyMantleSmall}} Holy Shield-like effect", nil, nil, "en")

		EID:addTarotClothBuffsCondition("5.300." .. Card.CARD_MOON, "Can teleport Isaac to the {{SuperSecretRoom}} Super Secret Room instead#If both have already been visited, instead teleports Isaac to the {{UltraSecretRoom}} Ultra Secret Room", nil, nil, "en")

		EID:RemoveCallback(ModCallbacks.MC_MAIN_MENU_RENDER, EID.OnMenuRender)
	end

	--Minimap API
	if MinimapAPI then
		MinimapAPI:AddIcon("MicroBattery", mod.MinimapSprite, "MicroBattery", 1)
		MinimapAPI:AddIcon("MegaBattery", mod.MinimapSprite, "MegaBattery", 1)
		MinimapAPI:AddIcon("MomTreasureRoom", mod.MinimapSprite, "MomTreasureRoom", 1)
		MinimapAPI:AddIcon("Blessing", mod.MinimapSprite, "Blessing", 1)
		MinimapAPI:AddIcon("MomsChest", mod.MinimapSpriteDefault, "ItemPoolChests", 5)
		MinimapAPI:AddIcon("Bed", mod.MinimapSprite, "Bed", 1)
		MinimapAPI:AddIcon("TeleporterRoomRed", mod.MinimapSprite, "TeleporterRoomRed", 1)
		MinimapAPI:AddIcon("MomsBed", mod.MinimapSprite, "MomsBed", 1)
		MinimapAPI:AddIcon("TV", mod.MinimapSprite, "TV", 1)
		MinimapAPI:AddIcon("TVOn", mod.MinimapSpriteDogma, "TVOn", 1)
		MinimapAPI:AddIcon("TeleporterRoom1", mod.MinimapSprite, "TeleporterRoom1", 1)
		MinimapAPI:AddIcon("TeleporterRoom2", mod.MinimapSprite, "TeleporterRoom2", 1)
		MinimapAPI:AddIcon("TeleporterRoom3", mod.MinimapSprite, "TeleporterRoom3", 1)
		MinimapAPI:AddIcon("TeleporterRoom1Red", mod.MinimapSprite, "TeleporterRoom1Red", 1)
		MinimapAPI:AddIcon("TeleporterRoom2Red", mod.MinimapSprite, "TeleporterRoom2Red", 1)
		MinimapAPI:AddIcon("TeleporterRoom3Red", mod.MinimapSprite, "TeleporterRoom3Red", 1)
		MinimapAPI:AddIcon("MomsBedroom", mod.MinimapSprite, "MomsBedroom", 1)
		MinimapAPI:AddIcon("BabyShop", mod.MinimapSprite, "BabyShop", 1)
		MinimapAPI:AddIcon("Grave", mod.MinimapSprite, "Grave", 1)
		MinimapAPI:AddPickup("MicroBattery", "MicroBattery", EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MICRO, MinimapAPI.PickupNotCollected, "batteries", 4033)
		MinimapAPI:AddPickup("MegaBattery", "MegaBattery", EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA, MinimapAPI.PickupNotCollected, "batteries", 3933)
		MinimapAPI:AddPickup("Blessing", "Blessing", EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.BLESSING, MinimapAPI.PickupNotCollected, "hearts", 15833)
		MinimapAPI:AddPickup("MomsChest", "MomsChest", EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_MOMSCHEST, -1, MinimapAPI.PickupChestNotCollected, "chests", 12833)
		MinimapAPI:AddPickup("Bed", "Bed", EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BED, BedSubType.BED_ISAAC, mod.PickupNotTouched, "beds", 3333)
		MinimapAPI:AddPickup("MomsBed", "MomsBed", EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BED, BedSubType.BED_MOM, mod.PickupNotTouched, "beds", 3433)
	end

	--Enhanced Boss Bars
	if HPBars and HPBars.BossDefinitions then
		if HPBars.BossDefinitions["79.1"] then
			HPBars.BossDefinitions["79.1"].bossColors = HPBars.BossDefinitions["79.1"].bossColors or {}
			HPBars.BossDefinitions["79.1"].bossColors[BossColors.GEMINI_STEVEN+1] = "_black"
		end
		if HPBars.BossDefinitions["79.11"] then
			HPBars.BossDefinitions["79.11"].bossColors = HPBars.BossDefinitions["79.11"].bossColors or {}
			HPBars.BossDefinitions["79.11"].bossColors[BossColors.GEMINI_STEVEN_BABY+1] = "_black"
		end
	end

	--Restored Collection
	mod.AddTrinketCompat(Isaac.GetTrinketIdByName("​Game Squid"), 1)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("​Stone Bombs"), ItemPoolType.POOL_TREASURE)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("​Stone Bombs"), ItemPoolType.POOL_GREED_TREASURE)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("​Blank Bombs"), ItemPoolType.POOL_TREASURE)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("​Blank Bombs"), ItemPoolType.POOL_GREED_TREASURE)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("Safety Bombs"), ItemPoolType.POOL_TREASURE)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("Safety Bombs"), ItemPoolType.POOL_GREED_TREASURE)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("​Dice Bombs"), ItemPoolType.POOL_TREASURE)
	mod.RemoveModItemFromPool(Isaac.GetItemIdByName("​Dice Bombs"), ItemPoolType.POOL_GREED_TREASURE)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Stone Bombs"), ItemPoolType.POOL_SHOP, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Stone Bombs"), ItemPoolType.POOL_GREED_SHOP, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Blank Bombs"), ItemPoolType.POOL_SHOP, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Blank Bombs"), ItemPoolType.POOL_GREED_SHOP, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Blank Bombs"), ItemPoolType.CRAWLSPACE)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Dice Bombs"), ItemPoolType.POOL_SHOP, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Dice Bombs"), ItemPoolType.POOL_GREED_SHOP, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Dice Bombs"), ItemPoolType.DICE_ROOM)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Checked Mate"), ItemPoolType.POOL_CRANE_GAME)
	mod.AddModItemToPool(Isaac.GetItemIdByName("Pumpkin Mask"), ItemPoolType.KRAMPUS)
	mod.AddModItemToPool(Isaac.GetItemIdByName("Pill Crusher"), ItemPoolType.POOL_MOMS_CHEST, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("Pill Crusher"), ItemPoolType.MOMS_CHEST_MAUSOLEUM, 0.5)
	mod.AddModItemToPool(Isaac.GetItemIdByName("Ol' Lopper"), ItemPoolType.CRAWLSPACE)
	mod.AddModItemToPool(Isaac.GetItemIdByName("​Keeper's Rope"), ItemPoolType.BARREN_ROOM)

	--Antibirth Runes
	mod.AddRuneCompat(Isaac.GetCardIdByName("Gebo"), 8)
	mod.AddRuneCompat(Isaac.GetCardIdByName("Kenaz"), 9)
	mod.AddRuneCompat(Isaac.GetCardIdByName("Fehu"), 10)
	mod.AddRuneCompat(Isaac.GetCardIdByName("Othala"), 11)
	mod.AddRuneCompat(Isaac.GetCardIdByName("Sowilo"), 12)
	mod.AddRuneCompat(Isaac.GetCardIdByName("Ingwaz"), 13)

	if LastJudgement and not PibersModLJPatch then
		print("piber mod missing last judgement patch :(")
	else
		print("piber mod loaded correctly :)")
	end

end
mod.AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, mod.OnModsLoadedCompat)
