local mod = PibersMod

function mod.PreShellGameUpdate(slot)
	local data = mod.GetData(slot)
	local state = slot:GetState()
	local prizeSprite = slot:GetPrizeSprite()
	if state == SlotState.IDLE or state == SlotState.CHOICE then
		local sprite = slot:GetSprite()
		local touch = slot:GetTouch()
		if not data.fastmode and touch > 120 then
			data.fastmode = true
			local currentanm2 = string.lower(sprite:GetFilename())
			data.origanm2 = currentanm2
			sprite:Load(string.gsub(currentanm2, ".anm2", " fast.anm2"), true)
			prizeSprite:Load(string.gsub(currentanm2, ".anm2", " fast.anm2"), true)
			if state == SlotState.IDLE then
				sprite:Play("Idle", true)
			end
			if state == SlotState.CHOICE then
				local curFrame = sprite:GetFrame()
				sprite:Play("PayShuffle", true)
				prizeSprite:Play("Prizes", true)
				prizeSprite:SetFrame(0)
				if curFrame > 20 then
					sprite:SetFrame(5)
					prizeSprite:SetFrame(5)
				end
				data.LastPrize = nil
			end
		end
		if data.fastmode and touch < 120 then
			data.fastmode = false
			sprite:Load(data.origanm2, true)
			prizeSprite:Load(data.origanm2, true)
			if state == SlotState.IDLE then
				sprite:Play("Idle", true)
			end
			if state == SlotState.CHOICE then
				local curFrame = sprite:GetFrame()
				sprite:Play("PayShuffle", true)
				prizeSprite:Play("Prizes", true)
				prizeSprite:SetFrame(0)
				if curFrame > 16 then
					sprite:SetFrame(5)
					prizeSprite:SetFrame(5)
				end
				data.LastPrize = nil
			end
		end
	end
	local prizeType = slot:GetPrizeType()
	if prizeType ~= PickupVariant.PICKUP_COLLECTIBLE and PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_SKATOLE) then
		local itemChance = 76
		if not data.PrizeRNG then
			data.PrizeRNG = RNG(slot.InitSeed)
		end
		if data.PrizeRNG:RandomInt(1, 1000) <= itemChance then
			slot:SetPrizeType(PickupVariant.PICKUP_COLLECTIBLE)
			prizeType = PickupVariant.PICKUP_COLLECTIBLE
			local game = Game()
			local itempool = game:GetItemPool()
			slot:SetPrizeCollectible(itempool:GetCollectible(ItemPoolType.POOL_SHELL_GAME, true, data.PrizeRNG:Next()), nil, ItemPoolType.POOL_BEGGAR)
		end
	end
	if data.LastPrize ~= prizeType or data.LastState ~= state then
		for _,layer in ipairs(prizeSprite:GetAllLayers()) do
			if layer:GetName() == "Shell3" then
				layer:SetVisible(true)
			elseif layer:GetName() == "Prize" then
				if prizeType == PickupVariant.PICKUP_HEART then
					layer:SetVisible(true)
					prizeSprite:ReplaceSpritesheet(layer:GetLayerID(),"gfx/items/pick ups/pickup_001_heart.png", true)
				elseif prizeType == PickupVariant.PICKUP_BOMB then
					layer:SetVisible(true)
					prizeSprite:ReplaceSpritesheet(layer:GetLayerID(),"gfx/items/pick ups/pickup_016_bomb.png", true)
				elseif prizeType == PickupVariant.PICKUP_COLLECTIBLE then
					local itemID = slot:GetPrizeCollectible()
					if itemID <= 0 then
						itemID = CollectibleType.COLLECTIBLE_SKATOLE
					end
					local xmlData = XMLData.GetEntryById(XMLNode.ITEM, itemID)
					if xmlData and xmlData.gfx then
						layer:SetVisible(true)
						prizeSprite:ReplaceSpritesheet(layer:GetLayerID(),"gfx/items/collectibles/" .. xmlData.gfx, true)
					end
				else
					layer:SetVisible(false)
				end
			elseif layer:GetName() == "PrizeCoin" then
				if prizeType == PickupVariant.PICKUP_COIN then
					layer:SetVisible(true)
					prizeSprite:ReplaceSpritesheet(layer:GetLayerID(),"gfx/items/pick ups/pickup_002_coin.png", true)
				else
					layer:SetVisible(false)
				end
			elseif layer:GetName() == "PrizeKey" then
				if prizeType == PickupVariant.PICKUP_KEY then
					layer:SetVisible(true)
					prizeSprite:ReplaceSpritesheet(layer:GetLayerID(),"gfx/items/pick ups/pickup_003_key.png", true)
				else
					layer:SetVisible(false)
				end
			else
				layer:SetVisible(false)
			end
		end
	end
	data.LastPrize = prizeType
	data.LastState = state
