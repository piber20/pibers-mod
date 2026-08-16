function PibersMod:IsXMLUnlocked(itemID, xml)
	local data = XMLData.GetEntryById(xml, itemID)
	if data and data.achievement and not Isaac.GetPersistentGameData():Unlocked(tonumber(data.achievement)) then
		return false
	end
	return true
end
function PibersMod:IsCollectibleUnlocked(itemID)
	return PibersMod:IsXMLUnlocked(itemID, XMLNode.ITEM)
end
function PibersMod:IsTrinketUnlocked(itemID)
	return PibersMod:IsXMLUnlocked(itemID, XMLNode.TRINKET)
end
function PibersMod:IsCardUnlocked(itemID)
	return PibersMod:IsXMLUnlocked(itemID, XMLNode.CARD)
end
function PibersMod:IsPillUnlocked(itemID)
	return PibersMod:IsXMLUnlocked(itemID, XMLNode.PILL)
end
function PibersMod:IsBabyUnlocked(itemID)
	local data = EntityConfig.GetBaby(itemID)
	if data and data:GetAchievementID() and Isaac.GetPersistentGameData():Unlocked(data:GetAchievementID()) then
		return false
	end
	return true
end
PibersMod.CollectionPageTabs = Sprite("gfx/ui/main menu/collectionmenu_tabs.anm2", true)
PibersMod.CollectionPageTabs:SetFrame("Tabs", 0)
PibersMod.CollectionPageTabsPos = Vector(70,166)
PibersMod.CollectionPageBulletOn = Sprite("gfx/ui/main menu/collectionmenu_bullet.anm2", true)
PibersMod.CollectionPageBulletOn:SetFrame("Idle", 0)
PibersMod.CollectionPageBulletOff = Sprite("gfx/ui/main menu/collectionmenu_bullet.anm2", true)
PibersMod.CollectionPageBulletOff:SetFrame("Idle", 1)
PibersMod.CollectionPageCollectible = Sprite("gfx/ui/death screen.anm2", true)
PibersMod.CollectionPageCollectible:SetFrame("Diary", 0)
for _,layer in pairs(PibersMod.CollectionPageCollectible:GetAllLayers()) do
	if layer:GetLayerID() == 6 then
		layer:SetVisible(true)
	else
		layer:SetVisible(false)
	end
