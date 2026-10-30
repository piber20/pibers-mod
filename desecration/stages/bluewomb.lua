local mod = Desecration

mod.NumBlueWombRooms = 5
function mod.OnNewLevelBlueWomb()
	local game = Game()
	if not game:IsGreedMode() then
		local level = game:GetLevel()
		local stage = level:GetAbsoluteStage()
		if stage == LevelStage.STAGE4_3 then
			local rng = RNG(level:GetDungeonPlacementSeed())
			local minDifficulty = 1
			local maxDifficulty = 10
			local isHard = game:IsHardMode()
			if isHard then
				maxDifficulty = 15
			end
			local stbType = Isaac.GetCurrentStageConfigId()

			--try to get the hush boss room
			local bossroomDesc = level:GetRoomByIdx(GridRooms.ROOM_BLUEWOMB_BOSS_DESC_IDX, Dimension.NORMAL)
			local bossroomConfig = nil
			if bossroomDesc then
				bossroomConfig = bossroomDesc.Data
			end

			--make a large regular room to replace the original hush boss room
			local useSize = rng:RandomInt(1, RoomShape.NUM_ROOMSHAPES)
			if useSize > RoomShape.ROOMSHAPE_LBR or useSize == RoomShape.ROOMSHAPE_LBL or useSize == RoomShape.ROOMSHAPE_IIH or useSize == RoomShape.ROOMSHAPE_2x1 then
				useSize = RoomShape.ROOMSHAPE_2x2
			elseif useSize == RoomShape.ROOMSHAPE_IV or useSize == RoomShape.ROOMSHAPE_IH or useSize == RoomShape.ROOMSHAPE_1x1 then
				useSize = RoomShape.ROOMSHAPE_1x2
			end
			if isHard and rng:Next() % 8 ~= 0 then
				minDifficulty = 5
			end
			local replaceBossConfig = RoomConfig.GetRandomRoom(rng:Next(), true, stbType, RoomType.ROOM_DEFAULT, useSize, 2, -1, minDifficulty, maxDifficulty, DoorSlot.DOWN0 | DoorSlot.UP0)
			if not replaceBossConfig then
				useSize = RoomShape.ROOMSHAPE_1x2
				replaceBossConfig = RoomConfig.GetRandomRoom(rng:Next(), true, stbType, RoomType.ROOM_DEFAULT, useSize, 2, -1, minDifficulty, maxDifficulty, DoorSlot.DOWN0 | DoorSlot.UP0)
			end
			bossroomDesc.Data = replaceBossConfig
			minDifficulty = 1

			--make a bunch of random regular rooms
			local maxIndex = 60
			local numRooms = rng:RandomInt(mod.NumBlueWombRooms-1, mod.NumBlueWombRooms+1)
			for i=0, numRooms do
				mod.TryPlaceRandomRoom(-maxIndex, Dimension.NORMAL, rng, true, true, false, 2)
			end

			--replace the door to the boss room with a regular door
			local room = game:GetRoom()
			local bossDoor = room:GetDoor(DoorSlot.UP0)
			if bossDoor then
				bossDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_DEFAULT)
				bossDoor:SetLocked(false)
			end

			--place the hush boss room somewhere else
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

			local numSecrets = 1
			if PlayerManager.AnyoneHasTrinket(TrinketType.TRINKET_FRAGMENTED_CARD) then
				numSecrets = numSecrets+1
			end
			for i=1, numSecrets do
				if isHard and rng:Next() % 8 ~= 0 then
					minDifficulty = 5
				end
				local secretConfig = RoomConfig.GetRandomRoom(rng:Next(), false, stbType, RoomType.ROOM_SECRET, RoomShape.NUM_ROOMSHAPES, 0, -1, minDifficulty, maxDifficulty)
				if minDifficulty > 0 and not secretConfig then
					secretConfig = RoomConfig.GetRandomRoom(rng:Next(), false, stbType, RoomType.ROOM_SECRET, RoomShape.NUM_ROOMSHAPES, 0, -1, 0, maxDifficulty)
				end
				if not secretConfig then
					secretConfig = RoomConfig.GetRandomRoom(rng:Next(), false, StbType.SPECIAL_ROOMS, RoomType.ROOM_SECRET, RoomShape.NUM_ROOMSHAPES, 0, -1, minDifficulty, maxDifficulty)
					if minDifficulty > 0 and not secretConfig then
						secretConfig = RoomConfig.GetRandomRoom(rng:Next(), false, StbType.SPECIAL_ROOMS, RoomType.ROOM_SECRET, RoomShape.NUM_ROOMSHAPES, 0, -1, 0, maxDifficulty)
					end
				end
				minDifficulty = 1

				local validSecretGrids = level:FindValidRoomPlacementLocations(secretConfig, Dimension.NORMAL, true, true)
				local validSecretGrids1 = {}
				local validSecretGrids2 = {}
				local validSecretGrids3 = {}
				local validSecretGrids4 = {}
				for _,placementindex in ipairs(validSecretGrids) do
					if placementindex < maxIndex then
						local neighbors = level:GetNeighboringRooms(placementindex, secretConfig.Shape, Dimension.NORMAL)
						local numNeighbors = 0
						for doorslot,neighborDesc in pairs(neighbors) do
							local roomType = neighborDesc.Data.Type
							if roomType == RoomType.ROOM_SECRET or roomType == RoomType.ROOM_SUPERSECRET or roomType == RoomType.ROOM_ULTRASECRET or roomType == RoomType.ROOM_BOSS then
								numNeighbors = 0
								break
							end
							numNeighbors = numNeighbors+1
						end
						if numNeighbors >= 4 then
							validSecretGrids4[#validSecretGrids4+1] = placementindex
						elseif numNeighbors >= 3 then
							validSecretGrids3[#validSecretGrids3+1] = placementindex
						elseif numNeighbors >= 2 then
							validSecretGrids2[#validSecretGrids2+1] = placementindex
						elseif numNeighbors >= 1 then
							validSecretGrids1[#validSecretGrids1+1] = placementindex
						end
					end
				end

				local secretGrid = nil
				if #validSecretGrids4 > 0 then
					secretGrid = validSecretGrids4[rng:RandomInt(1, #validSecretGrids4)]
				elseif #validSecretGrids3 > 0 then
					secretGrid = validSecretGrids3[rng:RandomInt(1, #validSecretGrids3)]
				elseif #validSecretGrids2 > 0 then
					secretGrid = validSecretGrids2[rng:RandomInt(1, #validSecretGrids2)]
				elseif #validSecretGrids1 > 0 then
					secretGrid = validSecretGrids1[rng:RandomInt(1, #validSecretGrids1)]
				end
				if secretGrid then
					level:TryPlaceRoom(secretConfig, secretGrid, Dimension.NORMAL, rng:Next(), true, true, false)
				end
			end

			--update minimapapi
			if MinimapAPI then
				MinimapAPI:LoadDefaultMap()
				MinimapAPI:updatePlayerPos()
				MinimapAPI:UpdateExternalMap()
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnNewLevelBlueWomb)
