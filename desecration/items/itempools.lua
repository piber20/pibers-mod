local mod = Desecration

mod.ReplaceCollectibleWithOnDupe = {}
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KEY_PIECE_1] = CollectibleType.COLLECTIBLE_KEY_PIECE_2
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KEY_PIECE_2] = CollectibleType.COLLECTIBLE_KEY_PIECE_1
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KNIFE_PIECE_1] = CollectibleType.COLLECTIBLE_KNIFE_PIECE_2
mod.ReplaceCollectibleWithOnDupe[CollectibleType.COLLECTIBLE_KNIFE_PIECE_2] = CollectibleType.COLLECTIBLE_KNIFE_PIECE_1
mod.ItemsAddedToPool = {}
mod.ItemsRemovedFromPool = {}
function mod.OnCollectibleInit(pickup)
	if mod.ReplaceCollectibleWithOnDupe[pickup.SubType] and PlayerManager.AnyoneHasCollectible(pickup.SubType) then
		pickup:Morph(pickup.Type, pickup.Variant, mod.ReplaceCollectibleWithOnDupe[pickup.SubType], true, true, true)
	elseif mod.ItemsRemovedFromPool[-1] and mod.ItemsRemovedFromPool[-1][pickup.SubType] then
		pickup:Morph(pickup.Type, pickup.Variant, 0, true, true, true)
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

function mod.AddModItemToPool(collID, poolID, weight)
	if itemID and itemID > 0 and poolID and poolID > 0 then
		if mod.ItemsRemovedFromPool[poolID] and mod.ItemsAddedToPool[poolID][collID] then
			mod.ItemsRemovedFromPool[poolID][collID] = nil
		else
			weight = weight or 1.0
			local game = Game()
			local itemPool = game:GetItemPool()
			mod.ItemsAddedToPool[poolID] = mod.ItemsAddedToPool[poolID] or {}
			mod.ItemsAddedToPool[poolID][collID] = {itemID=collID,weight=weight,decreaseBy=0.5,removeOn=0.1}
			itemPool:AddCollectible(poolID, mod.ItemsAddedToPool[poolID][collID])
		end
	end
end
function mod.RemoveModItemFromPool(collID, poolID)
	if itemID and itemID > 0 then
		if not poolID then
			poolID = -1
		end
		if mod.ItemsAddedToPool[poolID] and mod.ItemsAddedToPool[poolID][collID] then
			mod.ItemsAddedToPool[poolID][collID].weight = 0
		else
			mod.ItemsRemovedFromPool[poolID] = mod.ItemsRemovedFromPool[poolID] or {}
			mod.ItemsRemovedFromPool[poolID][collID] = true
		end
	end
end
function mod.BanItem(collID)
	mod.RemoveModItemFromPool(collID, -1)
end

mod.BanItem(CollectibleType.COLLECTIBLE_ANALOG_STICK)
mod.BanItem(CollectibleType.COLLECTIBLE_MARKED)
mod.BanItem(CollectibleType.COLLECTIBLE_FAST_BOMBS)

function mod.OnGetCollectible(itemID, poolID, decrease, seed)
	local game = Game()
	local itemPool = game:GetItemPool()
	--[[
	local lastPool = itemPool:GetLastPool()
	if not lastPool then
		lastPool = poolID
	end
	]]
	if (mod.ItemsRemovedFromPool[-1] and mod.ItemsRemovedFromPool[-1][itemID]) or (mod.ItemsRemovedFromPool[poolID] and mod.ItemsRemovedFromPool[poolID][itemID]) then
		local attempts = 0
		while attempts < 100 do
			local newID = itemPool:GetCollectible(poolID, decrease, seed+attempts)
			if newID and newID ~= itemID then
				return newID
			end
			attempts = attempts + 1
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_GET_COLLECTIBLE, mod.OnGetCollectible)

