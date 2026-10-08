local mod = Desecration

mod.ShadingBg = {}
mod.ShadingBg.IH = {}
mod.ShadingBg.IH.Shading = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.IH.Shading:Play("Shading")
mod.ShadingBg.IH.Shading:ReplaceSpritesheet(0, "gfx/backdrop/shading_ih_desecration.png", true)
mod.ShadingBg.ClosetL = {}
mod.ShadingBg.ClosetL.Floor = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.ClosetL.Floor:Play("ClosetFloors")
mod.ShadingBg.ClosetL.Wall = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.ClosetL.Wall:Play("ClosetWalls")
mod.ShadingBg.ClosetL.Shading = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.ClosetL.Shading:Play("Shading")
mod.ShadingBg.ClosetL.Shading:ReplaceSpritesheet(0, "gfx/backdrop/shading_closet_l.png", true)
--mod.ShadingBg.ClosetL.CameraPos = Vector(400,550)
--mod.ShadingBg.ClosetL.CameraPosStart = Vector(200,280)
mod.ShadingBg.ClosetL.WallGrids = {
	53,54,55,56,57,58,
	68,69,70,71,72,73,
	83,84,85,86,87,88
}
mod.ShadingBg.ClosetR = {}
mod.ShadingBg.ClosetR.Floor = mod.ShadingBg.ClosetL.Floor
mod.ShadingBg.ClosetR.Wall = mod.ShadingBg.ClosetL.Wall
mod.ShadingBg.ClosetR.Shading = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.ClosetR.Shading:Play("Shading")
mod.ShadingBg.ClosetR.Shading:ReplaceSpritesheet(0, "gfx/backdrop/shading_closet_r.png", true)
--mod.ShadingBg.ClosetR.CameraPos = Vector(640,550)
--mod.ShadingBg.ClosetR.CameraPosStart = Vector(440,280)
mod.ShadingBg.ClosetR.RenderPos = Vector(302,140)
mod.ShadingBg.ClosetR.WallGrids = {
	46,47,48,49,50,51,
	61,62,63,64,65,66,
	76,77,78,79,80,81
}
mod.ShadingBg.ClosetU = {}
mod.ShadingBg.ClosetU.Floor = mod.ShadingBg.ClosetL.Floor
mod.ShadingBg.ClosetU.Wall = mod.ShadingBg.ClosetL.Wall
mod.ShadingBg.ClosetU.Shading = mod.ShadingBg.ClosetL.Shading
mod.ShadingBg.ClosetU.RenderPos = Vector(302,140)
mod.ShadingBg.ClosetU.ShadingPos = Vector(302,140)
mod.ShadingBg.ClosetU.WallGrids = {
	16,17,18,					  26,27,28,
	31,32,33,					  41,42,43,
	46,47,48,					  56,57,58,
	61,62,63,64,65,66,67,68,69,70,71,72,73,
	76,77,78,79,80,81,82,83,84,85,86,87,88,
	91,92,93,94,95,96,97,98,99,100,101,102,103,
	106,107,108,109,110,111,112,113,114,115,116,117,118
}
mod.ShadingBg.ClosetD = {}
mod.ShadingBg.ClosetD.Floor = mod.ShadingBg.ClosetL.Floor
mod.ShadingBg.ClosetD.Wall = mod.ShadingBg.ClosetL.Wall
mod.ShadingBg.ClosetD.Shading = mod.ShadingBg.ClosetL.Shading
mod.ShadingBg.ClosetD.RenderPos = Vector(302,140)
mod.ShadingBg.ClosetD.ShadingPos = Vector(302,140)
mod.ShadingBg.ClosetD.WallGrids = {
	16,17,18,19,20,21,22,23,24,25,26,27,28,
	31,32,33,34,35,36,37,38,39,40,41,42,43,
	46,47,48,49,50,51,52,53,54,55,56,57,58,
	61,62,63,64,65,66,67,68,69,70,71,72,73,
	76,77,78,					  86,87,88,
	91,92,93,					  101,102,103,
	106,107,108,				  116,117,118
}
mod.ShadingBg.SquareL = {}
mod.ShadingBg.SquareL.Floor = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.SquareL.Floor:Play("SquareFloors")
mod.ShadingBg.SquareL.Wall = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.SquareL.Wall:Play("SquareWalls")
mod.ShadingBg.SquareL.Shading = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.SquareL.Shading:Play("Shading")
mod.ShadingBg.SquareL.Shading:ReplaceSpritesheet(0, "gfx/backdrop/shading_closet_l.png", true)
mod.ShadingBg.SquareL.WallGrids = {
	16,17,18,19,20,21,22,23,24,25,26,27,28,
				   36,37,38,39,40,41,42,43,
				   51,52,53,54,55,56,57,58,
				   66,67,68,69,70,71,72,73,
				   81,82,83,84,85,86,87,88,
				   96,97,98,99,100,101,102,103,
	106,107,108,109,110,111,112,113,114,115,116,117,118
}
mod.ShadingBg.SquareR = {}
mod.ShadingBg.SquareR.Floor = mod.ShadingBg.SquareL.Floor
mod.ShadingBg.SquareR.Wall = mod.ShadingBg.SquareL.Wall
mod.ShadingBg.SquareR.Shading = mod.ShadingBg.SquareL.Shading
mod.ShadingBg.SquareR.WallGrids = {
	16,17,18,19,20,21,22,23,24,25,26,27,28,
	31,32,33,34,35,36,37,38,
	46,47,48,49,50,51,52,53,
	61,62,63,64,65,66,67,68,
	76,77,78,79,80,81,82,83,
	91,92,93,94,95,96,97,98,
	106,107,108,109,110,111,112,113,114,115,116,117,118
}
mod.ShadingBg.SquareU = {}
mod.ShadingBg.SquareU.Floor = mod.ShadingBg.SquareL.Floor
mod.ShadingBg.SquareU.Wall = mod.ShadingBg.SquareL.Wall
mod.ShadingBg.SquareU.Shading = mod.ShadingBg.SquareL.Shading
mod.ShadingBg.SquareU.WallGrids = {
	95,96,97,98,99,
	110,111,112,113,114
}
mod.ShadingBg.SquareD = {}
mod.ShadingBg.SquareD.Floor = mod.ShadingBg.SquareL.Floor
mod.ShadingBg.SquareD.Wall = mod.ShadingBg.SquareL.Wall
mod.ShadingBg.SquareD.Shading = mod.ShadingBg.SquareL.Shading
mod.ShadingBg.SquareD.WallGrids = {
	20,21,22,23,24,
	35,36,37,38,39,
}
mod.ShadingBg.TinyClosetL = {}
mod.ShadingBg.TinyClosetL.Floor = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.TinyClosetL.Floor:Play("TinyClosetFloors")
mod.ShadingBg.TinyClosetL.Wall = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.TinyClosetL.Wall:Play("TinyClosetWalls")
mod.ShadingBg.TinyClosetL.Shading = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.TinyClosetL.Shading:Play("Shading")
mod.ShadingBg.TinyClosetL.Shading:ReplaceSpritesheet(0, "gfx/backdrop/shading_closet_l.png", true)
mod.ShadingBg.TinyClosetL.WallGrids = {
	51,52,53,54,55,56,57,58,
	66,67,68,69,70,71,72,73,
	81,82,83,84,85,86,87,88
}
mod.ShadingBg.TinyClosetR = {}
mod.ShadingBg.TinyClosetR.Floor = mod.ShadingBg.TinyClosetL.Floor
mod.ShadingBg.TinyClosetR.Wall = mod.ShadingBg.TinyClosetL.Wall
mod.ShadingBg.TinyClosetR.Shading = mod.ShadingBg.TinyClosetL.Shading
mod.ShadingBg.TinyClosetR.WallGrids = {
	46,47,48,49,50,51,52,53,
	61,62,63,64,65,66,67,68,
	76,77,78,79,80,81,82,83
}
mod.ShadingBg.TinyClosetU = {}
mod.ShadingBg.TinyClosetU.Floor = mod.ShadingBg.TinyClosetL.Floor
mod.ShadingBg.TinyClosetU.Wall = mod.ShadingBg.TinyClosetL.Wall
mod.ShadingBg.TinyClosetU.Shading = mod.ShadingBg.TinyClosetL.Shading
mod.ShadingBg.TinyClosetU.WallGrids = {
	65,66,67,68,69,
	80,81,82,83,84,
	95,96,97,98,99,
	110,111,112,113,114
}
mod.ShadingBg.TinyClosetD = {}
mod.ShadingBg.TinyClosetD.Floor = mod.ShadingBg.TinyClosetL.Floor
mod.ShadingBg.TinyClosetD.Wall = mod.ShadingBg.TinyClosetL.Wall
mod.ShadingBg.TinyClosetD.Shading = mod.ShadingBg.TinyClosetL.Shading
mod.ShadingBg.TinyClosetD.WallGrids = {
	20,21,22,23,24,
	35,36,37,38,39,
	50,51,52,53,54,
	65,66,67,68,69
}
mod.ShadingBg.TinySquareL = {}
mod.ShadingBg.TinySquareL.Floor = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.TinySquareL.Floor:Play("TinySquareFloors")
mod.ShadingBg.TinySquareL.Wall = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.TinySquareL.Wall:Play("TinySquareWalls")
mod.ShadingBg.TinySquareL.Shading = Sprite("gfx/backdrop/shading_desecration.anm2", true)
mod.ShadingBg.TinySquareL.Shading:Play("Shading")
mod.ShadingBg.TinySquareL.Shading:ReplaceSpritesheet(0, "gfx/backdrop/shading_closet_l.png", true)
mod.ShadingBg.TinySquareL.WallGrids = {
	49,50,51,52,53,54,55,56,57,58,
	64,65,66,67,68,69,70,71,72,73,
	79,80,81,82,83,84,85,86,87,88
}
mod.ShadingBg.TinySquareR = {}
mod.ShadingBg.TinySquareR.Floor = mod.ShadingBg.TinySquareL.Floor
mod.ShadingBg.TinySquareR.Wall = mod.ShadingBg.TinySquareL.Wall
mod.ShadingBg.TinySquareR.Shading = mod.ShadingBg.TinySquareL.Shading
mod.ShadingBg.TinySquareR.WallGrids = {
	46,47,48,49,50,51,52,53,54,55,
	61,62,63,64,65,66,67,68,69,70,
	76,77,78,79,80,81,82,83,84,85
}
mod.ShadingBg.TinySquareU = {}
mod.ShadingBg.TinySquareU.Floor = mod.ShadingBg.TinySquareL.Floor
mod.ShadingBg.TinySquareU.Wall = mod.ShadingBg.TinySquareL.Wall
mod.ShadingBg.TinySquareU.Shading = mod.ShadingBg.TinySquareL.Shading
mod.ShadingBg.TinySquareU.WallGrids = {
	20,			24,
	35,			39,
	50,			54,
	65,66,67,68,69,
	80,81,82,83,84,
	95,96,97,98,99,
	110,111,112,113,114
}
mod.ShadingBg.TinySquareD = {}
mod.ShadingBg.TinySquareD.Floor = mod.ShadingBg.TinySquareL.Floor
mod.ShadingBg.TinySquareD.Wall = mod.ShadingBg.TinySquareL.Wall
mod.ShadingBg.TinySquareD.Shading = mod.ShadingBg.TinySquareL.Shading
mod.ShadingBg.TinySquareD.WallGrids = {
	20,21,22,23,24,
	35,36,37,38,39,
	50,51,52,53,54,
	65,66,67,68,69,
	80,			84,
	95,			99,
	110,		114
}
mod.ShadingBg.DefaultRenderPos = Vector(60,140)
mod.ShadingBg.Current = "IH"
mod.ShadingBg.ShouldRender = false
mod.ShadingBg.CurrentBackdrop = BackdropType.BASEMENT
mod.ShadingBg.BackdropsSprites = {
	mod.ShadingBg.ClosetL.Floor,
	mod.ShadingBg.ClosetL.Wall,
	mod.ShadingBg.SquareL.Floor,
	mod.ShadingBg.SquareL.Wall,
	mod.ShadingBg.TinyClosetL.Floor,
	mod.ShadingBg.TinyClosetL.Wall
}
--mod.ShadingBg.ActiveCam = Options.CameraStyle   mod.ShadingBg.ClosetL.WallGrids

