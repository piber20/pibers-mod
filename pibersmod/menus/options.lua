PibersMod.OptionsMenuIsIngame = false

PibersMod.LastFrame = -1
PibersMod.LastPageAnim = "Idle"
PibersMod.EvenFrame = false
PibersMod.LastElement = 0
function PibersMod:OnMainMenuRenderOptions()
	if not Isaac.IsInGame() and PibersMod.OptionsMenuIsIngame then
		PibersMod.OptionsMenuIsIngame = false
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
PibersMod:AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, PibersMod.OnMainMenuRenderOptions)

function PibersMod:OnIngameMenuRenderOptions()
	if Isaac.IsInGame() and not PibersMod.OptionsMenuIsIngame then
		PibersMod.OptionsMenuIsIngame = true
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
PibersMod:AddCallback(ModCallbacks.MC_POST_RENDER, PibersMod.OnIngameMenuRenderOptions)
