local mod = Desecration

local plswork = 0.025
mod.basespeed = 6.5
function mod.OnPlayerUpdate(player)

	local game = Game()
	local itemPool = game:GetItemPool()
	local room = game:GetRoom()
	local roomType = room:GetType()

	-- Add innate Analog Stick for 360 degree movement
	if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ANALOG_STICK, false) <= 0 then
		player:AddInnateCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK, 1, "pibinnate", -1, false)
	end

	-- Add innate fast-bombs-like place delay
	if player:GetBombPlaceDelay() > 5 then
		player:SetBombPlaceDelay(5)
	end

	-- Make angels drop items (might give it its own pool)
	if not player:HasTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS, false)
		and roomType == RoomType.ROOM_ANGEL
		and (player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) or #Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_1, true) >= 1)
		and (player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) or #Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_2, true) >= 1) then
		if player:GetInnateTrinketCount(TrinketType.TRINKET_FILIGREE_FEATHERS, "pibinnate") <= 0 then
			player:AddInnateTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS, 1, "pibinnate", -1, false)
		end
	elseif player:GetInnateTrinketCount(TrinketType.TRINKET_FILIGREE_FEATHERS, "pibinnate") > 0 then
		player:RemoveInnateTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS, 1, "pibinnate")
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) then
		if not player:HasCollectible(CollectibleType.KEY_PIECE_COMPLETE) then
			mod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KEY_PIECE_1)
			mod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KEY_PIECE_2)
			player:AddCollectible(CollectibleType.KEY_PIECE_COMPLETE)
		end
	elseif player:HasCollectible(CollectibleType.KEY_PIECE_COMPLETE) then
		player:RemoveCollectible(CollectibleType.KEY_PIECE_COMPLETE)
	end

	if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_KEY_PIECE_1) > 1 and not player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) then
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
		player:AddCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
	elseif player:GetCollectibleNum(CollectibleType.COLLECTIBLE_KEY_PIECE_2) > 1 and not player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) then
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2)
		player:AddCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1) and player:HasCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2) then
		if not player:HasCollectible(CollectibleType.KNIFE_PIECE_COMPLETE) then
			mod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
			mod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KNIFE_PIECE_2)
			player:AddCollectible(CollectibleType.KNIFE_PIECE_COMPLETE)
		end
	elseif player:HasCollectible(CollectibleType.KNIFE_PIECE_COMPLETE) then
		player:RemoveCollectible(CollectibleType.KNIFE_PIECE_COMPLETE)
	end

	if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1) > 1 and not player:HasCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2) then
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
		player:AddCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2)
	elseif player:GetCollectibleNum(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2) > 1 and not player:HasCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1) then
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2)
		player:AddCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
	end

	if player.FrameCount % 30 == 0 then
		local data = mod.GetData(player)
		if data.lastpos then
			--print((data.lastpos:Distance(player.Position))*plswork)
			--print(mod.basespeed*(player.MoveSpeed))
		end
		data.lastpos = player.Position
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnPlayerUpdate)

function mod.OnNewRoomBuddy()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BUDDY_IN_A_BOX, -1, false, false)) do
		local familiarData = mod.GetData(entity)
		familiarData.BlankedBuddySpritesheet = false
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomBuddy)

