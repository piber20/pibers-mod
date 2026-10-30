local mod = Desecration

mod.NumVoidRooms = 10
function mod.OnNewLevelVoid()
	local game = Game()
	if not game:IsGreedMode() then
		local level = game:GetLevel()
		local stage = level:GetAbsoluteStage()
		if stage == LevelStage.STAGE7 then
			local rng = RNG(level:GetDungeonPlacementSeed())

			--save some of the already made rooms for our new floor
			local rooms = level:GetRooms()
			local dif15rooms = {}
			local dif20rooms = {}
			local startingroom = nil
			local bossroom = nil
			local secretConfig = nil
			local secretConfig2 = nil
			for i=0, rooms.Size-1 do
				local roomDesc = rooms:Get(i)
				local roomData = roomDesc.Data
				if roomDesc.GridIndex == GridRooms.ROOM_STARTING_IDX then
					startingroom = roomData
				elseif roomData.Type == RoomType.ROOM_BOSS then
					if roomData.Subtype == BossType.DELIRIUM then
						bossroom = roomData
					end
				elseif roomData.Type == RoomType.ROOM_SECRET then
					if not secretConfig then
						secretConfig = roomData
					else
						secretConfig2 = roomData
					end
				elseif roomData.Difficulty >= 20 then
					dif20rooms[#dif20rooms+1] = roomData
				elseif roomData.Difficulty >= 15 then --intentially making this >= 15 and not == 15, for void exclusive easier rooms at 19 or less
					dif15rooms[#dif15rooms+1] = roomData
				end
			end

			--get num rooms
			local halfnum = mod.NumVoidRooms/2
			local numEasyRooms = rng:RandomInt(halfnum+1, halfnum+3)
			local numHardRooms = rng:RandomInt(halfnum-3, halfnum-1)
			if game:IsHardMode() then
				numEasyRooms = numEasyRooms - 2
				numHardRooms = numHardRooms + 2
			end

			--place the starting room
			level:TryPlaceRoom(startingroom, GridRooms.ROOM_STARTING_IDX, Dimension.MIRROR, rng:Next(), true, true, true)

			--place some random rooms
			local easyPlaced = 0
			local hardPlaced = 0
			for i=0, numEasyRooms+numHardRooms do
				local doHard = false
				if easyPlaced < numEasyRooms and hardPlaced < numHardRooms then
					if rng:RandomInt(1,2) == 2 then
						doHard = true
					end
				elseif hardPlaced < numHardRooms then
					doHard = true
				end
				if doHard then
					if hardPlaced < #dif20rooms then
						mod.TryPlaceRoom(dif20rooms[hardPlaced+1], nil, Dimension.MIRROR, rng, true, true, false)
					else
						if not mod.TryPlaceRandomRoom(nil, Dimension.MIRROR, rng, true, true, false, nil, 20, 20) then
							if not mod.TryPlaceRandomRoom(nil, Dimension.MIRROR, rng, true, true, false, nil, 16, 19) then
								mod.TryPlaceRandomRoom(nil, Dimension.MIRROR, rng, true, true, false, nil, 15, 15)
							end
						end
					end
					hardPlaced = hardPlaced+1
				else
					if easyPlaced < #dif15rooms then
						mod.TryPlaceRoom(dif15rooms[easyPlaced+1], nil, Dimension.MIRROR, rng, true, true, false)
					else
						if not mod.TryPlaceRandomRoom(nil, Dimension.MIRROR, rng, true, true, false, nil, 16, 19) then
							mod.TryPlaceRandomRoom(nil, Dimension.MIRROR, rng, true, true, false, nil, 15, 15)
						end
					end
					easyPlaced = easyPlaced+1
				end
			end

			--place the deli boss room somewhere else
			local validBossGrids = level:FindValidRoomPlacementLocations(bossroom, Dimension.MIRROR, false, false)
			if #validBossGrids > 0 then
				local useGrid = validBossGrids[rng:RandomInt(1, #validBossGrids)]
				level:TryPlaceRoom(bossroom, useGrid, Dimension.MIRROR, rng:Next(), false, false, false)
			end

			local numSecrets = 1
			if PlayerManager.AnyoneHasTrinket(TrinketType.TRINKET_FRAGMENTED_CARD) then
				numSecrets = numSecrets+1
			end
			for i=1, numSecrets do
				local useConfig = secretConfig
				if i == 2 then
					useConfig = secretConfig2
				end
				local validSecretGrids = level:FindValidRoomPlacementLocations(useConfig, Dimension.MIRROR, true, true)
				local validSecretGrids1 = {}
				local validSecretGrids2 = {}
				local validSecretGrids3 = {}
				local validSecretGrids4 = {}
				for _,placementindex in ipairs(validSecretGrids) do
					local neighbors = level:GetNeighboringRooms(placementindex, useConfig.Shape, Dimension.MIRROR)
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
					level:TryPlaceRoom(useConfig, secretGrid, Dimension.MIRROR, rng:Next(), true, true, false)
				end
			end

			game:StartRoomTransition(GridRooms.ROOM_STARTING_IDX, Direction.NO_DIRECTION, RoomTransitionAnim.MAZE, Isaac.GetPlayer(), Dimension.MIRROR)

			--update minimapapi
			if MinimapAPI then
				MinimapAPI:LoadDefaultMap()
				MinimapAPI:updatePlayerPos()
				MinimapAPI:UpdateExternalMap()
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnNewLevelVoid)

mod.RedMistColor = Color(2,0,0,1)
function mod.OnMistUpdateVoid(effect)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE7 then
		local dimension = level:GetDimension()
		if dimension == Dimension.MIRROR then
			effect.Color = mod.RedMistColor
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.OnMistUpdateVoid, EffectVariant.MIST)

function mod.PreChangeRoomVoid(roomidx, dimension)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE7 then
		if dimension == Dimension.NORMAL then
			return {GridRooms.ROOM_STARTING_IDX, Dimension.MIRROR}
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_CHANGE_ROOM, mod.PreChangeRoomVoid)