mod.PoolsForRoom = {}
mod.PoolsForRoom[RoomType.ROOM_ARCADE] = ItemPoolType.POOL_CRANE_GAME
mod.PoolsForRoom[RoomType.ROOM_SACRIFICE] = ItemPoolType.SACRIFICE_ROOM
mod.PoolsForRoom[RoomType.ROOM_DUNGEON] = ItemPoolType.CRAWLSPACE
mod.PoolsForRoom[RoomType.ROOM_ISAACS] = ItemPoolType.ISAACS_ROOM
mod.PoolsForRoom[RoomType.ROOM_BARREN] = ItemPoolType.BARREN_ROOM
mod.PoolsForRoom[RoomType.ROOM_DICE] = ItemPoolType.DICE_ROOM
mod.PoolsForBoss = {}
mod.PoolsForMiniboss = {}
mod.PoolsForMiniboss[RoomSubType.MINIBOSS_KRAMPUS] = ItemPoolType.KRAMPUS
mod.PoolsForStageTreasure = {}
mod.PoolsForStageTreasure[StbType.BASEMENT] = ItemPoolType.TREASURE_BASEMENT
mod.PoolsForStageTreasure[StbType.CELLAR] = ItemPoolType.TREASURE_CELLAR
mod.PoolsForStageTreasure[StbType.BURNING_BASEMENT] = ItemPoolType.TREASURE_BURNINGBASEMENT
mod.PoolsForStageTreasure[StbType.CAVES] = ItemPoolType.TREASURE_CAVES
mod.PoolsForStageTreasure[StbType.CATACOMBS] = ItemPoolType.TREASURE_CATACOMBS
mod.PoolsForStageTreasure[StbType.FLOODED_CAVES] = ItemPoolType.TREASURE_FLOODEDCAVES
mod.PoolsForStageTreasure[StbType.DEPTHS] = ItemPoolType.TREASURE_DEPTHS
mod.PoolsForStageTreasure[StbType.NECROPOLIS] = ItemPoolType.TREASURE_NECROPOLIS
mod.PoolsForStageTreasure[StbType.DANK_DEPTHS] = ItemPoolType.TREASURE_DANKDEPTHS
mod.PoolsForStageTreasure[StbType.WOMB] = ItemPoolType.TREASURE_WOMB
mod.PoolsForStageTreasure[StbType.UTERO] = ItemPoolType.TREASURE_UTERO
mod.PoolsForStageTreasure[StbType.SCARRED_WOMB] = ItemPoolType.TREASURE_SCARREDWOMB
mod.PoolsForStageTreasure[StbType.BLUE_WOMB] = ItemPoolType.TREASURE_BLUEWOMB
mod.PoolsForStageTreasure[StbType.SHEOL] = ItemPoolType.TREASURE_SHEOL
mod.PoolsForStageTreasure[StbType.CATHEDRAL] = ItemPoolType.TREASURE_CATHEDRAL
mod.PoolsForStageTreasure[StbType.DARK_ROOM] = ItemPoolType.TREASURE_DARKROOM
mod.PoolsForStageTreasure[StbType.CHEST] = ItemPoolType.TREASURE_CHEST
mod.PoolsForStageTreasure[StbType.DOWNPOUR] = ItemPoolType.TREASURE_DOWNPOUR
mod.PoolsForStageTreasure[StbType.DROSS] = ItemPoolType.TREASURE_DROSS
mod.PoolsForStageTreasure[StbType.MINES] = ItemPoolType.TREASURE_MINES
mod.PoolsForStageTreasure[StbType.ASHPIT] = ItemPoolType.TREASURE_ASHPIT
mod.PoolsForStageTreasure[StbType.MAUSOLEUM] = ItemPoolType.TREASURE_MAUSOLEUM
mod.PoolsForStageTreasure[StbType.GEHENNA] = ItemPoolType.TREASURE_GEHENNA
mod.PoolsForStageTreasure[StbType.CORPSE] = ItemPoolType.TREASURE_CORPSE
function mod.PreNewRoom(room, roomDesc)
	local roomConfig = roomDesc.Data
	local roomType = roomConfig.Type
	local roomSubtype = roomConfig.Subtype
	if roomType == RoomType.ROOM_BOSS and mod.PoolsForBoss[roomSubtype]  then
		room:SetItemPool(mod.PoolsForBoss[roomSubtype])
	elseif roomType == RoomType.ROOM_MINIBOSS and mod.PoolsForMiniboss[roomSubtype] then
		room:SetItemPool(mod.PoolsForMiniboss[roomSubtype])
	elseif mod.PoolsForRoom[roomType] then
		room:SetItemPool(mod.PoolsForRoom[roomType])
	end

	local floorSave = mod.SaveManager.GetFloorSave()
	floorSave.babyshops = floorSave.babyshops or {}
	if roomType == RoomType.ROOM_SHOP then
		if floorSave.babyshops[roomDesc.GridIndex] then
			room:SetItemPool(ItemPoolType.POOL_BABY_SHOP)
		elseif roomDesc.VisitedCount <= 0 then
			if PlayerManager.AnyoneHasTrinket(TrinketType.TRINKET_ADOPTION_PAPERS) then
				floorSave.babyshops[roomDesc.GridIndex] = true
				room:SetItemPool(ItemPoolType.POOL_BABY_SHOP)
			else
				floorSave.babyshops[roomDesc.GridIndex] = false
			end
		end
	end
	mod.LastGridState = {}