function mod.PreUseMoonCard(cardID, player, useFlags)
	local isTarotUse = useFlags & UseFlag.USE_CARBATTERY > 0
	if isTarotUse then
		return true
	end
	local game = Game()
	local level = game:GetLevel()
	local dimension = level:GetDimension()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE3_2 then
		local stageType = level:GetStageType()
		if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
			if dimension == Dimension.MIRROR then
				if mod.PreUseCardMausTeleporterStart(cardID, player, useFlags) then
					return true
				end
			end
		end
	end
	local hasCloth = player:HasCollectible(CollectibleType.COLLECTIBLE_TAROT_CLOTH)
	local roomMaxVisits = -1
	local goodRooms = {}
	local ultraRooms = {}
	local rooms = level:GetRooms()
	for i=0, rooms.Size-1 do
		local roomDesc = rooms:Get(i)
		if roomDesc:GetDimension() == dimension then
			if roomDesc.Data.Type == RoomType.ROOM_ULTRASECRET and roomDesc.VisitedCount <= 0 then
				ultraRooms[#ultraRooms+1] = roomDesc.GridIndex
			end
			if roomDesc.VisitedCount <= roomMaxVisits or roomMaxVisits < 0 then
				if roomDesc.Data.Type == RoomType.ROOM_SECRET or ((hasCloth or game:IsGreedMode()) and roomDesc.Data.Type == RoomType.ROOM_SUPERSECRET) then
					if roomDesc.VisitedCount < roomMaxVisits or roomMaxVisits < 0 then
						roomMaxVisits = roomDesc.VisitedCount
						goodRooms = {}
					end
					goodRooms[#goodRooms+1] = roomDesc.GridIndex
				end
			end
		end
	end
	if hasCloth and (roomMaxVisits > 0 or #goodRooms <= 0) and #ultraRooms > 0 then
		player:UseCard(Card.CARD_REVERSE_MOON, UseFlag.USE_NOANIM|UseFlag.USE_NOANNOUNCER)
		return true
	end
	if #goodRooms > 0 then
		if #goodRooms == 1 then
			game:StartRoomTransition(goodRooms[1], Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, dimension)
		else
			game:StartRoomTransition(goodRooms[player:GetCardRNG(cardID):RandomInt(1,#goodRooms)], Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, dimension)
		end
		return true
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_USE_CARD, mod.PreUseMoonCard, Card.CARD_MOON)

function mod.OnTwoOfHeartsUse(cardType, player, useFlags)
	if player:GetMaxHearts() <= 0 then
		player:AddSoulHearts(2)
	end
end
mod.AddCallback(ModCallbacks.MC_USE_CARD, mod.OnTwoOfHeartsUse, Card.CARD_HEARTS_2)

function mod.OnGetPillRangeDown(effect, color, player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE) then
		return PillEffect.PILLEFFECT_RANGE_UP
	end
end
mod.AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, mod.OnGetPillRangeDown, PillEffect.PILLEFFECT_RANGE_DOWN)

function mod.PreChangeRoomItems(roomIndex, dimension)
	for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
		player:BlockCollectible(CollectibleType.COLLECTIBLE_TOXIC_SHOCK)
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, mod.PreChangeRoomItems)

function mod.OnLilChestUpdate(familiar)

	local sprite = familiar:GetSprite()
	if sprite:IsFinished("Spawn") then
		sprite:Play(sprite:GetDefaultAnimation(), false)
	end

end
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnLilChestUpdate, FamiliarVariant.LIL_CHEST)

mod.BuddyAnimations = {
	[Direction.LEFT] = {
		[0] = "LeftFloat",
		[1] = "LeftFloatShoot"
	},
	[Direction.UP] = {
		[0] = "UpFloat",
		[1] = "UpFloatShoot"
	},
	[Direction.RIGHT] = {
		[0] = "RightFloat",
		[1] = "RightFloatShoot"
	},
	[Direction.DOWN] = {
		[0] = "DownFloat",
		[1] = "DownFloatShoot"
	}
}
function mod.OnBuddyBoxRender(familiar, offset)

	local sprite, data = familiar:GetSprite(), mod.GetData(familiar)

	if not Game():IsPaused() then
		if familiar.FrameCount >= 5 and not data.BlankedBuddySpritesheet then
			sprite:ReplaceSpritesheet(0,"blank.png", true)
			data.BlankedBuddySpritesheet = true
		end

		local currentFrame = math.floor(sprite:GetFrame()*0.5)
		local shootDirection = familiar.Player:GetFireDirection()

		if shootDirection == Direction.NO_DIRECTION then
			if currentFrame == 1 and data.ShootDirection then
				shootDirection = data.ShootDirection
			else
				shootDirection = Direction.DOWN
			end
		end

		if not sprite:IsOverlayPlaying(mod.BuddyAnimations[shootDirection][currentFrame]) then
			data.ShootDirection = nil
			if currentFrame == 1 then
				data.ShootDirection = shootDirection
			end
			sprite:PlayOverlay(mod.BuddyAnimations[shootDirection][currentFrame], true)
		end
	end

end
mod.AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, mod.OnBuddyBoxRender, FamiliarVariant.BUDDY_IN_A_BOX)

function mod.PreEntityTakeDMGVanillaItems(entity, amount, flags, source, cooldown)
	if entity and entity:IsVulnerableEnemy() and entity.HitPoints - amount <= 0 and source and source.Entity then
		local sourceEntity = source.Entity
		for _, matchEntity in pairs(Isaac.FindByType(source.Entity.Type, source.Entity.Variant, source.Entity.SubType, false, false)) do
			if GetPtrHash(source.Entity) == GetPtrHash(matchEntity) then
				sourceEntity = matchEntity
			end
		end
		local player = sourceEntity:ToPlayer()
		if not player and sourceEntity.Type == EntityType.ENTITY_TEAR then
			for i=1, 2 do
				local check = nil
				if i == 1 then
					check = sourceEntity.Parent
				elseif i == 2 then
					check = sourceEntity.SpawnerEntity
				end
				if check then
					if check.Type == EntityType.ENTITY_PLAYER then
						for _, matchEntity in pairs(Isaac.FindByType(check.Type, check.Variant, check.SubType, false, false)) do
							if GetPtrHash(check) == GetPtrHash(matchEntity) then
								player = matchEntity:ToPlayer()
							end
						end
					elseif check.Type == EntityType.ENTITY_FAMILIAR and check.Variant == FamiliarVariant.INCUBUS then
						player = check:ToFamiliar().Player:ToPlayer()
					end
				end
			end
		end
		if player and player:HasCollectible(CollectibleType.COLLECTIBLE_TOXIC_SHOCK) then
			local numToxicShock = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TOXIC_SHOCK, true)
			local doPoison = false
			for attempt=1, numToxicShock do
				local chance = 15.0 + (player.Luck*2)
				chance = math.max(math.min(chance,50.0),10.0)
				if player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TOXIC_SHOCK):RandomInt(1,10000) <= (chance*100) then
					doPoison = true
				end
			end
			if doPoison then
				player:AddCollectible(CollectibleType.COLLECTIBLE_TOXIC_SHOCK)
				player:RemoveCollectible(CollectibleType.COLLECTIBLE_TOXIC_SHOCK)
			end
		end
	end
