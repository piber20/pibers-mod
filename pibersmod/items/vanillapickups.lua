local mod = PibersMod

function mod.OnCoinInit(pickup)
	if pickup.SubType == CoinSubType.COIN_STICKYNICKEL then
		local sprite, data = pickup:GetSprite(), mod.GetData(pickup)

		--spawn the effect
		local stickyEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PIBERSMOD, mod.Effects.STICKY_NICKEL_PUDDLE, pickup.Position, Vector.Zero, pickup)
		local stickySprite, stickyData = stickyEffect:GetSprite(), mod.GetData(stickyEffect)

		--get what animation to use
		local animation = "Idle"
		if sprite:IsPlaying("Appear") then
			animation = "Appear"
		end
		stickySprite:Play(animation, true)

		--set up the data
		data.WasStickyNickel = true
		stickyData.StickyNickel = pickup

		--make it render below most things
		stickyEffect.RenderZOffset = -10000
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.OnCoinInit, PickupVariant.PICKUP_COIN)

mod.PoofSpawnOffset = Vector(0,2)
mod.PickupPoofScale = {}
mod.PickupPoofScale[0] = {}
mod.PickupPoofScale[0][0] = Vector(1.0,0.75)
mod.PickupPoofColor = {}
mod.PickupPoofColor[0] = {}
mod.PickupPoofColor[0][0] = Color(0.5,0.4,0.4,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_HEART] = {}
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][0] = Color(0.6,0.2,0.2,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_SOUL] = Color(0.6,0.6,0.8,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_HALF_SOUL] = mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_SOUL]
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.BLESSING] = mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_SOUL]
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_ETERNAL] = Color(1.0,1.0,1.0,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_GOLDEN] = Color(0.8,0.6,0.45,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_BONE] = mod.PickupPoofColor[0][0]
mod.PickupPoofColor[PickupVariant.PICKUP_HEART][HeartSubType.HEART_ROTTEN] = Color(0.6,0.6,0.2,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_KEY] = {}
mod.PickupPoofColor[PickupVariant.PICKUP_KEY][KeySubType.KEY_GOLDEN] = Color(0.8,0.6,0.45,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_BOMB] = {}
mod.PickupPoofColor[PickupVariant.PICKUP_BOMB][BombSubType.BOMB_GOLDEN] = Color(0.8,0.6,0.45,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_LIL_BATTERY] = {}
mod.PickupPoofColor[PickupVariant.PICKUP_LIL_BATTERY][BatterySubType.BATTERY_GOLDEN] = Color(0.8,0.6,0.45,0.4)
mod.PickupPoofColor[PickupVariant.PICKUP_POOP] = {}
mod.PickupPoofColor[PickupVariant.PICKUP_POOP][0] = Color(0.6,0.5,0.0,0.4)
mod.PickupPoofBig = {}
mod.PickupPoofBig[PickupVariant.PICKUP_BOMB] = {}
mod.PickupPoofBig[PickupVariant.PICKUP_BOMB][BombSubType.BOMB_GIGA] = {}
mod.PickupPoofBlacklist = {}
mod.PickupPoofBlacklist[PickupVariant.PICKUP_COIN] = {}
mod.PickupPoofBlacklist[PickupVariant.PICKUP_COIN][0] = true
mod.PickupPoofBlacklist[PickupVariant.PICKUP_BIGCHEST] = {}
mod.PickupPoofBlacklist[PickupVariant.PICKUP_BIGCHEST][0] = true
mod.PickupPoofOffset = Vector(0,-2)
mod.PickupPoofChestOffset = Vector(0,-12)
function mod.PrePickupUpdate(pickup)
	local doPoof = true
	if mod.PickupPoofBlacklist[pickup.Variant] then
		if mod.PickupPoofBlacklist[pickup.Variant][0] then
			doPoof = false
		end
		if mod.PickupPoofBlacklist[pickup.Variant][pickup.SubType] then
			doPoof = false
		end
	end
	local sprite = pickup:GetSprite()
	if doPoof then
		if sprite:GetFrame() == 0 and (sprite:IsPlaying("Collect") or sprite:IsPlaying("collect")) then
			local useBig = false
			if mod.PickupPoofBig[pickup.Variant] then
				if mod.PickupPoofBig[pickup.Variant][0] then
					useBig = true
				end
				if mod.PickupPoofBig[pickup.Variant][pickup.SubType] then
					useBig = true
				end
			end
			local useSubType = Poof02Subtype.SMALL
			if useBig then
				useSubType = Poof02Subtype.LARGE
			end
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, useSubType, pickup.Position+mod.PoofSpawnOffset, Vector.Zero, pickup)
			local poofSprite = poof:GetSprite()

			local scale = mod.PickupPoofScale[0][0]
			if mod.PickupPoofScale[pickup.Variant] then
				if mod.PickupPoofScale[pickup.Variant][0] then
					scale = mod.PickupPoofScale[pickup.Variant][0]
				end
				if mod.PickupPoofScale[pickup.Variant][pickup.SubType] then
					scale = mod.PickupPoofScale[pickup.Variant][pickup.SubType]
				end
			end

			local color = mod.PickupPoofColor[0][0]
			if mod.PickupPoofColor[pickup.Variant] then
				if mod.PickupPoofColor[pickup.Variant][0] then
					color = mod.PickupPoofColor[pickup.Variant][0]
				end
				if mod.PickupPoofColor[pickup.Variant][pickup.SubType] then
					color = mod.PickupPoofColor[pickup.Variant][pickup.SubType]
				end
			end

			poofSprite.Offset = mod.PickupPoofOffset
			poofSprite.Scale = scale
			poofSprite.Color = color
		end
		if sprite:GetFrame() == 4 and (sprite:IsPlaying("Open") or sprite:IsPlaying("open")) then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.LARGE, pickup.Position+mod.PoofSpawnOffset, Vector.Zero, pickup)
			local poofSprite = poof:GetSprite()

			local scale = mod.PickupPoofScale[0][0]
			if mod.PickupPoofScale[pickup.Variant] then
				if mod.PickupPoofScale[pickup.Variant][0] then
					scale = mod.PickupPoofScale[pickup.Variant][0]
				end
				if mod.PickupPoofScale[pickup.Variant][pickup.SubType] then
					scale = mod.PickupPoofScale[pickup.Variant][pickup.SubType]
				end
			end

			local color = mod.PickupPoofColor[0][0]
			if mod.PickupPoofColor[pickup.Variant] then
				if mod.PickupPoofColor[pickup.Variant][0] then
					color = mod.PickupPoofColor[pickup.Variant][0]
				end
				if mod.PickupPoofColor[pickup.Variant][pickup.SubType] then
					color = mod.PickupPoofColor[pickup.Variant][pickup.SubType]
				end
			end

			poofSprite.Offset = mod.PickupPoofChestOffset
			poofSprite.Scale = scale
			poofSprite.Color = color
		end
	end
	if pickup.Variant == PickupVariant.PICKUP_BIGCHEST and sprite:IsPlaying("Appear") and sprite:IsEventTriggered("DropSound") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.GROUND_FOREGROUND, pickup.Position+mod.PoofSpawnOffset, Vector.Zero, pickup)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.PickupPoofChestOffset
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_PICKUP_UPDATE, mod.PrePickupUpdate)

