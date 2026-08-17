local mod = PibersMod

function mod.SetWoods()
	Isaac.SetCurrentFloorMusic(Music.MUSIC_BOSS_OVER_TWISTED)
	Isaac.SetCurrentFloorName("The Woods")
end

function mod.OnNewRoomHome()

	local game = Game()
	local room = game:GetRoom()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE8 then
		local roomDescriptor = level:GetCurrentRoomDesc()
		local roomConfigRoom = roomDescriptor.Data
		if roomConfigRoom.Subtype == 330 then
			room:SetBackdropType(BackdropType.CORPSE, 1) --placeholder (outside)
		elseif roomConfigRoom.Subtype == 331 or roomConfigRoom.Subtype == 333 then
			room:SetBackdropType(BackdropType.CORPSE2, 1) --placeholder (woods entrance and woods)
		elseif roomConfigRoom.Subtype == 332 then
			room:SetBackdropType(BackdropType.MINES, 1) --placeholder (kitchen)
		end
		local dimension = level:GetDimension()
		if MinimapAPI and dimension == Dimension.NORMAL then
			local isaacsroom = MinimapAPI:GetRoomByIdx(GridRooms.ROOM_HOME_ISAACSROOM_IDX)
			if isaacsroom then
				isaacsroom.PermanentIcons = {"IsaacsRoom"}
			end
			local momsroom = MinimapAPI:GetRoomByIdx(GridRooms.ROOM_HOME_MOMSROOM_IDX)
			if momsroom then
				momsroom.PermanentIcons = {"MomsBedroom"}
			end
		end
	end

	local backdropType = room:GetBackdropType()
	if backdropType == BackdropType.MOMS_BEDROOM then
		for doorSlot=0, DoorSlot.NUM_DOOR_SLOTS-1 do
			local door = room:GetDoor(doorSlot)
			if door then
				local doorSprite = door:GetSprite()
				if string.lower(doorSprite:GetFilename()) == "gfx/grid/door_house.anm2" then
					for layer=0,4 do
						doorSprite:ReplaceSpritesheet(layer, "gfx/grid/door_house_mom.png")
					end
					doorSprite:LoadGraphics()
				end
			end
		end
	end

end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomHome)