end
mod.AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, mod.PreEntityTakeDMGVanillaItems)

mod.AnalogStickTears = 0.35
function mod.OnEvaluateTearsUp(player, statStage, value)
	local effects = player:GetEffects()
	local valueMod = 0
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK, false, false) then
		-- Remove innate Analog Stick's tears up, but make later pick ups of the item stackable
		valueMod = valueMod + ((mod.AnalogStickTears * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ANALOG_STICK, true, true)) - mod.AnalogStickTears)
	end
	if valueMod ~= 0 then
		return value + valueMod
	end
end
mod.AddCallback(ModCallbacks.MC_EVALUATE_STAT, mod.OnEvaluateTearsUp, EvaluateStatStage.TEARS_UP)

mod.SpeedMin = 0.8 -- Minimum speed is now 0.8 instead of 0.2
function mod.OnEvaluateSpeedMin(player, cacheFlag)
	-- Speed downs that go below 1 are less punishing
	local currSpeed = player.MoveSpeed
	if currSpeed < 1 then
		currSpeed = mod.SpeedMin - ((currSpeed-0.2)*(mod.SpeedMin-1))
		if currSpeed < mod.SpeedMin then
			currSpeed = mod.SpeedMin
		end
		player.MoveSpeed = currSpeed
	end
end
mod.AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE, mod.OnEvaluateSpeedMin, CacheFlag.CACHE_SPEED)

mod.InfestationColor = Color(1,1,0.5,1,0,0,0)
function mod.PostAddCostume(itemconfigitem, player, itemstateonly)
	if itemconfigitem.ID == CollectibleType.COLLECTIBLE_INFESTATION then
		player.Color = mod.InfestationColor
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PLAYER_ADD_COSTUME, mod.PostAddCostume)

