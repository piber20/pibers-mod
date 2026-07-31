PibersMod.MantleSprite = {}
PibersMod.MantleSprite.Empty = Sprite("gfx/ui/ui_hearts_mantle.anm2", true)
PibersMod.MantleSprite.Empty:Play("Empty")
PibersMod.MantleSprite.Unknown = Sprite("gfx/ui/ui_hearts_mantle.anm2", true)
PibersMod.MantleSprite.Unknown:Play("Unknown")
PibersMod.MantleSprite.HolyMantle = Sprite("gfx/ui/ui_hearts_mantle.anm2", true)
PibersMod.MantleSprite.HolyMantle:Play("HolyMantle")
PibersMod.MantleSprite.WoodenCross = Sprite("gfx/ui/ui_hearts_mantle.anm2", true)
PibersMod.MantleSprite.WoodenCross:Play("WoodenCross")
PibersMod.MantleSprite.Blanket = Sprite("gfx/ui/ui_hearts_mantle.anm2", true)
PibersMod.MantleSprite.Blanket:Play("Blanket")
PibersMod.MantleSprite.HolyCard = Sprite("gfx/ui/ui_hearts_mantle.anm2", true)
PibersMod.MantleSprite.HolyCard:Play("HolyCard")
PibersMod.MantleSprite.Dogma = Sprite("gfx/ui/ui_hearts_mantle.anm2", true)
PibersMod.MantleSprite.Dogma:Play("Dogma")
PibersMod.MantleSprite.Dogma:SetRenderFlags(AnimRenderFlags.STATIC)
function PibersMod:OnRenderHearts(offset, heartSprite, pos, scale, player)

	local game = Game()
	local level = game:GetLevel()
	local effects = player:GetEffects()
	local currentMantles = effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE)

	local playerHud = player:GetPlayerHUD()
	local playerHearts = playerHud:GetHearts()
	local playerType = player:GetPlayerType()
	local isLost = effects:HasNullEffect(NullItemID.ID_LOST_CURSE) --or playerType == PlayerType.PLAYER_THELOST
	local isForgotten = playerType == PlayerType.PLAYER_THEFORGOTTEN or playerType == PlayerType.PLAYER_THESOUL

	local doIndex = 0
	if level:GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN > 0 then
		if not isLost then
			doIndex = 1
		end
	else
		local startIndex = #playerHearts
		if isLost then
			startIndex = 0
		elseif isForgotten then
			startIndex = math.min(6,startIndex)
		end
		for heartIndex=startIndex, 1, -1 do
			local heart = playerHearts[heartIndex]
			if heart:IsVisible() then
				doIndex = heartIndex
				break
			end
		end
	end
	PibersMod.RenderMantles(pos, currentMantles, doIndex, player, isLost, isForgotten)

end
PibersMod:AddCallback(ModCallbacks.MC_POST_PLAYERHUD_RENDER_HEARTS, PibersMod.OnRenderHearts)

