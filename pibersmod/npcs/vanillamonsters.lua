local mod = PibersMod

function mod.onGusherInitUpdate(npc)
	if npc.Variant == 0 or npc.Variant == 1 then
		local data = mod.GetData(npc)
		if data.ReplaceSprite and not data.ReplacedSprite then
			local sprite = npc:GetSprite()
			local anm2 = sprite:GetFilename()
			sprite:Reset()
			sprite:Load(anm2, false)
			npc:ReplaceSpritesheet(0, data.ReplaceSprite, true)
			data.ReplacedSprite = true
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onGusherInitUpdate, EntityType.ENTITY_GUSHER)
mod.AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.onGusherInitUpdate, EntityType.ENTITY_GUSHER)

function mod.onMrMawInitUpdate(npc)
	local data = mod.GetData(npc)
	if not data.ReplacedSprite then
		if npc.Variant == 0 or npc.Variant == 1 then
			data.ReplaceSprite = "gfx/monsters/classic/monster_141_maw_gusher.png"
		elseif npc.Variant == 2 or npc.Variant == 3 then
			data.ReplaceSprite = "gfx/monsters/classic/monster_142_redmaw_gusher.png"
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onMrMawInitUpdate, EntityType.ENTITY_MRMAW)
mod.AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.onMrMawInitUpdate, EntityType.ENTITY_MRMAW)

function mod.onLeperInitUpdate(npc)
	local data = mod.GetData(npc)
	if not data.ReplacedSprite then
		if npc.Variant == 0 then
			data.ReplaceSprite = "gfx/monsters/afterbirthplus/leper_body_gusher.png"
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onLeperInitUpdate, EntityType.ENTITY_LEPER)
mod.AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.onLeperInitUpdate, EntityType.ENTITY_LEPER)

function mod.onFredUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Jump") then
		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
	end
	if sprite:IsEventTriggered("Land") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -mod.PickupPoofOffset
		poofSprite.Scale = mod.PoofScaleSmall
	end
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.Monstro2PoofOffset
		poofSprite.Color = mod.BloodPoofColor
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onFredUpdate, EntityType.ENTITY_FRED)

function mod.onMemBrainUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -mod.PickupPoofOffset
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onMemBrainUpdate, EntityType.ENTITY_MEMBRAIN)

function mod.onLeaperUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("BigJumpDown") then
		if sprite:IsEventTriggered("Land") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -mod.PickupPoofOffset
			poofSprite.Scale = mod.PoofScaleSmall
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onLeaperUpdate, EntityType.ENTITY_LEAPER)

mod.SpittyPoofOffset = Vector(12,-3)
mod.SpittyPoofOffsetFlip = Vector(-12,-3)
mod.SpittyPoofOffsetUp = Vector(0,-12)
function mod.onSpittyUpdate(npc)
	local sprite = npc:GetSprite()
	if npc.SpawnerEntity and npc.SpawnerType == EntityType.ENTITY_CHUB and npc.SpawnerEntity.SubType == 2 then
		local data = mod.GetData(npc)
		if not data.ReplacedSprite then
			npc:ReplaceSpritesheet(0, "gfx/monsters/classic/monster_115_spitty_orange.png", true)
			data.ReplacedSprite = true
		end
	end
	if sprite:IsEventTriggered("Shoot") then
		if sprite:IsPlaying("Attack Up") then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.SpittyPoofOffsetUp, Vector.Zero, npc)
		else
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			if sprite:IsPlaying("Attack Hori") then
				if sprite.FlipX then
					poofSprite.Offset = mod.SpittyPoofOffsetFlip
				else
					poofSprite.Offset = mod.SpittyPoofOffset
				end
			else
				poofSprite.Offset = mod.PickupPoofOffset
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onSpittyUpdate, EntityType.ENTITY_SPITTY)

