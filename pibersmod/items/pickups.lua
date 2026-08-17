local mod = PibersMod

function mod.PostPickupSelection(pickup, variant, subtype, requestedVariant, requestedSubType, rng)
	if requestedVariant == 0 or requestedSubType == 0 then
		if variant == PickupVariant.PICKUP_HEART then
			local blessingChance = 0.2

			if subtype == HeartSubType.HEART_SOUL or subtype == HeartSubType.HEART_HALF_SOUL or subtype == HeartSubType.HEART_BLACK or PlayerManager.AnyoneHasTrinket(TrinketType.TRINKET_WOODEN_CROSS) then
				blessingChance = blessingChance * 2
			end
			if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_HOLY_WATER) then
				blessingChance = blessingChance * 1.5
			end
			if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_HOLY_GRAIL) then
				blessingChance = blessingChance * 1.3
			end

			if blessingChance > 10 then
				blessingChance = 10
			end

			if rng:RandomInt(999)+1 <= math.floor(blessingChance*10) then
				return {PickupVariant.PICKUP_HEART, HeartSubType.BLESSING}
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, mod.PostPickupSelection)

function mod.PreHeartCollision(pickup, collider, low)
	if pickup:Exists() and collider:ToPlayer() and pickup.SubType == HeartSubType.BLESSING then
		local player = collider:ToPlayer()
		local sprite = pickup:GetSprite()
		local canPick = true
		if (sprite:IsPlaying("Appear") and not sprite:WasEventTriggered("DropSound")) or sprite:IsPlaying("Collect") then
			canPick = false
		end

		if sprite:IsPlaying("Collect") then
			pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
			pickup.Velocity = Vector.Zero
			return false
		end

		local isShopItem = pickup:IsShopItem()
		local price = 0
		if isShopItem then
			price = pickup.Price
			if player:GetNumCoins() < price then
				canPick = false
			end
		end

		if canPick then
			if pickup:IsShopItem() then
				local game = Game()
				local room = game:GetRoom()
				if price > 0 then
					player:AddCoins(-price)
				end
				if player:HasTrinket(TrinketType.TRINKET_STORE_CREDIT) then
					local isGold = player:HasGoldenTrinket(TrinketType.TRINKET_STORE_CREDIT)
					player:TryRemoveTrinket(TrinketType.TRINKET_STORE_CREDIT)
					if isGold then
						player:AddTrinket(TrinketType.TRINKET_STORE_CREDIT, false)
					end
				end
				if game:IsGreedMode() or PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_RESTOCK) then
					local roomSave = mod.SaveManager.GetRoomSave()
					local pickupData = {
						Variant = variant,
						SubType = subtype,
						Position = position,
						Price = price,
						Frame = Isaac.GetFrameCount(),
						RoomSeed = room:GetDecorationSeed(),
						DoPoof = true
					}
					roomSave.pickupToRestock = roomSave.pickupToRestock or {}
					roomSave.pickupToRestock[#roomSave.pickupToRestock+1] = pickupData
				end
				pickup:Remove()
			else
				pickup.Velocity = Vector.Zero
				pickup.Touched = true
				pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				sprite:Play("Collect", true)
				pickup:Die() --this will remove the pickup but let it continue playing the animation
			end
			player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM|UseFlag.USE_NOANNOUNCER)
			SFXManager():Play(SoundEffect.SOUND_HOLY, 1, 0, false, 1.25)
			return true
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.PreHeartCollision, PickupVariant.PICKUP_HEART)

function mod.CheckPickupRestock()
	local roomSave = mod.SaveManager.GetRoomSave()
	if roomSave.pickupToRestock and #roomSave.pickupToRestock >= 1 then
		for i=1, #roomSave.pickupToRestock do
			if roomSave.pickupToRestock[i] then
				if Isaac.GetFrameCount() >= roomSave.pickupToRestock[i].Frame + 60 then
					local game = Game()
					local rng = RNG(roomSave.pickupToRestock.RoomSeed)
					local position = roomSave.pickupToRestock[i].Position
					local respawnedPickup = game:Spawn(EntityType.ENTITY_PICKUP, roomSave.pickupToRestock[i].Variant or 0, position, Vector.Zero, nil, roomSave.pickupToRestock[i].SubType or 0, rng):ToPickup()
					if roomSave.pickupToRestock[i].DoPoof then
						game:Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, position, Vector.Zero, nil, 0, rng)
					end
					if respawnedPickup and respawnedPickup:Exists() then
						respawnedPickup.Price = roomSave.pickupToRestock[i].Price or 5
					end
					roomSave.pickupToRestock[i] = nil
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_UPDATE, mod.CheckPickupRestock)
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.CheckPickupRestock)
