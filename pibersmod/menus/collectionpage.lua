local mod = PibersMod

function mod.IsXMLUnlocked(itemID, xml)
	local data = XMLData.GetEntryById(xml, itemID)
	if data and data.achievement and not Isaac.GetPersistentGameData():Unlocked(tonumber(data.achievement)) then
		return false
	end
	return true
end
function mod.IsCollectibleUnlocked(itemID)
	return mod.IsXMLUnlocked(itemID, XMLNode.ITEM)
end
function mod.IsTrinketUnlocked(itemID)
	return mod.IsXMLUnlocked(itemID, XMLNode.TRINKET)
end
function mod.IsCardUnlocked(itemID)
	return mod.IsXMLUnlocked(itemID, XMLNode.CARD)
end
function mod.IsPillUnlocked(itemID)
	return mod.IsXMLUnlocked(itemID, XMLNode.PILL)
end
function mod.IsBabyUnlocked(itemID)
	local data = EntityConfig.GetBaby(itemID)
	if data and data:GetAchievementID() and Isaac.GetPersistentGameData():Unlocked(data:GetAchievementID()) then
		return false
	end
	return true
end
mod.CollectionPageTabs = Sprite("gfx/ui/main menu/collectionmenu_tabs.anm2", true)
mod.CollectionPageTabs:SetFrame("Tabs", 0)
mod.CollectionPageTabsPos = Vector(70,166)
mod.CollectionPageBulletOn = Sprite("gfx/ui/main menu/collectionmenu_bullet.anm2", true)
mod.CollectionPageBulletOn:SetFrame("Idle", 0)
mod.CollectionPageBulletOff = Sprite("gfx/ui/main menu/collectionmenu_bullet.anm2", true)
mod.CollectionPageBulletOff:SetFrame("Idle", 1)
mod.CollectionPageCollectible = Sprite("gfx/ui/death screen.anm2", true)
mod.CollectionPageCollectible:SetFrame("Diary", 0)
for _,layer in pairs(mod.CollectionPageCollectible:GetAllLayers()) do
	if layer:GetLayerID() == 6 then
		layer:SetVisible(true)
	else
		layer:SetVisible(false)
	end