mod.BoilPoofOffset = Vector(0,-14)
function mod.onBoilUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.BoilPoofOffset
		if npc.Variant == 1 then
			poofSprite.Color = Color.ProjectileIpecac
		elseif npc.Variant == 2 then
			poofSprite.Color = mod.WhiteCreepColor
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onBoilUpdate, EntityType.ENTITY_BOIL)

mod.WalkingBoilOffsetUp = Vector(0,-22)
function mod.onWalkingBoilUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.WalkingBoilOffsetUp
		if npc.Variant == 1 then
			poofSprite.Color = Color.ProjectileIpecac
		elseif npc.Variant == 2 then
			poofSprite.Color = mod.WhiteCreepColor
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onWalkingBoilUpdate, EntityType.ENTITY_WALKINGBOIL)

mod.KeeperPoofOffset = Vector(0,-6)
function mod.onKeeperUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.KeeperPoofOffset
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onKeeperUpdate, EntityType.ENTITY_KEEPER)

mod.HangerPoofOffset = Vector(0,-24)
function mod.onHangerUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.HangerPoofOffset
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onHangerUpdate, EntityType.ENTITY_HANGER)

function mod.onBabyUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.FallenPoofOffset
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onBabyUpdate, EntityType.ENTITY_BABY)

mod.EternalFlyOrbitDistParents = {}
mod.EternalFlyOrbitDistParents[EntityType.ENTITY_DUKE] = 55
function mod.preEternalFlyUpdate(npc)
	if npc.Parent and npc.Parent:Exists() and not npc.Parent:IsDead() then
		local parentData = mod.GetData(npc.Parent)
		if parentData.FlyOrbitDist or mod.EternalFlyOrbitDistParents[npc.Parent.Type] then
			local orbitDist = parentData.FlyOrbitDist or mod.EternalFlyOrbitDistParents[npc.Parent.Type]
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
mod.AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, mod.preEternalFlyUpdate, EntityType.ENTITY_ETERNALFLY)

function mod.preEternalFlyDamage(entity, amount, flags, source, countdown, extraSource)
	if entity.Parent and mod.EternalFlyOrbitDistParents[entity.Parent.Type] then
		return false
	end
end
mod.AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.preEternalFlyDamage, EntityType.ENTITY_ETERNALFLY)

function mod.onLilHauntUpdate(npc)
	if npc.Variant == 10 then
		if npc.Parent and npc.Parent.Type == EntityType.ENTITY_THE_HAUNT then
			local data = mod.GetData(npc)
			if not data.ReplacedSprite then
				if npc.Parent.SubType == 1 then
					npc:ReplaceSpritesheet(0, "gfx/monsters/rebirth/260.010_lilhaunt_black.png", true)
				elseif npc.Parent.SubType == 2 then
					npc:ReplaceSpritesheet(0, "gfx/monsters/rebirth/260.010_lilhaunt_pink.png", true)
				end
				data.ReplacedSprite = true
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onLilHauntUpdate, EntityType.ENTITY_THE_HAUNT)

function mod.onLumpUpdate(npc)
	if Isaac.GetCurrentStageConfigId() == StbType.CORPSE and Game():GetRoom():GetBackdropType() == BackdropType.CORPSE2 then
		local data = mod.GetData(npc)
		if not data.ReplacedSprite then
			npc:ReplaceSpritesheet(0, "gfx/monsters/classic/monster_198_lump_corpse2.png", false)
			npc:ReplaceSpritesheet(1, "gfx/monsters/classic/monster_198_lump_corpse2.png", true)
			data.ReplacedSprite = true
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onLumpUpdate, EntityType.ENTITY_LUMP)

function mod.onGasbagUpdate(npc)
	if Isaac.GetCurrentStageConfigId() == StbType.CORPSE and Game():GetRoom():GetBackdropType() == BackdropType.CORPSE2 then
		local data = mod.GetData(npc)
		if not data.ReplacedSprite then
			npc:ReplaceSpritesheet(0, "gfx/monsters/repentance/856.000_gasbag2.png", true)
			data.ReplacedSprite = true
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onGasbagUpdate, EntityType.ENTITY_GASBAG)
