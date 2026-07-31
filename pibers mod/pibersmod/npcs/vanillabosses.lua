function PibersMod:PreEntityTakeDMGVanillaBosses(entity, amount, flags, source, cooldown)
	local ignoresArmor = flags & DamageFlag.DAMAGE_IGNORE_ARMOR > 0
	if not ignoresArmor then
		return {DamageFlags = flags | DamageFlag.DAMAGE_IGNORE_ARMOR}
	end
end
PibersMod:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, PibersMod.PreEntityTakeDMGVanillaBosses)

function PibersMod:onGeminiUpdate(npc)
	if npc.ChildNPC then
		if npc.ChildNPC.Variant ~= npc.Variant+10 or npc.ChildNPC.SubType ~= npc.SubType then
			npc.ChildNPC:Morph(EntityType.ENTITY_GEMINI, npc.Variant+10, npc.SubType, npc:GetChampionColorIdx())
		end
	end
	local bossColor = npc:GetBossColorIdx()
	if npc.Variant == GeminiVariant.CONTUSION and bossColor == BossColors.GEMINI_STEVEN then
		npc.Variant = GeminiVariant.STEVEN
		if npc.ChildNPC then
			npc.ChildNPC.Variant = GeminiVariant.STEVEN_BABY
		end
		if HPBars and HPBars.BossDefinitions then
			if HPBars.BossDefinitions["79.1"] then
				HPBars.BossDefinitions["79.1"].barStyle = nil
			end
			if HPBars.BossDefinitions["79.11"] then
				HPBars.BossDefinitions["79.11"].barStyle = nil
			end
		end
	end
	if npc.Variant == GeminiVariant.SUTURE and bossColor == BossColors.GEMINI_STEVEN_BABY then
		npc.Variant = GeminiVariant.STEVEN_BABY
	end
	if npc.Variant == GeminiVariant.CORD and bossColor == BossColors.GEMINI_STEVEN_CORD then
		npc:Remove()
	end
	if (npc.Variant == GeminiVariant.STEVEN and bossColor ~= BossColors.GEMINI_STEVEN) or (npc.Variant == GeminiVariant.STEVEN_BABY and bossColor ~= BossColors.GEMINI_STEVEN_BABY) then
		local runSave = PibersMod.SaveManager.GetRunSave()
		if not runSave.EncounteredSteven then
			runSave.EncounteredSteven = true
			runSave.Weirdness = runSave.Weirdness or PibersMod.StartingWeirdness
			runSave.Weirdness = runSave.Weirdness + 15
		end
		if HPBars and HPBars.BossDefinitions then
			if HPBars.BossDefinitions["79.1"] then
				HPBars.BossDefinitions["79.1"].barStyle = "Steven"
			end
			if HPBars.BossDefinitions["79.11"] then
				HPBars.BossDefinitions["79.11"].barStyle = "Steven"
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onGeminiUpdate, EntityType.ENTITY_GEMINI)

function PibersMod:preGeminiUpdate(npc)
	if npc.Variant == GeminiVariant.STEVEN_BABY and npc.SubType == 0 then
		local sprite = npc:GetSprite()
		if sprite:IsPlaying("Rage") then
			if sprite:WasEventTriggered("Land") then
				npc.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
				npc.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
				if not sprite:WasEventTriggered("GetUp") then
					npc.Velocity = npc.Velocity * 0.5
					return true
				end
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, PibersMod.preGeminiUpdate, EntityType.ENTITY_GEMINI)

PibersMod.StevenBabyOffsetL = Vector(32,-2)
PibersMod.StevenBabyOffsetR = Vector(-32,-2)
function PibersMod:onGeminiRender(npc, offset)
	if npc.Variant == GeminiVariant.STEVEN and npc.SubType == 0 and npc.ChildNPC and npc.HitPoints >= 60 then
		local flipx = npc:GetSprite().FlipX == true or npc.FlipX == true
		if flipx then
			npc.ChildNPC.Position = npc.Position + PibersMod.StevenBabyOffsetL
		else
			npc.ChildNPC.Position = npc.Position + PibersMod.StevenBabyOffsetR
		end
		npc.ChildNPC.Velocity = npc.Velocity
		npc.ChildNPC.DepthOffset = 10
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, PibersMod.onGeminiRender, EntityType.ENTITY_GEMINI)