function mod.BackdropHasWalls(backdrop)
	return backdrop ~= BackdropType.DARKROOM and backdrop ~= BackdropType.MEGA_SATAN and backdrop ~= BackdropType.ERROR_ROOM and backdrop ~= BackdropType.DUNGEON and backdrop ~= BackdropType.PLANETARIUM and backdrop ~= BackdropType.DOGMA and backdrop ~= BackdropType.DUNGEON_GIDEON and backdrop ~= BackdropType.DUNGEON_ROTGUT and backdrop ~= BackdropType.DUNGEON_BEAST
end

function mod.PreRenderWallsShading(color)
	local game = Game()
	local room = game:GetRoom()
	local backdrop = room:GetBackdropType()
	local roomShape = room:GetRoomShape()
	mod.ShadingBg.ShouldRender = false

	if backdrop ~- BackdropType.CLOSET and backdrop ~- BackdropType.CLOSET_B and mod.BackdropHasWalls(backdrop) then
		if roomShape == RoomShape.ROOMSHAPE_IH then
			mod.ShadingBg.ShouldRender = true

			local doClosetL = true
			for _,grid in ipairs(mod.ShadingBg.ClosetL.WallGrids) do
				if room:GetGridCollision(grid) ~= GridCollisionClass.COLLISION_WALL then
					doClosetL = false
					break
				end
			end
			if doClosetL then
				mod.ShadingBg.Current = "ClosetL"
			else

				local doClosetR = true
				for _,grid in ipairs(mod.ShadingBg.ClosetR.WallGrids) do
					if room:GetGridCollision(grid) ~= GridCollisionClass.COLLISION_WALL then
						doClosetR = false
						break
					end
				end
				if doClosetR then
					mod.ShadingBg.Current = "ClosetR"
				else

					mod.ShadingBg.Current = "IH"
				end
			end
		end
	end

	if mod.ShadingBg.ShouldRender then
		if mod.ShadingBg.CurrentBackdrop ~= backdrop then
			mod.ShadingBg.CurrentBackdrop = backdrop
			for _,sprite in ipairs(mod.ShadingBg.BackdropsSprites) do
				local backdropData = XMLData.GetEntryById(XMLNode.BACKDROP, backdrop)
				if backdropData.gfx then
					for i=1, 16 do
						sprite:ReplaceSpritesheet(i, "gfx/backdrop/" .. backdropData.gfx, false)
					end
				end
				sprite:LoadGraphics()
			end
		end
		if Isaac.CountEntities(nil, EntityType.ENTITY_EFFECT, EffectVariant.DESECRATION, mod.Effects.FAKE_WALL_HANDLER) == 0 then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DESECRATION, mod.Effects.FAKE_WALL_HANDLER, Vector(0,-1500), Vector.Zero, nil).SortingLayer = SortingLayer.SORTING_DOOR
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DESECRATION, mod.Effects.FAKE_WALL_HANDLER, Vector(0,-1500), Vector.Zero, nil).SortingLayer = SortingLayer.SORTING_BACKGROUND
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_BACKDROP_RENDER_WALLS, mod.PreRenderWallsShading)