function mod.OnCoinUpdate(pickup)
	local sprite, data = pickup:GetSprite(), mod.GetData(pickup)
	if pickup.SubType == CoinSubType.COIN_STICKYNICKEL then
		if sprite:IsPlaying("Touched") then
			sprite:Play("TouchedStick", true)
		end
	elseif data.WasStickyNickel then --check for our WasStickyNickel data
		data.WasStickyNickel = false
		sprite:Load("gfx/005.022_nickel.anm2", true) --revert nickel sprite to original
		sprite:Play("Idle", true)
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnCoinUpdate, PickupVariant.PICKUP_COIN)

mod.ModEffectRenderFuncs[mod.Effects.STICKY_NICKEL_PUDDLE] = function(effect,sprite,data)
	local removeEffect = true
	if data.StickyNickel then --check if StickyNickel isnt nil
		local coin = data.StickyNickel
		if coin:Exists() then --check if the nickel exists
			if coin.SubType == CoinSubType.COIN_STICKYNICKEL then --check if the nickel is sticky
				effect.Position = coin.Position --force our position to the nickel's position
				removeEffect = false --make sure we dont remove this effect
			end
		end
	end

	if removeEffect then --remove the effect
		if sprite:IsPlaying("Disappear") then
			if sprite:GetFrame() >= 44 then
				effect:Remove()
			end
		else
			sprite:Play("Disappear", true)
		end
	end
end

function mod.OnUpdateChest(pickup)
	local sprite = pickup:GetSprite()
	if sprite:IsPlaying("Appear") and sprite:GetFrame() == 1 then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_CHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_BOMBCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_SPIKEDCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_ETERNALCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_MIMICCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_OLDCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_WOODENCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_MEGACHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_HAUNTEDCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_LOCKEDCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_REDCHEST)
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateChest, PickupVariant.PICKUP_MOMSCHEST)

function mod.PreEntitySpawnRedKey(entType, entVariant, entSubType, pos, vel, spawner, seed)
	if entType == EntityType.ENTITY_PICKUP then
		local floorSave = mod.SaveManager.GetFloorSave()
		if entVariant == PickupVariant.PICKUP_COLLECTIBLE then
			if entSubType == CollectibleType.COLLECTIBLE_RED_KEY then
				floorSave.FoundRedKey = true
			end
		elseif entVariant == PickupVariant.PICKUP_TAROTCARD then
			if entSubType == Card.CARD_CRACKED_KEY then
				floorSave.FoundRedKey = true
			end
		end
		if not floorSave.FoundRedKey then
			local game = Game()
			local level = game:GetLevel()
			if level:GetStage() == LevelStage.STAGE8 and level:GetCurrentRoomIndex() == GridRooms.ROOM_HOME_RIGHTHALL_CLOSET_IDX then
				local gamedata = Isaac.GetPersistentGameData()
				if gamedata:Unlocked(Achievement.RED_KEY) then
					local canOpenOtherCloset = false
					for _,player in ipairs(PlayerManager.GetPlayers()) do
						if player:HasCollectible(CollectibleType.COLLECTIBLE_RED_KEY) or player:GetCard(1) == Card.CARD_CRACKED_KEY or player:GetCard(2) == Card.CARD_CRACKED_KEY or player:GetCard(3) == Card.CARD_CRACKED_KEY or player:GetCard(4) == Card.CARD_CRACKED_KEY then
							canOpenOtherCloset = true
							break
						end
					end
					if not canOpenOtherCloset then
						floorSave.FoundRedKey = true
						return {entType,PickupVariant.PICKUP_TAROTCARD,Card.CARD_CRACKED_KEY,seed}
					end
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.PreEntitySpawnRedKey)
