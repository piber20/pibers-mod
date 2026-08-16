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

PibersMod.HatCollectibles = {}
PibersMod.HatCollectibles[CollectibleType.COLLECTIBLE_MAGIC_8_BALL] = true
PibersMod.HatCollectibles[CollectibleType.COLLECTIBLE_CARD_READING] = true
PibersMod.HatHairCostumes = {}
PibersMod.HatHairCostumes[PlayerType.PLAYER_MAGDALENE] = NullItemID.MAGGYS_HAIR_HAT
function PibersMod:PostAddHatCollectible(collectibleID, charge, firstTime, slot, varData, player)
	if PibersMod.HatCollectibles[collectibleID] and PibersMod.HatHairCostumes[player:GetPlayerType()] then
		local effects = player:GetEffects()
		if not player:HasNullEffect(PibersMod.HatHairCostumes[player:GetPlayerType()]) then
			player:AddNullEffect(PibersMod.HatHairCostumes[player:GetPlayerType()], true, 1)
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, PibersMod.PostAddHatCollectible)

PibersMod.ExtraCostumes = {}
PibersMod.ExtraCostumes[CollectibleType.COLLECTIBLE_PENTAGRAM] = CostumeID.PENTAGRAM_HORNS
function PibersMod:PostAddCostumeForExtras(itemconfig, player, itemstateonly)
	if PibersMod.ExtraCostumes[itemconfig.ID] then
		player:AddNullCostume(PibersMod.ExtraCostumes[itemconfig.ID])
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PLAYER_ADD_COSTUME, PibersMod.PostAddCostumeForExtras)

function PibersMod:PostRemoveCostumeForExtras(itemconfig, player, itemstateonly)
	if PibersMod.ExtraCostumes[itemconfig.ID] then
		player:TryRemoveNullCostume(PibersMod.ExtraCostumes[itemconfig.ID])
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PLAYER_REMOVE_COSTUME, PibersMod.PostRemoveCostumeForExtras)
