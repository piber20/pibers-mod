local mod = PibersMod

mod.FakeWallsEnabled = false
mod.FakeWallSprite = Sprite("gfx/backdrop/fake_walls.anm2", true)
mod.FakeWallSprite:Play("Walls")
mod.FakeWallSpriteFull = Sprite("gfx/backdrop/fake_walls.anm2", true)
mod.FakeWallSpriteFull:Play("WallsFull")
mod.FakeWallBackdrop = BackdropType.BACKDROP_NULL
mod.FakeWalls = {}
function mod.BackdropHasWalls(backdrop)
	return backdrop ~= BackdropType.DARKROOM and backdrop ~= BackdropType.MEGA_SATAN and backdrop ~= BackdropType.ERROR_ROOM and backdrop ~= BackdropType.DUNGEON and backdrop ~= BackdropType.PLANETARIUM and backdrop ~= BackdropType.DOGMA and backdrop ~= BackdropType.DUNGEON_GIDEON and backdrop ~= BackdropType.DUNGEON_ROTGUT and backdrop ~= BackdropType.DUNGEON_BEAST
end

function mod.PreRenderFloorFakeWalls(color)
	local game = Game()
	local room = game:GetRoom()
	local backdropType = room:GetBackdropType()
	if mod.FakeWallsEnabled and mod.BackdropHasWalls(backdropType) then
		local lastGrid = room:GetGridSize()-1
		local gridWidth = room:GetGridWidth()
		local foundFakeWall = true
		while foundFakeWall do
			foundFakeWall = false
			for gridIndex=0, lastGrid do
				if not mod.FakeWalls[gridIndex] then
					local gridEntity = room:GetGridEntity(gridIndex)
					if gridEntity then
						if gridEntity:GetType() == GridEntityType.GRID_WALL or gridEntity:GetType() == GridEntityType.GRID_DOOR then
							mod.FakeWalls[gridIndex] = true
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
							if mod.FakeWalls[gridLeft] or (gridEntityLeft and gridEntityLeft:GetType() == GridEntityType.GRID_WALL) then
								adjWalls = adjWalls + 1
							elseif mod.FakeWalls[gridRight] or (gridEntityRight and gridEntityRight:GetType() == GridEntityType.GRID_WALL) then
								adjWalls = adjWalls + 1
							end
							if mod.FakeWalls[gridUp] or (gridEntityUp and (gridEntityUp:GetType() == GridEntityType.GRID_WALL or gridEntityUp:GetType() == GridEntityType.GRID_PILLAR)) then
								adjWalls = adjWalls + 1
							elseif mod.FakeWalls[gridDown] or (gridEntityDown and (gridEntityDown:GetType() == GridEntityType.GRID_WALL or gridEntityDown:GetType() == GridEntityType.GRID_PILLAR)) then
								adjWalls = adjWalls + 1
							end
							if adjWalls >= 2 then
								mod.FakeWalls[gridIndex] = true
								foundFakeWall = true
							end
						end
					end
				end
			end
		end
		if not foundFakeWall and Isaac.CountEntities(nil, EntityType.ENTITY_EFFECT, EffectVariant.PIBERSMOD, mod.Effects.FAKE_WALL_HANDLER) < 1 then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PIBERSMOD, mod.Effects.FAKE_WALL_HANDLER, Vector(0,-1500), Vector.Zero, nil).SortingLayer = SortingLayer.SORTING_DOOR
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_BACKDROP_RENDER_FLOOR, mod.PreRenderFloorFakeWalls)

