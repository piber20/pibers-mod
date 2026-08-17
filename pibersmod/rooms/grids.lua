local mod = PibersMod

mod.FireplacePoofColor = {}
mod.FireplacePoofColor[0] = Color(1.0,0.5,0.0,0.3)
mod.FireplacePoofColor[FireplaceVariant.RED] = Color(1.0,0.2,0.0,0.3)
mod.FireplacePoofColor[FireplaceVariant.BLUE] = Color(0.6,0.6,0.75,0.3)
mod.FireplacePoofColor[FireplaceVariant.PURPLE] = Color(0.5,0.0,0.6,0.3)
mod.FireplacePoofColor[FireplaceVariant.WHITE] = Color(1.0,1.0,1.0,0.3)
mod.FireplacePoofOffset = Vector(1,-4)
mod.FireplacePoofScale = Vector(0.8,0.75)
function mod.OnFireplaceUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:GetFrame() == 0 and (sprite:IsPlaying("Dissapear") or sprite:IsPlaying("Dissapear2") or sprite:IsPlaying("Dissapear3")) then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.LARGE, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()

		local color = mod.FireplacePoofColor[0]
		if mod.FireplacePoofColor[npc.Variant] then
			color = mod.FireplacePoofColor[npc.Variant]
		end

		poofSprite.Offset = mod.FireplacePoofOffset
		poofSprite.Scale = mod.FireplacePoofScale
		poofSprite.Color = color
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.OnFireplaceUpdate, EntityType.ENTITY_FIREPLACE)

mod.PoopPoofColor = {}
mod.PoopPoofColor[0] = Color(0.35,0.18,0.16,0.3)
mod.PoopPoofColor[PoopVariant.RED] = Color(0.35,0.0,0.0,0.3)
mod.PoopPoofColor[PoopVariant.GOLDEN] = Color(0.8,0.6,0.45,0.3)
mod.PoopPoofColor[PoopVariant.RAINBOW] = Color(0.35,0.0,0.0,0.3)
mod.PoopPoofColor[PoopVariant.BLACK] = Color(0.16,0.16,0.16,0.3)
mod.PoopPoofColor[PoopVariant.WHITE] = Color(0.6,0.6,0.8,0.3)
mod.LastGridState = {}
mod.PoopPoofScale = Vector(0.5,0.5)
function mod.OnPoopUpdate(grident)
	local index = grident:GetGridIndex()
	if grident.State == 1000 and mod.LastGridState[index] and mod.LastGridState[index] < grident.State then
		local variant = grident:GetVariant()
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_FOREGROUND_WHITE, grident.Position+mod.PoofSpawnOffset, Vector.Zero, nil)
		local poofSprite = poof:GetSprite()

		local color = mod.PoopPoofColor[0]
		if mod.PoopPoofColor[variant] then
			color = mod.PoopPoofColor[variant]
		end

		poofSprite.Scale = mod.PoopPoofScale
		poofSprite.Color = color
	end
	mod.LastGridState[index] = grident.State
end
mod.AddCallback(ModCallbacks.MC_POST_GRID_ENTITY_POOP_UPDATE, mod.OnPoopUpdate)
