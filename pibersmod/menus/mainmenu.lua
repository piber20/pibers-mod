PibersMod.LastFrame = -1
PibersMod.LastPageAnim = "Idle"
PibersMod.EvenFrame = false
PibersMod.LastElement = 0
function PibersMod:OnMainMenuRender()
	PibersMod.EvenFrame = not PibersMod.EvenFrame
	local currentActive = MenuManager:GetActiveMenu()
	if currentActive == MainMenuType.GAME then
		local selected = MainMenu.GetSelectedElement()
		if selected == 2 then
			if PibersMod.LastElement < 2 then
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
		PibersMod.LastElement = selected
	end
end
PibersMod:AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, PibersMod.OnMainMenuRender)