function mod.RenderFakeWalls()

	if not mod.FakeWallsEnabled then
		return
	end

	local game = Game()
	local room = game:GetRoom()
	local backdropType = room:GetBackdropType()

	if mod.BackdropHasWalls(backdropType) then
		local lastGrid = room:GetGridSize()-1
		local gridWidth = room:GetGridWidth()

		if mod.FakeWallBackdrop ~= backdropType then
			mod.FakeWallBackdrop = backdropType
			local backdropData = XMLData.GetEntryById(XMLNode.BACKDROP, backdropType)
			if backdropData.gfx then
				mod.FakeWallSprite:ReplaceSpritesheet(0, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSprite:ReplaceSpritesheet(1, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSprite:ReplaceSpritesheet(2, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSprite:ReplaceSpritesheet(3, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSprite:ReplaceSpritesheet(4, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSprite:ReplaceSpritesheet(5, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSprite:ReplaceSpritesheet(6, "gfx/backdrop/" .. backdropData.gfx, true)
				mod.FakeWallSpriteFull:ReplaceSpritesheet(0, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSpriteFull:ReplaceSpritesheet(1, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSpriteFull:ReplaceSpritesheet(2, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSpriteFull:ReplaceSpritesheet(3, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSpriteFull:ReplaceSpritesheet(4, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSpriteFull:ReplaceSpritesheet(5, "gfx/backdrop/" .. backdropData.gfx, false)
				mod.FakeWallSpriteFull:ReplaceSpritesheet(6, "gfx/backdrop/" .. backdropData.gfx, true)
			end
		end

		mod.FakeWallSprite:SetFrame(44)
		mod.FakeWallSpriteFull:SetFrame(44)
		for gridIndex, isWall in pairs(mod.FakeWalls) do
			if isWall then
				local isWallLeft = mod.FakeWalls[gridIndex-1]
				if gridIndex-1 < 0 then
					isWallLeft = mod.FakeWalls[0]
				end
				local isWallRight = mod.FakeWalls[gridIndex+1]
				if gridIndex+1 > lastGrid then
					isWallRight = mod.FakeWalls[lastGrid]
				end
				local isWallUp = mod.FakeWalls[gridIndex-gridWidth]
				if gridIndex-gridWidth < 0 then
					isWallUp = mod.FakeWalls[0]
				end
				local isWallDown = mod.FakeWalls[gridIndex+gridWidth]
				if gridIndex+gridWidth > lastGrid then
					isWallDown = mod.FakeWalls[lastGrid]
				end
				local isWallUpLeft = mod.FakeWalls[(gridIndex-gridWidth)-1]
				if (gridIndex-gridWidth)-1 < 0 then
					isWallUpLeft = mod.FakeWalls[0]
				end
				local isWallUpRight = mod.FakeWalls[(gridIndex-gridWidth)+1]
				if (gridIndex-gridWidth)+1 < 0 then
					isWallUpRight = mod.FakeWalls[0]
				end
				local isWallDownLeft = mod.FakeWalls[(gridIndex+gridWidth)-1]
				if (gridIndex+gridWidth)-1 > lastGrid then
					isWallDownLeft = mod.FakeWalls[lastGrid]
				end
				local isWallDownRight = mod.FakeWalls[(gridIndex+gridWidth)+1]
				if (gridIndex+gridWidth)+1 > lastGrid then
					isWallDownRight = mod.FakeWalls[lastGrid]
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

				mod.FakeWalls[gridIndex] = frame

				local gridEntity = room:GetGridEntity(gridIndex)
				if gridEntity and (gridEntity:GetType() == GridEntityType.GRID_WALL or gridEntity:GetType() == GridEntityType.GRID_DOOR) then
					if frame ~= 44 then
						if gridIndex == 0 or gridIndex == gridWidth-1 or gridIndex == lastGrid-(gridWidth-1) or gridIndex == lastGrid then
							mod.FakeWalls[gridIndex] = -1
						elseif frame ~= 0 and frame ~= 14 and frame ~= 29 and frame ~= 43 then
							mod.FakeWalls[gridIndex] = -1
						end
					end
				end

				if frame == 44 then
					local floorPos = room:GetGridPosition(gridIndex)
					mod.FakeWallSprite:Render(Isaac.WorldToScreen(floorPos))
				end
			end
		end

		for gridIndex, frame in pairs(mod.FakeWalls) do
			if type(frame) == "number" and frame >= 0 and frame ~= 44 then
				local floorPos = room:GetGridPosition(gridIndex)
				mod.FakeWallSpriteFull:SetFrame(frame)
				mod.FakeWallSpriteFull:Render(Isaac.WorldToScreen(floorPos))
			end
		end

		for gridIndex, frame in pairs(mod.FakeWalls) do
			if type(frame) == "number" and (frame == 45 or frame == 46 or frame == 47 or frame == 48) then
				local floorPos = room:GetGridPosition(gridIndex)
				mod.FakeWallSprite:SetFrame(frame)
				mod.FakeWallSprite:Render(Isaac.WorldToScreen(floorPos))
			end
		end

		for gridIndex, frame in pairs(mod.FakeWalls) do
			if type(frame) == "number" and (frame == 0 or frame == 14 or frame == 29 or frame == 43) then
				local floorPos = room:GetGridPosition(gridIndex)
				mod.FakeWallSprite:SetFrame(frame)
				mod.FakeWallSprite:Render(Isaac.WorldToScreen(floorPos))
			end
		end
	end
end

function mod.PrePillarRender(gridEntity)
	if mod.FakeWallsEnabled then
		local game = Game()
		local room = game:GetRoom()
		local backdropType = room:GetBackdropType()
		if mod.BackdropHasWalls(backdropType) and mod.FakeWalls[gridEntity:GetGridIndex()] then
			gridEntity:GetSprite().Scale = Vector.Zero
			return false
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_GRID_ENTITY_ROCK_RENDER, mod.PrePillarRender, GridEntityType.GRID_PILLAR)

function mod.OnNewRoomFakeWalls()
	mod.FakeWalls = {}
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomFakeWalls)

mod.ModEffectRenderFuncs[mod.Effects.FAKE_WALL_HANDLER] = function(effect,sprite,data)
	mod.RenderFakeWalls()
end
