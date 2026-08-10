function PibersMod:OnModsLoadedVanillaItems()
	local itemConfig = Isaac.GetItemConfig()

	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_SERAPHIM).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_SERAPHIM).Tags | ItemConfig.TAG_ANGEL
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_BROKEN_GLASS_CANNON).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_BROKEN_GLASS_CANNON).Tags | ItemConfig.TAG_NO_EDEN

	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_DECK_OF_CARDS).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_DECK_OF_CARDS).Tags ~ ItemConfig.TAG_STARS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_CARD_READING).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_CARD_READING).Tags ~ ItemConfig.TAG_STARS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_ECHO_CHAMBER).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_ECHO_CHAMBER).Tags ~ ItemConfig.TAG_STARS

	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_TINY_PLANET).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_TINY_PLANET).Tags | ItemConfig.TAG_STARS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_BLACK_HOLE).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_BLACK_HOLE).Tags | ItemConfig.TAG_STARS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_ANGELIC_PRISM).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_ANGELIC_PRISM).Tags | ItemConfig.TAG_STARS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_GENESIS).Tags = itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_GENESIS).Tags | ItemConfig.TAG_STARS

	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_SOL).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_LUNA).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_MERCURIUS).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_VENUS).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_TERRA).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_MARS).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_JUPITER).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_SATURNUS).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_URANUS).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_NEPTUNUS).AchievementID = Achievement.PLANETARIUMS
	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_PLUTO).AchievementID = Achievement.PLANETARIUMS

	itemConfig:GetCollectible(CollectibleType.COLLECTIBLE_DOGMA).AchievementID = Achievement.RED_KEY
end
PibersMod:AddCallback(ModCallbacks.MC_POST_MODS_LOADED, PibersMod.OnModsLoadedVanillaItems)

function PibersMod:OnPlayerUpdate(player)

	local game = Game()
	local itemPool = game:GetItemPool()
	local room = game:GetRoom()
	local roomType = room:GetType()

	-- Add innate Analog Stick for 360 degree movement
	if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ANALOG_STICK, false) <= 0 then
		player:AddInnateCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK, 1, "pibinnate", -1, false)
	end
	-- Remove Marked and Analog Stick from the pool
	if itemPool:HasCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK) then
		itemPool:RemoveCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK)
	end
	-- We remove Marked too because it's effectively the same thing but worse
	if itemPool:HasCollectible(CollectibleType.COLLECTIBLE_MARKED) then
		itemPool:RemoveCollectible(CollectibleType.COLLECTIBLE_MARKED)
	end

	if player:GetBombPlaceDelay() > 5 then
		player:SetBombPlaceDelay(5)
	end
	-- Remove it from the pool
	if itemPool:HasCollectible(CollectibleType.COLLECTIBLE_FAST_BOMBS) then
		itemPool:RemoveCollectible(CollectibleType.COLLECTIBLE_FAST_BOMBS)
	end
	-- Add innate Filigree Feather
	if not player:HasTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS, false)
		and roomType == RoomType.ROOM_ANGEL
		and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1)
		and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) then
		if player:GetInnateTrinketCount(TrinketType.TRINKET_FILIGREE_FEATHERS, "pibinnate") <= 0 then
			player:AddInnateTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS, 1, "pibinnate", -1, false)
		end
	elseif player:GetInnateTrinketCount(TrinketType.TRINKET_FILIGREE_FEATHERS, "pibinnate") > 0 then
		player:RemoveInnateTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS, 1, "pibinnate")
	end
	-- Remove it from the pool
	if itemPool:HasTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS) then
		itemPool:RemoveTrinket(TrinketType.TRINKET_FILIGREE_FEATHERS)
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) then
		if not player:HasCollectible(CollectibleType.KEY_PIECE_COMPLETE) then
			PibersMod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KEY_PIECE_1)
			PibersMod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KEY_PIECE_2)
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
			PibersMod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
			PibersMod.RemoveItemFromHistory(player, CollectibleType.COLLECTIBLE_KNIFE_PIECE_2)
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
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, PibersMod.OnPlayerUpdate)