end
mod.CollectionPageTrinket = Sprite("gfx/ui/death items trinkets.anm2", true)
mod.CollectionPageTrinket:SetFrame("Diary", 0)
mod.CollectionPageCard = Sprite("gfx/ui/death items pickups.anm2", true)
mod.CollectionPageCard:SetFrame("Diary", 0)
mod.CollectionPagePill = Sprite("gfx/ui/death items pills.anm2", true)
mod.CollectionPagePill:SetFrame("Diary", 0)
mod.CollectionPageDupe = Sprite("gfx/ui/main menu/collectionmenu.anm2", true)
mod.CollectionPageDupe:SetFrame("Idle", 0)
mod.CollectionPageItem = Sprite("gfx/005.100_collectible.anm2", true)
mod.CollectionPageItem:SetFrame("PlayerPickup", 0)
mod.CollectionPageItemPickup = Sprite("gfx/005.301_tarot card", true)
mod.CollectionPageItemPickup:SetFrame("HUD", 0)
mod.CollectionPageItemCard = Sprite("gfx/ui/ui_cardspills.anm2", true)
mod.CollectionPageItemCard:SetFrame("CardFronts", 0)
mod.CollectionPageItemCardModded = nil
mod.CollectionPageDisplayItem = true
mod.CollectionPageForceDisplayPickup = false
mod.CollectionPageFont = Font("font/teammeatex/teammeatex12.fnt")
mod.CollectionPageFontColor = KColor(0.47,0.45,0.38,1.0)
mod.CollectionPageNumPages = 0
mod.CollectionPageNumPagesCollectible = 0
mod.CollectionPageNumPagesTrinket = 0
mod.CollectionPageNumPagesCard = 0
mod.CollectionPageValidCollectibles = {}
mod.CollectionPageValidTrinkets = {}
mod.CollectionPageValidCards = {}
mod.CollectionPageValidCardIsPill = {}
mod.CollectionPageCardPickup = {}
mod.CollectionPageFirstItem = Vector(121,43)
mod.CollectionPageFirstItemCentered = Vector(37,63)
mod.CollectionPageBulletPos = Vector(-39,-57)
mod.CollectionPageItemNotePos = Vector(-39,-15)
mod.CollectionPageItemIconPos = Vector(-38,-8)
mod.CollectionPageItemIconPosCard = Vector(-41,-13)
mod.CollectionPageItemNamePos = Vector(-20,-31)
mod.CollectionPageItemDescPos = Vector(-20,-16)
mod.CollectionPageItemName = ""
mod.CollectionPageItemDesc = ""
mod.CollectionPageBulletHeight = 84
mod.CollectionPageMode = 0
mod.CollectionPageLastMode = 0
mod.CollectionPageLastElement = 0
mod.CollectionPageItemsPerRow = 20
mod.CollectionPageItemsPerCol = 6
mod.CollectionPageItemsPerPage = mod.CollectionPageItemsPerRow*mod.CollectionPageItemsPerCol
mod.CollectionPageFakeCurrentPage = 0
mod.CollectionPageFakeNumPages = 0
mod.CollectionPageSortMode = 0
mod.CollectionPageFakeElementsInPage = mod.CollectionPageItemsPerPage
mod.CollectionPageTrinketCustom = Sprite("gfx/ui/death items trinkets pibersmod.anm2", true)
mod.CollectionPageTrinketCustom:SetFrame(mod.CollectionPageTrinketCustom:GetDefaultAnimation(), 0)
mod.CollectionPagePickupCustom = Sprite("gfx/ui/death items pickups pibersmod.anm2", true)
mod.CollectionPagePickupCustom:SetFrame(mod.CollectionPagePickupCustom:GetDefaultAnimation(), 0)
mod.CollectionPageCardCustom = Sprite("gfx/ui/death items cards pibersmod.anm2", true)
mod.CollectionPageCardCustom:SetFrame(mod.CollectionPageCardCustom:GetDefaultAnimation(), 0)
mod.CollectionPageIconOverrideCollectibles = {}
mod.CollectionPageIconOverrideTrinket = {}
mod.CollectionPageIconOverridePickup = {}
mod.CollectionPageIconOverrideCard = {}
mod.CollectionPageIconOverrideCard[Card.RUNE_HAGALAZ] = {mod.CollectionPageCardCustom, 0}
mod.CollectionPageIconOverrideCard[Card.RUNE_JERA] = {mod.CollectionPageCardCustom, 1}
mod.CollectionPageIconOverrideCard[Card.RUNE_EHWAZ] = {mod.CollectionPageCardCustom, 2}
mod.CollectionPageIconOverrideCard[Card.RUNE_DAGAZ] = {mod.CollectionPageCardCustom, 3}
mod.CollectionPageIconOverrideCard[Card.RUNE_ANSUZ] = {mod.CollectionPageCardCustom, 4}
mod.CollectionPageIconOverrideCard[Card.RUNE_PERTHRO] = {mod.CollectionPageCardCustom, 5}
mod.CollectionPageIconOverrideCard[Card.RUNE_BERKANO] = {mod.CollectionPageCardCustom, 6}
mod.CollectionPageIconOverrideCard[Card.RUNE_ALGIZ] = {mod.CollectionPageCardCustom, 7}
mod.CollectionPageDescriptionOverridePill = {}
mod.CollectionPageDescriptionOverridePill[PillEffect.PILLEFFECT_EXPERIMENTAL] = "One stat up, one stat down"
mod.CollectionPageSortPriority = {}
mod.CollectionPageSortPriority.ORIGINAL = 100
mod.CollectionPageSortPriority.WOTL = 200
mod.CollectionPageSortPriority.REBIRTH = 300
mod.CollectionPageSortPriority.AFTERBIRTH = 400
mod.CollectionPageSortPriority.AFTERBIRTH_PLUS = 500
mod.CollectionPageSortPriority.COMMUNITY_REMIX = 600
mod.CollectionPageSortPriority.COMMUNITY_REMIX_1 = 610
mod.CollectionPageSortPriority.COMMUNITY_REMIX_2 = 620
mod.CollectionPageSortPriority.COMMUNITY_REMIX_3 = 630
mod.CollectionPageSortPriority.COMMUNITY_REMIX_4 = 640
mod.CollectionPageSortPriority.COMMUNITY_REMIX_5 = 650
mod.CollectionPageSortPriority.COMMUNITY_REMIX_6 = 660
mod.CollectionPageSortPriority.ANTIBIRTH = 700
mod.CollectionPageSortPriority.ANTIBIRTH_1 = 710
mod.CollectionPageSortPriority.ANTIBIRTH_2 = 720
mod.CollectionPageSortPriority.REPENTANCE = 800
mod.CollectionPageSortPriority.REPENTANCE_PLUS = 900
mod.CollectionPageSortPriority.PIBERSMOD = 1000
mod.CollectionPageSortPriority.MODDED_START = 2000
mod.CollectionPageSortPriority.MODDED_OFFSET = 10
mod.CollectionPageSortItem = {}
mod.CollectionPageSortTrinket = {}
mod.CollectionPageSortCard = {}
mod.CollectionPageSortPill = {}
function mod.GenerateCollectionMenuData()
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
			local priority = mod.CollectionPageSortPriority.MODDED_START+((id-CollectibleType.NUM_COLLECTIBLES)*mod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < CollectibleType.COLLECTIBLE_GUPPYS_PAW then
				priority = mod.CollectionPageSortPriority.ORIGINAL

			elseif id < CollectibleType.COLLECTIBLE_MOMS_KEY then
				priority = mod.CollectionPageSortPriority.WOTL

			elseif id < CollectibleType.COLLECTIBLE_DIPLOPIA then
				priority = mod.CollectionPageSortPriority.REBIRTH

				if id == CollectibleType.COLLECTIBLE_POLAROID then
					priority = mod.CollectionPageSortPriority.WOTL
				elseif id == CollectibleType.COLLECTIBLE_CLEAR_RUNE then
					priority = mod.CollectionPageSortPriority.REPENTANCE
				end

			elseif id < CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < CollectibleType.COLLECTIBLE_MUCORMYCOSIS then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH_PLUS

				if id == CollectibleType.COLLECTIBLE_SCHOOLBAG then
					priority = mod.CollectionPageSortPriority.ANTIBIRTH_2
				end

			elseif id < CollectibleType.COLLECTIBLE_FRUITY_PLUM then
				priority = mod.CollectionPageSortPriority.ANTIBIRTH_2

				if id < CollectibleType.COLLECTIBLE_GOLDEN_RAZOR then
					priority = mod.CollectionPageSortPriority.ANTIBIRTH
				elseif id < CollectibleType.COLLECTIBLE_GENESIS then
					priority = mod.CollectionPageSortPriority.ANTIBIRTH_1
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
					priority = mod.CollectionPageSortPriority.REPENTANCE

				elseif id == CollectibleType.COLLECTIBLE_FORTUNE_COOKIE then
					-- id == jawbone
					-- id == counterfeit dollar
					-- id == box of wires
					-- id == tammys paw
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX

				elseif id == CollectibleType.COLLECTIBLE_IT_HURTS
					or id == CollectibleType.COLLECTIBLE_NANCY_BOMBS
					-- id == tammys tail
					or id == CollectibleType.COLLECTIBLE_BLOOD_OATH then
					-- id == d12
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX_1

				elseif id == CollectibleType.COLLECTIBLE_SULFUR
					-- id == bowl of tears
					or id == CollectibleType.COLLECTIBLE_SOCKS then
					-- id == book of despair
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX_2

				elseif id == CollectibleType.COLLECTIBLE_BAR_OF_SOAP then
					-- id == cool bean
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX_3

				elseif id == CollectibleType.COLLECTIBLE_EYE_SORE
					or id == CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES then
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX_4

				elseif id == CollectibleType.COLLECTIBLE_MUCORMYCOSIS
					or id == CollectibleType.COLLECTIBLE_2SPOOKY
					or id == CollectibleType.COLLECTIBLE_WAVY_CAP then
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX_5

				elseif id == CollectibleType.COLLECTIBLE_PLAYDOUGH_COOKIE
					or id == CollectibleType.COLLECTIBLE_BIRTHRIGHT then
					-- id == maxs paw
					-- id == maxs tail
					-- id == the apple
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX_6
				end

			elseif id < CollectibleType.NUM_COLLECTIBLES then
				priority = mod.CollectionPageSortPriority.REPENTANCE

				if id == CollectibleType.COLLECTIBLE_GIANT_CELL then
					priority = mod.CollectionPageSortPriority.ANTIBIRTH_2
				elseif id == CollectibleType.COLLECTIBLE_SAUSAGE then
					priority = mod.CollectionPageSortPriority.ANTIBIRTH_1
				end

			elseif id >= CollectibleType.MIXED_VEGGIES and id <= CollectibleType.BIRTHDAY_CAKE then
				priority = mod.CollectionPageSortPriority.PIBERSMOD

				if id == CollectibleType.KEY_PIECE_COMPLETE then
					priority = mod.CollectionPageSortPriority.REBIRTH
				elseif id == CollectibleType.KNIFE_PIECE_COMPLETE then
					priority = mod.CollectionPageSortPriority.ANTIBIRTH_2
				elseif id == CollectibleType.COUNTERFEIT_DOLLAR then
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX
				end
			end

			mod.CollectionPageSortItem[priority] = mod.CollectionPageSortItem[priority] or {}
			mod.CollectionPageSortItem[priority][#mod.CollectionPageSortItem[priority]+1] = id
			mod.CollectionPageValidCollectibles[#mod.CollectionPageValidCollectibles+1] = id
		end
		id = id + 1
	end
	local numItems = lastItem-numHidden
	mod.CollectionPageNumPagesCollectible = math.ceil(numItems/mod.CollectionPageItemsPerPage)
	mod.CollectionPageNumPages = mod.CollectionPageNumPagesCollectible

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
			local priority = mod.CollectionPageSortPriority.MODDED_START+((id-TrinketType.NUM_TRINKETS)*mod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < TrinketType.TRINKET_FISH_HEAD then
				priority = mod.CollectionPageSortPriority.REBIRTH

				if id == TrinketType.TRINKET_WIGGLE_WORM then
					priority = mod.CollectionPageSortPriority.ORIGINAL
				end

			elseif id < TrinketType.TRINKET_SHINY_ROCK then
				priority = mod.CollectionPageSortPriority.WOTL

			elseif id < TrinketType.TRINKET_MECONIUM then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < TrinketType.TRINKET_JAW_BREAKER then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < TrinketType.TRINKET_SHORT_FUSE then
				priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX

				if id == TrinketType.TRINKET_BLESSED_PENNY then
					priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX_1
				end

			elseif id < TrinketType.TRINKET_BLUE_KEY then
				priority = mod.CollectionPageSortPriority.ANTIBIRTH

			elseif id < TrinketType.NUM_TRINKETS then
				priority = mod.CollectionPageSortPriority.REPENTANCE
			end

			if id == TrinketType.ORTHODOX_CROSS then
				priority = mod.CollectionPageSortPriority.COMMUNITY_REMIX
			end

			mod.CollectionPageSortTrinket[priority] = mod.CollectionPageSortTrinket[priority] or {}
			mod.CollectionPageSortTrinket[priority][#mod.CollectionPageSortTrinket[priority]+1] = id
			mod.CollectionPageValidTrinkets[#mod.CollectionPageValidTrinkets+1] = id
		end
		id = id + 1
	end
	local numTrinkets = lastTrinket-numHidden
	mod.CollectionPageNumPagesTrinket = math.ceil(numTrinkets/mod.CollectionPageItemsPerPage)

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
			local priority = mod.CollectionPageSortPriority.MODDED_START+((id-Card.NUM_CARDS)*mod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < Card.CARD_CLUBS_2 then
				priority = mod.CollectionPageSortPriority.ORIGINAL

			elseif id < Card.CARD_ACE_OF_CLUBS then
				priority = mod.CollectionPageSortPriority.WOTL

			elseif id < Card.CARD_JOKER then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < Card.CARD_GET_OUT_OF_JAIL then
				priority = mod.CollectionPageSortPriority.REBIRTH

				if id == Card.RUNE_BLANK then
					priority = mod.CollectionPageSortPriority.AFTERBIRTH
				elseif id == Card.RUNE_BLACK then
					priority = mod.CollectionPageSortPriority.AFTERBIRTH_PLUS
				end

			elseif id < Card.CARD_HOLY then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < Card.RUNE_SHARD then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < Card.NUM_CARDS then
				priority = mod.CollectionPageSortPriority.REPENTANCE
			end

			mod.CollectionPageSortCard[priority] = mod.CollectionPageSortCard[priority] or {}
			mod.CollectionPageSortCard[priority][#mod.CollectionPageSortCard[priority]+1] = id
			mod.CollectionPageValidCards[#mod.CollectionPageValidCards+1] = id
			if card.PickupSubtype and tonumber(card.PickupSubtype) then
				mod.CollectionPageCardPickup[id] = tonumber(card.PickupSubtype)
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
			local priority = mod.CollectionPageSortPriority.MODDED_START+((id-PillEffect.NUM_PILL_EFFECTS)*mod.CollectionPageSortPriority.MODDED_OFFSET)

			if id < PillEffect.PILLEFFECT_48HOUR_ENERGY then
				priority = mod.CollectionPageSortPriority.ORIGINAL

				if id == PillEffect.PILLEFFECT_PUBERTY
				or id == PillEffect.PILLEFFECT_LUCK_DOWN
				or id == PillEffect.PILLEFFECT_LUCK_UP then
					priority = mod.CollectionPageSortPriority.WOTL
				end

			elseif id < PillEffect.PILLEFFECT_PERCS then
				priority = mod.CollectionPageSortPriority.REBIRTH

				if id == PillEffect.PILLEFFECT_FRIENDS_TILL_THE_END then
					priority = mod.CollectionPageSortPriority.WOTL
				end

			elseif id < PillEffect.PILLEFFECT_X_LAX then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH

			elseif id < PillEffect.PILLEFFECT_SHOT_SPEED_DOWN then
				priority = mod.CollectionPageSortPriority.AFTERBIRTH_PLUS

			elseif id < PillEffect.NUM_PILL_EFFECTS then
				priority = mod.CollectionPageSortPriority.ANTIBIRTH
			end

			mod.CollectionPageSortPill[priority] = mod.CollectionPageSortPill[priority] or {}
			mod.CollectionPageSortPill[priority][#mod.CollectionPageSortPill[priority]+1] = id
			mod.CollectionPageValidCards[#mod.CollectionPageValidCards+1] = id
			mod.CollectionPageValidCardIsPill[#mod.CollectionPageValidCards] = true
		end
		id = id + 1
	end
	local numCards = (1+lastCard+lastPill)-numHidden
	mod.CollectionPageNumPagesCard = math.ceil(numCards/mod.CollectionPageItemsPerPage)
end
mod.AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, mod.GenerateCollectionMenuData)

function mod.OnMainMenuRenderCollectionPage()
	local currentActive = MenuManager:GetActiveMenu()
	if currentActive == MainMenuType.COLLECTION then
		local itemConfig = Isaac.GetItemConfig()
		if mod.CollectionPageNumPages > 0 then
			local collsprite = CollectionMenu.GetCollectionMenuSprite()
			local iconsprite = CollectionMenu.GetDeathScreenSprite()
			local currentPage = CollectionMenu.GetSelectedPage()
			local currentElement = CollectionMenu.GetSelectedElement()
			local numPages = mod.CollectionPageNumPages
			local eiddesc = nil
			if mod.CollectionPageMode == 0 then
				if mod.CollectionPageSortMode > 0 then
					mod.CollectionPageFakeNumPages = mod.CollectionPageNumPagesCollectible
					mod.CollectionPageFakeElementsInPage = mod.CollectionPageItemsPerPage-1
					for i=1, mod.CollectionPageItemsPerPage do
						local id = mod.CollectionPageValidCollectibles[i+(mod.CollectionPageFakeCurrentPage*mod.CollectionPageItemsPerPage)]
						if id then
							local renderIcon = true
							local renderPosOffset = Vector(16*((i-1)%mod.CollectionPageItemsPerRow),16*(math.floor((i-1)/mod.CollectionPageItemsPerRow)))
							if not mod.IsCollectibleUnlocked(id) then
								mod.CollectionPageCollectible:SetFrame(0)
							elseif mod.CollectionPageIconOverrideCollectibles[id] then
								if type(mod.CollectionPageIconOverrideCollectibles[id]) == "number" then
									mod.CollectionPageCollectible:SetFrame(id-1)
								elseif type(mod.CollectionPageIconOverrideCollectibles[id]) == "table" and mod.CollectionPageIconOverrideCollectibles[id][1] and type(mod.CollectionPageIconOverrideCollectibles[id][2]) == "number" then
									mod.CollectionPageIconOverrideCollectibles[id][1]:SetFrame(mod.CollectionPageIconOverrideCollectibles[id][2])
									mod.CollectionPageIconOverrideCollectibles[id][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItemCentered+renderPosOffset))
									renderIcon = false
								else
									mod.CollectionPageCollectible:SetFrame(CollectibleType.NUM_COLLECTIBLES)
								end
							elseif id >= CollectibleType.NUM_COLLECTIBLES then
								mod.CollectionPageCollectible:SetFrame(CollectibleType.NUM_COLLECTIBLES)
							else
								mod.CollectionPageCollectible:SetFrame(id)
							end
							if renderIcon then
								mod.CollectionPageCollectible:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItem+renderPosOffset))
							end
							mod.CollectionPageFakeElementsInPage = i-1
						end
					end
					local currentCollectible = mod.CollectionPageValidCollectibles[(currentElement+1)+(mod.CollectionPageFakeCurrentPage*mod.CollectionPageItemsPerPage)]
					if currentCollectible then
						if mod.CollectionPageLastElement ~= currentElement or mod.CollectionPageLastMode ~= 0 then
							if not mod.IsCollectibleUnlocked(currentCollectible) then
								mod.CollectionPageDisplayItem = false
								mod.CollectionPageItemName = ""
								mod.CollectionPageItemDesc = ""
							else
								local data = XMLData.GetEntryById(XMLNode.ITEM, currentCollectible)
								if data then
									if data.gfx then
										mod.CollectionPageItem:ReplaceSpritesheet(1, "gfx/items/collectibles/" .. data.gfx, true)
										mod.CollectionPageDisplayItem = true
									else
										mod.CollectionPageDisplayItem = false
									end
									if data.name then
										if string.sub(data.name, 1, 2) == "#" then
											mod.CollectionPageItemName = Isaac.GetString("Items", data.name)
										else
											mod.CollectionPageItemName = data.name
										end
									else
										mod.CollectionPageItemName = ""
									end
									if data.description then
										if string.sub(data.description, 1, 2) == "#" then
											mod.CollectionPageItemDesc = Isaac.GetString("Items", data.description)
										else
											mod.CollectionPageItemDesc = data.description
										end
									else
										mod.CollectionPageItemDesc = ""
									end
								end
							end
						end
						if EID then
							if EID.Config["RGON_ShowOnCollectionPage"] then
								EID:HandleRenderingKeys()
								if not EID.isHidden then
									if not mod.IsCollectibleUnlocked(currentCollectible) then
										eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
									else
										eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, currentCollectible, nil, false)
									end
								end
							end
						end
					elseif mod.CollectionPageLastElement ~= currentElement or mod.CollectionPageLastMode ~= 0 then
						mod.CollectionPageDisplayItem = false
						mod.CollectionPageItemName = ""
						mod.CollectionPageItemDesc = ""
					end
				else
					if mod.CollectionPageLastMode ~= 0 then
						mod.CollectionPageTabs:SetFrame(0)
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
			elseif mod.CollectionPageMode == 1 then
				mod.CollectionPageFakeNumPages = mod.CollectionPageNumPagesTrinket
				mod.CollectionPageFakeElementsInPage = mod.CollectionPageItemsPerPage-1
				for i=1, mod.CollectionPageItemsPerPage do
					local id = mod.CollectionPageValidTrinkets[i+(mod.CollectionPageFakeCurrentPage*mod.CollectionPageItemsPerPage)]
					if id then
						local renderIcon = true
						local renderPosOffset = Vector(16*((i-1)%mod.CollectionPageItemsPerRow),16*(math.floor((i-1)/mod.CollectionPageItemsPerRow)))
						if not mod.IsTrinketUnlocked(id) then
							mod.CollectionPageTrinket:SetFrame(0)
						elseif mod.CollectionPageIconOverrideTrinket[id] then
							if type(mod.CollectionPageIconOverrideTrinket[id]) == "number" then
								mod.CollectionPageTrinket:SetFrame(id)
							elseif type(mod.CollectionPageIconOverrideTrinket[id]) == "table" and mod.CollectionPageIconOverrideTrinket[id][1] and type(mod.CollectionPageIconOverrideTrinket[id][2]) == "number" then
								mod.CollectionPageIconOverrideTrinket[id][1]:SetFrame(mod.CollectionPageIconOverrideTrinket[id][2])
								mod.CollectionPageIconOverrideTrinket[id][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItemCentered+renderPosOffset))
								renderIcon = false
							else
								mod.CollectionPageTrinket:SetFrame(TrinketType.NUM_TRINKETS)
							end
						elseif id >= TrinketType.NUM_TRINKETS then
							mod.CollectionPageTrinket:SetFrame(TrinketType.NUM_TRINKETS)
						else
							mod.CollectionPageTrinket:SetFrame(id)
						end
						if renderIcon then
							mod.CollectionPageTrinket:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItem+renderPosOffset))
						end
						mod.CollectionPageFakeElementsInPage = i-1
					end
				end
				local currentTrinket = mod.CollectionPageValidTrinkets[(currentElement+1)+(mod.CollectionPageFakeCurrentPage*mod.CollectionPageItemsPerPage)]
				if currentTrinket then
					if mod.CollectionPageLastElement ~= currentElement or mod.CollectionPageLastMode ~= 1 then
						if not mod.IsTrinketUnlocked(currentTrinket) then
							mod.CollectionPageDisplayItem = false
							mod.CollectionPageItemName = ""
							mod.CollectionPageItemDesc = ""
						else
							local data = XMLData.GetEntryById(XMLNode.TRINKET, currentTrinket)
							if data then
								if data.gfx then
									mod.CollectionPageItem:ReplaceSpritesheet(1, "gfx/items/trinkets/" .. data.gfx, true)
									mod.CollectionPageDisplayItem = true
								else
									mod.CollectionPageDisplayItem = false
								end
								if data.name then
									if string.sub(data.name, 1, 2) == "#" then
										mod.CollectionPageItemName = Isaac.GetString("Items", data.name)
									else
										mod.CollectionPageItemName = data.name
									end
								else
									mod.CollectionPageItemName = ""
								end
								if data.description then
									if string.sub(data.description, 1, 2) == "#" then
										mod.CollectionPageItemDesc = Isaac.GetString("Items", data.description)
									else
										mod.CollectionPageItemDesc = data.description
									end
								else
									mod.CollectionPageItemDesc = ""
								end
							end
						end
					end
					if EID then
						if EID.Config["RGON_ShowOnCollectionPage"] then
							EID:HandleRenderingKeys()
							if not EID.isHidden then
								if not mod.IsTrinketUnlocked(currentTrinket) then
									eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
								else
									eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, currentTrinket, nil, false)
								end
							end
						end
					end
				elseif mod.CollectionPageLastElement ~= currentElement or mod.CollectionPageLastMode ~= 1 then
					mod.CollectionPageDisplayItem = false
					mod.CollectionPageItemName = ""
					mod.CollectionPageItemDesc = ""
				end
			elseif mod.CollectionPageMode == 2 then
				mod.CollectionPageFakeNumPages = mod.CollectionPageNumPagesCard
				mod.CollectionPageFakeElementsInPage = mod.CollectionPageItemsPerPage-1
				for i=1, mod.CollectionPageItemsPerPage do
					local elementindex = i+(mod.CollectionPageFakeCurrentPage*mod.CollectionPageItemsPerPage)
					local id = mod.CollectionPageValidCards[elementindex]
					if id then
						local renderIcon = true
						local renderPosOffset = Vector(16*((i-1)%mod.CollectionPageItemsPerRow),16*(math.floor((i-1)/mod.CollectionPageItemsPerRow)))
						local useFrame = PickupSubType.NUM_PICKUPS
						local pickup = mod.CollectionPageCardPickup[id]
						if pickup then
							useFrame = pickup
						end
						if mod.CollectionPageValidCardIsPill[elementindex] then
							if not mod.IsPillUnlocked(id) then
								mod.CollectionPageCard:SetFrame(0)
							else
								mod.CollectionPagePill:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItem+renderPosOffset))
								renderIcon = false
							end
						elseif not mod.IsCardUnlocked(id) then
							mod.CollectionPageCard:SetFrame(0)
						elseif mod.CollectionPageIconOverrideCard[id] and type(mod.CollectionPageIconOverrideCard[id]) == "table" and mod.CollectionPageIconOverrideCard[id][1] and type(mod.CollectionPageIconOverrideCard[id][2]) == "number" then
								mod.CollectionPageIconOverrideCard[id][1]:SetFrame(mod.CollectionPageIconOverrideCard[id][2])
								mod.CollectionPageIconOverrideCard[id][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItemCentered+renderPosOffset))
								renderIcon = false
						elseif mod.CollectionPageIconOverridePickup[useFrame] then
							if type(mod.CollectionPageIconOverridePickup[useFrame]) == "number" then
								mod.CollectionPageCard:SetFrame(useFrame)
							elseif type(mod.CollectionPageIconOverridePickup[useFrame]) == "table" and mod.CollectionPageIconOverridePickup[useFrame][1] and type(mod.CollectionPageIconOverridePickup[useFrame][2]) == "number" then
								mod.CollectionPageIconOverridePickup[useFrame][1]:SetFrame(mod.CollectionPageIconOverridePickup[useFrame][2])
								mod.CollectionPageIconOverridePickup[useFrame][1]:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItemCentered+renderPosOffset))
								renderIcon = false
							else
								mod.CollectionPageCard:SetFrame(PickupSubType.NUM_PICKUPS)
							end
						elseif useFrame >= PickupSubType.NUM_PICKUPS then
							mod.CollectionPageCard:SetFrame(PickupSubType.NUM_PICKUPS)
						else
							mod.CollectionPageCard:SetFrame(useFrame)
						end
						if renderIcon then
							mod.CollectionPageCard:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageFirstItem+renderPosOffset))
						end
						mod.CollectionPageFakeElementsInPage = i-1
					end
				end
				local currentElementIndex = (currentElement+1)+(mod.CollectionPageFakeCurrentPage*mod.CollectionPageItemsPerPage)
				local currentCard = mod.CollectionPageValidCards[currentElementIndex]
				if currentCard then
					if mod.CollectionPageLastElement ~= currentElement or mod.CollectionPageLastMode ~= 1 then
						mod.CollectionPageForceDisplayPickup = false
						if mod.CollectionPageValidCardIsPill[currentElementIndex] then
							if not mod.IsPillUnlocked(currentCard) then
								mod.CollectionPageDisplayItem = false
								mod.CollectionPageItemName = ""
								mod.CollectionPageItemDesc = ""
							else
								mod.CollectionPageItemPickup:Load("gfx/ui/ui_pills_unknown.anm2", true)
								mod.CollectionPageItemPickup:SetFrame("HUD", 0)
								mod.CollectionPageForceDisplayPickup = true
								mod.CollectionPageDisplayItem = true
								local data = XMLData.GetEntryById(XMLNode.PILL, currentCard)
								if data.name then
									if string.sub(data.name, 1, 2) == "#" then
										mod.CollectionPageItemName = Isaac.GetString("Pills", data.name)
									else
										mod.CollectionPageItemName = data.name
									end
								else
									mod.CollectionPageItemName = ""
								end
								if mod.CollectionPageDescriptionOverridePill[currentCard] then
									mod.CollectionPageItemDesc = mod.CollectionPageDescriptionOverridePill[currentCard]
								elseif data.description then
									if string.sub(data.description, 1, 2) == "#" then
										mod.CollectionPageItemDesc = Isaac.GetString("Pills", data.description)
									else
										mod.CollectionPageItemDesc = data.description
									end
								else
									mod.CollectionPageItemDesc = ""
								end
							end
						elseif not mod.IsCardUnlocked(currentCard) then
							mod.CollectionPageDisplayItem = false
							mod.CollectionPageItemName = ""
							mod.CollectionPageItemDesc = ""
						else
							local data = XMLData.GetEntryById(XMLNode.CARD, currentCard)
							if data then
								mod.CollectionPageItemCard:SetFrame("CardFronts", currentCard)
								mod.CollectionPageItemCardModded = nil
								if data.hud then
									local cardconfig = itemConfig:GetCard(currentCard)
									if cardconfig and cardconfig.ModdedCardFront then
										mod.CollectionPageItemCardModded = cardconfig.ModdedCardFront
										mod.CollectionPageItemCardModded:SetFrame(data.hud, 0)
									end
								end
								if data.pickup and tonumber(data.pickup) then
									local pickupXML = XMLData.GetEntityByTypeVarSub(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, tonumber(data.pickup))
									if pickupXML and pickupXML.anm2path then
										mod.CollectionPageItemPickup:Load("gfx/" .. pickupXML.anm2path, true)
										mod.CollectionPageItemPickup:SetFrame("HUD", 0)
										mod.CollectionPageDisplayItem = true
									end
								else
									mod.CollectionPageDisplayItem = false
								end
								if data.name then
									if string.sub(data.name, 1, 2) == "#" then
										mod.CollectionPageItemName = Isaac.GetString("Cards", data.name)
									else
										mod.CollectionPageItemName = data.name
									end
								else
									mod.CollectionPageItemName = ""
								end
								if data.description then
									if string.sub(data.description, 1, 2) == "#" then
										mod.CollectionPageItemDesc = Isaac.GetString("Cards", data.description)
									else
										mod.CollectionPageItemDesc = data.description
									end
								else
									mod.CollectionPageItemDesc = ""
								end
							end
						end
					end
					if EID then
						if EID.Config["RGON_ShowOnCollectionPage"] then
							EID:HandleRenderingKeys()
							if not EID.isHidden then
								if mod.CollectionPageValidCardIsPill[currentElementIndex] then
									if not mod.IsPillUnlocked(currentCard) then
										eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
									else
										--eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, currentCard, nil, false)
									end
								else
									if not mod.IsCardUnlocked(currentCard) then
										eiddesc = {Icon = EID.InlineIcons["QuestionMark"], Description = description or "", Entity = entity}
									else
										eiddesc = EID:getDescriptionObj(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, currentCard, nil, false)
									end
								end
							end
						end
					end
				elseif mod.CollectionPageLastElement ~= currentElement or mod.CollectionPageLastMode ~= 2 then
					mod.CollectionPageDisplayItem = false
					mod.CollectionPageForceDisplayPickup = false
					mod.CollectionPageItemName = ""
					mod.CollectionPageItemDesc = ""
				end
			end
			if mod.CollectionPageMode ~= 0 then
				mod.CollectionPageDupe:RenderLayer(2, Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageItemNotePos))
				local iconPos = collsprite:GetNullFrame("BigItemIcon"):GetPos()
				if mod.CollectionPageDisplayItem then
					if mod.CollectionPageMode == 2 then
						if mod.CollectionPageItemCardModded then
							mod.CollectionPageItemCardModded:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+mod.CollectionPageItemIconPosCard))
						else
							local renderFront = false
							local frame = mod.CollectionPageItemCard:GetFrame()
							for _,animlayer in ipairs(mod.CollectionPageItemCard:GetCurrentAnimationData():GetAllLayers()) do
								local animframe = animlayer:GetFrame(frame)
								if animframe and animframe:IsVisible() then
									renderFront = true
									break
								end
							end
							if renderFront and not mod.CollectionPageForceDisplayPickup then
								mod.CollectionPageItemCard:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+mod.CollectionPageItemIconPosCard))
							else
								mod.CollectionPageItemPickup:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+mod.CollectionPageItemIconPosCard))
							end
						end
					else
						mod.CollectionPageItem:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+mod.CollectionPageItemIconPos))
					end
				end
				local namePos = Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+mod.CollectionPageItemNamePos)
				mod.CollectionPageFont:DrawString(mod.CollectionPageItemName, namePos.X, namePos.Y, mod.CollectionPageFontColor)
				local descPos = Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, iconPos+mod.CollectionPageItemDescPos)
				mod.CollectionPageFont:DrawString(mod.CollectionPageItemDesc, descPos.X, descPos.Y, mod.CollectionPageFontColor)
				if EID and eiddesc then
					if EID.Config["RGON_ShowOnCollectionPage"] then
						EID:HandleRenderingKeys()
						if not EID.isHidden then
							EID:printDescription(eiddesc, nil)
						end
					end
				end
				if mod.CollectionPageLastMode == 0 then
					CollectionMenu.SetSelectedPage(2)
					currentPage = 2
					collsprite:ReplaceSpritesheet(2, "blank.png", true)
					collsprite:ReplaceSpritesheet(4, "blank.png", true)
					collsprite:ReplaceSpritesheet(5, "blank.png", true)
					iconsprite:ReplaceSpritesheet(6, "blank.png", true)
					if mod.CollectionPageFakeNumPages > 1 then
						collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
					end
				end
				if mod.CollectionPageLastMode ~= mod.CollectionPageMode then
					mod.CollectionPageTabs:SetFrame(mod.CollectionPageMode)
					mod.CollectionPageFakeCurrentPage = 0
					collsprite:ReplaceSpritesheet(4, "blank.png", true)
					if mod.CollectionPageFakeNumPages > 1 then
						collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
					else
						collsprite:ReplaceSpritesheet(3, "blank.png", true)
					end
				end
				if currentPage ~= 2 then
					if currentPage > 2 then
						CollectionMenu.SetSelectedPage(2)
						mod.CollectionPageFakeCurrentPage = mod.CollectionPageFakeCurrentPage + 1
					elseif currentPage < 2 then
						CollectionMenu.SetSelectedPage(2)
						mod.CollectionPageFakeCurrentPage = mod.CollectionPageFakeCurrentPage - 1
					end
					if mod.CollectionPageFakeCurrentPage > mod.CollectionPageFakeNumPages-1 then
						mod.CollectionPageFakeCurrentPage = 0
					end
					if mod.CollectionPageFakeCurrentPage < 0 then
						mod.CollectionPageFakeCurrentPage = mod.CollectionPageFakeNumPages-1
					end
					if mod.CollectionPageFakeCurrentPage == 0 then
						collsprite:ReplaceSpritesheet(4, "blank.png", true)
						if mod.CollectionPageFakeNumPages > 1 then
							collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
						else
							collsprite:ReplaceSpritesheet(3, "blank.png", true)
						end
					elseif mod.CollectionPageFakeCurrentPage == mod.CollectionPageFakeNumPages-1 then
						collsprite:ReplaceSpritesheet(3, "blank.png", true)
						collsprite:ReplaceSpritesheet(4, "gfx/ui/main menu/collectionmenu.png", true)
					else
						collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
						collsprite:ReplaceSpritesheet(4, "gfx/ui/main menu/collectionmenu.png", true)
					end
				end
				--[[
				if currentElement > mod.CollectionPageFakeElementsInPage then
					if currentElement - mod.CollectionPageLastElement == 1 then
						currentElement = 0
						CollectionMenu.SetSelectedElement(currentElement)
						mod.CollectionPageFakeCurrentPage = 0
					elseif currentElement&mod.CollectionPageItemsPerRow == mod.CollectionPageFakeElementsInPage&mod.CollectionPageItemsPerRow then
						currentElement = mod.CollectionPageFakeElementsInPage
						CollectionMenu.SetSelectedElement(currentElement)
					else
						currentElement = currentElement&mod.CollectionPageItemsPerRow
						CollectionMenu.SetSelectedElement(currentElement)
						mod.CollectionPageFakeCurrentPage = 0
					end
					CollectionMenu.SetSelectedPage(2)
				end
				]]
				numPages = mod.CollectionPageFakeNumPages
				currentPage = mod.CollectionPageFakeCurrentPage
			else
				mod.CollectionPageFakeCurrentPage = 0
				mod.CollectionPageFakeElementsInPage = mod.CollectionPageItemsPerPage
			end
			if numPages > 1 then
				local bulletGap = Vector(0,mod.CollectionPageBulletHeight/numPages)
				local bulletPos = (collsprite:GetNullFrame("Bullet"):GetPos()+mod.CollectionPageBulletPos)-(bulletGap/2)
				for i=1,numPages do
					local currentPos = bulletPos+(bulletGap*i)
					if i-1 == currentPage then
						mod.CollectionPageBulletOn:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, currentPos))
					else
						mod.CollectionPageBulletOff:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, currentPos))
					end
				end
			end
			mod.CollectionPageTabs:Render(Isaac.WorldToMenuPosition(MainMenuType.COLLECTION, mod.CollectionPageTabsPos))
			mod.CollectionPageLastMode = mod.CollectionPageMode
			mod.CollectionPageLastElement = currentElement
			if Input.IsActionTriggered(ButtonAction.ACTION_PILLCARD, 0) then
				mod.CollectionPageMode = mod.CollectionPageMode - 1
			end
			if Input.IsActionTriggered(ButtonAction.ACTION_BOMB, 0) then
				mod.CollectionPageMode = mod.CollectionPageMode + 1
			end
			if mod.CollectionPageMode > 2 then
				mod.CollectionPageMode = 0
			end
			if mod.CollectionPageMode < 0 then
				mod.CollectionPageMode = 2
			end
		else
			mod.GenerateCollectionMenuData()
		end
	elseif mod.CollectionPageMode ~= 0 then
		local collsprite = CollectionMenu.GetCollectionMenuSprite()
		local iconsprite = CollectionMenu.GetDeathScreenSprite()
		mod.CollectionPageMode = 0
		CollectionMenu.SetSelectedPage(0)
		collsprite:ReplaceSpritesheet(2, "gfx/ui/main menu/collectionmenu.png", true)
		collsprite:ReplaceSpritesheet(3, "gfx/ui/main menu/collectionmenu.png", true)
		collsprite:ReplaceSpritesheet(5, "gfx/ui/death items.png", true)
		iconsprite:ReplaceSpritesheet(6, "gfx/ui/death items.png", true)
	end
end
mod.AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, mod.OnMainMenuRenderCollectionPage)
