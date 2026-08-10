function PibersMod:OnNewLevelBlueWomb()
	local game = Game()
	local isGreed = game:IsGreedMode()
	if not isGreed then
		local level = game:GetLevel()
		local stage = level:GetAbsoluteStage()
		if stage == LevelStage.STAGE4_3 then
			local bossroomDesc = level:GetRoomByIdx(GridRooms.ROOM_BLUEWOMB_BOSS_DESC_IDX, Dimension.NORMAL)
			local bossroomConfig = nil
			if bossroomDesc then
				bossroomConfig = bossroomDesc.Data
			end
			local minDifficulty = 1
			local maxDifficulty = 10
			local isHard = game:IsHardMode()
			local rng = RNG(level:GetDungeonPlacementSeed())
			if isHard then
				if rng:Next() % 8 == 0 then
					minDifficulty = 1
				else
					minDifficulty = 2
				end
				maxDifficulty = 15
			end
			local stbType = Isaac.GetCurrentStageConfigId()
			if not bossroomConfig then
				bossroomConfig = RoomConfig.GetRandomRoom(rng:Next(), false, stbType, RoomType.ROOM_BOSS, RoomShape.NUM_ROOMSHAPES, 0, -1, minDifficulty, maxDifficulty, 0, BossType.HUSH)
				if minDifficulty > 0 and not bossroomConfig then
					bossroomConfig = RoomConfig.GetRandomRoom(rng:Next(), false, stbType, RoomType.ROOM_BOSS, RoomShape.NUM_ROOMSHAPES, 0, -1, 0, maxDifficulty, 0, BossType.HUSH)
				end
				if not bossroomConfig then
					bossroomConfig = RoomConfig.GetRandomRoom(rng:Next(), false, StbType.SPECIAL_ROOMS, RoomType.ROOM_BOSS, RoomShape.NUM_ROOMSHAPES, 0, -1, minDifficulty, maxDifficulty, 0, BossType.HUSH)
					if minDifficulty > 0 and not bossroomConfig then
						bossroomConfig = RoomConfig.GetRandomRoom(rng:Next(), false, StbType.SPECIAL_ROOMS, RoomType.ROOM_BOSS, RoomShape.NUM_ROOMSHAPES, 0, -1, 0, maxDifficulty, 0, BossType.HUSH)
					end
				end
			end
			local useSize = rng:RandomInt(1, RoomShape.NUM_ROOMSHAPES)
			if useSize > RoomShape.ROOMSHAPE_LBR or useSize == RoomShape.ROOMSHAPE_LBL or useSize == RoomShape.ROOMSHAPE_IIH or useSize == RoomShape.ROOMSHAPE_2x1 then
				useSize = RoomShape.ROOMSHAPE_2x2
			elseif useSize == RoomShape.ROOMSHAPE_IV or useSize == RoomShape.ROOMSHAPE_IH or useSize == RoomShape.ROOMSHAPE_1x1 then
				useSize = RoomShape.ROOMSHAPE_1x2
			end
			local replaceBossConfig = RoomConfig.GetRandomRoom(rng:Next(), true, stbType, RoomType.ROOM_DEFAULT, useSize, 2, -1, minDifficulty, maxDifficulty, DoorSlot.DOWN0 | DoorSlot.UP0)
			if not replaceBossConfig then
				useSize = RoomShape.ROOMSHAPE_1x2
				replaceBossConfig = RoomConfig.GetRandomRoom(rng:Next(), true, stbType, RoomType.ROOM_DEFAULT, useSize, 2, -1, minDifficulty, maxDifficulty, DoorSlot.DOWN0 | DoorSlot.UP0)
			end
			bossroomDesc.Data = replaceBossConfig
			local numRooms = rng:RandomInt(4, 5)
			for i=0, numRooms do
				PibersMod:TryPlaceRandomRoom(-60, Dimension.NORMAL, rng, true, true, false, 2)
			end
			local room = game:GetRoom()
			local bossDoor = room:GetDoor(DoorSlot.UP0)
			if bossDoor then
				bossDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_DEFAULT)
				bossDoor:SetLocked(false)
			end
			local validBossGrids = level:FindValidRoomPlacementLocations(bossroomConfig, Dimension.NORMAL, false, false)
			if #validBossGrids > 0 then
				local topmostRow = 13
				local topmostRowIndexes = {}
				for _,otherindex in ipairs(validBossGrids) do
					local row = math.floor(otherindex/GridRooms.WIDTH)
					if row < topmostRow then
						topmostRow = row
						topmostRowIndexes = {}
					end
					topmostRowIndexes[#topmostRowIndexes+1] = otherindex
				end
				if #topmostRowIndexes > 0 then
					local useGrid = topmostRowIndexes[rng:RandomInt(1, #topmostRowIndexes)]
					level:TryPlaceRoom(bossroomConfig, useGrid, Dimension.NORMAL, rng:Next(), false, false, false)
				else
					local useGrid = validBossGrids[rng:RandomInt(1, #validBossGrids)]
					level:TryPlaceRoom(bossroomConfig, useGrid, Dimension.NORMAL, rng:Next(), false, false, false)
				end
			end
			if MinimapAPI then
				MinimapAPI:LoadDefaultMap()
				MinimapAPI:updatePlayerPos()
				MinimapAPI:UpdateExternalMap()
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, PibersMod.OnNewLevelBlueWomb)
