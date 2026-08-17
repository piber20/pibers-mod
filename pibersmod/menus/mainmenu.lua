local mod = PibersMod

mod.LastFrame = -1
mod.LastPageAnim = "Idle"
mod.EvenFrame = false
mod.LastElement = 0
function mod.OnMainMenuRender()
	mod.EvenFrame = not mod.EvenFrame
	local currentActive = MenuManager:GetActiveMenu()
	if currentActive == MainMenuType.GAME then
		local selected = MainMenu.GetSelectedElement()
		if selected == 2 then
			if mod.LastElement < 2 then
				MainMenu.SetSelectedElement(3)
			else
				local frameData = MainMenu.GetGameMenuSprite():GetLayerFrameData(2)
				if frameData:GetStartFrame() > 0 then
					MainMenu.SetSelectedElement(0)
				else
					MainMenu.SetSelectedElement(1)
				end
			end
		end
		mod.LastElement = selected
	end
end
mod.AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, mod.OnMainMenuRender)