PibersMod.ReplaceCollectibleWithOnDupe = {}
PibersMod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KEY_PIECE_1] = CollectibleType.COLLECTIBLE_KEY_PIECE_2
PibersMod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KEY_PIECE_2] = CollectibleType.COLLECTIBLE_KEY_PIECE_1
PibersMod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KNIFE_PIECE_1] = CollectibleType.COLLECTIBLE_KNIFE_PIECE_2
PibersMod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KNIFE_PIECE_2] = CollectibleType.COLLECTIBLE_KNIFE_PIECE_1
function PibersMod:OnCollectibleInit(pickup)
	if PibersMod.ReplaceCollectibleWithOnDupe[pickup.SubType] and PlayerManager.AnyoneHasCollectible(pickup.SubType) then
		pickup:Morph(pickup.Type, pickup.Variant, PibersMod.ReplaceCollectibleWithOnDupe[pickup.SubType], true, true, true)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, PibersMod.OnCollectibleInit, PickupVariant.PICKUP_COLLECTIBLE)

function PibersMod:OnCollectibleUpdate(pickup)
	if pickup.FrameCount > 2 and PibersMod.ReplaceCollectibleWithOnDupe[pickup.SubType] then
		if PlayerManager.AnyoneHasCollectible(pickup.SubType) and not PlayerManager.AnyoneHasCollectible(PibersMod.ReplaceCollectibleWithOnDupe[pickup.SubType]) then
			pickup:Morph(pickup.Type, pickup.Variant, PibersMod.ReplaceCollectibleWithOnDupe[pickup.SubType], true, true, true)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position-PibersMod.PoofSpawnOffset, Vector.Zero, pickup)
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, PibersMod.OnCollectibleUpdate, PickupVariant.PICKUP_COLLECTIBLE)

function PibersMod:OnNewRoomBuddy()
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BUDDY_IN_A_BOX, -1, false, false)) do
		local familiarData = PibersMod.GetData(entity)
		familiarData.BlankedBuddySpritesheet = false
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PibersMod.OnNewRoomBuddy)

function PibersMod:PreUseMoonCard(cardID, player, useFlags)
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
				if PibersMod:PreUseCardMausTeleporterStart(cardID, player, useFlags) then
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
PibersMod:AddCallback(ModCallbacks.MC_PRE_USE_CARD, PibersMod.PreUseMoonCard, Card.CARD_MOON)

function PibersMod:OnTwoOfHeartsUse(cardType, player, useFlags)
	if player:GetMaxHearts() <= 0 then
		player:AddSoulHearts(2)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_USE_CARD, PibersMod.OnTwoOfHeartsUse, Card.CARD_HEARTS_2)

function PibersMod:OnGetPillRangeDown(effect, color, player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE) then
		return PillEffect.PILLEFFECT_RANGE_UP
	end
end
PibersMod:AddCallback(ModCallbacks.MC_GET_PILL_EFFECT, PibersMod.OnGetPillRangeDown, PillEffect.PILLEFFECT_RANGE_DOWN)