function PibersMod.RenderMantles(pos, num, index, player, isLost, isForgotten)

	local game = Game()
	local room = game:GetRoom()
	local level = game:GetLevel()
	local roomType = room:GetType()
	local floorSave = PibersMod.SaveManager.GetFloorSave(player)
	local tempSave = PibersMod.SaveManager.GetTempSave(player)
	local gameData = Isaac.GetPersistentGameData()

	local heldDogma = 0
	if player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and not tempSave.takenDogmaDamage then
		heldDogma = 1
	end
	local dogmaCounter = 0

	local heldMantles = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false)
	local mantleCounter = 0

	if isLost and gameData:Unlocked(Achievement.THE_LOST_HOLDS_HOLY_MANTLE) then
		heldMantles = heldMantles + 1
	end

	local heldBlankets = 0
	if roomType == RoomType.ROOM_BOSS then
		heldBlankets = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BLANKET, false)
	end
	local blanketCounter = 0

	local heldCross = 0
	if player:HasTrinket(TrinketType.TRINKET_WOODEN_CROSS) and not floorSave.takenCrossDamage then
		heldCross = 1
	end
	local crossCounter = 0

	local holyCardCounter = 0
	local suspectedHolyCards = 0
	local holyOffset = heldDogma + heldMantles + heldBlankets + heldCross
	if num > holyOffset then
		suspectedHolyCards = num - holyOffset
	end

	if level:GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN > 0 then
		local data = PibersMod.GetData(player)
		data.MostMantlesInRoom = data.MostMantlesInRoom or 0
		if data.MostMantlesInRoom > 0 or heldDogma > 0 or heldMantles > 0 or heldBlankets > 0 or heldCross > 0 or num > 0 then
			local mantlePos = pos+Vector((index)*12,0)
			PibersMod.MantleSprite.Unknown:RenderLayer(0, mantlePos)
		end
	else
		local rowSize = 6
		if index > 6 and index%6 == 0 and not isForgotten then
			rowSize = 7
		end
		--glow
		for mantleIndex=1, math.max(num, heldMantles) do
			local displayIndex = mantleIndex-1
			if rowSize == 7 then
				displayIndex = (displayIndex-1) + math.floor(index/6)
			end
			local mantlePos = pos+Vector(((index+displayIndex)%rowSize)*12,math.floor((index+displayIndex)/rowSize)*10)
			if isForgotten then
				mantlePos = pos+Vector((index+displayIndex)*12,0)
			end
			if mantleIndex > num then
				PibersMod.MantleSprite.Empty:RenderLayer(1, mantlePos)
			else
				if dogmaCounter < heldDogma then
					dogmaCounter = dogmaCounter + 1
					PibersMod.MantleSprite.Dogma:RenderLayer(1, mantlePos)
				elseif holyCardCounter < suspectedHolyCards then
					holyCardCounter = holyCardCounter + 1
					PibersMod.MantleSprite.HolyCard:RenderLayer(1, mantlePos)
				elseif mantleCounter < heldMantles then
					mantleCounter = mantleCounter + 1
					PibersMod.MantleSprite.HolyMantle:RenderLayer(1, mantlePos)
				elseif blanketCounter < heldBlankets then
					blanketCounter = blanketCounter + 1
					PibersMod.MantleSprite.Blanket:RenderLayer(1, mantlePos)
				elseif crossCounter < heldCross then
					crossCounter = crossCounter + 1
					PibersMod.MantleSprite.WoodenCross:RenderLayer(1, mantlePos)
				else
					PibersMod.MantleSprite.HolyMantle:RenderLayer(1, mantlePos)
				end
			end
		end
		dogmaCounter = 0
		holyCardCounter = 0
		mantleCounter = 0
		blanketCounter = 0
		crossCounter = 0
		--mantle
		for mantleIndex=1, math.max(num, heldMantles) do
			local displayIndex = mantleIndex-1
			if rowSize == 7 then
				displayIndex = (displayIndex-1) + math.floor(index/6)
			end
			local mantlePos = pos+Vector(((index+displayIndex)%rowSize)*12,math.floor((index+displayIndex)/rowSize)*10)
			if isForgotten then
				mantlePos = pos+Vector((index+displayIndex)*12,0)
			end
			PibersMod.MantleSprite.Empty:RenderLayer(0, mantlePos)
			if mantleIndex <= num then
				if dogmaCounter < heldDogma then
					dogmaCounter = dogmaCounter + 1
					PibersMod.MantleSprite.Dogma:RenderLayer(0, mantlePos)
				elseif holyCardCounter < suspectedHolyCards then
					holyCardCounter = holyCardCounter + 1
					PibersMod.MantleSprite.HolyCard:RenderLayer(0, mantlePos)
				elseif mantleCounter < heldMantles then
					mantleCounter = mantleCounter + 1
					PibersMod.MantleSprite.HolyMantle:RenderLayer(0, mantlePos)
				elseif blanketCounter < heldBlankets then
					blanketCounter = blanketCounter + 1
					PibersMod.MantleSprite.Blanket:RenderLayer(0, mantlePos)
				elseif crossCounter < heldCross then
					crossCounter = crossCounter + 1
					PibersMod.MantleSprite.WoodenCross:RenderLayer(0, mantlePos)
				else
					PibersMod.MantleSprite.HolyMantle:RenderLayer(0, mantlePos)
				end
			end
		end
	end
end

