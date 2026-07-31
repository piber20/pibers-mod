function PibersMod:OnNewRoomRunes()
	if PibersMod.ColdActive and PibersMod.ColdTimer > 6 then
		PibersMod.ColdTimer = 0
		PibersMod.ColdActive = false
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PibersMod.OnNewRoomRunes)

function PibersMod:OnUpdateRunes()
	if PibersMod.ColdTimer > 0 then
		PibersMod.ColdTimer = PibersMod.ColdTimer - 1
		if PibersMod.ColdMult > 0.5 then
			PibersMod.ColdMult = PibersMod.ColdMult - 0.05
		end

		if PibersMod.ColdTimer <= 0 and PibersMod.ColdActive then
			for _, entity in pairs(Isaac.GetRoomEntities()) do
				if entity:IsVulnerableEnemy() then
					entity.Velocity = entity.Velocity * PibersMod.ColdMult
					if PibersMod.ColdTimer <= 0 then
						local data = PibersMod.GetData(entity)
						if data.OldColor then
							entity.Color = data.OldColor
							entity:ClearEntityFlags(EntityFlag.FLAG_ICE)
						end
					end
				end
			end
			PibersMod.ColdMult = 1
			PibersMod.ColdActive = false
			PibersMod.ColdTimer = 0
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_UPDATE, PibersMod.OnUpdateRunes)

PibersMod.InvisibleColor = Color(1,1,1,0)
PibersMod.ColdCloud = Sprite("gfx/overlays/cold_cloud.anm2", true)
PibersMod.ColdCloud:Play("Idle", true)
PibersMod.ColdColor = Color(1,1,1,0,0.2,0.3,0.5)
PibersMod.ColdActive = false
PibersMod.ColdTimer = 0
PibersMod.ColdMult = 1
function PibersMod:OnUseIsaz(cardID, player, useFlags)
	local sfx = SFXManager()
	sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
	PibersMod.ColdActive = true
	PibersMod.ColdTimer = 300
	PibersMod.ColdCloud.Rotation = 0
	PibersMod.ColdCloud.Color = PibersMod.InvisibleColor
end
PibersMod:AddCallback(ModCallbacks.MC_USE_CARD, PibersMod.OnUseIsaz, Card.RUNE_ISAZ)

function PibersMod:OnUseWunjo(cardID, player, useFlags)
	player:AddEternalHearts(1)
end
PibersMod:AddCallback(ModCallbacks.MC_USE_CARD, PibersMod.OnUseWunjo, Card.RUNE_WUNJO)

function PibersMod:OnRenderItems()
	local game = Game()
	local renderColdCloud = false
	if game:IsPaused() then
		if PibersMod.ColdCloud.Color.A > 0.01 then
			renderColdCloud = true
		end
	else
		renderColdCloud = false
		if PibersMod.ColdActive then
			PibersMod.ColdCloud.Color = Color.Lerp(PibersMod.ColdCloud.Color,Color.Default,0.05)
			renderColdCloud = true
		else
			if PibersMod.ColdCloud.Color.A > 0.01 then
				PibersMod.ColdCloud.Color = Color.Lerp(PibersMod.ColdCloud.Color,PibersMod.InvisibleColor,0.035)
				renderColdCloud = true
			end
		end
		if renderColdCloud then
			PibersMod.ColdCloud.Rotation = PibersMod.ColdCloud.Rotation + 1
		end
	end
	if renderColdCloud then
		local centerPos = Vector(Isaac.GetScreenWidth(), Isaac.GetScreenHeight()) / 2
		PibersMod.ColdCloud:Render(centerPos, Vector.Zero, Vector.Zero)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_RENDER, PibersMod.OnRenderItems)
