local mod = PibersMod

--[[
mod.ArcadeMachines = {}
mod.ArcadeMachines.UpLeft = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
mod.ArcadeMachines.UpLeft:Play("upleft")
mod.ArcadeMachines.UpMiddle = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
mod.ArcadeMachines.UpMiddle:Play("upmiddle")
mod.ArcadeMachines.LeftUp = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
mod.ArcadeMachines.LeftUp:Play("leftup")
mod.ArcadeMachines.LeftMiddle = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
mod.ArcadeMachines.LeftMiddle:Play("leftmiddle")
mod.ArcadeMachines.RenderPos = Vector(60,140)
]]

modForceBackdropSubTypes = {}
modForceBackdropSubTypes[101] = BackdropType.RUNEROOM_SECRET
function mod.OnNewRoomSpecialRooms()
	local game = Game()
	local level = game:GetLevel()
	local roomDescriptor = level:GetCurrentRoomDesc()
	local roomConfigRoom = roomDescriptor.Data
	local floorSave = mod.SaveManager.GetFloorSave()
	if MinimapAPI then
		local dimension = level:GetDimension()
		local rooms = level:GetRooms()
		for i=0, rooms.Size-1 do
			local roomDesc = rooms:Get(i)
			if roomDesc:GetDimension() == dimension and roomDesc.Data.Type == RoomType.ROOM_SHOP then
				local minimapRoom = MinimapAPI:GetRoomByIdx(roomDesc.GridIndex)
				if minimapRoom then
					floorSave.babyshops = floorSave.babyshops or {}
					if floorSave.babyshops[roomDesc.GridIndex] or (PlayerManager.AnyoneHasTrinket(TrinketType.TRINKET_ADOPTION_PAPERS) and roomDesc.VisitedCount <= 0) then
						if minimapRoom.PermanentIcons ~= "BabyShop" then
							minimapRoom.PermanentIcons = {"BabyShop"}
						end
					else
						if minimapRoom.PermanentIcons ~= "Shop" then
							minimapRoom.PermanentIcons = {"Shop"}
						end
					end
				end
			end
		end
	end
	local room = game:GetRoom()
	if roomConfigRoom.Type == RoomType.ROOM_SUPERSECRET and roomConfigRoom.Subtype == BackdropType.DARKROOM then
		if game:IsGreedMode() then
			if roomConfigRoom.Variant == 12 then --vanilla
				room:SetBackdropType(BackdropType.RUNEROOM_SECRET, 1)
			end
		else
			if roomConfigRoom.Variant == 7 --vanilla
			or roomConfigRoom.Variant == 24001 then --restored monsters
				room:SetBackdropType(BackdropType.RUNEROOM_SECRET, 1)
			end
		end
	end
	local backdropType = room:GetBackdropType()
	if roomConfigRoom.Type == RoomType.ROOM_BOSS and backdropType == BackdropType.BASEMENT then
		room:SetBackdropType(BackdropType.BASEMENT_BOSS, 1)
	end
	if roomConfigRoom.Type == RoomType.ROOM_SECRET_EXIT and backdropType == BackdropType.SECRET then
		room:SetBackdropType(BackdropType.MINES_ENTRANCE, 1)
	end
	floorSave.babyshops = floorSave.babyshops or {}
	if roomConfigRoom.Type == RoomType.ROOM_SHOP and floorSave.babyshops[roomDescriptor.GridIndex] then
		room:SetBackdropType(BackdropType.BABY_SHOP, 1)
	end
	for _, entity in pairs(Isaac.FindByType(EntityType.EFFECT_PROXY, -1, -1, false, false)) do
		game:Spawn(EntityType.ENTITY_EFFECT, entity.Variant, entity.Position, entity.Velocity, entity.SpawnerEntity, entity.SubType, entity.InitSeed)
		entity:Remove()
	end
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PIBERSMOD_FORCEBACKDROP, -1, false, false)) do
		if modForceBackdropSubTypes[entity.SubType] then
			room:SetBackdropType(modForceBackdropSubTypes[entity.SubType], 1)
		else
			room:SetBackdropType(entity.SubType, 1)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomSpecialRooms)

function mod.OnIsPersistentRoomEntity(entType, entVariant)
	if entType == EntityType.ENTITY_EFFECT and entVariant == EffectVariant.PIBERSMOD_FORCEBACKDROP then
		return true
	end
end
mod.AddCallback(ModCallbacks.MC_IS_PERSISTENT_ROOM_ENTITY, mod.OnIsPersistentRoomEntity)

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

function mod.PreGetCollectiblePlanetarium(itempoolType, decrease, seed)
	if itempoolType == ItemPoolType.POOL_PLANETARIUM then
		local floorSave = mod.SaveManager.GetFloorSave()
		floorSave.PlanetariumItemsGenerated = floorSave.PlanetariumItemsGenerated or 0
		floorSave.PlanetariumItemsGenerated = floorSave.PlanetariumItemsGenerated+1
		if floorSave.PlanetariumItemsGenerated > 1 then
			local itempool = Game():GetItemPool()
			return itempool:GetCollectible(ItemPoolType.PLANETARIUM_BLOATED, true, seed)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.PreGetCollectiblePlanetarium)

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