PibersMod.ChargeDischargeSprites = {}
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_LEMON_MISHAP] = Sprite("gfx/ui/hud_lemonmishap.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_HOURGLASS] = Sprite("gfx/ui/hud_thehourglass.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_THE_NAIL] = Sprite("gfx/ui/hud_thenail.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_DECK_OF_CARDS] = Sprite("gfx/ui/hud_deckofcards.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_GAMEKID] = Sprite("gfx/ui/hud_thegamekid.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_MOMS_BOTTLE_OF_PILLS] = Sprite("gfx/ui/hud_momsbottleofpills.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_CANDLE] = Sprite("gfx/ui/hud_bluecandle.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_BOX_OF_SPIDERS] = Sprite("gfx/ui/hud_boxofspiders.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_RED_CANDLE] = Sprite("gfx/ui/hud_redcandle.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_ISAACS_TEARS] = Sprite("gfx/ui/hud_isaacstears.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_TEAR_DETONATOR] = Sprite("gfx/ui/hud_teardetonator.anm2", true)
PibersMod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_FREE_LEMONADE] = Sprite("gfx/ui/hud_freelemonade.anm2", true)
PibersMod.AnimDischargeSprites = {}
PibersMod.AnimDischargeSprites[CollectibleType.COLLECTIBLE_YUM_HEART] = Sprite("gfx/ui/hud_yumheart.anm2", true)
PibersMod.AnimDischargeSprites[CollectibleType.COLLECTIBLE_YUCK_HEART] = Sprite("gfx/ui/hud_yuckheart.anm2", true)
local lastFrame = 0
function PibersMod:PreRenderActive(player, slot, offset, alpha, scale, chargebaroffset)
	local itemID = player:GetActiveItem(slot)
	if PibersMod.AnimDischargeSprites[itemID] then
		local activeSprite = PibersMod.AnimDischargeSprites[itemID]
		activeSprite.Color = Color(activeSprite.Color.R, activeSprite.Color.G, activeSprite.Color.B, alpha)
		activeSprite.Scale = Vector(scale,scale)
		local game = Game()
		if player:NeedsCharge(slot) or player:GetActiveCharge(slot) < Isaac.GetItemConfig():GetCollectible(itemID).MaxCharges then
			if game:GetFrameCount()&2 == 0 and not game:IsPaused() then
				activeSprite:Update()
			end
		else
			if activeSprite:GetFrame() ~= 0 then
				activeSprite:Play("Idle", true)
			end
		end
		activeSprite:Render(offset)
		return {HideItem=true,HideOutline=true}
	elseif PibersMod.ChargeDischargeSprites[itemID] then
		local activeSprite = PibersMod.ChargeDischargeSprites[itemID]
		activeSprite.Color = Color(activeSprite.Color.R, activeSprite.Color.G, activeSprite.Color.B, alpha)
		activeSprite.Scale = Vector(scale,scale)
		if player:NeedsCharge(slot) or player:GetActiveCharge(slot) < Isaac.GetItemConfig():GetCollectible(itemID).MaxCharges then
			if activeSprite:GetFrame() ~= 1 then
				activeSprite:SetFrame("Idle", 1)
			end
		else
			if activeSprite:GetFrame() ~= 0 then
				activeSprite:SetFrame("Idle", 0)
			end
		end
		activeSprite:Render(offset)
		return {HideItem=true,HideOutline=true}
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_PLAYERHUD_RENDER_ACTIVE_ITEM, PibersMod.PreRenderActive)

function PibersMod:PreChangeRoomItems(roomIndex, dimension)
	for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
		player:BlockCollectible(CollectibleType.COLLECTIBLE_TOXIC_SHOCK)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, PibersMod.PreChangeRoomItems)

function PibersMod:OnLilChestUpdate(familiar)

	local sprite = familiar:GetSprite()
	if sprite:IsFinished("Spawn") then
		sprite:Play(sprite:GetDefaultAnimation(), false)
	end

end
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnLilChestUpdate, FamiliarVariant.LIL_CHEST)

PibersMod.BuddyAnimations = {
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
function PibersMod:OnBuddyBoxRender(familiar, offset)

	local sprite, data = familiar:GetSprite(), PibersMod.GetData(familiar)

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

		if not sprite:IsOverlayPlaying(PibersMod.BuddyAnimations[shootDirection][currentFrame]) then
			data.ShootDirection = nil
			if currentFrame == 1 then
				data.ShootDirection = shootDirection
			end
			sprite:PlayOverlay(PibersMod.BuddyAnimations[shootDirection][currentFrame], true)
		end
	end

end
PibersMod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, PibersMod.OnBuddyBoxRender, FamiliarVariant.BUDDY_IN_A_BOX)