function mod.PostRemoveCostume(itemconfigitem, player, itemstateonly)
	if itemconfigitem.ID == CollectibleType.COLLECTIBLE_INFESTATION then
		player.Color = Color.Default
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PLAYER_REMOVE_COSTUME, mod.PostRemoveCostume)

mod.IncubusShootToBrimstone = {
	ShootDown = "Shoot2Down",
	ShootSide = "Shoot2Side",
	ShootUp = "Shoot2Up",
	FloatShootDown = "Shoot2Down",
	FloatShootSide = "Shoot2Side",
	FloatShootUp = "Shoot2Up"
}
mod.IncubusShootToBrimstoneFloat = {
	ShootDown = "FloatShoot2Down",
	ShootSide = "FloatShoot2Side",
	ShootUp = "FloatShoot2Up",
	FloatShootDown = "FloatShoot2Down",
	FloatShootSide = "FloatShoot2Side",
	FloatShootUp = "FloatShoot2Up",
	Shoot2Down = "FloatShoot2Down",
	Shoot2Side = "FloatShoot2Side",
	Shoot2Up = "FloatShoot2Up",
	FloatShoot2Down = "FloatShoot2Down",
	FloatShoot2Side = "FloatShoot2Side",
	FloatShoot2Up = "FloatShoot2Up"
}
function mod.OnIncubusUpdate(incubus)
	local player = incubus.Player
	if player ~= nil and player:Exists() and player.Type == EntityType.ENTITY_PLAYER then
		if player:ToPlayer() then
			player = player:ToPlayer()
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
				local data = mod.GetData(incubus)
				local sprite = incubus:GetSprite()
				local foundAnim = nil
				for animationPlaying, animationShouldPlay in pairs(mod.IncubusShootToBrimstone) do
					if sprite:IsPlaying(animationPlaying) then
						sprite:Play(animationShouldPlay, true)
						foundAnim = animationShouldPlay
						break
					end
				end
				if foundAnim then
					if not data.BrimShootAnim then
						data.BrimShootAnim = foundAnim
					end
					if not data.BrimShootFrame then
						data.BrimShootFrame = incubus.FrameCount
					end
					local diff = math.floor((incubus.FrameCount-data.BrimShootFrame)/2)
					if diff >= 8 then
						foundAnim = mod.IncubusShootToBrimstoneFloat[data.BrimShootAnim]
						if data.BrimShootAnim ~= foundAnim then
							data.BrimShootAnim = foundAnim
						end
						diff = diff-8
					end
					sprite:SetFrame(data.BrimShootAnim, diff)
				else
					data.BrimShootAnim = nil
					data.BrimShootFrame = nil
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnIncubusUpdate, FamiliarVariant.INCUBUS)

mod.EvilUpItems = {}
mod.EvilUpItems[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_NECRONOMICON] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_SATANIC_BIBLE] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_BOOK_OF_SIN] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_PONY] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_MEGA_BLAST] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_CELTIC_CROSS] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_NEGATIVE] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_EMPTY_VESSEL] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_CAMBION_CONCEPTION] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_DUALITY] = true
mod.EvilUpItems[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL_PASSIVE] = true
mod.EvilUpTrinkets = {}
mod.EvilUpTrinkets[TrinketType.TRINKET_WICKED_CROWN] = true
mod.EvilUpTrinkets[TrinketType.TRINKET_DEVILS_CROWN] = true
mod.EvilUpTrinkets[TrinketType.TRINKET_NUMBER_MAGNET] = true
function mod.OnEvaluateDamageUpVanillaItems(player, stage, value)
	local mult = player:GetTrinketMultiplier(TrinketType.TRINKET_BLACK_FEATHER) * 0.5
	if mult > 0 then
		local evils = 0
		for itemID, isevil in pairs(mod.EvilUpItems) do
			if isevil then
				evils = evils + player:GetCollectibleNum(itemID, true)
			end
		end
		for trinketID, isevil in pairs(mod.EvilUpTrinkets) do
			if isevil then
				evils = evils + player:GetTrinketMultiplier(trinketID)
			end
		end
		return value + (evils*mult)
	end