end
mod.AddCallback(ModCallbacks.MC_PRE_NEW_ROOM, mod.PreNewRoom)

mod.StagePoolChance = 0.1
function mod.PreGetCollectibleItemPools(itempoolType, decrease, seed)
	if itempoolType == ItemPoolType.POOL_TREASURE then
		if mod.PoolsForStageTreasure[Isaac.GetCurrentStageConfigId()] and RNG(seed):RandomFloat() < mod.StagePoolChance then
			local itempool = Game():GetItemPool()
			return itempool:GetCollectible(mod.PoolsForStageTreasure[Isaac.GetCurrentStageConfigId()], decrease, seed)
		end
	elseif itempoolType == ItemPoolType.POOL_PLANETARIUM then
		local floorSave = mod.SaveManager.GetFloorSave()
		floorSave.PlanetariumItemsGenerated = floorSave.PlanetariumItemsGenerated or 0
		floorSave.PlanetariumItemsGenerated = floorSave.PlanetariumItemsGenerated+1
		if floorSave.PlanetariumItemsGenerated > 1 then
			local itempool = Game():GetItemPool()
			return itempool:GetCollectible(ItemPoolType.PLANETARIUM_BLOATED, decrease, seed)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.PreGetCollectibleItemPools)

function mod.GetBossThematicItem(spawned, itemid, trinketid)
	if spawned and itemid > 0 and trinketid == 0 then
		local game = Game()
		local level = game:GetLevel()
		local roomDesc = level:GetCurrentRoomDesc()
		local roomConfig = roomDesc.Data
		local roomType = roomConfig.Type
		local roomSubtype = roomConfig.Subtype
		if roomType == RoomType.ROOM_BOSS and mod.PoolsForBoss[roomSubtype] then
			local itempool = game:GetItemPool()
			return {Collectible=itempool:GetCollectible(mod.PoolsForBoss[roomSubtype], true, roomDesc.AwardSeed)}
		elseif roomType == RoomType.ROOM_MINIBOSS and mod.PoolsForMiniboss[roomSubtype] then
			local itempool = game:GetItemPool()
			return {Collectible=itempool:GetCollectible(mod.PoolsForMiniboss[roomSubtype], true, roomDesc.AwardSeed)}
		end
	end
end
mod.AddCallback(ModCallbacks.MC_GET_BOSS_THEMATIC_ITEM, mod.GetBossThematicItem)

function mod.OnCollectibleInitBossDrop(pickup)
	if pickup.SubType == CollectibleType.COLLECTIBLE_LUMP_OF_COAL or pickup.SubType == CollectibleType.COLLECTIBLE_HEAD_OF_KRAMPUS then
		local game = Game()
		local level = game:GetLevel()
		local roomDesc = level:GetCurrentRoomDesc()
		local roomConfig = roomDesc.Data
		local roomType = roomConfig.Type
		local roomSubtype = roomConfig.Subtype
		if roomType == RoomType.ROOM_MINIBOSS and roomSubtype == RoomSubType.MINIBOSS_KRAMPUS then
			local floorSave = mod.SaveManager.GetFloorSave()
			if not floorSave.ReplacedKrampusDrop then
				floorSave.ReplacedKrampusDrop = true
				local itempool = game:GetItemPool()
				local newID = itempool:GetCollectible(ItemPoolType.KRAMPUS, true, roomDesc.AwardSeed, CollectibleType.COLLECTIBLE_LUMP_OF_COAL)
				pickup:Morph(pickup.Type, pickup.Variant, newID, true, true, true)
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.OnCollectibleInitBossDrop, PickupVariant.PICKUP_COLLECTIBLE)