PibersMod.FamiliarPoofScale = {}
PibersMod.FamiliarPoofScale[0] = {}
PibersMod.FamiliarPoofScale[0][0] = Vector(1.0,0.75)
PibersMod.FamiliarPoofColor = {}
PibersMod.FamiliarPoofColor[0] = {}
PibersMod.FamiliarPoofColor[0][0] = Color(0.5,0.4,0.4,0.4)
PibersMod.FamiliarPoofColor[FamiliarVariant.SACK_OF_PENNIES] = {}
PibersMod.FamiliarPoofColor[FamiliarVariant.SACK_OF_PENNIES][0] = Color(0.8,0.6,0.45,0.4)
PibersMod.FamiliarPoofColor[FamiliarVariant.LITTLE_CHAD] = {}
PibersMod.FamiliarPoofColor[FamiliarVariant.LITTLE_CHAD][0] = Color(0.6,0.2,0.2,0.4)
PibersMod.FamiliarPoofColor[FamiliarVariant.RELIC] = {}
PibersMod.FamiliarPoofColor[FamiliarVariant.RELIC][0] = Color(0.6,0.6,0.8,0.4)
PibersMod.FamiliarPoofBlacklist = {}
PibersMod.FamiliarPoofSpawnerOffset = Vector(0,-20)
function PibersMod:OnFamiliarUpdate(familiar)
	local doPoof = true
	if PibersMod.FamiliarPoofBlacklist[familiar.Variant] then
		if PibersMod.FamiliarPoofBlacklist[familiar.Variant][0] then
			doPoof = false
		end
		if PibersMod.FamiliarPoofBlacklist[familiar.Variant][familiar.SubType] then
			doPoof = false
		end
	end
	if doPoof then
		local sprite = familiar:GetSprite()
		if sprite:GetFrame() == 2 and (sprite:IsPlaying("Spawn") or sprite:IsPlaying("spawn")) then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, familiar.Position+PibersMod.PoofSpawnOffset, Vector.Zero, familiar)
			local poofSprite = poof:GetSprite()

			local scale = PibersMod.FamiliarPoofScale[0][0]
			if PibersMod.FamiliarPoofScale[familiar.Variant] then
				if PibersMod.FamiliarPoofScale[familiar.Variant][0] then
					scale = PibersMod.FamiliarPoofScale[familiar.Variant][0]
				end
				if PibersMod.FamiliarPoofScale[familiar.Variant][familiar.SubType] then
					scale = PibersMod.FamiliarPoofScale[familiar.Variant][familiar.SubType]
				end
			end

			local color = PibersMod.FamiliarPoofColor[0][0]
			if PibersMod.FamiliarPoofColor[familiar.Variant] then
				if PibersMod.FamiliarPoofColor[familiar.Variant][0] then
					color = PibersMod.FamiliarPoofColor[familiar.Variant][0]
				end
				if PibersMod.FamiliarPoofColor[familiar.Variant][familiar.SubType] then
					color = PibersMod.FamiliarPoofColor[familiar.Variant][familiar.SubType]
				end
			end

			poofSprite.Offset = PibersMod.FamiliarPoofSpawnerOffset
			poofSprite.Scale = scale
			poofSprite.Color = color
		end
		if sprite:GetFrame() == 10 and (sprite:IsPlaying("StompArm") or sprite:IsPlaying("StompLeg")) then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.GROUND_FOREGROUND, familiar.Position, Vector.Zero, familiar)
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnFamiliarUpdate)

function PibersMod:OnBloodDripFamiliarUpdate(familiar)
	local sprite = familiar:GetSprite()
	if not sprite:IsOverlayPlaying("Blood") then
		sprite:PlayOverlay("Blood", true)
		sprite:SetOverlayRenderPriority(true)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnBloodDripFamiliarUpdate, FamiliarVariant.CUBE_OF_MEAT_2)
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnBloodDripFamiliarUpdate, FamiliarVariant.CUBE_OF_MEAT_3)
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnBloodDripFamiliarUpdate, FamiliarVariant.CUBE_OF_MEAT_4)
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnBloodDripFamiliarUpdate, FamiliarVariant.PEEPER)
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnBloodDripFamiliarUpdate, FamiliarVariant.HEADLESS_BABY)
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnBloodDripFamiliarUpdate, FamiliarVariant.PEEPER_2)