end
mod.AddCallback(ModCallbacks.MC_EVALUATE_STAT, mod.OnEvaluateDamageUpVanillaItems, EvaluateStatStage.DAMAGE_UP)

function mod.PostAddItemForBlackFeather(itemID, charge, firsttime, slot, varData, player)
	if mod.EvilUpItems[itemID] and player:HasTrinket(TrinketType.TRINKET_BLACK_FEATHER) then
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE, true)
	end
end
mod.AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.PostAddItemForBlackFeather)

function mod.PreAddTrinketForBlackFeather(player, trinketID, firsttime)
	if mod.EvilUpTrinkets[trinketID] and player:HasTrinket(TrinketType.TRINKET_BLACK_FEATHER) then
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE, true)
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_ADD_TRINKET, mod.PreAddTrinketForBlackFeather)

function mod.OnInputForCursor(entity, hook, action)
	if action == ButtonAction.ACTION_DROP and Input.IsMouseBtnPressed(Mouse.MOUSE_BUTTON_RIGHT) then
		if hook == InputHook.GET_ACTION_VALUE then
			return 1
		else
			return true
		end
	end
	if entity and (action == ButtonAction.ACTION_SHOOTLEFT or action == ButtonAction.ACTION_SHOOTRIGHT or action == ButtonAction.ACTION_SHOOTUP or action == ButtonAction.ACTION_SHOOTDOWN) then
		local data = mod.GetData(entity)
		if Input.IsMouseBtnPressed(Mouse.MOUSE_BUTTON_LEFT) then
			local frame = Isaac.GetFrameCount()
			if not data.heldmouseframe then
				data.heldmouseframe = frame
			end
			local mousepos = Input.GetMousePosition(true)
			local entpos = entity.Position
			local inputdir = mousepos - entpos
			inputdir:Resize(1)
			if action == ButtonAction.ACTION_SHOOTLEFT then
				if inputdir.X < 0 then
					print("left " .. (-inputdir.X))
					if hook == InputHook.GET_ACTION_VALUE then
						return -inputdir.X
					elseif inputdir.X <= -0.5 then
						if hook == InputHook.IS_ACTION_TRIGGERED then
							if data.heldmouseframe == frame then
								return true
							end
						else
							return true
						end
					end
				end
			elseif action == ButtonAction.ACTION_SHOOTRIGHT then
				if inputdir.X > 0 then
					print("right " .. inputdir.X)
					if hook == InputHook.GET_ACTION_VALUE then
						return inputdir.X
					elseif inputdir.X >= 0.5 then
						if hook == InputHook.IS_ACTION_TRIGGERED then
							if data.heldmouseframe == frame then
								return true
							end
						else
							return true
						end
					end
				end
			elseif action == ButtonAction.ACTION_SHOOTUP then
				if inputdir.Y < 0 then
					print("up " .. (-inputdir.Y))
					if hook == InputHook.GET_ACTION_VALUE then
						return -inputdir.Y
					elseif inputdir.Y <= -0.5 then
						if hook == InputHook.IS_ACTION_TRIGGERED then
							if data.heldmouseframe == frame then
								return true
							end
						else
							return true
						end
					end
				end
			elseif action == ButtonAction.ACTION_SHOOTDOWN then
				if inputdir.Y > 0 then
					print("down " .. inputdir.Y)
					if hook == InputHook.GET_ACTION_VALUE then
						return inputdir.Y
					elseif inputdir.Y >= 0.5 then
						if hook == InputHook.IS_ACTION_TRIGGERED then
							if data.heldmouseframe == frame then
								return true
							end
						else
							return true
						end
					end
				end
			end
		else
			data.heldmouseframe = nil
		end
	end
end
mod.AddCallback(ModCallbacks.MC_INPUT_ACTION, mod.OnInputForCursor)
