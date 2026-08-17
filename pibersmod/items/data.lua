local mod = PibersMod

mod.ReplaceCollectibleWithOnDupe = {}
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KEY_PIECE_1] = CollectibleType.COLLECTIBLE_KEY_PIECE_2
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KEY_PIECE_2] = CollectibleType.COLLECTIBLE_KEY_PIECE_1
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KNIFE_PIECE_1] = CollectibleType.COLLECTIBLE_KNIFE_PIECE_2
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KNIFE_PIECE_2] = CollectibleType.COLLECTIBLE_KNIFE_PIECE_1
function mod.OnCollectibleInit(pickup)
	if mod.ReplaceCollectibleWithOnDupe[pickup.SubType] and PlayerManager.AnyoneHasCollectible(pickup.SubType) then
		pickup:Morph(pickup.Type, pickup.Variant, mod.ReplaceCollectibleWithOnDupe[pickup.SubType], true, true, true)
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.OnCollectibleInit, PickupVariant.PICKUP_COLLECTIBLE)

function mod.OnCollectibleUpdate(pickup)
	if pickup.FrameCount > 2 and mod.ReplaceCollectibleWithOnDupe[pickup.SubType] then
		if PlayerManager.AnyoneHasCollectible(pickup.SubType) and not PlayerManager.AnyoneHasCollectible(mod.ReplaceCollectibleWithOnDupe[pickup.SubType]) then
			pickup:Morph(pickup.Type, pickup.Variant, mod.ReplaceCollectibleWithOnDupe[pickup.SubType], true, true, true)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position-mod.PoofSpawnOffset, Vector.Zero, pickup)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnCollectibleUpdate, PickupVariant.PICKUP_COLLECTIBLE)

mod.ChargeDischargeSprites = {}
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_LEMON_MISHAP] = Sprite("gfx/ui/hud_lemonmishap.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_HOURGLASS] = Sprite("gfx/ui/hud_thehourglass.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_THE_NAIL] = Sprite("gfx/ui/hud_thenail.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_DECK_OF_CARDS] = Sprite("gfx/ui/hud_deckofcards.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_GAMEKID] = Sprite("gfx/ui/hud_thegamekid.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_MOMS_BOTTLE_OF_PILLS] = Sprite("gfx/ui/hud_momsbottleofpills.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_CANDLE] = Sprite("gfx/ui/hud_bluecandle.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_BOX_OF_SPIDERS] = Sprite("gfx/ui/hud_boxofspiders.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_RED_CANDLE] = Sprite("gfx/ui/hud_redcandle.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_ISAACS_TEARS] = Sprite("gfx/ui/hud_isaacstears.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_TEAR_DETONATOR] = Sprite("gfx/ui/hud_teardetonator.anm2", true)
mod.ChargeDischargeSprites[CollectibleType.COLLECTIBLE_FREE_LEMONADE] = Sprite("gfx/ui/hud_freelemonade.anm2", true)
mod.AnimDischargeSprites = {}
mod.AnimDischargeSprites[CollectibleType.COLLECTIBLE_YUM_HEART] = Sprite("gfx/ui/hud_yumheart.anm2", true)
mod.AnimDischargeSprites[CollectibleType.COLLECTIBLE_YUCK_HEART] = Sprite("gfx/ui/hud_yuckheart.anm2", true)
local lastFrame = 0
function mod.PreRenderActive(player, slot, offset, alpha, scale, chargebaroffset)
	local itemID = player:GetActiveItem(slot)
	if mod.AnimDischargeSprites[itemID] then
		local activeSprite = mod.AnimDischargeSprites[itemID]
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
	elseif mod.ChargeDischargeSprites[itemID] then
		local activeSprite = mod.ChargeDischargeSprites[itemID]
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
mod.AddCallback(ModCallbacks.MC_PRE_PLAYERHUD_RENDER_ACTIVE_ITEM, mod.PreRenderActive)

