PibersMod.CathedralSprite = {}
PibersMod.CathedralSprite.Big = Sprite("gfx/backdrop/10_cathedralfloordetails.anm2", true)
PibersMod.CathedralSprite.Big:Play("Big")
PibersMod.CathedralSprite.Wide = Sprite("gfx/backdrop/10_cathedralfloordetails.anm2", true)
PibersMod.CathedralSprite.Wide:Play("Wide")
PibersMod.CathedralSprite.Tall = Sprite("gfx/backdrop/10_cathedralfloordetails.anm2", true)
PibersMod.CathedralSprite.Tall:Play("Tall")
PibersMod.CathedralSprite.RenderPos = Vector(60,140)
function PibersMod:PreRenderWallsCathedral(color)
	local game = Game()
	local room = game:GetRoom()
	local backdrop = room:GetBackdropType()
	if backdrop == BackdropType.CATHEDRAL then
		local roomShape = room:GetRoomShape()
		if roomShape == RoomShape.ROOMSHAPE_1x2 then
			PibersMod.CathedralSprite.Tall:Render(Isaac.WorldToScreen(PibersMod.CathedralSprite.RenderPos))
		elseif roomShape == RoomShape.ROOMSHAPE_2x1 then
			PibersMod.CathedralSprite.Wide:Render(Isaac.WorldToScreen(PibersMod.CathedralSprite.RenderPos))
		elseif roomShape == RoomShape.ROOMSHAPE_2x2 then
			PibersMod.CathedralSprite.Big:Render(Isaac.WorldToScreen(PibersMod.CathedralSprite.RenderPos))
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_BACKDROP_RENDER_WALLS, PibersMod.PreRenderWallsCathedral)
