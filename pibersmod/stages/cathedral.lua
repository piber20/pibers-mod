local mod = PibersMod

mod.CathedralSprite = {}
mod.CathedralSprite.Big = Sprite("gfx/backdrop/10_cathedralfloordetails.anm2", true)
mod.CathedralSprite.Big:Play("Big")
mod.CathedralSprite.Wide = Sprite("gfx/backdrop/10_cathedralfloordetails.anm2", true)
mod.CathedralSprite.Wide:Play("Wide")
mod.CathedralSprite.Tall = Sprite("gfx/backdrop/10_cathedralfloordetails.anm2", true)
mod.CathedralSprite.Tall:Play("Tall")
mod.CathedralSprite.RenderPos = Vector(60,140)
function mod.PreRenderWallsCathedral(color)
	local game = Game()
	local room = game:GetRoom()
	local backdrop = room:GetBackdropType()
	if backdrop == BackdropType.CATHEDRAL then
		local roomShape = room:GetRoomShape()
		if roomShape == RoomShape.ROOMSHAPE_1x2 then
			mod.CathedralSprite.Tall:Render(Isaac.WorldToScreen(mod.CathedralSprite.RenderPos))
		elseif roomShape == RoomShape.ROOMSHAPE_2x1 then
			mod.CathedralSprite.Wide:Render(Isaac.WorldToScreen(mod.CathedralSprite.RenderPos))
		elseif roomShape == RoomShape.ROOMSHAPE_2x2 then
			mod.CathedralSprite.Big:Render(Isaac.WorldToScreen(mod.CathedralSprite.RenderPos))
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_BACKDROP_RENDER_WALLS, mod.PreRenderWallsCathedral)