--[[
function mod.OnNewLevelHome()
	local game = Game()
	local isHard = game:IsHardMode()
	local isGreed = game:IsGreedMode()
	local level = game:GetLevel()
	local stage = level:GetAbsoluteStage()
	local truestage = level:GetStage()
	local stageType = level:GetStageType()
	local isAscent = level:IsAscent()
	if stage == LevelStage.STAGE8 then
		if level:GetDimension() == Dimension.MIRROR then
			mod.SetWoods()
		else
			local seed = level:GetDungeonPlacementSeed()
			local kitchenIdx = GridRooms.ROOM_HOME_LIVINGROOM_BOTTOM_IDX + 1
			local outsideIdx = GridRooms.ROOM_HOME_LIVINGROOM_BOTTOM_IDX + GridRooms.WIDTH
			local woodsIdx = outsideIdx + (GridRooms.WIDTH*2)
			local roomConfigKitchen = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 332)
			local roomConfigOutside = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 330)
			local roomConfigWoodsStart = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 331)
			level:TryPlaceRoom(roomConfigKitchen, kitchenIdx, Dimension.NORMAL, nil, true, true, true)
			level:TryPlaceRoom(roomConfigOutside, outsideIdx, Dimension.NORMAL, nil, true, true, true)
			level:TryPlaceRoom(roomConfigWoodsStart, woodsIdx, Dimension.NORMAL, nil, true, true, true)

			level:TryPlaceRoom(roomConfigWoodsStart, GridRooms.ROOM_STARTING_IDX, Dimension.MIRROR, nil, true, true, true)
			level:TryPlaceRoom(roomConfigWoodsStart, GridRooms.ROOM_STARTING_IDX+1, Dimension.MIRROR, nil, true, true, true)
			level:TryPlaceRoom(roomConfigWoodsStart, GridRooms.ROOM_STARTING_IDX-1, Dimension.MIRROR, nil, true, true, true)
			level:TryPlaceRoom(roomConfigWoodsStart, GridRooms.ROOM_STARTING_IDX+GridRooms.WIDTH, Dimension.MIRROR, nil, true, true, true)
			level:TryPlaceRoom(roomConfigWoodsStart, GridRooms.ROOM_STARTING_IDX-GridRooms.WIDTH, Dimension.MIRROR, nil, true, true, true)
			level:TryPlaceRoom(roomConfigWoodsStart, (GridRooms.ROOM_STARTING_IDX-GridRooms.WIDTH)-1, Dimension.MIRROR, nil, true, true, true)
			level:TryPlaceRoom(roomConfigWoodsStart, GridRooms.ROOM_STARTING_IDX-2, Dimension.MIRROR, nil, true, true, true)

			local roomConfigWoods1x1 = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 333)
			local roomConfigWoodsIH = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 334)
			local roomConfigWoodsIV = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 335)
			local roomConfigWoods1x2 = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 336)
			local roomConfigWoodsIIV = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 337)
			local roomConfigWoods2x1 = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 338)
			local roomConfigWoodsIIH = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 339)
			local roomConfigWoods2x2 = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 340)
			local roomConfigWoodsLTL = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 341)
			local roomConfigWoodsLTR = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 342)
			local roomConfigWoodsLBL = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 343)
			local roomConfigWoodsLBR = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, 344)
			local woodsrng = RNG(seed)
			for roomIndex=GridRooms.ROOM_FIRST_IDX, GridRooms.ROOM_LAST_IDX do
				if roomIndex <= GridRooms.WIDTH or roomIndex >= ((GridRooms.ROOM_LAST_IDX-GridRooms.WIDTH)-1) or roomIndex%GridRooms.WIDTH == 0 or roomIndex%GridRooms.WIDTH == 12 then
					level:TryPlaceRoom(roomConfigWoods1x1, roomIndex, Dimension.MIRROR, nil, true, true, true)
				end
			end
			for roomIndex=GridRooms.ROOM_FIRST_IDX, GridRooms.ROOM_LAST_IDX do
				if roomIndex > GridRooms.WIDTH and roomIndex < ((GridRooms.ROOM_LAST_IDX-GridRooms.WIDTH)-1) and roomIndex%GridRooms.WIDTH ~= 0 and roomIndex%GridRooms.WIDTH ~= 12 then
					local allowAltRoom = woodsrng:RandomInt(2)
					if allowAltRoom ~= 0 then
						local allowLRoom = woodsrng:RandomInt(8)
						if allowLRoom == 1 then
							local roomConfig = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, woodsrng:RandomInt(333,344))
							local newRoom = level:TryPlaceRoom(roomConfig, roomIndex, Dimension.MIRROR, nil, true, true, true)
						else
							local roomConfig = RoomConfig.GetRoomByStageTypeAndVariant(StbType.HOME, 1, woodsrng:RandomInt(333,340))
							local newRoom = level:TryPlaceRoom(roomConfig, roomIndex, Dimension.MIRROR, nil, true, true, true)
						end
					end
				end
				level:TryPlaceRoom(roomConfigWoods1x1, roomIndex, Dimension.MIRROR, nil, true, true, true)
			end
			if MinimapAPI then
				MinimapAPI:LoadDefaultMap()
				MinimapAPI:updatePlayerPos()
				MinimapAPI:UpdateExternalMap()
				local minimapRoom = MinimapAPI:GetRoomByIdx(GridRooms.ROOM_HOME_LIVINGROOM_IDX)
				if minimapRoom then
					minimapRoom.PermanentIcons = {"TV"}
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnNewLevelHome)
]]

function mod.PreChangeRoomHome(roomIndex, dimension)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE8 then
		local outsideIdx = GridRooms.ROOM_HOME_LIVINGROOM_BOTTOM_IDX + GridRooms.WIDTH
		local woodsIdx = outsideIdx + (GridRooms.WIDTH*2)
		if roomIndex == outsideIdx then
			MusicManager():Fadeout(0.01)
		end
		if roomIndex == woodsIdx and dimension ~= Dimension.MIRROR then
			mod.SetWoods()
			--MusicManager():Fadein(Music.MUSIC_BOSS_OVER_TWISTED, Options.MusicVolume)
			ItemOverlay.Show(Giantbook.CLICKER, 0)
			return {GridRooms.ROOM_STARTING_IDX, Dimension.MIRROR}
		end
		if dimension == Dimension.MIRROR and (roomIndex <= GridRooms.WIDTH or roomIndex >= ((GridRooms.ROOM_LAST_IDX-GridRooms.WIDTH)-1) or roomIndex%GridRooms.WIDTH == 0 or roomIndex%GridRooms.WIDTH == 12) then
			ItemOverlay.Show(Giantbook.CLICKER, 0)
			return {GridRooms.ROOM_STARTING_IDX, Dimension.MIRROR}
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, mod.PreChangeRoomHome)

function mod.PostSleepNightmareShow(giantbookID, player)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE8 then
		if MinimapAPI then
			local minimapRoom = MinimapAPI:GetRoomByIdx(GridRooms.ROOM_HOME_LIVINGROOM_IDX)
			if minimapRoom then
				minimapRoom.PermanentIcons = {"TVOn"}
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_ITEM_OVERLAY_SHOW, mod.PostSleepNightmareShow, Giantbook.SLEEP_NIGHTMARE)