mod.ModEffectRenderFuncs[mod.Effects.FAKE_WALL_HANDLER] = function(effect,sprite,data)
	if mod.ShadingBg.ShouldRender and mod.ShadingBg[mod.ShadingBg.Current] then
		if effect.SortingLayer == SortingLayer.SORTING_DOOR then
			if mod.ShadingBg[mod.ShadingBg.Current].Wall then
				mod.ShadingBg[mod.ShadingBg.Current].Wall:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.Current].RenderPos or mod.ShadingBg.DefaultRenderPos))
			end
			if mod.ShadingBg[mod.ShadingBg.Current].Shading then
				mod.ShadingBg[mod.ShadingBg.Current].Shading:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.Current].ShadingPos or mod.ShadingBg.DefaultRenderPos))
			end
		end
		if effect.SortingLayer == SortingLayer.SORTING_BACKGROUND then
			if mod.ShadingBg[mod.ShadingBg.Current].Floor then
				mod.ShadingBg[mod.ShadingBg.Current].Floor:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.Current].RenderPos or mod.ShadingBg.DefaultRenderPos))
			end
		end
	end
end

--[[
mod.ShadingBg.CurrentCamPos = nil
mod.framemult = 20
function mod.OnRenderShading()
	local game = Game()
	local room = game:GetRoom()
	if mod.ShadingBg.ShouldRender then
		if mod.ShadingBg[mod.ShadingBg.Current] and mod.ShadingBg[mod.ShadingBg.Current].CameraPos then
			Options.CameraStyle = 2
			local camera = room:GetCamera()
			if camera:IsClampEnabled() then
				camera:SetClampEnabled(false)
			end
			mod.ShadingBg.CurrentCamPos = Vector(mod.ShadingBg[mod.ShadingBg.Current].CameraPosStart.X,mod.ShadingBg[mod.ShadingBg.Current].CameraPosStart.Y)
			camera:SnapToPosition(mod.ShadingBg.CurrentCamPos:Lerp(mod.ShadingBg[mod.ShadingBg.Current].CameraPos,math.min(room:GetFrameCount()/mod.framemult,1)))
		end
	elseif Options.CameraStyle ~= mod.ShadingBg.ActiveCam and room:GetFrameCount() < 10 then
		Options.CameraStyle = mod.ShadingBg.ActiveCam
	end
end
mod.AddCallback(ModCallbacks.MC_POST_RENDER, mod.OnRenderShading)
]]
