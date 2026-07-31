function PibersMod.GetData(entity)
	local data = entity:GetData()
	if data.PibersMod == nil then
		data.PibersMod = {}
	end
	return data.PibersMod
end

function PibersMod.Clamp(num, min, max)
    return math.min(math.max(num,min),max)
end

function PibersMod.Round(num, decimalPlaces)
    local mult = 10^(decimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function PibersMod.GetOffset()
	return PibersMod.Clamp(math.floor(Options.HUDOffset*10),0,10)
end

function PibersMod.GetScreenSize()
	return Vector(Isaac.GetScreenWidth(), Isaac.GetScreenHeight())
end

function PibersMod.RoundVector(vector, decimalPlaces)
    return Vector(PibersMod.Round(vector.X, decimalPlaces), PibersMod.Round(vector.Y, decimalPlaces))
end

function PibersMod.GetScreenCenter()
	return PibersMod.GetScreenSize() / 2
end

function PibersMod.GetScreenBottomRight(offset)
	offset = offset or PibersMod.GetOffset()
	local pos = PibersMod.GetScreenSize()
	local hudOffset = Vector(-offset * 2.2, -offset * 1.6)
	pos = pos + hudOffset
	return PibersMod.RoundVector(pos)
end

function PibersMod.GetScreenBottomLeft(offset)
	offset = offset or PibersMod.GetOffset()
	local pos = Vector(0, PibersMod.GetScreenBottomRight(0).Y)
	local hudOffset = Vector(offset * 2.2, -offset * 1.6)
	pos = pos + hudOffset
	return PibersMod.RoundVector(pos)
end

function PibersMod.GetScreenTopRight(offset)
	offset = offset or PibersMod.GetOffset()
	local pos = Vector(PibersMod.GetScreenBottomRight(0).X, 0)
	local hudOffset = Vector(-offset * 2.2, offset * 1.2)
	pos = pos + hudOffset
	return PibersMod.RoundVector(pos)
end

function PibersMod.GetScreenTopLeft(offset)
	offset = offset or PibersMod.GetOffset()
	local pos = Vector.Zero
	local hudOffset = Vector(offset * 2, offset * 1.2)
	pos = pos + hudOffset
	return PibersMod.RoundVector(pos)
end

function PibersMod:TryForcePlaceRandomRoom(roomConfig, roomShape, roomSubtype, dimension, rng, index, minDifficulty, maxDifficulty, forceDoors, avoidGrid, avoidGridDistance, minDistance, ignoreStage)
	local roomType = RoomType.ROOM_DEFAULT
	if not roomConfig or type(roomConfig) == "number" then
		roomType = roomConfig or RoomType.ROOM_DEFAULT
		roomConfig = nil
	else
		ignoreStage = minDistance
		minDistance = avoidGridDistance
		avoidGridDistance = avoidGrid
		avoidGrid = forceDoors
		forceDoors = maxDifficulty
		maxDifficulty = minDifficulty
		minDifficulty = index
		index = rng
		rng = dimension
		dimension = roomSubtype
		roomSubtype = roomShape
		roomShape = RoomShape.NUM_ROOMSHAPES
		roomType = roomConfig.Type
	end
	if not roomType or roomType < 0 then
		roomType = RoomType.ROOM_DEFAULT
	end
	if not roomShape or roomShape < 0 then
		roomShape = RoomShape.NUM_ROOMSHAPES
	end
	if not roomSubtype then
		roomSubtype = -1
	end
	if not dimension then
		dimension = Dimension.NORMAL
	end
	if not avoidGridDistance then
		avoidGridDistance = GridRooms.WIDTH
	end
	if not minDistance then
		minDistance = 1
	end
	if not forceDoors then
		forceDoors = 0
	end
	if type(forceDoors) == "boolean" and forceDoors == true then
		forceDoors = Isaac.GetAllowedDoorsMaskForRoomShape(roomShape)
	end
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if not minDifficulty or minDifficulty < 0 then
		if stage == LevelStage.STAGE7 then
			minDifficulty = 15
		elseif game:IsHardMode() then
			if rng:GetSeed() % 8 == 0 then
				minDifficulty = 1
			else
				minDifficulty = 2
			end
		else
			minDifficulty = 1
		end
	end
	if not maxDifficulty or maxDifficulty < 0 then
		if stage == LevelStage.STAGE7 then
			maxDifficulty = 20
		elseif game:IsHardMode() and ((stage ~= LevelStage.STAGE1_1 and stage ~= LevelStage.STAGE2_1 and stage ~= LevelStage.STAGE3_1 and stage ~= LevelStage.STAGE4_1) or game:IsGreedMode()) then
			maxDifficulty = 15
		else
			maxDifficulty = 10
		end
	end
	if minDifficulty > maxDifficulty then
		minDifficulty = maxDifficulty
	end
	local isSpecial = roomType ~= RoomType.ROOM_DEFAULT
	if not roomConfig then
		local stbType = Isaac.GetCurrentStageConfigId()
		if not ignoreStage then
			roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, stbType, roomType, roomShape, 0, -1, minDifficulty, maxDifficulty, forceDoors, roomSubtype)
			if minDifficulty > 0 and not roomConfig then
				roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, stbType, roomType, roomShape, 0, -1, 0, maxDifficulty, forceDoors, roomSubtype)
			end
		end
		if isSpecial and not roomConfig then
			roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, StbType.SPECIAL_ROOMS, roomType, roomShape, 0, -1, minDifficulty, maxDifficulty, forceDoors, roomSubtype)
			if minDifficulty > 0 and not roomConfig then
				roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, StbType.SPECIAL_ROOMS, roomType, roomShape, 0, -1, 0, maxDifficulty, forceDoors, roomSubtype)
			end
		end
		if not roomConfig and game:IsGreedMode() then
			if not ignoreStage then
				roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, stbType, roomType, roomShape, 0, -1, minDifficulty, maxDifficulty, forceDoors, roomSubtype, 0)
				if minDifficulty > 0 and not roomConfig then
					roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, stbType, roomType, roomShape, 0, -1, 0, maxDifficulty, forceDoors, roomSubtype, 0)
				end
			end
			if isSpecial and not roomConfig then
				roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, StbType.SPECIAL_ROOMS, roomType, roomShape, 0, -1, minDifficulty, maxDifficulty, forceDoors, roomSubtype, 0)
				if minDifficulty > 0 and not roomConfig then
					roomConfig = RoomConfig.GetRandomRoom(rng:Next(), not isSpecial, StbType.SPECIAL_ROOMS, roomType, roomShape, 0, -1, 0, maxDifficulty, forceDoors, roomSubtype, 0)
				end
			end
		end
	end
	local validGrids = {index}
	if not index then
		validGrids = level:FindValidRoomPlacementLocations(roomConfig, dimension, not isSpecial, not isSpecial)
		if #validGrids <= 0 and isSpecial then
			validGrids = level:FindValidRoomPlacementLocations(roomConfig, dimension, true, not isSpecial)
			if #validGrids <= 0 then
				validGrids = level:FindValidRoomPlacementLocations(roomConfig, dimension, true, true)
			end
		end
	elseif index <= -1 then
		-- -1 = every grid
		-- -2 = avoid edge
		validGrids = {}
		if index == -2 then
			for i=GridRooms.WIDTH+1, GridRooms.ROOM_LAST_IDX-(GridRooms.WIDTH+1) do
				if i%GridRooms.WIDTH > 0 and i%GridRooms.WIDTH < GridRooms.WIDTH then
					validGrids[#validGrids+1] = i
				end
			end
		else
			for i=GridRooms.ROOM_FIRST_IDX, GridRooms.ROOM_LAST_IDX do
				validGrids[#validGrids+1] = i
			end
		end
		index = nil
	end
	local validGridsByDistance = {}
	if avoidGrid then
		for _, roomindex in ipairs(validGrids) do
			local row = math.floor(roomindex/GridRooms.WIDTH)
			local col = roomindex%GridRooms.WIDTH
			local distance = GridRooms.WIDTH
			if type(avoidGrid) == "table" then
				for _, avoidIndex in ipairs(avoidGrid) do
					local rowAvoid = math.floor(avoidIndex/GridRooms.WIDTH)
					local colAvoid = avoidIndex%GridRooms.WIDTH
					distance = math.min(distance,math.max(math.abs(col - colAvoid),math.abs(row - rowAvoid)))
				end
			else
				local rowAvoid = math.floor(avoidGrid/GridRooms.WIDTH)
				local colAvoid = avoidGrid%GridRooms.WIDTH
				distance = math.max(math.abs(col - colAvoid),math.abs(row - rowAvoid))
			end
			if distance > avoidGridDistance then
				distance = avoidGridDistance
			end
			if distance >= minDistance and distance <= GridRooms.WIDTH then
				validGridsByDistance[distance] = validGridsByDistance[distance] or {}
				validGridsByDistance[distance][#validGridsByDistance[distance]+1] = roomindex
			end
		end
	end
	local attempts = 0
	while attempts < 100 do
		attempts = attempts + 1
		local useGrid = index
		if not index and #validGrids > 0 then
			useGrid = validGrids[rng:RandomInt(1, #validGrids)]
		end
		local roomDesc = nil
		if avoidGrid and not index then
			for distance=GridRooms.WIDTH, 1, -1 do
				if validGridsByDistance[distance] then
					local avoidAttempts = 0
					while avoidAttempts < 100 do
						avoidAttempts = avoidAttempts + 1
						useGrid = validGridsByDistance[distance][rng:RandomInt(1, #validGridsByDistance[distance])]
						roomDesc = level:TryPlaceRoom(roomConfig, useGrid, dimension, rng:Next(), true, true, true)
						if roomDesc then
							break
						end
					end
				end
				if roomDesc then
					break
				end
			end
		end
		if not roomDesc then
			roomDesc = level:TryPlaceRoom(roomConfig, useGrid, dimension, rng:Next(), true, true, true)
		end
		if roomDesc then
			attempts = 100
			return roomDesc
		end
	end
end

PibersMod.ModEffectUpdateFuncs = {}
PibersMod.ModEffectRenderFuncs = {}
function PibersMod:OnModEffectUpdate(effect)
	local sprite, data = effect:GetSprite(), PibersMod.GetData(effect)
	if PibersMod.ModEffectUpdateFuncs[effect.SubType] then
		PibersMod.ModEffectUpdateFuncs[effect.SubType](effect,sprite,data)
	end
end
function PibersMod:OnModEffectRender(effect)
	local sprite, data = effect:GetSprite(), PibersMod.GetData(effect)
	if PibersMod.ModEffectRenderFuncs[effect.SubType] then
		PibersMod.ModEffectRenderFuncs[effect.SubType](effect,sprite,data)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, PibersMod.OnModEffectUpdate, EffectVariant.PIBERSMOD)
PibersMod:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, PibersMod.OnModEffectRender, EffectVariant.PIBERSMOD)

function PibersMod.RemoveItemFromHistory(player, itemid, isTrinket)
	if isTrinket then
		isTrinket = true
	else
		isTrinket = false
	end
	local history = player:GetHistory()
	local items = history:GetCollectiblesHistory()
	for index=#items, 1, -1 do
		local item = items[index]
		if item then
			if item:GetItemID() == itemid and isTrinket == item:IsTrinket() then
				return history:RemoveHistoryItemByIndex(index-1)
			end
		end
	end
	return false
end