end
mod.AddCallback(ModCallbacks.MC_PRE_SLOT_UPDATE, mod.PreShellGameUpdate, SlotVariant.SHELL_GAME)

function mod.SomeoneTakesFullHeartDMG()
	local game = Game()
	local level = game:GetLevel()
	if level:GetStage() > LevelStage.STAGE3_2 and not game:IsGreedMode() then
		for _,player in ipairs(PlayerManager.GetPlayers()) do
			if not player:HasCollectible(CollectibleType.COLLECTIBLE_WAFER) then
				return true
			end
		end
	end
	return false
end

function mod.PlayerTakesFullHeartDMG(player)
	local game = Game()
	local level = game:GetLevel()
	if level:GetStage() > LevelStage.STAGE3_2 and not game:IsGreedMode() and not player:HasCollectible(CollectibleType.COLLECTIBLE_WAFER) then
		return true
	end
	return false
end

mod.HeartSigns = {}
mod.HeartSigns[SlotVariant.DEVIL_BEGGAR] = "slot_005_devil_beggar"
mod.HeartSigns[SlotVariant.HELL_GAME] = "hell_game"
function mod.PreHeartSlotUpdate(slot)
	local data = mod.GetData(slot)
	local sprite = slot:GetSprite()
	if mod.HeartSigns[slot.Variant] then
		local game = Game()
		local level = game:GetLevel()
		if mod.SomeoneTakesFullHeartDMG() then
			if not data.heartsign then
				sprite:ReplaceSpritesheet(0,"gfx/items/slots/" .. mod.HeartSigns[slot.Variant] .. "_full.png", true)
				data.heartsign = true
			end
		elseif data.heartsign then
			sprite:ReplaceSpritesheet(0,"gfx/items/slots/" .. mod.HeartSigns[slot.Variant] .. ".png", true)
			data.heartsign = false
		end
	end
	if (sprite:IsPlaying("PayPrize") or sprite:IsPlaying("PayNothing") or sprite:IsPlaying("PayShuffle")) and sprite:GetFrame() == 0 then
		sprite:PlayOverlay("PayOverlay", true)
		local layerOffset = 0
		if slot.Variant == SlotVariant.HELL_GAME then
			layerOffset = 6
		end
		local firstLayer = 2+layerOffset
		if not data.payment then
			data.payment = firstLayer
		end
		for _,layer in ipairs(sprite:GetAllLayers()) do
			local layerID = layer:GetLayerID()
			if layerID >= firstLayer then
				if layerID == data.payment+layerOffset then
					layer:SetVisible(true)
				else
					layer:SetVisible(false)
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_SLOT_UPDATE, mod.PreHeartSlotUpdate, SlotVariant.DEVIL_BEGGAR)
mod.AddCallback(ModCallbacks.MC_PRE_SLOT_UPDATE, mod.PreHeartSlotUpdate, SlotVariant.HELL_GAME)

