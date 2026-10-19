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
			for i=0, rooms.Size-1 do
				local roomDesc = rooms:Get(i)
				local roomData = roomDesc.Data
				if roomDesc.GridIndex == GridRooms.ROOM_STARTING_IDX then
					startingroom = roomData
				elseif roomData.Type == RoomType.ROOM_BOSS then
					if roomData.Subtype == BossType.DELIRIUM then
						bossroom = roomData
					end
				elseif roomData.Difficulty >= 20 then
					dif20rooms[#dif20rooms+1] = roomData
				elseif roomData.Difficulty >= 15 then --intentially making this >= 15 and not == 15, for void exclusive easier rooms at 19 or less
					dif15rooms[#dif15rooms+1] = roomData
				end
			end

			--make a deli room if it doesnt exist somehow
			if not bossroom then
				bossroomConfig = RoomConfig.GetRandomRoom(rng:Next(), false, StbType.SPECIAL_ROOMS, RoomType.ROOM_BOSS, RoomShape.NUM_ROOMSHAPES, 0, -1, 0, 20, 0, BossType.DELIRIUM)
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
	local room = game:GetRoom()
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