function PibersMod:onStevenProjectileUpdate(proj)
	if proj.SpawnerEntity and proj.SpawnerEntity:ToNPC() then
		if proj.SpawnerEntity.Type == EntityType.ENTITY_GEMINI then
			local spawnerBossColor = proj.SpawnerEntity:ToNPC():GetBossColorIdx()
			if spawnerBossColor == BossColors.GEMINI_STEVEN or spawnerBossColor == BossColors.GEMINI_STEVEN_BABY then
				proj.Variant = ProjectileVariant.PROJECTILE_NORMAL
				local projSprite = proj:GetSprite()
				local currAnim = projSprite:GetAnimation()
				projSprite:Load("gfx/009.000_Projectile.anm2", true)
				if currAnim == "Small" then
					projSprite:Play("RegularTear3", true)
				else
					projSprite:Play("RegularTear9", true)
				end
				proj:ClearProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)
				proj.Color = Color.ProjectileTar
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, PibersMod.onStevenProjectileUpdate, ProjectileVariant.PROJECTILE_FCUK)

PibersMod.StartingWeirdness = 5
PibersMod.DontReplaceBosses = {}
PibersMod.DontReplaceBosses[BossType.MOM] = true
PibersMod.DontReplaceBosses[BossType.MOMS_HEART] = true
PibersMod.DontReplaceBosses[BossType.FAMINE] = true
PibersMod.DontReplaceBosses[BossType.PESTILENCE] = true
PibersMod.DontReplaceBosses[BossType.WAR] = true
PibersMod.DontReplaceBosses[BossType.DEATH] = true
PibersMod.DontReplaceBosses[BossType.STEVEN] = true
PibersMod.DontReplaceBosses[BossType.HEADLESS_HORSEMAN] = true
PibersMod.DontReplaceBosses[BossType.THE_FALLEN] = true
PibersMod.DontReplaceBosses[BossType.SATAN] = true
PibersMod.DontReplaceBosses[BossType.IT_LIVES] = true
PibersMod.DontReplaceBosses[BossType.CONQUEST] = true
PibersMod.DontReplaceBosses[BossType.ISAAC] = true
PibersMod.DontReplaceBosses[BossType.BLUE_BABY] = true
PibersMod.DontReplaceBosses[BossType.THE_LAMB] = true
PibersMod.DontReplaceBosses[BossType.MEGA_SATAN] = true
PibersMod.DontReplaceBosses[BossType.ULTRA_GREED] = true
PibersMod.DontReplaceBosses[BossType.HUSH] = true
PibersMod.DontReplaceBosses[BossType.DELIRIUM] = true
PibersMod.DontReplaceBosses[BossType.ULTRA_GREEDIER] = true
PibersMod.DontReplaceBosses[BossType.MOTHER] = true
PibersMod.DontReplaceBosses[BossType.MOM_MAUSOLEUM] = true
PibersMod.DontReplaceBosses[BossType.MOMS_HEART_MAUSOLEUM] = true
PibersMod.DontReplaceBosses[BossType.DOGMA] = true
PibersMod.DontReplaceBosses[BossType.THE_BEAST] = true
function PibersMod:preBossSelect(bossType, bossPool, stage, stagetype)
	if not PibersMod.DontReplaceBosses[bossType] then
		local runSave = PibersMod.SaveManager.GetRunSave()
		if not runSave.EncounteredSteven then
			runSave.Weirdness = runSave.Weirdness or PibersMod.StartingWeirdness --might use weirdness for other things
			local bossRNG = bossPool:GetRNG()
			if bossRNG:RandomInt(1, 100) <= runSave.Weirdness then
				return BossType.STEVEN
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_BOSS_SELECT, PibersMod.preBossSelect)

