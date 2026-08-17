local mod = PibersMod

function mod.OnNewRoomRunes()
	if mod.ColdActive and mod.ColdTimer > 6 then
		mod.ColdTimer = 0
		mod.ColdActive = false
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomRunes)

function mod.OnUpdateRunes()
	if mod.ColdTimer > 0 then
		mod.ColdTimer = mod.ColdTimer - 1
		if mod.ColdMult > 0.5 then
			mod.ColdMult = mod.ColdMult - 0.05
		end

		if mod.ColdTimer <= 0 and mod.ColdActive then
			for _, entity in pairs(Isaac.GetRoomEntities()) do
				if entity:IsVulnerableEnemy() then
					entity.Velocity = entity.Velocity * mod.ColdMult
					if mod.ColdTimer <= 0 then
						local data = mod.GetData(entity)
						if data.OldColor then
							entity.Color = data.OldColor
							entity:ClearEntityFlags(EntityFlag.FLAG_ICE)
						end
					end
				end
			end
			mod.ColdMult = 1
			mod.ColdActive = false
			mod.ColdTimer = 0
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_UPDATE, mod.OnUpdateRunes)

mod.InvisibleColor = Color(1,1,1,0)
mod.ColdCloud = Sprite("gfx/overlays/cold_cloud.anm2", true)
mod.ColdCloud:Play("Idle", true)
mod.ColdColor = Color(1,1,1,0,0.2,0.3,0.5)
mod.ColdActive = false
mod.ColdTimer = 0
mod.ColdMult = 1
function mod.OnUseIsaz(cardID, player, useFlags)
	local sfx = SFXManager()
	sfx:Play(SoundEffect.SOUND_DEATH_CARD, 1, 0, false, 1)
	mod.ColdActive = true
	mod.ColdTimer = 300
	mod.ColdCloud.Rotation = 0
	mod.ColdCloud.Color = mod.InvisibleColor
end
mod.AddCallback(ModCallbacks.MC_USE_CARD, mod.OnUseIsaz, Card.RUNE_ISAZ)

function mod.OnUseWunjo(cardID, player, useFlags)
	player:AddEternalHearts(1)
end
mod.AddCallback(ModCallbacks.MC_USE_CARD, mod.OnUseWunjo, Card.RUNE_WUNJO)

function mod.OnRenderItems()
	local game = Game()
	local renderColdCloud = false
	if game:IsPaused() then
		if mod.ColdCloud.Color.A > 0.01 then
			renderColdCloud = true
		end
	else
		renderColdCloud = false
		if mod.ColdActive then
			mod.ColdCloud.Color = Color.Lerp(mod.ColdCloud.Color,Color.Default,0.05)
			renderColdCloud = true
		else
			if mod.ColdCloud.Color.A > 0.01 then
				mod.ColdCloud.Color = Color.Lerp(mod.ColdCloud.Color,mod.InvisibleColor,0.035)
				renderColdCloud = true
			end
		end
		if renderColdCloud then
			mod.ColdCloud.Rotation = mod.ColdCloud.Rotation + 1
		end
	end
	if renderColdCloud then
		local centerPos = Vector(Isaac.GetScreenWidth(), Isaac.GetScreenHeight()) / 2
		mod.ColdCloud:Render(centerPos, Vector.Zero, Vector.Zero)
	end
end
mod.AddCallback(ModCallbacks.MC_POST_RENDER, mod.OnRenderItems)
