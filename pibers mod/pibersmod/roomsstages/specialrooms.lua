--[[
PibersMod.ArcadeMachines = {}
PibersMod.ArcadeMachines.UpLeft = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
PibersMod.ArcadeMachines.UpLeft:Play("upleft")
PibersMod.ArcadeMachines.UpMiddle = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
PibersMod.ArcadeMachines.UpMiddle:Play("upmiddle")
PibersMod.ArcadeMachines.LeftUp = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
PibersMod.ArcadeMachines.LeftUp:Play("leftup")
PibersMod.ArcadeMachines.LeftMiddle = Sprite("gfx/backdrop/0e_arcade_beta_machines.anm2", true)
PibersMod.ArcadeMachines.LeftMiddle:Play("leftmiddle")
PibersMod.ArcadeMachines.RenderPos = Vector(60,140)
]]

PibersModForceBackdropSubTypes = {}
PibersModForceBackdropSubTypes[101] = BackdropType.RUNEROOM_SECRET
function PibersMod:OnNewRoomSpecialRooms()
	local game = Game()
	local level = game:GetLevel()
	local roomDescriptor = level:GetCurrentRoomDesc()
	local roomConfigRoom = roomDescriptor.Data
	local floorSave = PibersMod.SaveManager.GetFloorSave()
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
		if PibersModForceBackdropSubTypes[entity.SubType] then
			room:SetBackdropType(PibersModForceBackdropSubTypes[entity.SubType], 1)
		else
			room:SetBackdropType(entity.SubType, 1)
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PibersMod.OnNewRoomSpecialRooms)

function PibersMod:OnIsPersistentRoomEntity(entType, entVariant)
	if entType == EntityType.ENTITY_EFFECT and entVariant == EffectVariant.PIBERSMOD_FORCEBACKDROP then
		return true
	end
end
PibersMod:AddCallback(ModCallbacks.MC_IS_PERSISTENT_ROOM_ENTITY, PibersMod.OnIsPersistentRoomEntity)

PibersMod.PoolsForRoom = {}
PibersMod.PoolsForRoom[RoomType.ROOM_ARCADE] = ItemPoolType.POOL_CRANE_GAME
PibersMod.PoolsForRoom[RoomType.ROOM_SACRIFICE] = ItemPoolType.SACRIFICE_ROOM
PibersMod.PoolsForRoom[RoomType.ROOM_DUNGEON] = ItemPoolType.CRAWLSPACE
PibersMod.PoolsForRoom[RoomType.ROOM_ISAACS] = ItemPoolType.ISAACS_ROOM
PibersMod.PoolsForRoom[RoomType.ROOM_BARREN] = ItemPoolType.BARREN_ROOM
PibersMod.PoolsForRoom[RoomType.ROOM_DICE] = ItemPoolType.DICE_ROOM
function PibersMod:PreNewRoom(room, roomDesc)
	local roomType = roomDesc.Data.Type
	if PibersMod.PoolsForRoom[roomType] then
		room:SetItemPool(PibersMod.PoolsForRoom[roomType])
	end
	local floorSave = PibersMod.SaveManager.GetFloorSave()
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
	PibersMod.LastGridState = {}
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_NEW_ROOM, PibersMod.PreNewRoom)