function mod.PreEntitySpawnForSlots(entType, entVariant, entSubType, pos, vel, spawner, seed)
	if entType == EntityType.ENTITY_ATTACKFLY then
		for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, SlotVariant.SHELL_GAME, -1, true, false)) do
			if entity.Position:Distance(pos) < 50 then
				return {EntityType.ENTITY_FLY,0,0,seed}
			end
		end
	elseif entType == EntityType.ENTITY_PICKUP then
		if entVariant == PickupVariant.PICKUP_COLLECTIBLE then
			if entSubType == CollectibleType.COLLECTIBLE_SKATOLE then
				for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, SlotVariant.SHELL_GAME, -1, true, false)) do
					if entity:ToSlot() then
						local slot = entity:ToSlot()
						local prize = slot:GetPrizeCollectible()
						if slot:GetState() == SlotState.REWARD_SHELL_GAME and prize > 0 and prize ~= CollectibleType.COLLECTIBLE_SKATOLE then
							return {entType,entVariant,prize,seed}
						end
					end
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.PreEntitySpawnForSlots)

function mod.PrePlayerTakeDMGSlots(player, amount, flags, source, cooldown)
	if source and source.Entity and source.Type == EntityType.ENTITY_SLOT and (source.Variant == SlotVariant.DEVIL_BEGGAR or source.Variant == SlotVariant.HELL_GAME) then
		local sourceent = source.Entity
		local sourceData = mod.GetData(sourceent)
		local takesFullDMG = mod.PlayerTakesFullHeartDMG(player)
		local redHearts = player:GetHearts()
		local rottenHearts = player:GetRottenHearts()
		local eternalHearts = player:GetEternalHearts()
		local soulHearts = player:GetSoulHearts()
		local lastSoulIsHalf = false
		local lastSoulIsBlack = false
		local secondtolastSoulIsBlack = false
		local lastHeartIsBone = false
		if soulHearts > 0 then
			lastSoulIsHalf = soulHearts % 2 ~= 0
			lastSoulIsBlack = player:IsBlackHeart((math.ceil(soulHearts/2)*2)-1)
			if soulHearts > 2 then
				secondtolastSoulIsBlack = player:IsBlackHeart((math.ceil(soulHearts/2)*2)-3)
			end
		end
		if player:IsBoneHeart(math.ceil(soulHearts/2)+player:GetBoneHearts()-1) then
			lastHeartIsBone = true
		else
			lastHeartIsBone = false
		end
		if takesFullDMG then
			if redHearts >= 2 then
				sourceData.payment = 3
			elseif redHearts == 1 then
				if soulHearts >= 1 then
					if lastSoulIsBlack then
						sourceData.payment = 10
					else
						sourceData.payment = 9
					end
				elseif lastHeartIsBone then
					sourceData.payment = 12
				elseif eternalHearts >= 1 then
					sourceData.payment = 4
				elseif rottenHearts >= 1 then
					sourceData.payment = 13
				else
					sourceData.payment = 2
				end
			elseif soulHearts >= 2 then
				if lastSoulIsBlack then
					if (lastSoulIsHalf and secondtolastSoulIsBlack) or not lastSoulIsHalf then
						sourceData.payment = 8
					else
						sourceData.payment = 11
					end
				else
					if (lastSoulIsHalf and not secondtolastSoulIsBlack) or not lastSoulIsHalf then
						sourceData.payment = 6
					else
						sourceData.payment = 11
					end
				end
			elseif lastHeartIsBone then
				sourceData.payment = 12
			elseif eternalHearts >= 1 then
				sourceData.payment = 4
			elseif soulHearts == 1 then
				if lastSoulIsBlack then
					sourceData.payment = 7
				else
					sourceData.payment = 5
				end
			end
		else
			if redHearts >= 1 then
				if rottenHearts >= redHearts then
					sourceData.payment = 13
				else
					sourceData.payment = 2
				end
			elseif soulHearts >= 1 then
				if lastSoulIsBlack then
					sourceData.payment = 7
				else
					sourceData.payment = 5
				end
			elseif lastHeartIsBone then
				sourceData.payment = 12
			elseif eternalHearts >= 1 then
				sourceData.payment = 4
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, mod.PrePlayerTakeDMGSlots)
