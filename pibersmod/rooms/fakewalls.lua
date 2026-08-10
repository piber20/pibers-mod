PibersMod.FakeWallsEnabled = false
PibersMod.FakeWallSprite = Sprite("gfx/backdrop/fake_walls.anm2", true)
PibersMod.FakeWallSprite:Play("Walls")
PibersMod.FakeWallSpriteFull = Sprite("gfx/backdrop/fake_walls.anm2", true)
PibersMod.FakeWallSpriteFull:Play("WallsFull")
PibersMod.FakeWallBackdrop = BackdropType.BACKDROP_NULL
PibersMod.FakeWalls = {}
function PibersMod:BackdropHasWalls(backdrop)
	return backdrop ~= BackdropType.DARKROOM and backdrop ~= BackdropType.MEGA_SATAN and backdrop ~= BackdropType.ERROR_ROOM and backdrop ~= BackdropType.DUNGEON and backdrop ~= BackdropType.PLANETARIUM and backdrop ~= BackdropType.DOGMA and backdrop ~= BackdropType.DUNGEON_GIDEON and backdrop ~= BackdropType.DUNGEON_ROTGUT and backdrop ~= BackdropType.DUNGEON_BEAST
end

function PibersMod:PreRenderFloorFakeWalls(color)
	local game = Game()
	local room = game:GetRoom()
	local backdropType = room:GetBackdropType()
	if PibersMod.FakeWallsEnabled and PibersMod:BackdropHasWalls(backdropType) then
		local lastGrid = room:GetGridSize()-1
		local gridWidth = room:GetGridWidth()
		local foundFakeWall = true
		while foundFakeWall do
			foundFakeWall = false
			for gridIndex=0, lastGrid do
				if not PibersMod.FakeWalls[gridIndex] then
					local gridEntity = room:GetGridEntity(gridIndex)
					if gridEntity then
						if gridEntity:GetType() == GridEntityType.GRID_WALL or gridEntity:GetType() == GridEntityType.GRID_DOOR then
							PibersMod.FakeWalls[gridIndex] = true
						elseif gridEntity:GetType() == GridEntityType.GRID_PILLAR then
							local gridLeft = gridIndex-1
							local gridRight = gridIndex+1
							local gridUp = gridIndex-gridWidth
							local gridDown = gridIndex+gridWidth
							local gridEntityLeft = room:GetGridEntity(gridLeft)
							local gridEntityRight = room:GetGridEntity(gridRight)
							local gridEntityUp = room:GetGridEntity(gridUp)
							local gridEntityDown = room:GetGridEntity(gridDown)
							local adjWalls = 0
							if PibersMod.FakeWalls[gridLeft] or (gridEntityLeft and gridEntityLeft:GetType() == GridEntityType.GRID_WALL) then
								adjWalls = adjWalls + 1
							elseif PibersMod.FakeWalls[gridRight] or (gridEntityRight and gridEntityRight:GetType() == GridEntityType.GRID_WALL) then
								adjWalls = adjWalls + 1
							end
							if PibersMod.FakeWalls[gridUp] or (gridEntityUp and (gridEntityUp:GetType() == GridEntityType.GRID_WALL or gridEntityUp:GetType() == GridEntityType.GRID_PILLAR)) then
								adjWalls = adjWalls + 1
							elseif PibersMod.FakeWalls[gridDown] or (gridEntityDown and (gridEntityDown:GetType() == GridEntityType.GRID_WALL or gridEntityDown:GetType() == GridEntityType.GRID_PILLAR)) then
								adjWalls = adjWalls + 1
							end
							if adjWalls >= 2 then
								PibersMod.FakeWalls[gridIndex] = true
								foundFakeWall = true
							end
						end
					end
				end
			end
		end
		if not foundFakeWall and Isaac.CountEntities(nil, EntityType.ENTITY_EFFECT, EffectVariant.PIBERSMOD, PibersMod.Effects.FAKE_WALL_HANDLER) < 1 then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PIBERSMOD, PibersMod.Effects.FAKE_WALL_HANDLER, Vector(0,-1500), Vector.Zero, nil).SortingLayer = SortingLayer.SORTING_DOOR
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_BACKDROP_RENDER_FLOOR, PibersMod.PreRenderFloorFakeWalls)