function PibersMod:onBlastocystBigUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Walk") and sprite:IsEventTriggered("Land") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.GROUND_FOREGROUND, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -PibersMod.PickupPoofOffset
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onBlastocystBigUpdate, EntityType.ENTITY_BLASTOCYST_BIG)

function PibersMod:onHeartOfInfamyUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("HeartAttack") and sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -PibersMod.PickupPoofOffset
		if npc.SubType == 1 then
			poofSprite.Color = Color.ProjectileHoming
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onHeartOfInfamyUpdate, EntityType.ENTITY_HEART_OF_INFAMY)

PibersMod.PoofScaleMid = Vector(0.75,0.75)
PibersMod.PoofScaleSmall = Vector(0.5,0.5)
PibersMod.SatanPoofOffset = Vector(0,-40)
PibersMod.SatanPoofOffsetLeft = Vector(-64,-42)
PibersMod.SatanPoofOffsetRight = Vector(64,-42)
PibersMod.BloodPoofColor = Color(0.8,0,0,0.5)
function PibersMod:onSatanUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack01") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.SatanPoofOffset
			poofSprite.Color = PibersMod.BloodPoofColor
		end
		if sprite:IsEventTriggered("Shoot2") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.SatanPoofOffset
			poofSprite.Scale = PibersMod.PoofScaleMid
		end
	end
	if sprite:IsPlaying("Attack02") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.SatanPoofOffset
			poofSprite.Scale = PibersMod.PoofScaleMid
		end
	end
	if sprite:IsPlaying("Attack03") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.SatanPoofOffsetLeft
			poofSprite.Color = PibersMod.BloodPoofColor
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.SatanPoofOffsetRight
			poofSprite.Color = PibersMod.BloodPoofColor
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onSatanUpdate, EntityType.ENTITY_SATAN)

PibersMod.FaminePoofOffset = Vector(2,-18)
function PibersMod:onFamineUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("HeadAttack") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.FaminePoofOffset
			poofSprite.Color = PibersMod.BloodPoofColor
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onFamineUpdate, EntityType.ENTITY_FAMINE)

PibersMod.Monstro2PoofOffset = Vector(0,-18)
function PibersMod:onMonstro2Update(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Taunt") then
		if sprite:GetFrame() == 20 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.Monstro2PoofOffset
			poofSprite.Scale = PibersMod.PoofScaleMid
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onMonstro2Update, EntityType.ENTITY_MONSTRO2)

function PibersMod:onLokiUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack01") then
		if sprite:GetFrame() == 50 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -PibersMod.PickupPoofOffset
			poofSprite.Scale = PibersMod.PoofScaleSmall
		end
		if sprite:GetFrame() == 25 or sprite:GetFrame() == 75 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -PibersMod.PickupPoofOffset
			poofSprite.Scale = PibersMod.PoofScaleSmall
		end
	end
	if sprite:IsPlaying("Attack03") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -PibersMod.PickupPoofOffset
			poofSprite.Scale = PibersMod.PoofScaleMid
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onLokiUpdate, EntityType.ENTITY_LOKI)

PibersMod.HourglassPoofColor = Color(0.5,0.4,0.25,0.5)
PibersMod.HourglassPoofOffset = Vector(23,-30)
PibersMod.HourglassPoofOffsetFlip = Vector(-23,-30)
function PibersMod:onDeathUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack02") then
		if sprite:GetFrame() == 21 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			if sprite.FlipX then
				poofSprite.Offset = PibersMod.HourglassPoofOffsetFlip
			else
				poofSprite.Offset = PibersMod.HourglassPoofOffset
			end
			poofSprite.Color = PibersMod.HourglassPoofColor
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onDeathUpdate, EntityType.ENTITY_DEATH)