function PibersMod:PreEntityTakeDMGVanillaItems(entity, amount, flags, source, cooldown)
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
PibersMod:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, PibersMod.PreEntityTakeDMGVanillaItems)

PibersMod.AnalogStickTears = 0.35
function PibersMod:OnEvaluateTearsUp(player, statStage, value)
	local effects = player:GetEffects()
	local valueMod = 0
	if player:HasCollectible(CollectibleType.COLLECTIBLE_ANALOG_STICK, false, false) then
		-- Remove innate Analog Stick's tears up, but make later pick ups of the item stackable
		valueMod = valueMod + ((PibersMod.AnalogStickTears * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ANALOG_STICK, true, true)) - PibersMod.AnalogStickTears)
	end
	if valueMod ~= 0 then
		return value + valueMod
	end
end
PibersMod:AddCallback(ModCallbacks.MC_EVALUATE_STAT, PibersMod.OnEvaluateTearsUp, EvaluateStatStage.TEARS_UP)

PibersMod.SpeedMin = 0.8 -- Minimum speed is now 0.8 instead of 0.2
function PibersMod:OnEvaluateSpeedMin(player, cacheFlag)
	-- Speed downs that go below 1 are less punishing
	local currSpeed = player.MoveSpeed
	if currSpeed < 1 then
		currSpeed = PibersMod.SpeedMin - ((currSpeed-0.2)*(PibersMod.SpeedMin-1))
		if currSpeed < PibersMod.SpeedMin then
			currSpeed = PibersMod.SpeedMin
		end
		player.MoveSpeed = currSpeed
	end
end
PibersMod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE, PibersMod.OnEvaluateSpeedMin, CacheFlag.CACHE_SPEED)

function PibersMod:OnEvaluateCritChance(player, cacheTag, value)
	--default crit chance - 1%
	value = 0.01
end
PibersMod:AddCallback(ModCallbacks.MC_EVALUATE_CUSTOM_CACHE, PibersMod.OnEvaluateCritChance, "critchance")

function PibersMod:OnEvaluateCritDamage(player, cacheTag, value)
	--default crit damage - 200%
	value = 2
end
PibersMod:AddCallback(ModCallbacks.MC_EVALUATE_CUSTOM_CACHE, PibersMod.OnEvaluateCritDamage, "critdamage")

PibersMod.HatCollectibles = {}
PibersMod.HatCollectibles[CollectibleType.COLLECTIBLE_MAGIC_8_BALL] = true
PibersMod.HatCollectibles[CollectibleType.COLLECTIBLE_CARD_READING] = true
function PibersMod:PostAddCollectible(collectibleID, charge, firstTime, slot, varData, player)
	if PibersMod.HatCollectibles[collectibleID] and player:GetPlayerType() == PlayerType.PLAYER_MAGDALENE then
		local effects = player:GetEffects()
		if not player:HasNullEffect(NullItemID.MAGGYS_HAIR_HAT) then
			player:AddNullEffect(NullItemID.MAGGYS_HAIR_HAT, true, 1)
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, PibersMod.PostAddCollectible)

PibersMod.InfestationColor = Color(1,1,0.5,1,0,0,0)
function PibersMod:PostAddCostume(itemconfigitem, player, itemstateonly)
	if itemconfigitem.ID == CollectibleType.COLLECTIBLE_INFESTATION then
		player.Color = PibersMod.InfestationColor
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PLAYER_ADD_COSTUME, PibersMod.PostAddCostume)

function PibersMod:PostRemoveCostume(itemconfigitem, player, itemstateonly)
	if itemconfigitem.ID == CollectibleType.COLLECTIBLE_INFESTATION then
		player.Color = Color.Default
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PLAYER_REMOVE_COSTUME, PibersMod.PostRemoveCostume)

