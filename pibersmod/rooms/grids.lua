PibersMod.FireplacePoofColor = {}
PibersMod.FireplacePoofColor[0] = Color(1.0,0.5,0.0,0.3)
PibersMod.FireplacePoofColor[FireplaceVariant.RED] = Color(1.0,0.2,0.0,0.3)
PibersMod.FireplacePoofColor[FireplaceVariant.BLUE] = Color(0.6,0.6,0.75,0.3)
PibersMod.FireplacePoofColor[FireplaceVariant.PURPLE] = Color(0.5,0.0,0.6,0.3)
PibersMod.FireplacePoofColor[FireplaceVariant.WHITE] = Color(1.0,1.0,1.0,0.3)
PibersMod.FireplacePoofOffset = Vector(1,-4)
PibersMod.FireplacePoofScale = Vector(0.8,0.75)
function PibersMod:OnFireplaceUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:GetFrame() == 0 and (sprite:IsPlaying("Dissapear") or sprite:IsPlaying("Dissapear2") or sprite:IsPlaying("Dissapear3")) then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.LARGE, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()

		local color = PibersMod.FireplacePoofColor[0]
		if PibersMod.FireplacePoofColor[npc.Variant] then
			color = PibersMod.FireplacePoofColor[npc.Variant]
		end

		poofSprite.Offset = PibersMod.FireplacePoofOffset
		poofSprite.Scale = PibersMod.FireplacePoofScale
		poofSprite.Color = color
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.OnFireplaceUpdate, EntityType.ENTITY_FIREPLACE)

PibersMod.PoopPoofColor = {}
PibersMod.PoopPoofColor[0] = Color(0.35,0.18,0.16,0.3)
PibersMod.PoopPoofColor[PoopVariant.RED] = Color(0.35,0.0,0.0,0.3)
PibersMod.PoopPoofColor[PoopVariant.GOLDEN] = Color(0.8,0.6,0.45,0.3)
PibersMod.PoopPoofColor[PoopVariant.RAINBOW] = Color(0.35,0.0,0.0,0.3)
PibersMod.PoopPoofColor[PoopVariant.BLACK] = Color(0.16,0.16,0.16,0.3)
PibersMod.PoopPoofColor[PoopVariant.WHITE] = Color(0.6,0.6,0.8,0.3)
PibersMod.LastGridState = {}
PibersMod.PoopPoofScale = Vector(0.5,0.5)
function PibersMod:OnPoopUpdate(grident)
	local index = grident:GetGridIndex()
	if grident.State == 1000 and PibersMod.LastGridState[index] and PibersMod.LastGridState[index] < grident.State then
		local variant = grident:GetVariant()
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_FOREGROUND_WHITE, grident.Position+PibersMod.PoofSpawnOffset, Vector.Zero, nil)
		local poofSprite = poof:GetSprite()

		local color = PibersMod.PoopPoofColor[0]
		if PibersMod.PoopPoofColor[variant] then
			color = PibersMod.PoopPoofColor[variant]
		end

		poofSprite.Scale = PibersMod.PoopPoofScale
		poofSprite.Color = color
	end
	PibersMod.LastGridState[index] = grident.State
end
PibersMod:AddCallback(ModCallbacks.MC_POST_GRID_ENTITY_POOP_UPDATE, PibersMod.OnPoopUpdate)