PibersMod.PestilencePoofOffset = Vector(0,-34)
PibersMod.WhiteCreepColor = Color(0,0,0,1,1,1,1)
function PibersMod:onPestilenceUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack1") then
		if sprite:GetFrame() == 17 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.PestilencePoofOffset
			if npc.SubType == 1 then
				poofSprite.Color = PibersMod.WhiteCreepColor
			else
				poofSprite.Color = Color.ProjectileIpecac
			end
		end
	end
	if sprite:IsPlaying("Attack2") then
		if sprite:GetFrame() == 22 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -PibersMod.PickupPoofOffset
			if npc.SubType == 1 then
				poofSprite.Color = PibersMod.WhiteCreepColor
			else
				poofSprite.Color = Color.ProjectileIpecac
			end
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_FOREGROUND, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.PickupPoofOffset
			if npc.SubType == 1 then
				poofSprite.Color = PibersMod.WhiteCreepColor
			else
				poofSprite.Color = Color.ProjectileIpecac
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onPestilenceUpdate, EntityType.ENTITY_PESTILENCE)

function PibersMod:onWarUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack1") then
		if sprite:GetFrame() == 5 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position-PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.PestilencePoofOffset
			poofSprite.Scale = PibersMod.PoofScaleMid
			if npc.Variant == 1 then
				poofSprite.Color = Color.ProjectileHoming
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onWarUpdate, EntityType.ENTITY_WAR)

PibersMod.HeadlessHorsemanHeadPoofOffset = Vector(0,-12)
function PibersMod:onHeadlessHorsemanHeadUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack") then
		if sprite:GetFrame() == 16 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.HeadlessHorsemanHeadPoofOffset
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onHeadlessHorsemanHeadUpdate, EntityType.ENTITY_HORSEMAN_HEAD)

PibersMod.HeadlessHorsemanPoofOffset = Vector(0,-28)
function PibersMod:onHeadlessHorsemanUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack") then
		if sprite:GetFrame() == 8 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.HeadlessHorsemanPoofOffset
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onHeadlessHorsemanUpdate, EntityType.ENTITY_HEADLESS_HORSEMAN)

PibersMod.FallenPoofOffset = Vector(0,-18)
function PibersMod:onFallenUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") or sprite:IsEventTriggered("Shoot2") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = PibersMod.FallenPoofOffset
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onFallenUpdate, EntityType.ENTITY_FALLEN)

function PibersMod:onSlothUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack") then
		if sprite:GetFrame() == 4 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.FallenPoofOffset
			poofSprite.Color = Color.ProjectileIpecac
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onSlothUpdate, EntityType.ENTITY_SLOTH)

PibersMod.PinPoofOffset = Vector(0,-56)
function PibersMod:onPinUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack1") then
		if sprite:GetFrame() == 44 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+PibersMod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = PibersMod.PinPoofOffset
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onPinUpdate, EntityType.ENTITY_PIN)

PibersMod.DukeFlyOrbitDist = 40
function PibersMod:onDukeUpdate(npc)
	if npc:GetBossColorIdx() == BossColors.DUKE_ETERNAL then
		local data = PibersMod.GetData(npc)
		if not data.SpawnedFlies then
			for i=1, 3 do
				local fly = Isaac.Spawn(EntityType.ENTITY_ETERNALFLY, 0, 0, npc.Position, Vector.Zero, npc):ToNPC()
				fly.Parent = npc
				fly.StateFrame = i
			end
			data.SpawnedFlies = true
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_NPC_UPDATE, PibersMod.onDukeUpdate, EntityType.ENTITY_DUKE)

function PibersMod:onDukeEternalFlyUpdate(npc)
	if npc.Parent and npc.Parent.Type == EntityType.ENTITY_DUKE then
		local dukePos = npc.Parent.Position
		local currentOrbitPos = dukePos - npc.Position
		npc.Position = dukePos + currentOrbitPos:Resized(PibersMod.DukeFlyOrbitDist)
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, PibersMod.onDukeEternalFlyUpdate, EntityType.ENTITY_ETERNALFLY)
