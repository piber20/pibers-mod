function PibersMod:onGusherInitUpdate(npc)
	if npc.Variant == 0 or npc.Variant == 1 then
		local data = PibersMod.GetData(npc)
		if data.ReplaceSprite and not data.ReplacedSprite then
			local sprite = npc:GetSprite()
			local anm2 = sprite:GetFilename()
			sprite:Reset()
			sprite:Load(anm2, false)
			sprite:ReplaceSpritesheet(0, data.ReplaceSprite, true)
			data.ReplacedSprite = true
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onGusherInitUpdate, EntityType.ENTITY_GUSHER)
PibersMod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, PibersMod.onGusherInitUpdate, EntityType.ENTITY_GUSHER)

function PibersMod:onMrMawInitUpdate(npc)
	local data = PibersMod.GetData(npc)
	if not data.ReplacedSprite then
		if npc.Variant == 0 or npc.Variant == 1 then
			data.ReplaceSprite = "gfx/monsters/classic/monster_141_maw_gusher.png"
		elseif npc.Variant == 2 or npc.Variant == 3 then
			data.ReplaceSprite = "gfx/monsters/classic/monster_142_redmaw_gusher.png"
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onMrMawInitUpdate, EntityType.ENTITY_MRMAW)
PibersMod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, PibersMod.onMrMawInitUpdate, EntityType.ENTITY_MRMAW)

function PibersMod:onLeperInitUpdate(npc)
	local data = PibersMod.GetData(npc)
	if not data.ReplacedSprite then
		if npc.Variant == 0 then
			data.ReplaceSprite = "gfx/monsters/afterbirthplus/leper_body_gusher.png"
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onLeperInitUpdate, EntityType.ENTITY_LEPER)
PibersMod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, PibersMod.onLeperInitUpdate, EntityType.ENTITY_LEPER)

function PibersMod:onFredUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Jump") then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
	end
	if sprite:IsEventTriggered("Land") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -PibersMod.PickupPoofOffset
		poofSprite.Scale = PibersMod.PoofScaleSmall
	end
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = PibersMod.Monstro2PoofOffset
		poofSprite.Color = PibersMod.BloodPoofColor
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onFredUpdate, EntityType.ENTITY_FRED)

function PibersMod:onMemBrainUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -PibersMod.PickupPoofOffset
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onMemBrainUpdate, EntityType.ENTITY_MEMBRAIN)

function PibersMod:onLeaperUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("BigJumpDown") then
		if sprite:IsEventTriggered("Land") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -PibersMod.PickupPoofOffset
			poofSprite.Scale = PibersMod.PoofScaleSmall
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onLeaperUpdate, EntityType.ENTITY_LEAPER)

PibersMod.SpittyPoofOffset = Vector(12,-3)
PibersMod.SpittyPoofOffsetFlip = Vector(-12,-3)
PibersMod.SpittyPoofOffsetUp = Vector(0,-12)
function PibersMod:onSpittyUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		if sprite:IsPlaying("Attack Up") then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.SpittyPoofOffsetUp, Vector.Zero, npc)
		else
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			if sprite:IsPlaying("Attack Hori") then
				if sprite.FlipX then
					poofSprite.Offset = PibersMod.SpittyPoofOffsetFlip
				else
					poofSprite.Offset = PibersMod.SpittyPoofOffset
				end
			else
				poofSprite.Offset = PibersMod.PickupPoofOffset
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onSpittyUpdate, EntityType.ENTITY_SPITTY)

PibersMod.BoilPoofOffset = Vector(0,-14)
function PibersMod:onBoilUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = PibersMod.BoilPoofOffset
		if npc.Variant == 1 then
			poofSprite.Color = Color.ProjectileIpecac
		elseif npc.Variant == 2 then
			poofSprite.Color = PibersMod.WhiteCreepColor
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onBoilUpdate, EntityType.ENTITY_BOIL)

PibersMod.WalkingBoilOffsetUp = Vector(0,-22)
function PibersMod:onWalkingBoilUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = PibersMod.WalkingBoilOffsetUp
		if npc.Variant == 1 then
			poofSprite.Color = Color.ProjectileIpecac
		elseif npc.Variant == 2 then
			poofSprite.Color = PibersMod.WhiteCreepColor
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onWalkingBoilUpdate, EntityType.ENTITY_WALKINGBOIL)

PibersMod.KeeperPoofOffset = Vector(0,-6)
function PibersMod:onKeeperUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = PibersMod.KeeperPoofOffset
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onKeeperUpdate, EntityType.ENTITY_KEEPER)

PibersMod.HangerPoofOffset = Vector(0,-24)
function PibersMod:onHangerUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = PibersMod.HangerPoofOffset
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onHangerUpdate, EntityType.ENTITY_HANGER)

function PibersMod:onBabyUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = PibersMod.FallenPoofOffset
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onBabyUpdate, EntityType.ENTITY_BABY)

PibersMod.EternalFlyOrbitDistParents = {}
PibersMod.EternalFlyOrbitDistParents[EntityType.ENTITY_DUKE] = 55
function PibersMod:preEternalFlyUpdate(npc)
	if npc.Parent then
		local parentData = PibersMod.GetData(npc.Parent)
		if parentData.FlyOrbitDist or PibersMod.EternalFlyOrbitDistParents[npc.Parent.Type] then
			local orbitDist = parentData.FlyOrbitDist or PibersMod.EternalFlyOrbitDistParents[npc.Parent.Type]
			npc.Position = npc.Parent.Position + Vector(0, orbitDist):Rotated((npc.FrameCount*2)+npc.StateFrame)
			npc.Velocity = Vector.Zero
			local sprite = npc:GetSprite()
			if not sprite:IsPlaying() then
				sprite:Play("Fly")
			end
			return true
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, PibersMod.preEternalFlyUpdate, EntityType.ENTITY_ETERNALFLY)

function PibersMod:preEternalFlyDamage(entity, amount, flags, source, countdown, extraSource)
	if entity.Parent and PibersMod.EternalFlyOrbitDistParents[entity.Parent.Type] then
		return false
	end
end
PibersMod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, PibersMod.preEternalFlyDamage, EntityType.ENTITY_ETERNALFLY)