end
PibersMod.CollectionPageTrinket = Sprite("gfx/ui/death items trinkets.anm2", true)
PibersMod.CollectionPageTrinket:SetFrame("Diary", 0)
PibersMod.CollectionPageCard = Sprite("gfx/ui/death items pickups.anm2", true)
PibersMod.CollectionPageCard:SetFrame("Diary", 0)
PibersMod.CollectionPagePill = Sprite("gfx/ui/death items pills.anm2", true)
PibersMod.CollectionPagePill:SetFrame("Diary", 0)
PibersMod.CollectionPageDupe = Sprite("gfx/ui/main menu/collectionmenu.anm2", true)
PibersMod.CollectionPageDupe:SetFrame("Idle", 0)
PibersMod.CollectionPageItem = Sprite("gfx/005.100_collectible.anm2", true)
PibersMod.CollectionPageItem:SetFrame("PlayerPickup", 0)
PibersMod.CollectionPageItemPickup = Sprite("gfx/005.301_tarot card", true)
PibersMod.CollectionPageItemPickup:SetFrame("HUD", 0)
PibersMod.CollectionPageItemCard = Sprite("gfx/ui/ui_cardspills.anm2", true)
PibersMod.CollectionPageItemCard:SetFrame("CardFronts", 0)
PibersMod.CollectionPageItemCardModded = nil
PibersMod.CollectionPageDisplayItem = true
PibersMod.CollectionPageForceDisplayPickup = false
PibersMod.CollectionPageFont = Font("font/teammeatex/teammeatex12.fnt")
PibersMod.CollectionPageFontColor = KColor(0.47,0.45,0.38,1.0)
PibersMod.CollectionPageNumPages = 0
PibersMod.CollectionPageNumPagesCollectible = 0
PibersMod.CollectionPageNumPagesTrinket = 0
PibersMod.CollectionPageNumPagesCard = 0
PibersMod.CollectionPageValidCollectibles = {}
PibersMod.CollectionPageValidTrinkets = {}
PibersMod.CollectionPageValidCards = {}
PibersMod.CollectionPageValidCardIsPill = {}
PibersMod.CollectionPageCardPickup = {}
PibersMod.CollectionPageFirstItem = Vector(121,43)
PibersMod.CollectionPageFirstItemCentered = Vector(37,63)
PibersMod.CollectionPageBulletPos = Vector(-39,-57)
PibersMod.CollectionPageItemNotePos = Vector(-39,-15)
PibersMod.CollectionPageItemIconPos = Vector(-38,-8)
PibersMod.CollectionPageItemIconPosCard = Vector(-41,-13)
PibersMod.CollectionPageItemNamePos = Vector(-20,-31)
PibersMod.CollectionPageItemDescPos = Vector(-20,-16)
PibersMod.CollectionPageItemName = ""
PibersMod.CollectionPageItemDesc = ""
PibersMod.CollectionPageBulletHeight = 84
PibersMod.CollectionPageMode = 0
PibersMod.CollectionPageLastMode = 0
PibersMod.CollectionPageLastElement = 0
PibersMod.CollectionPageItemsPerRow = 20
PibersMod.CollectionPageItemsPerCol = 6
PibersMod.CollectionPageItemsPerPage = PibersMod.CollectionPageItemsPerRow*PibersMod.CollectionPageItemsPerCol
PibersMod.CollectionPageFakeCurrentPage = 0
PibersMod.CollectionPageFakeNumPages = 0
PibersMod.CollectionPageSortMode = 0
PibersMod.CollectionPageFakeElementsInPage = PibersMod.CollectionPageItemsPerPage
PibersMod.CollectionPageTrinketCustom = Sprite("gfx/ui/death items trinkets pibersmod.anm2", true)
PibersMod.CollectionPageTrinketCustom:SetFrame(PibersMod.CollectionPageTrinketCustom:GetDefaultAnimation(), 0)
PibersMod.CollectionPagePickupCustom = Sprite("gfx/ui/death items pickups pibersmod.anm2", true)
PibersMod.CollectionPagePickupCustom:SetFrame(PibersMod.CollectionPagePickupCustom:GetDefaultAnimation(), 0)
PibersMod.CollectionPageCardCustom = Sprite("gfx/ui/death items cards pibersmod.anm2", true)
PibersMod.CollectionPageCardCustom:SetFrame(PibersMod.CollectionPageCardCustom:GetDefaultAnimation(), 0)
PibersMod.CollectionPageIconOverrideCollectibles = {}
PibersMod.CollectionPageIconOverrideTrinket = {}
PibersMod.CollectionPageIconOverridePickup = {}
PibersMod.CollectionPageIconOverrideCard = {}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_HAGALAZ] = {PibersMod.CollectionPageCardCustom, 0}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_JERA] = {PibersMod.CollectionPageCardCustom, 1}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_EHWAZ] = {PibersMod.CollectionPageCardCustom, 2}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_DAGAZ] = {PibersMod.CollectionPageCardCustom, 3}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_ANSUZ] = {PibersMod.CollectionPageCardCustom, 4}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_PERTHRO] = {PibersMod.CollectionPageCardCustom, 5}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_BERKANO] = {PibersMod.CollectionPageCardCustom, 6}
PibersMod.CollectionPageIconOverrideCard[Card.RUNE_ALGIZ] = {PibersMod.CollectionPageCardCustom, 7}
PibersMod.CollectionPageDescriptionOverridePill = {}
PibersMod.CollectionPageDescriptionOverridePill[PillEffect.PILLEFFECT_EXPERIMENTAL] = "One stat up, one stat down"
PibersMod.CollectionPageSortPriority = {}
PibersMod.CollectionPageSortPriority.ORIGINAL = 100
PibersMod.CollectionPageSortPriority.WOTL = 200
PibersMod.CollectionPageSortPriority.REBIRTH = 300
PibersMod.CollectionPageSortPriority.AFTERBIRTH = 400
PibersMod.CollectionPageSortPriority.AFTERBIRTH_PLUS = 500
PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX = 600
PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_1 = 610
PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_2 = 620
PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_3 = 630
PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_4 = 640
PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_5 = 650
PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_6 = 660
PibersMod.CollectionPageSortPriority.ANTIBIRTH = 700
PibersMod.CollectionPageSortPriority.ANTIBIRTH_1 = 710
PibersMod.CollectionPageSortPriority.ANTIBIRTH_2 = 720
PibersMod.CollectionPageSortPriority.REPENTANCE = 800
PibersMod.CollectionPageSortPriority.REPENTANCE_PLUS = 900
PibersMod.CollectionPageSortPriority.PIBERSMOD = 1000
PibersMod.CollectionPageSortPriority.MODDED_START = 2000
PibersMod.CollectionPageSortPriority.MODDED_OFFSET = 10
PibersMod.CollectionPageSortItem = {}
PibersMod.CollectionPageSortTrinket = {}
PibersMod.CollectionPageSortCard = {}
PibersMod.CollectionPageSortPill = {}
function PibersMod.GenerateCollectionMenuData()
	local itemConfig = Isaac.GetItemConfig()
	local lastItem = CollectibleType.NUM_COLLECTIBLES
	local numHidden = 0
	local id=0
	while id >= 0 do
		local item = itemConfig:GetCollectible(id)
		if not item then
			if id >= CollectibleType.NUM_COLLECTIBLES then
				lastItem = id-1
				id = -id
			else
				numHidden = numHidden + 1
			end
		elseif item.Hidden then
			numHidden = numHidden + 1
		else
			local priority = PibersMod.CollectionPageSortPriority.MODDED_START+((id-CollectibleType.NUM_COLLECTIBLES)*PibersMod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < CollectibleType.COLLECTIBLE_GUPPYS_PAW then
				priority = PibersMod.CollectionPageSortPriority.ORIGINAL

			elseif id < CollectibleType.COLLECTIBLE_MOMS_KEY then
				priority = PibersMod.CollectionPageSortPriority.WOTL

			elseif id < CollectibleType.COLLECTIBLE_DIPLOPIA then
				priority = PibersMod.CollectionPageSortPriority.REBIRTH

				if id == CollectibleType.COLLECTIBLE_POLAROID then
					priority = PibersMod.CollectionPageSortPriority.WOTL
				elseif id == CollectibleType.COLLECTIBLE_CLEAR_RUNE then
					priority = PibersMod.CollectionPageSortPriority.REPENTANCE
				end

			elseif id < CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < CollectibleType.COLLECTIBLE_MUCORMYCOSIS then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH_PLUS

				if id == CollectibleType.COLLECTIBLE_SCHOOLBAG then
					priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH_2
				end

			elseif id < CollectibleType.COLLECTIBLE_FRUITY_PLUM then
				priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH_2

				if id < CollectibleType.COLLECTIBLE_GOLDEN_RAZOR then
					priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH
				elseif id < CollectibleType.COLLECTIBLE_GENESIS then
					priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH_1
				end

				if id == CollectibleType.COLLECTIBLE_GOLDEN_RAZOR
					or id == CollectibleType.COLLECTIBLE_BLOOD_PUPPY
					or id == CollectibleType.COLLECTIBLE_DREAM_CATCHER
					or id == CollectibleType.COLLECTIBLE_DIVINE_INTERVENTION
					or id == CollectibleType.COLLECTIBLE_LARYNX
					or id == CollectibleType.COLLECTIBLE_GENESIS
					or id == CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE
					or id == CollectibleType.COLLECTIBLE_DOGMA
					or id == CollectibleType.COLLECTIBLE_PURGATORY then
					priority = PibersMod.CollectionPageSortPriority.REPENTANCE

				elseif id == CollectibleType.COLLECTIBLE_FORTUNE_COOKIE then
					-- id == jawbone
					-- id == counterfeit dollar
					-- id == box of wires
					-- id == tammys paw
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX

				elseif id == CollectibleType.COLLECTIBLE_IT_HURTS
					or id == CollectibleType.COLLECTIBLE_NANCY_BOMBS
					-- id == tammys tail
					or id == CollectibleType.COLLECTIBLE_BLOOD_OATH then
					-- id == d12
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_1

				elseif id == CollectibleType.COLLECTIBLE_SULFUR
					-- id == bowl of tears
					or id == CollectibleType.COLLECTIBLE_SOCKS then
					-- id == book of despair
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_2

				elseif id == CollectibleType.COLLECTIBLE_BAR_OF_SOAP then
					-- id == cool bean
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_3

				elseif id == CollectibleType.COLLECTIBLE_EYE_SORE
					or id == CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES then
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_4

				elseif id == CollectibleType.COLLECTIBLE_MUCORMYCOSIS
					or id == CollectibleType.COLLECTIBLE_2SPOOKY
					or id == CollectibleType.COLLECTIBLE_WAVY_CAP then
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_5

				elseif id == CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE
					or id == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
					-- id == maxs paw
					-- id == maxs tail
					-- id == the apple
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_6
				end

			elseif id < CollectibleType.NUM_COLLECTIBLES then
				priority = PibersMod.CollectionPageSortPriority.REPENTANCE

				if id == CollectibleType.COLLECTIBLE_GIANT_CELL then
					priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH_2
				elseif id == CollectibleType.COLLECTIBLE_SAUSAGE then
					priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH_1
				end

			elseif id >= CollectibleType.MIXED_VEGGIES and id <= CollectibleType.BIRTHDAY_CAKE then
				priority = PibersMod.CollectionPageSortPriority.PIBERSMOD

				if id == CollectibleType.KEY_PIECE_COMPLETE then
					priority = PibersMod.CollectionPageSortPriority.REBIRTH
				elseif id == CollectibleType.KNIFE_PIECE_COMPLETE then
					priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH_2
				elseif id == CollectibleType.COUNTERFEIT_DOLLAR then
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX
				end
			end

			PibersMod.CollectionPageSortItem[priority] = PibersMod.CollectionPageSortItem[priority] or {}
			PibersMod.CollectionPageSortItem[priority][#PibersMod.CollectionPageSortItem[priority]+1] = id
			PibersMod.CollectionPageValidCollectibles[#PibersMod.CollectionPageValidCollectibles+1] = id
		end
		id = id + 1
	end
	local numItems = lastItem-numHidden
	PibersMod.CollectionPageNumPagesCollectible = math.ceil(numItems/PibersMod.CollectionPageItemsPerPage)
	PibersMod.CollectionPageNumPages = PibersMod.CollectionPageNumPagesCollectible

	local lastTrinket = TrinketType.NUM_TRINKETS
	numHidden = 0
	id=0
	while id >= 0 do
		local trinket = itemConfig:GetTrinket(id)
		if not trinket then
			if id >= TrinketType.NUM_TRINKETS then
				lastTrinket = id-1
				id = -id
			else
				numHidden = numHidden + 1
			end
		elseif trinket.Hidden then
			numHidden = numHidden + 1
		else
			local priority = PibersMod.CollectionPageSortPriority.MODDED_START+((id-TrinketType.NUM_TRINKETS)*PibersMod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < TrinketType.TRINKET_FISH_HEAD then
				priority = PibersMod.CollectionPageSortPriority.REBIRTH

				if id == TrinketType.TRINKET_WIGGLE_WORM then
					priority = PibersMod.CollectionPageSortPriority.ORIGINAL
				end

			elseif id < TrinketType.TRINKET_SHINY_ROCK then
				priority = PibersMod.CollectionPageSortPriority.WOTL

			elseif id < TrinketType.TRINKET_MECONIUM then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < TrinketType.TRINKET_JAW_BREAKER then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < TrinketType.TRINKET_SHORT_FUSE then
				priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX

				if id == TrinketType.TRINKET_BLESSED_PENNY then
					priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX_1
				end

			elseif id < TrinketType.TRINKET_BLUE_KEY then
				priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH

			elseif id < TrinketType.NUM_TRINKETS then
				priority = PibersMod.CollectionPageSortPriority.REPENTANCE
			end

			if id == TrinketType.ORTHODOX_CROSS then
				priority = PibersMod.CollectionPageSortPriority.COMMUNITY_REMIX
			end

			PibersMod.CollectionPageSortTrinket[priority] = PibersMod.CollectionPageSortTrinket[priority] or {}
			PibersMod.CollectionPageSortTrinket[priority][#PibersMod.CollectionPageSortTrinket[priority]+1] = id
			PibersMod.CollectionPageValidTrinkets[#PibersMod.CollectionPageValidTrinkets+1] = id
		end
		id = id + 1
	end
	local numTrinkets = lastTrinket-numHidden
	PibersMod.CollectionPageNumPagesTrinket = math.ceil(numTrinkets/PibersMod.CollectionPageItemsPerPage)

	local lastCard = Card.NUM_CARDS
	numHidden = 0
	id=1 --manually skipping CARD_NULL
	while id >= 0 do
		local card = itemConfig:GetCard(id)
		if not card then
			if id >= Card.NUM_CARDS then
				lastCard = id-1
				id = -id
			else
				numHidden = numHidden + 1
			end
		elseif card.Hidden then
			numHidden = numHidden + 1
		else
			local priority = PibersMod.CollectionPageSortPriority.MODDED_START+((id-Card.NUM_CARDS)*PibersMod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < Card.CARD_CLUBS_2 then
				priority = PibersMod.CollectionPageSortPriority.ORIGINAL

			elseif id < Card.CARD_ACE_OF_CLUBS then
				priority = PibersMod.CollectionPageSortPriority.WOTL

			elseif id < Card.CARD_JOKER then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < Card.CARD_GET_OUT_OF_JAIL then
				priority = PibersMod.CollectionPageSortPriority.REBIRTH

				if id == Card.RUNE_BLANK then
					priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH
				elseif id == Card.RUNE_BLACK then
					priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH_PLUS
				end

			elseif id < Card.CARD_HOLY then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < Card.RUNE_SHARD then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < Card.NUM_CARDS then
				priority = PibersMod.CollectionPageSortPriority.REPENTANCE
			end

			PibersMod.CollectionPageSortCard[priority] = PibersMod.CollectionPageSortCard[priority] or {}
			PibersMod.CollectionPageSortCard[priority][#PibersMod.CollectionPageSortCard[priority]+1] = id
			PibersMod.CollectionPageValidCards[#PibersMod.CollectionPageValidCards+1] = id
			if card.PickupSubtype and tonumber(card.PickupSubtype) then
				PibersMod.CollectionPageCardPickup[id] = tonumber(card.PickupSubtype)
			end
		end
		id = id + 1
	end

	local lastPill = PillEffect.NUM_PILL_EFFECTS
	id=0
	while id >= 0 do
		local pill = itemConfig:GetPillEffect(id)
		if not pill then
			if id >= PillEffect.NUM_PILL_EFFECTS then
				lastPill = id-1
				id = -id
			else
				numHidden = numHidden + 1
			end
		elseif pill.Hidden then
			numHidden = numHidden + 1
		else
			local priority = PibersMod.CollectionPageSortPriority.MODDED_START+((id-PillEffect.NUM_PILL_EFFECTS)*PibersMod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < PillEffect.PILLEFFECT_48HOUR_ENERGY then
				priority = PibersMod.CollectionPageSortPriority.ORIGINAL

				if id == PillEffect.PILLEFFECT_PUBERTY
				or id == PillEffect.PILLEFFECT_LUCK_DOWN
				or id == PillEffect.PILLEFFECT_LUCK_UP then
					priority = PibersMod.CollectionPageSortPriority.WOTL
				end

			elseif id < PillEffect.PILLEFFECT_PERCS then
				priority = PibersMod.CollectionPageSortPriority.REBIRTH

				if id == PillEffect.PILLEFFECT_FRIENDS_TILL_THE_END then
					priority = PibersMod.CollectionPageSortPriority.WOTL
				end

			elseif id < PillEffect.PILLEFFECT_X_LAX then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < PillEffect.PILLEFFECT_SHOT_SPEED_DOWN then
				priority = PibersMod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < PillEffect.NUM_PILL_EFFECTS then
				priority = PibersMod.CollectionPageSortPriority.ANTIBIRTH
			end

			PibersMod.CollectionPageSortPill[priority] = PibersMod.CollectionPageSortPill[priority] or {}
			PibersMod.CollectionPageSortPill[priority][#PibersMod.CollectionPageSortPill[priority]+1] = id
			PibersMod.CollectionPageValidCards[#PibersMod.CollectionPageValidCards+1] = id
			PibersMod.CollectionPageValidCardIsPill[#PibersMod.CollectionPageValidCards] = true
		end
		id = id + 1
	end
	local numCards = (1+lastCard+lastPill)-numHidden
	PibersMod.CollectionPageNumPagesCard = math.ceil(numCards/PibersMod.CollectionPageItemsPerPage)
end
PibersMod:AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, PibersMod.GenerateCollectionMenuData)

function PibersMod:OnMainMenuRenderCollectionPage()
	local currentActive = MenuManager:GetActiveMenu()
	if currentActive == MainMenuType.COLLECTION then
		local itemConfig = Isaac.GetItemConfig()
		if PibersMod.CollectionPageNumPages > 0 then
			local collsprite = CollectionMenu.GetCollectionMenuSprite()
			local iconsprite = CollectionMenu.GetDeathScreenSprite()
			local currentPage = CollectionMenu.GetSelectedPage()
			local currentElement = CollectionMenu.GetSelectedElement()
			local numPages = PibersMod.CollectionPageNumPages
			local eiddesc = nil
			if PibersMod.CollectionPageMode == 0 then
				if PibersMod.CollectionPageSortMode > 0 then
					PibersMod.CollectionPageFakeNumPages = PibersMod.CollectionPageNumPagesCollectible
					PibersMod.CollectionPageFakeElementsInPage = PibersMod.CollectionPageItemsPerPage-1
					for i=1, PibersMod.CollectionPageItemsPerPage do
						local id = PibersMod.CollectionPageValidCollectibles[i+(PibersMod.CollectionPageFakeCurrentPage*PibersMod.CollectionPageItemsPerPage)]
						if id then
							local renderIcon = true
							local renderPosOffset = Vector(16*((i-1)%PibersMod.CollectionPageItemsPerRow),16*(math.floor((i-1)/PibersMod.CollectionPageItemsPerRow)))
							if not PibersMod:IsCollectibleUnlocked(id) then
								PibersMod.CollectionPageCollectible:SetFrame(0)
							elseif PibersMod.CollectionPageIconOverrideCollectibles[id] then
								if type(PibersMod.CollectionPageIconOverrideCollectibles[id]) == "number" then
									PibersMod.CollectionPageCollectible:SetFrame(id-1)
								elseif type(PibersMod.CollectionPageIconOverrideCollectibles[id]) == "table" and PibersMod.CollectionPageIconOverrideCollectibles[id][1] and type(PibersMod.CollectionPageIconOverrideCollectibles[id][2]) == "number" then
									PibersMod.CollectionPageIconOverrideCollectibles[id][1]:SetFrame(PibersMod.CollectionPageIconOverrideCollectibles[id][2])
									PibersMod.CollectionPageIconOverrideCollectibles[id][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItemCentered+renderPosOffset))
									renderIcon = false
								else
									PibersMod.CollectionPageCollectible:SetFrame(CollectibleType.NUM_COLLECTIBLES)
								end
							elseif id >= CollectibleType.NUM_COLLECTIBLES then
								PibersMod.CollectionPageCollectible:SetFrame(CollectibleType.NUM_COLLECTIBLES)
							else
								PibersMod.CollectionPageCollectible:SetFrame(id)
							end
							if renderIcon then
								PibersMod.CollectionPageCollectible:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItem+renderPosOffset))
							end
							PibersMod.CollectionPageFakeElementsInPage = i-1
						end
					end
					local currentCollectible = PibersMod.CollectionPageValidCollectibles[(currentElement+1)+(PibersMod.CollectionPageFakeCurrentPage*PibersMod.CollectionPageItemsPerPage)]
					if currentCollectible then
						if PibersMod.CollectionPageLastElement ~= currentElement or PibersMod.CollectionPageLastMode ~= 0 then
							if not PibersMod:IsCollectibleUnlocked(currentCollectible) then
								PibersMod.CollectionPageDisplayItem = false
								PibersMod.CollectionPageItemName = ""
								PibersMod.CollectionPageItemDesc = ""
							else
								local data = XMLData.GetEntryById(XMLNode.ITEM, currentCollectible)
								if data then
									if data.gfx then
										PibersMod.CollectionPageItem:ReplaceSpritesheet(1, "gfx/items/collectibles/" .. data.gfx, true)
										PibersMod.CollectionPageDisplayItem = true
									else
										PibersMod.CollectionPageDisplayItem = false
									end
									if data.name then
										if string.sub(data.name, 1, 2) == "#" then
											PibersMod.CollectionPageItemName = Isaac.GetString("Items", data.name)
										else
											PibersMod.CollectionPageItemName = data.name
										end
									else
										PibersMod.CollectionPageItemName = ""
									end
									if data.description then
										if string.sub(data.description, 1, 2) == "#" then
											PibersMod.CollectionPageItemDesc = Isaac.GetString("Items", data.description)
										else
											PibersMod.CollectionPageItemDesc = data.description
										end
									else
										PibersMod.CollectionPageItemDesc = ""
									end
								end
							end
						end
						if EID then
							if EID.Config["RGON_ShowOnCollectionPage"] then
								EID:HandleRenderingKeys()
								if not EID.isHidden then
									if not PibersMod:IsCollectibleUnlocked(currentCollectible) then
										eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
									else
										eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, currentCollectible, nil, false)
									end
								end
							end
						end
					elseif PibersMod.CollectionPageLastElement ~= currentElement or PibersMod.CollectionPageLastMode ~= 0 then
						PibersMod.CollectionPageDisplayItem = false
						PibersMod.CollectionPageItemName = ""
						PibersMod.CollectionPageItemDesc = ""
					end
				else
					if PibersMod.CollectionPageLastMode ~= 0 then
						PibersMod.CollectionPageTabs:SetFrame(0)
						CollectionMenu.SetSelectedPage(0)
						collsprite:ReplaceSpritesheet(2, "gfx/ui/main menu/collectionmenu.png", true)
						collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
						collsprite:ReplaceSpritesheet(4, "gfx/ui/main menu/collectionmenu.png", true)
						collsprite:ReplaceSpritesheet(5, "gfx/ui/death items.png", true)
						iconsprite:ReplaceSpritesheet(6, "gfx/ui/death items.png", true)
					end
					if EID then
						EID:OnMenuRender()
					end
				end
			elseif PibersMod.CollectionPageMode == 1 then
				PibersMod.CollectionPageFakeNumPages = PibersMod.CollectionPageNumPagesTrinket
				PibersMod.CollectionPageFakeElementsInPage = PibersMod.CollectionPageItemsPerPage-1
				for i=1, PibersMod.CollectionPageItemsPerPage do
					local id = PibersMod.CollectionPageValidTrinkets[i+(PibersMod.CollectionPageFakeCurrentPage*PibersMod.CollectionPageItemsPerPage)]
					if id then
						local renderIcon = true
						local renderPosOffset = Vector(16*((i-1)%PibersMod.CollectionPageItemsPerRow),16*(math.floor((i-1)/PibersMod.CollectionPageItemsPerRow)))
						if not PibersMod:IsTrinketUnlocked(id) then
							PibersMod.CollectionPageTrinket:SetFrame(0)
						elseif PibersMod.CollectionPageIconOverrideTrinket[id] then
							if type(PibersMod.CollectionPageIconOverrideTrinket[id]) == "number" then
								PibersMod.CollectionPageTrinket:SetFrame(id)
							elseif type(PibersMod.CollectionPageIconOverrideTrinket[id]) == "table" and PibersMod.CollectionPageIconOverrideTrinket[id][1] and type(PibersMod.CollectionPageIconOverrideTrinket[id][2]) == "number" then
								PibersMod.CollectionPageIconOverrideTrinket[id][1]:SetFrame(PibersMod.CollectionPageIconOverrideTrinket[id][2])
								PibersMod.CollectionPageIconOverrideTrinket[id][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItemCentered+renderPosOffset))
								renderIcon = false
							else
								PibersMod.CollectionPageTrinket:SetFrame(TrinketType.NUM_TRINKETS)
							end
						elseif id >= TrinketType.NUM_TRINKETS then
							PibersMod.CollectionPageTrinket:SetFrame(TrinketType.NUM_TRINKETS)
						else
							PibersMod.CollectionPageTrinket:SetFrame(id)
						end
						if renderIcon then
							PibersMod.CollectionPageTrinket:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItem+renderPosOffset))
						end
						PibersMod.CollectionPageFakeElementsInPage = i-1
					end
				end
				local currentTrinket = PibersMod.CollectionPageValidTrinkets[(currentElement+1)+(PibersMod.CollectionPageFakeCurrentPage*PibersMod.CollectionPageItemsPerPage)]
				if currentTrinket then
					if PibersMod.CollectionPageLastElement ~= currentElement or PibersMod.CollectionPageLastMode ~= 1 then
						if not PibersMod:IsTrinketUnlocked(currentTrinket) then
							PibersMod.CollectionPageDisplayItem = false
							PibersMod.CollectionPageItemName = ""
							PibersMod.CollectionPageItemDesc = ""
						else
							local data = XMLData.GetEntryById(XMLNode.TRINKET, currentTrinket)
							if data then
								if data.gfx then
									PibersMod.CollectionPageItem:ReplaceSpritesheet(1, "gfx/items/trinkets/" .. data.gfx, true)
									PibersMod.CollectionPageDisplayItem = true
								else
									PibersMod.CollectionPageDisplayItem = false
								end
								if data.name then
									if string.sub(data.name, 1, 2) == "#" then
										PibersMod.CollectionPageItemName = Isaac.GetString("Items", data.name)
									else
										PibersMod.CollectionPageItemName = data.name
									end
								else
									PibersMod.CollectionPageItemName = ""
								end
								if data.description then
									if string.sub(data.description, 1, 2) == "#" then
										PibersMod.CollectionPageItemDesc = Isaac.GetString("Items", data.description)
									else
										PibersMod.CollectionPageItemDesc = data.description
									end
								else
									PibersMod.CollectionPageItemDesc = ""
								end
							end
						end
					end
					if EID then
						if EID.Config["RGON_ShowOnCollectionPage"] then
							EID:HandleRenderingKeys()
							if not EID.isHidden then
								if not PibersMod:IsTrinketUnlocked(currentTrinket) then
									eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
								else
									eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, currentTrinket, nil, false)
								end
							end
						end
					end
				elseif PibersMod.CollectionPageLastElement ~= currentElement or PibersMod.CollectionPageLastMode ~= 1 then
					PibersMod.CollectionPageDisplayItem = false
					PibersMod.CollectionPageItemName = ""
					PibersMod.CollectionPageItemDesc = ""
				end
			elseif PibersMod.CollectionPageMode == 2 then
				PibersMod.CollectionPageFakeNumPages = PibersMod.CollectionPageNumPagesCard
				PibersMod.CollectionPageFakeElementsInPage = PibersMod.CollectionPageItemsPerPage-1
				for i=1, PibersMod.CollectionPageItemsPerPage do
					local elementindex = i+(PibersMod.CollectionPageFakeCurrentPage*PibersMod.CollectionPageItemsPerPage)
					local id = PibersMod.CollectionPageValidCards[elementindex]
					if id then
						local renderIcon = true
						local renderPosOffset = Vector(16*((i-1)%PibersMod.CollectionPageItemsPerRow),16*(math.floor((i-1)/PibersMod.CollectionPageItemsPerRow)))
						local useFrame = PickupSubType.NUM_PICKUPS
						local pickup = PibersMod.CollectionPageCardPickup[id]
						if pickup then
							useFrame = pickup
						end
						if PibersMod.CollectionPageValidCardIsPill[elementindex] then
							if not PibersMod:IsPillUnlocked(id) then
								PibersMod.CollectionPageCard:SetFrame(0)
							else
								PibersMod.CollectionPagePill:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItem+renderPosOffset))
								renderIcon = false
							end
						elseif not PibersMod:IsCardUnlocked(id) then
							PibersMod.CollectionPageCard:SetFrame(0)
						elseif PibersMod.CollectionPageIconOverrideCard[id] and type(PibersMod.CollectionPageIconOverrideCard[id]) == "table" and PibersMod.CollectionPageIconOverrideCard[id][1] and type(PibersMod.CollectionPageIconOverrideCard[id][2]) == "number" then
								PibersMod.CollectionPageIconOverrideCard[id][1]:SetFrame(PibersMod.CollectionPageIconOverrideCard[id][2])
								PibersMod.CollectionPageIconOverrideCard[id][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItemCentered+renderPosOffset))
								renderIcon = false
						elseif PibersMod.CollectionPageIconOverridePickup[useFrame] then
							if type(PibersMod.CollectionPageIconOverridePickup[useFrame]) == "number" then
								PibersMod.CollectionPageCard:SetFrame(useFrame)
							elseif type(PibersMod.CollectionPageIconOverridePickup[useFrame]) == "table" and PibersMod.CollectionPageIconOverridePickup[useFrame][1] and type(PibersMod.CollectionPageIconOverridePickup[useFrame][2]) == "number" then
								PibersMod.CollectionPageIconOverridePickup[useFrame][1]:SetFrame(PibersMod.CollectionPageIconOverridePickup[useFrame][2])
								PibersMod.CollectionPageIconOverridePickup[useFrame][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItemCentered+renderPosOffset))
								renderIcon = false
							else
								PibersMod.CollectionPageCard:SetFrame(PickupSubType.NUM_PICKUPS)
							end
						elseif useFrame >= PickupSubType.NUM_PICKUPS then
							PibersMod.CollectionPageCard:SetFrame(PickupSubType.NUM_PICKUPS)
						else
							PibersMod.CollectionPageCard:SetFrame(useFrame)
						end
						if renderIcon then
							PibersMod.CollectionPageCard:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageFirstItem+renderPosOffset))
						end
						PibersMod.CollectionPageFakeElementsInPage = i-1
					end
				end
				local currentElementIndex = (currentElement+1)+(PibersMod.CollectionPageFakeCurrentPage*PibersMod.CollectionPageItemsPerPage)
				local currentCard = PibersMod.CollectionPageValidCards[currentElementIndex]
				if currentCard then
					if PibersMod.CollectionPageLastElement ~= currentElement or PibersMod.CollectionPageLastMode ~= 1 then
						PibersMod.CollectionPageForceDisplayPickup = false
						if PibersMod.CollectionPageValidCardIsPill[currentElementIndex] then
							if not PibersMod:IsPillUnlocked(currentCard) then
								PibersMod.CollectionPageDisplayItem = false
								PibersMod.CollectionPageItemName = ""
								PibersMod.CollectionPageItemDesc = ""
							else
								PibersMod.CollectionPageItemPickup:Load("gfx/ui/ui_pills_unknown.anm2", true)
								PibersMod.CollectionPageItemPickup:SetFrame("HUD", 0)
								PibersMod.CollectionPageForceDisplayPickup = true
								PibersMod.CollectionPageDisplayItem = true
								local data = XMLData.GetEntryById(XMLNode.PILL, currentCard)
								if data.name then
									if string.sub(data.name, 1, 2) == "#" then
										PibersMod.CollectionPageItemName = Isaac.GetString("Pills", data.name)
									else
										PibersMod.CollectionPageItemName = data.name
									end
								else
									PibersMod.CollectionPageItemName = ""
								end
								if PibersMod.CollectionPageDescriptionOverridePill[currentCard] then
									PibersMod.CollectionPageItemDesc = PibersMod.CollectionPageDescriptionOverridePill[currentCard]
								elseif data.description then
									if string.sub(data.description, 1, 2) == "#" then
										PibersMod.CollectionPageItemDesc = Isaac.GetString("Pills", data.description)
									else
										PibersMod.CollectionPageItemDesc = data.description
									end
								else
									PibersMod.CollectionPageItemDesc = ""
								end
							end
						elseif not PibersMod:IsCardUnlocked(currentCard) then
							PibersMod.CollectionPageDisplayItem = false
							PibersMod.CollectionPageItemName = ""
							PibersMod.CollectionPageItemDesc = ""
						else
							local data = XMLData.GetEntryById(XMLNode.CARD, currentCard)
							if data then
								PibersMod.CollectionPageItemCard:SetFrame("CardFronts", currentCard)
								PibersMod.CollectionPageItemCardModded = nil
								if data.hud then
									local cardconfig = itemConfig:GetCard(currentCard)
									if cardconfig and cardconfig.ModdedCardFront then
										PibersMod.CollectionPageItemCardModded = cardconfig.ModdedCardFront
										PibersMod.CollectionPageItemCardModded:SetFrame(data.hud, 0)
									end
								end
								if data.pickup and tonumber(data.pickup) then
									local pickupXML = XMLData.GetEntityByTypeVarSub(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, tonumber(data.pickup))
									if pickupXML and pickupXML.anm2path then
										PibersMod.CollectionPageItemPickup:Load("gfx/" .. pickupXML.anm2path, true)
										PibersMod.CollectionPageItemPickup:SetFrame("HUD", 0)
										PibersMod.CollectionPageDisplayItem = true
									end
								else
									PibersMod.CollectionPageDisplayItem = false
								end
								if data.name then
									if string.sub(data.name, 1, 2) == "#" then
										PibersMod.CollectionPageItemName = Isaac.GetString("Cards", data.name)
									else
										PibersMod.CollectionPageItemName = data.name
									end
								else
									PibersMod.CollectionPageItemName = ""
								end
								if data.description then
									if string.sub(data.description, 1, 2) == "#" then
										PibersMod.CollectionPageItemDesc = Isaac.GetString("Cards", data.description)
									else
										PibersMod.CollectionPageItemDesc = data.description
									end
								else
									PibersMod.CollectionPageItemDesc = ""
								end
							end
						end
					end
					if EID then
						if EID.Config["RGON_ShowOnCollectionPage"] then
							EID:HandleRenderingKeys()
							if not EID.isHidden then
								if PibersMod.CollectionPageValidCardIsPill[currentElementIndex] then
									if not PibersMod:IsPillUnlocked(currentCard) then
										eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
									else
										--eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, currentCard, nil, false)
									end
								else
									if not PibersMod:IsCardUnlocked(currentCard) then
										eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
									else
										eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, currentCard, nil, false)
									end
								end
							end
						end
					end
				elseif PibersMod.CollectionPageLastElement ~= currentElement or PibersMod.CollectionPageLastMode ~= 2 then
					PibersMod.CollectionPageDisplayItem = false
					PibersMod.CollectionPageForceDisplayPickup = false
					PibersMod.CollectionPageItemName = ""
					PibersMod.CollectionPageItemDesc = ""
				end
			end
			if PibersMod.CollectionPageMode ~= 0 then
				PibersMod.CollectionPageDupe:RenderLayer(2, Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageItemNotePos))
				local iconPos = collsprite:GetNullFrame("BigItemIcon"):GetPos()
				if PibersMod.CollectionPageDisplayItem then
					if PibersMod.CollectionPageMode == 2 then
						if PibersMod.CollectionPageItemCardModded then
							PibersMod.CollectionPageItemCardModded:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+PibersMod.CollectionPageItemIconPosCard))
						else
							local renderFront = false
							local frame = PibersMod.CollectionPageItemCard:GetFrame()
							for _,animlayer in ipairs(PibersMod.CollectionPageItemCard:GetCurrentAnimationData():GetAllLayers()) do
								local animframe = animlayer:GetFrame(frame)
								if animframe and animframe:IsVisible() then
									renderFront = true
									break
								end
							end
							if renderFront and not PibersMod.CollectionPageForceDisplayPickup then
								PibersMod.CollectionPageItemCard:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+PibersMod.CollectionPageItemIconPosCard))
							else
								PibersMod.CollectionPageItemPickup:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+PibersMod.CollectionPageItemIconPosCard))
							end
						end
					else
						PibersMod.CollectionPageItem:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+PibersMod.CollectionPageItemIconPos))
					end
				end
				local namePos = Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+PibersMod.CollectionPageItemNamePos)
				PibersMod.CollectionPageFont:DrawString(PibersMod.CollectionPageItemName, namePos.X, namePos.Y, PibersMod.CollectionPageFontColor)
				local descPos = Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+PibersMod.CollectionPageItemDescPos)
				PibersMod.CollectionPageFont:DrawString(PibersMod.CollectionPageItemDesc, descPos.X, descPos.Y, PibersMod.CollectionPageFontColor)
				if EID and eiddesc then
					if EID.Config["RGON_ShowOnCollectionPage"] then
						EID:HandleRenderingKeys()
						if not EID.isHidden then
							EID:printDescription(eiddesc, nil)
						end
					end
				end
				if PibersMod.CollectionPageLastMode == 0 then
					CollectionMenu.SetSelectedPage(2)
					currentPage = 2
					collsprite:ReplaceSpritesheet(2, "blank.png", true)
					collsprite:ReplaceSpritesheet(4, "blank.png", true)
					collsprite:ReplaceSpritesheet(5, "blank.png", true)
					iconsprite:ReplaceSpritesheet(6, "blank.png", true)
					if PibersMod.CollectionPageFakeNumPages > 1 then
						collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
					end
				end
				if PibersMod.CollectionPageLastMode ~= PibersMod.CollectionPageMode then
					PibersMod.CollectionPageTabs:SetFrame(PibersMod.CollectionPageMode)
					PibersMod.CollectionPageFakeCurrentPage = 0
					collsprite:ReplaceSpritesheet(4, "blank.png", true)
					if PibersMod.CollectionPageFakeNumPages > 1 then
						collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
					else
						collsprite:ReplaceSpritesheet(3, "blank.png", true)
					end
				end
				if currentPage ~= 2 then
					if currentPage > 2 then
						CollectionMenu.SetSelectedPage(2)
						PibersMod.CollectionPageFakeCurrentPage = PibersMod.CollectionPageFakeCurrentPage + 1
					elseif currentPage < 2 then
						CollectionMenu.SetSelectedPage(2)
						PibersMod.CollectionPageFakeCurrentPage = PibersMod.CollectionPageFakeCurrentPage - 1
					end
					if PibersMod.CollectionPageFakeCurrentPage > PibersMod.CollectionPageFakeNumPages-1 then
						PibersMod.CollectionPageFakeCurrentPage = 0
					end
					if PibersMod.CollectionPageFakeCurrentPage < 0 then
						PibersMod.CollectionPageFakeCurrentPage = PibersMod.CollectionPageFakeNumPages-1
					end
					if PibersMod.CollectionPageFakeCurrentPage == 0 then
						collsprite:ReplaceSpritesheet(4, "blank.png", true)
						if PibersMod.CollectionPageFakeNumPages > 1 then
							collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
						else
							collsprite:ReplaceSpritesheet(3, "blank.png", true)
						end
					elseif PibersMod.CollectionPageFakeCurrentPage == PibersMod.CollectionPageFakeNumPages-1 then
						collsprite:ReplaceSpritesheet(3, "blank.png", true)
						collsprite:ReplaceSpritesheet(4, "gfx/ui/main menu/collectionmenu.png", true)
					else
						collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
						collsprite:ReplaceSpritesheet(4, "gfx/ui/main menu/collectionmenu.png", true)
					end
				end
				--[[
				if currentElement > PibersMod.CollectionPageFakeElementsInPage then
					if currentElement - PibersMod.CollectionPageLastElement == 1 then
						currentElement = 0
						CollectionMenu.SetSelectedElement(currentElement)
						PibersMod.CollectionPageFakeCurrentPage = 0
					elseif currentElement&PibersMod.CollectionPageItemsPerRow == PibersMod.CollectionPageFakeElementsInPage&PibersMod.CollectionPageItemsPerRow then
						currentElement = PibersMod.CollectionPageFakeElementsInPage
						CollectionMenu.SetSelectedElement(currentElement)
					else
						currentElement = currentElement&PibersMod.CollectionPageItemsPerRow
						CollectionMenu.SetSelectedElement(currentElement)
						PibersMod.CollectionPageFakeCurrentPage = 0
					end
					CollectionMenu.SetSelectedPage(2)
				end
				]]
				numPages = PibersMod.CollectionPageFakeNumPages
				currentPage = PibersMod.CollectionPageFakeCurrentPage
			else
				PibersMod.CollectionPageFakeCurrentPage = 0
				PibersMod.CollectionPageFakeElementsInPage = PibersMod.CollectionPageItemsPerPage
			end
			if numPages > 1 then
				local bulletGap = Vector(0,PibersMod.CollectionPageBulletHeight/numPages)
				local bulletPos = (collsprite:GetNullFrame("Bullet"):GetPos()+PibersMod.CollectionPageBulletPos)-(bulletGap/2)
				for i=1,numPages do
					local currentPos = bulletPos+(bulletGap*i)
					if i-1 == currentPage then
						PibersMod.CollectionPageBulletOn:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, currentPos))
					else
						PibersMod.CollectionPageBulletOff:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, currentPos))
					end
				end
			end
			PibersMod.CollectionPageTabs:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, PibersMod.CollectionPageTabsPos))
			PibersMod.CollectionPageLastMode = PibersMod.CollectionPageMode
			PibersMod.CollectionPageLastElement = currentElement
			if Input.IsActionTriggered(ButtonAction.ACTION_PILLCARD, 0) then
				PibersMod.CollectionPageMode = PibersMod.CollectionPageMode - 1
			end
			if Input.IsActionTriggered(ButtonAction.ACTION_BOMB, 0) then
				PibersMod.CollectionPageMode = PibersMod.CollectionPageMode + 1
			end
			if PibersMod.CollectionPageMode > 2 then
				PibersMod.CollectionPageMode = 0
			end
			if PibersMod.CollectionPageMode < 0 then
				PibersMod.CollectionPageMode = 2
			end
		else
			PibersMod.GenerateCollectionMenuData()
		end
	elseif PibersMod.CollectionPageMode ~= 0 then
		local collsprite = CollectionMenu.GetCollectionMenuSprite()
		local iconsprite = CollectionMenu.GetDeathScreenSprite()
		PibersMod.CollectionPageMode = 0
		CollectionMenu.SetSelectedPage(0)
		collsprite:ReplaceSpritesheet(2, "gfx/ui/main menu/collectionmenu.png", true)
		collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
		collsprite:ReplaceSpritesheet(5, "gfx/ui/death items.png", true)
		iconsprite:ReplaceSpritesheet(6, "gfx/ui/death items.png", true)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, PibersMod.OnMainMenuRenderCollectionPage)
