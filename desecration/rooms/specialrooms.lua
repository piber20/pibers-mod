local mod = Desecration

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

mod.ForceBackdropSubTypes = {}
mod.ForceBackdropSubTypes[101] = BackdropType.RUNEROOM_SECRET
mod.ForceBackdropSubTypes[102] = BackdropType.BASEMENT_BOSS
mod.ForceBackdropSubTypes[103] = BackdropType.TEST
mod.ForceBackdropSubTypes[104] = BackdropType.BABY_SHOP
mod.ForceBackdropSubTypes[105] = BackdropType.ARCADE_BETA
mod.ForceBackdropSubTypes[106] = BackdropType.BLANK
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
	for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.DESECRATION_FORCEBACKDROP, -1, false, false)) do
		if mod.ForceBackdropSubTypes[entity.SubType] then
			room:SetBackdropType(mod.ForceBackdropSubTypes[entity.SubType], 1)
		else
			room:SetBackdropType(entity.SubType, 1)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomSpecialRooms)

function mod.OnIsPersistentRoomEntity(entType, entVariant)
	if entType == EntityType.ENTITY_EFFECT and entVariant == EffectVariant.DESECRATION_FORCEBACKDROP then
		return true
	end
end
mod.AddCallback(ModCallbacks.MC_IS_PERSISTENT_ROOM_ENTITY, mod.OnIsPersistentRoomEntity)
