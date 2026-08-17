local mod = PibersMod

mod.OptionsMenuIsIngame = false

mod.LastFrame = -1
mod.LastPageAnim = "Idle"
mod.EvenFrame = false
mod.LastElement = 0
function mod.OnMainMenuRenderOptions()
	if not Isaac.IsInGame() and mod.OptionsMenuIsIngame then
		mod.OptionsMenuIsIngame = false
		local optionsSprite = OptionsMenu.GetOptionsMenuSprite()
		optionsSprite:ReplaceSpritesheet(0, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:ReplaceSpritesheet(1, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:ReplaceSpritesheet(2, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:ReplaceSpritesheet(3, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:ReplaceSpritesheet(4, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:ReplaceSpritesheet(5, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:ReplaceSpritesheet(11, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:ReplaceSpritesheet(12, "gfx/ui/main menu/optionsmenu.png", false)
		optionsSprite:LoadGraphics()
	end
end
mod.AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, mod.OnMainMenuRenderOptions)

function mod.OnIngameMenuRenderOptions()
	if Isaac.IsInGame() and not mod.OptionsMenuIsIngame then
		mod.OptionsMenuIsIngame = true
		local optionsSprite = OptionsMenu.GetOptionsMenuSprite()
		if optionsSprite then
		optionsSprite:ReplaceSpritesheet(0, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:ReplaceSpritesheet(1, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:ReplaceSpritesheet(2, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:ReplaceSpritesheet(3, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:ReplaceSpritesheet(4, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:ReplaceSpritesheet(5, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:ReplaceSpritesheet(11, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:ReplaceSpritesheet(12, "gfx/ui/main menu/optionsmenudark.png", false)
		optionsSprite:LoadGraphics()
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_RENDER, mod.OnIngameMenuRenderOptions)