function PibersMod:RenderFakeWalls()

	if not PibersMod.FakeWallsEnabled then
		return
	end

	local game = Game()
	local room = game:GetRoom()
	local backdropType = room:GetBackdropType()

	if PibersMod:BackdropHasWalls(backdropType) then
		local lastGrid = room:GetGridSize()-1
		local gridWidth = room:GetGridWidth()

		if PibersMod.FakeWallBackdrop ~= backdropType then
			PibersMod.FakeWallBackdrop = backdropType
			local backdropData = XMLData.GetEntryById(XMLNode.BACKDROP, backdropType)
			if backdropData.gfx then
				PibersMod.FakeWallSprite:ReplaceSpritesheet(0, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSprite:ReplaceSpritesheet(1, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSprite:ReplaceSpritesheet(2, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSprite:ReplaceSpritesheet(3, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSprite:ReplaceSpritesheet(4, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSprite:ReplaceSpritesheet(5, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSprite:ReplaceSpritesheet(6, "gfx/backdrop/" .. backdropData.gfx, true)
				PibersMod.FakeWallSpriteFull:ReplaceSpritesheet(0, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSpriteFull:ReplaceSpritesheet(1, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSpriteFull:ReplaceSpritesheet(2, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSpriteFull:ReplaceSpritesheet(3, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSpriteFull:ReplaceSpritesheet(4, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSpriteFull:ReplaceSpritesheet(5, "gfx/backdrop/" .. backdropData.gfx, false)
				PibersMod.FakeWallSpriteFull:ReplaceSpritesheet(6, "gfx/backdrop/" .. backdropData.gfx, true)
			end
		end

		PibersMod.FakeWallSprite:SetFrame(44)
		PibersMod.FakeWallSpriteFull:SetFrame(44)
		for gridIndex, isWall in pairs(PibersMod.FakeWalls) do
			if isWall then
				local isWallLeft = PibersMod.FakeWalls[gridIndex-1]
				if gridIndex-1 < 0 then
					isWallLeft = PibersMod.FakeWalls[0]
				end
				local isWallRight = PibersMod.FakeWalls[gridIndex+1]
				if gridIndex+1 > lastGrid then
					isWallRight = PibersMod.FakeWalls[lastGrid]
				end
				local isWallUp = PibersMod.FakeWalls[gridIndex-gridWidth]
				if gridIndex-gridWidth < 0 then
					isWallUp = PibersMod.FakeWalls[0]
				end
				local isWallDown = PibersMod.FakeWalls[gridIndex+gridWidth]
				if gridIndex+gridWidth > lastGrid then
					isWallDown = PibersMod.FakeWalls[lastGrid]
				end
				local isWallUpLeft = PibersMod.FakeWalls[(gridIndex-gridWidth)-1]
				if (gridIndex-gridWidth)-1 < 0 then
					isWallUpLeft = PibersMod.FakeWalls[0]
				end
				local isWallUpRight = PibersMod.FakeWalls[(gridIndex-gridWidth)+1]
				if (gridIndex-gridWidth)+1 < 0 then
					isWallUpRight = PibersMod.FakeWalls[0]
				end
				local isWallDownLeft = PibersMod.FakeWalls[(gridIndex+gridWidth)-1]
				if (gridIndex+gridWidth)-1 > lastGrid then
					isWallDownLeft = PibersMod.FakeWalls[lastGrid]
				end
				local isWallDownRight = PibersMod.FakeWalls[(gridIndex+gridWidth)+1]
				if (gridIndex+gridWidth)+1 > lastGrid then
					isWallDownRight = PibersMod.FakeWalls[lastGrid]
				end

				local wallFlag = 0
				if isWallLeft then
					wallFlag = wallFlag + 10000000
				end
				if isWallRight then
					wallFlag = wallFlag +  1000000
				end
				if isWallUp then
					wallFlag = wallFlag +   100000
				end
				if isWallDown then
					wallFlag = wallFlag +    10000
				end
				if isWallUpLeft then
					wallFlag = wallFlag +     1000
				end
				if isWallUpRight then
					wallFlag = wallFlag +      100
				end
				if isWallDownLeft then
					wallFlag = wallFlag +       10
				end
				if isWallDownRight then
					wallFlag = wallFlag +        1
				end


				local frame = 44
				if wallFlag == 10111010
				or wallFlag == 10111110
				or wallFlag == 10111011
				or wallFlag == 10111111 then --left wall
					frame = 21
				elseif wallFlag == 01110101
				or wallFlag == 01111101
				or wallFlag == 01110111
				or wallFlag == 01111111 then --right wall
					frame = 22
				elseif wallFlag == 11101100
				or wallFlag == 11101110
				or wallFlag == 11101101
				or wallFlag == 11101111 then --up wall
					frame = 7
				elseif wallFlag == 11010011
				or wallFlag == 11011011
				or wallFlag == 11010111
				or wallFlag == 11011111 then --down wall
					frame = 36
				elseif wallFlag == 10101000
				or wallFlag == 10101001
				or wallFlag == 10101010
				or wallFlag == 10101011
				or wallFlag == 10101100
				or wallFlag == 10101101
				or wallFlag == 10101110
				or wallFlag == 10101111 then --up left outer corner
					frame = 45
				elseif wallFlag == 01100100
				or wallFlag == 01100110
				or wallFlag == 01101100
				or wallFlag == 01101110
				or wallFlag == 01100101
				or wallFlag == 01100111
				or wallFlag == 01101101
				or wallFlag == 01101111 then --up right outer corner
					frame = 46
				elseif wallFlag == 10010010
				or wallFlag == 10010110
				or wallFlag == 10010011
				or wallFlag == 10010111
				or wallFlag == 10011010
				or wallFlag == 10011110
				or wallFlag == 10011011
				or wallFlag == 10011111 then --down left outer corner
					frame = 47
				elseif wallFlag == 01010001
				or wallFlag == 01011001
				or wallFlag == 01010011
				or wallFlag == 01011011
				or wallFlag == 01010101
				or wallFlag == 01011101
				or wallFlag == 01010111
				or wallFlag == 01011111 then --down right outer corner
					frame = 48
				elseif wallFlag == 11111110 then --up left inner corner
					frame = 0
				elseif wallFlag == 11111101 then --up right inner corner
					frame = 14
				elseif wallFlag == 11111011 then --bottom left inner corner
					frame = 29
				elseif wallFlag == 11110111 then --bottom right inner corner
					frame = 43
				end

				PibersMod.FakeWalls[gridIndex] = frame

				local gridEntity = room:GetGridEntity(gridIndex)
				if gridEntity and (gridEntity:GetType() == GridEntityType.GRID_WALL or gridEntity:GetType() == GridEntityType.GRID_DOOR) then
					if frame ~= 44 then
						if gridIndex == 0 or gridIndex == gridWidth-1 or gridIndex == lastGrid-(gridWidth-1) or gridIndex == lastGrid then
							PibersMod.FakeWalls[gridIndex] = -1
						elseif frame ~= 0 and frame ~= 14 and frame ~= 29 and frame ~= 43 then
							PibersMod.FakeWalls[gridIndex] = -1
						end
					end
				end

				if frame == 44 then
					local floorPos = room:GetGridPosition(gridIndex)
					PibersMod.FakeWallSprite:Render(Isaac.WorldToScreen(floorPos))
				end
			end
		end

		for gridIndex, frame in pairs(PibersMod.FakeWalls) do
			if type(frame) == "number" and frame >= 0 and frame ~= 44 then
				local floorPos = room:GetGridPosition(gridIndex)
				PibersMod.FakeWallSpriteFull:SetFrame(frame)
				PibersMod.FakeWallSpriteFull:Render(Isaac.WorldToScreen(floorPos))
			end
		end

		for gridIndex, frame in pairs(PibersMod.FakeWalls) do
			if type(frame) == "number" and (frame == 45 or frame == 46 or frame == 47 or frame == 48) then
				local floorPos = room:GetGridPosition(gridIndex)
				PibersMod.FakeWallSprite:SetFrame(frame)
				PibersMod.FakeWallSprite:Render(Isaac.WorldToScreen(floorPos))
			end
		end

		for gridIndex, frame in pairs(PibersMod.FakeWalls) do
			if type(frame) == "number" and (frame == 0 or frame == 14 or frame == 29 or frame == 43) then
				local floorPos = room:GetGridPosition(gridIndex)
				PibersMod.FakeWallSprite:SetFrame(frame)
				PibersMod.FakeWallSprite:Render(Isaac.WorldToScreen(floorPos))
			end
		end
	end
end

function PibersMod:PrePillarRender(gridEntity)
	if PibersMod.FakeWallsEnabled then
		local game = Game()
		local room = game:GetRoom()
		local backdropType = room:GetBackdropType()
		if PibersMod:BackdropHasWalls(backdropType) and PibersMod.FakeWalls[gridEntity:GetGridIndex()] then
			gridEntity:GetSprite().Scale = Vector.Zero
			return false
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_GRID_ENTITY_ROCK_RENDER, PibersMod.PrePillarRender, GridEntityType.GRID_PILLAR)

function PibersMod:OnNewRoomFakeWalls()
	PibersMod.FakeWalls = {}
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PibersMod.OnNewRoomFakeWalls)

PibersMod.ModEffectRenderFuncs[PibersMod.Effects.FAKE_WALL_HANDLER] = function(effect,sprite,data)
	PibersMod:RenderFakeWalls()
end