mod.FamiliarPoofScale = {}
mod.FamiliarPoofScale[0] = {}
mod.FamiliarPoofScale[0][0] = Vector(1.0,0.75)
mod.FamiliarPoofColor = {}
mod.FamiliarPoofColor[0] = {}
mod.FamiliarPoofColor[0][0] = Color(0.5,0.4,0.4,0.4)
mod.FamiliarPoofColor[FamiliarVariant.SACK_OF_PENNIES] = {}
mod.FamiliarPoofColor[FamiliarVariant.SACK_OF_PENNIES][0] = Color(0.8,0.6,0.45,0.4)
mod.FamiliarPoofColor[FamiliarVariant.LITTLE_CHAD] = {}
mod.FamiliarPoofColor[FamiliarVariant.LITTLE_CHAD][0] = Color(0.6,0.2,0.2,0.4)
mod.FamiliarPoofColor[FamiliarVariant.RELIC] = {}
mod.FamiliarPoofColor[FamiliarVariant.RELIC][0] = Color(0.6,0.6,0.8,0.4)
mod.FamiliarPoofBlacklist = {}
mod.FamiliarPoofSpawnerOffset = Vector(0,-20)
function mod.OnFamiliarUpdate(familiar)
	local doPoof = true
	if mod.FamiliarPoofBlacklist[familiar.Variant] then
		if mod.FamiliarPoofBlacklist[familiar.Variant][0] then
			doPoof = false
		end
		if mod.FamiliarPoofBlacklist[familiar.Variant][familiar.SubType] then
			doPoof = false
		end
	end
	if doPoof then
		local sprite = familiar:GetSprite()
		if sprite:GetFrame() == 2 and (sprite:IsPlaying("Spawn") or sprite:IsPlaying("spawn")) then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, familiar.Position+mod.PoofSpawnOffset, Vector.Zero, familiar)
			local poofSprite = poof:GetSprite()

			local scale = mod.FamiliarPoofScale[0][0]
			if mod.FamiliarPoofScale[familiar.Variant] then
				if mod.FamiliarPoofScale[familiar.Variant][0] then
					scale = mod.FamiliarPoofScale[familiar.Variant][0]
				end
				if mod.FamiliarPoofScale[familiar.Variant][familiar.SubType] then
					scale = mod.FamiliarPoofScale[familiar.Variant][familiar.SubType]
				end
			end

			local color = mod.FamiliarPoofColor[0][0]
			if mod.FamiliarPoofColor[familiar.Variant] then
				if mod.FamiliarPoofColor[familiar.Variant][0] then
					color = mod.FamiliarPoofColor[familiar.Variant][0]
				end
				if mod.FamiliarPoofColor[familiar.Variant][familiar.SubType] then
					color = mod.FamiliarPoofColor[familiar.Variant][familiar.SubType]
				end
			end

			poofSprite.Offset = mod.FamiliarPoofSpawnerOffset
			poofSprite.Scale = scale
			poofSprite.Color = color
		end
		if sprite:GetFrame() == 10 and (sprite:IsPlaying("StompArm") or sprite:IsPlaying("StompLeg")) then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.GROUND_FOREGROUND, familiar.Position, Vector.Zero, familiar)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnFamiliarUpdate)

function mod.OnBloodDripFamiliarUpdate(familiar)
	local sprite = familiar:GetSprite()
	if not sprite:IsOverlayPlaying("Blood") then
		sprite:PlayOverlay("Blood", true)
		sprite:SetOverlayRenderPriority(true)
	end
end
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnBloodDripFamiliarUpdate, FamiliarVariant.CUBE_OF_MEAT_2)
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnBloodDripFamiliarUpdate, FamiliarVariant.CUBE_OF_MEAT_3)
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnBloodDripFamiliarUpdate, FamiliarVariant.CUBE_OF_MEAT_4)
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnBloodDripFamiliarUpdate, FamiliarVariant.PEEPER)
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnBloodDripFamiliarUpdate, FamiliarVariant.HEADLESS_BABY)
mod.AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.OnBloodDripFamiliarUpdate, FamiliarVariant.PEEPER_2)

mod.HatCollectibles = {}
mod.HatCollectibles[CollectibleType.COLLECTIBLE_MAGIC_8_BALL] = true
mod.HatCollectibles[CollectibleType.COLLECTIBLE_CARD_READING] = true
mod.HatHairCostumes = {}
mod.HatHairCostumes[PlayerType.PLAYER_MAGDALENE] = NullItemID.MAGGYS_HAIR_HAT
function mod.PostAddHatCollectible(collectibleID, charge, firstTime, slot, varData, player)
	if mod.HatCollectibles[collectibleID] and mod.HatHairCostumes[player:GetPlayerType()] then
		local effects = player:GetEffects()
		if not player:HasNullEffect(mod.HatHairCostumes[player:GetPlayerType()]) then
			player:AddNullEffect(mod.HatHairCostumes[player:GetPlayerType()], true, 1)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.PostAddHatCollectible)

mod.ExtraCostumes = {}
mod.ExtraCostumes[CollectibleType.COLLECTIBLE_PENTAGRAM] = CostumeID.PENTAGRAM_HORNS
function mod.PostAddCostumeForExtras(itemconfig, player, itemstateonly)
	if mod.ExtraCostumes[itemconfig.ID] then
		player:AddNullCostume(mod.ExtraCostumes[itemconfig.ID])
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PLAYER_ADD_COSTUME, mod.PostAddCostumeForExtras)

function mod.PostRemoveCostumeForExtras(itemconfig, player, itemstateonly)
	if mod.ExtraCostumes[itemconfig.ID] then
		player:TryRemoveNullCostume(mod.ExtraCostumes[itemconfig.ID])
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PLAYER_REMOVE_COSTUME, mod.PostRemoveCostumeForExtras)