PibersMod.IncubusShootToBrimstone = {
	ShootDown = "Shoot2Down",
	ShootSide = "Shoot2Side",
	ShootUp = "Shoot2Up",
	FloatShootDown = "Shoot2Down",
	FloatShootSide = "Shoot2Side",
	FloatShootUp = "Shoot2Up"
}
PibersMod.IncubusShootToBrimstoneFloat = {
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
function PibersMod:OnIncubusUpdate(incubus)
	local player = incubus.Player
	if player ~= nil and player:Exists() and player.Type == EntityType.ENTITY_PLAYER then
		if player:ToPlayer() then
			player = player:ToPlayer()
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then
				local data = PibersMod.GetData(incubus)
				local sprite = incubus:GetSprite()
				local foundAnim = nil
				for animationPlaying, animationShouldPlay in pairs(PibersMod.IncubusShootToBrimstone) do
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
						foundAnim = PibersMod.IncubusShootToBrimstoneFloat[data.BrimShootAnim]
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
PibersMod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, PibersMod.OnIncubusUpdate, FamiliarVariant.INCUBUS)

--[[
PibersMod.HudSlotSprite = {}
PibersMod.HudSlotSprite.Active = Sprite("gfx/ui/ui_slots.anm2", true)
PibersMod.HudSlotSprite.Active:Play("Active")
PibersMod.HudSlotSprite.ActiveOffset = Vector(20,22)
PibersMod.HudSlotSprite.ActiveOffsetSecondary = Vector(0,0)
function PibersMod:PreActiveRender(player, slot, offset, alpha, scale, chargebarOffset)
	PibersMod.HudSlotSprite.Active.Color = Color(1,1,1,alpha)
	PibersMod.HudSlotSprite.Active.Scale = Vector(scale,scale)
	local renderPos = Vector.Zero
	if slot == ActiveSlot.SLOT_PRIMARY then
		renderPos = PibersMod.GetScreenTopLeft() + PibersMod.HudSlotSprite.ActiveOffset
		PibersMod.HudSlotSprite.Active:Render(renderPos)
	elseif slot == ActiveSlot.SLOT_SECONDARY then
		renderPos = PibersMod.GetScreenTopLeft() + PibersMod.HudSlotSprite.ActiveOffsetSecondary
		PibersMod.HudSlotSprite.Active:Render(renderPos)
	else
		PibersMod.HudSlotSprite.Active:Render(renderPos)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_PLAYERHUD_RENDER_ACTIVE_ITEM, PibersMod.PreActiveRender)
]]

--[[
function PibersMod:PreRenderPlayerBody(player, offset)
	local game = Game()
	local room = game:GetRoom()
	if room:GetRenderMode() == RenderMode.RENDER_WATER_ABOVE and not player.CanFly then
		local water = room:GetWaterAmount()
		if water > 0 then
			local sprite = player:GetSprite()
			sprite:RenderLayer(1, offset, Vector.Zero, Vector(0,8+(water*2)))
			sprite:RenderLayer(2, offset, Vector.Zero, Vector(0,8+(water*2)))
			sprite:RenderLayer(3, offset, Vector.Zero, Vector(0,8+(water*2)))
			return false
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_RENDER_PLAYER_BODY, PibersMod.PreRenderPlayerBody)

function PibersMod:PreRenderWater()
	local game = Game()
	local room = game:GetRoom()
	if room:GetRenderMode() == RenderMode.RENDER_WATER_ABOVE then
		for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
			if not player.CanFly then
				local sprite = player:GetSprite()
				sprite:RenderLayer(1, Isaac.WorldToScreen(player.Position), Vector.Zero, Vector.Zero)
				sprite:RenderLayer(2, Isaac.WorldToScreen(player.Position), Vector.Zero, Vector.Zero)
				sprite:RenderLayer(3, Isaac.WorldToScreen(player.Position), Vector.Zero, Vector.Zero)
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_BACKDROP_RENDER_WATER, PibersMod.PreRenderWater)
]]