PibersMod.Player1HeartOffset = Vector(68,30)
function PibersMod:OnRenderHud()
	if Isaac.GetFrameCount() % 2 == 0 then
		PibersMod.MantleSprite.Empty:Update()
		PibersMod.MantleSprite.HolyMantle:Update()
		PibersMod.MantleSprite.WoodenCross:Update()
		PibersMod.MantleSprite.Blanket:Update()
		PibersMod.MantleSprite.HolyCard:Update()
		PibersMod.MantleSprite.Dogma:Update()
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_HUD_RENDER, PibersMod.OnRenderHud)

function PibersMod:OnPlayerUpdateMantles(player)

	local game = Game()
	local effects = player:GetEffects()
	local playerData = PibersMod.GetData(player)
	local room = game:GetRoom()
	local roomType = room:GetType()

	local floorSave = PibersMod.SaveManager.GetFloorSave(player)
	local tempSave = PibersMod.SaveManager.GetTempSave(player)
	local currentMantles = effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
	playerData.preDMGMantles = playerData.preDMGMantles or currentMantles

	floorSave.HolyCards = floorSave.HolyCards or 0
	if playerData.newRoomDelayed then
		player:UnblockCollectible(CollectibleType.COLLECTIBLE_TOXIC_SHOCK)
		playerData.newRoomDelayed = false
	end
	if playerData.newRoom then
		playerData.MostMantlesInRoom = 0
		local heldMantles = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false)
		local addMantles = 0
		if heldMantles > 1 then
			addMantles = addMantles + heldMantles-1
		end

		local heldBlankets = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BLANKET, false)
		if heldBlankets > 1 and roomType == RoomType.ROOM_BOSS then
			addMantles = addMantles + heldBlankets-1
		end

		if player:HasTrinket(TrinketType.TRINKET_WOODEN_CROSS) and floorSave.takenHolyDamage and not floorSave.takenCrossDamage then
			addMantles = addMantles + 1
		end
		if floorSave.HolyCards > 0 then
			if floorSave.takenCrossDamage or floorSave.takenHolyDamage then
				addMantles = addMantles + floorSave.HolyCards
			elseif floorSave.HolyCards > 1 then
				addMantles = addMantles + floorSave.HolyCards-1
			end
		end

		if addMantles > 0 then
			effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, true, addMantles)
		end
		playerData.newRoom = false
		playerData.newRoomDelayed = true
	elseif playerData.preDMGMantles > currentMantles then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_DOGMA) and currentMantles == 0 then
			tempSave.takenDogmaDamage = true
		end
		if player:HasTrinket(TrinketType.TRINKET_WOODEN_CROSS) and not floorSave.takenCrossDamage then
			floorSave.takenCrossDamage = true
		end
		if floorSave.HolyCards > 0 then
			floorSave.HolyCards = floorSave.HolyCards - 1
			floorSave.takenHolyDamage = true
		end
		for i=1, player:GetCollectibleNum(CollectibleType.BLOODY_FEATHER) do
			PibersMod.BloodyFeatherEffect(player)
		end
		playerData.preDMGMantles = currentMantles
	end
	playerData.MostMantlesInRoom = playerData.MostMantlesInRoom or 0
	playerData.MostMantlesInRoom = math.max(playerData.MostMantlesInRoom,player:GetCollectibleNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false))

end
PibersMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, PibersMod.OnPlayerUpdateMantles)

function PibersMod:PrePlayerTakeDMGMantles(player, amount, flags, source, cooldown)
	local effects = player:GetEffects()
	local currentMantles = effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
	local playerData = PibersMod.GetData(player)
	playerData.preDMGMantles = currentMantles
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, PibersMod.PrePlayerTakeDMGMantles)

function PibersMod:OnHolyCardUse(cardType, player, useFlags)
	local floorSave = PibersMod.SaveManager.GetFloorSave(player)
	floorSave.HolyCards = floorSave.HolyCards or 0
	floorSave.HolyCards = floorSave.HolyCards + 1
	if floorSave.HolyCards > 1 or (player:HasTrinket(TrinketType.TRINKET_WOODEN_CROSS) and not floorSave.takenCrossDamage) then
		local effects = player:GetEffects()
		effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, true, 1)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_USE_CARD, PibersMod.OnHolyCardUse, Card.CARD_HOLY)
