local mod = PibersMod

local lastRoomTransMode = false
mod.BossChampionNames = {}
mod.BossChampionNames[BossType.LARRY_JR] = {}
mod.BossChampionNames[BossType.LARRY_JR][0] = "gush_green"
mod.BossChampionNames[BossType.LARRY_JR][1] = "tanky_blue"
mod.BossChampionNames[BossType.THE_HOLLOW] = {}
mod.BossChampionNames[BossType.THE_HOLLOW][0] = "gush_green"
mod.BossChampionNames[BossType.THE_HOLLOW][1] = "boom"
mod.BossChampionNames[BossType.THE_HOLLOW][2] = "gilded"
mod.BossChampionNames[BossType.MONSTRO] = {}
mod.BossChampionNames[BossType.MONSTRO][0] = "duplo_red"
mod.BossChampionNames[BossType.MONSTRO][1] = "tanky_black"
mod.BossChampionNames[BossType.CHUB] = {}
mod.BossChampionNames[BossType.CHUB][0] = "tanky_blue"
mod.BossChampionNames[BossType.CHUB][1] = "orange"
mod.BossChampionNames[BossType.THE_CARRION_QUEEN] = {}
mod.BossChampionNames[BossType.THE_CARRION_QUEEN][0] = "tanky_pink"
mod.BossChampionNames[BossType.GURDY] = {}
mod.BossChampionNames[BossType.GURDY][0] = "green"
mod.BossChampionNames[BossType.MONSTRO_2] = {}
mod.BossChampionNames[BossType.MONSTRO_2][0] = "red"
mod.BossChampionNames[BossType.MOM] = {}
mod.BossChampionNames[BossType.MOM][0] = "tanky_blue"
mod.BossChampionNames[BossType.MOM][1] = "red"
mod.BossChampionNames[BossType.PIN] = {}
mod.BossChampionNames[BossType.PIN][0] = "tanky_black"
mod.BossChampionNames[BossType.FAMINE] = {}
mod.BossChampionNames[BossType.FAMINE][0] = "blue"
mod.BossChampionNames[BossType.PESTILENCE] = {}
mod.BossChampionNames[BossType.PESTILENCE][0] = "infested"
mod.BossChampionNames[BossType.WAR] = {}
mod.BossChampionNames[BossType.WAR][0] = "tanky_black"
mod.BossChampionNames[BossType.DEATH] = {}
mod.BossChampionNames[BossType.DEATH][0] = "tanky_black"
mod.BossChampionNames[BossType.DUKE_OF_FLIES] = {}
mod.BossChampionNames[BossType.DUKE_OF_FLIES][0] = "gush_green"
mod.BossChampionNames[BossType.DUKE_OF_FLIES][1] = "tanky_orange"
mod.BossChampionNames[BossType.DUKE_OF_FLIES][BossColors.DUKE_ETERNAL] = "dry"
mod.BossChampionNames[BossType.THE_HUSK] = {}
mod.BossChampionNames[BossType.THE_HUSK][0] = "boom"
mod.BossChampionNames[BossType.THE_HUSK][1] = "gush_red"
mod.BossChampionNames[BossType.PEEP] = {}
mod.BossChampionNames[BossType.PEEP][0] = "yellow"
mod.BossChampionNames[BossType.PEEP][1] = "cyan"
mod.BossChampionNames[BossType.THE_BLOAT] = {}
mod.BossChampionNames[BossType.THE_BLOAT][0] = "green"
mod.BossChampionNames[BossType.FISTULA] = {}
mod.BossChampionNames[BossType.FISTULA][0] = "boom"
mod.BossChampionNames[BossType.GEMINI] = {}
mod.BossChampionNames[BossType.GEMINI][0] = "green"
mod.BossChampionNames[BossType.GEMINI][1] = "blue"
mod.BossChampionNames[BossType.GEMINI][BossColors.GEMINI_STEVEN] = "black"
mod.BossChampionNames[BossType.MASK_OF_INFAMY] = {}
mod.BossChampionNames[BossType.MASK_OF_INFAMY][0] = "tanky_black"
mod.BossChampionNames[BossType.GURDY_JR] = {}
mod.BossChampionNames[BossType.GURDY_JR][0] = "duplo_blue"
mod.BossChampionNames[BossType.GURDY_JR][1] = "tanky_yellow"
mod.BossChampionNames[BossType.WIDOW] = {}
mod.BossChampionNames[BossType.WIDOW][0] = "black"
mod.BossChampionNames[BossType.WIDOW][1] = "pink"
mod.BossChampionNames[BossType.GURGLINGS] = {}
mod.BossChampionNames[BossType.GURGLINGS][0] = "triplo_yellow"
mod.BossChampionNames[BossType.GURGLINGS][1] = "boom"
mod.BossChampionNames[BossType.THE_HAUNT] = {}
mod.BossChampionNames[BossType.THE_HAUNT][0] = "infested"
mod.BossChampionNames[BossType.THE_HAUNT][1] = "gush_pink"
mod.BossChampionNames[BossType.DINGLE] = {}
mod.BossChampionNames[BossType.DINGLE][0] = "red"
mod.BossChampionNames[BossType.DINGLE][1] = "infested"
mod.BossChampionNames[BossType.MEGA_MAW] = {}
mod.BossChampionNames[BossType.MEGA_MAW][0] = "gush_red"
mod.BossChampionNames[BossType.MEGA_MAW][1] = "infested"
mod.BossChampionNames[BossType.THE_GATE] = {}
mod.BossChampionNames[BossType.THE_GATE][0] = "gush_red"
mod.BossChampionNames[BossType.THE_GATE][1] = "tanky_black"
mod.BossChampionNames[BossType.MEGA_FATTY] = {}
mod.BossChampionNames[BossType.MEGA_FATTY][0] = "gush_red"
mod.BossChampionNames[BossType.MEGA_FATTY][1] = "brown"
mod.BossChampionNames[BossType.THE_CAGE] = {}
mod.BossChampionNames[BossType.THE_CAGE][0] = "green"
mod.BossChampionNames[BossType.THE_CAGE][1] = "pink"
mod.BossChampionNames[BossType.POLYCEPHALUS] = {}
mod.BossChampionNames[BossType.POLYCEPHALUS][0] = "red"
mod.BossChampionNames[BossType.POLYCEPHALUS][1] = "pink"
mod.BossChampionNames[BossType.LITTLE_HORN] = {}
mod.BossChampionNames[BossType.LITTLE_HORN][0] = "flaming"
mod.BossChampionNames[BossType.LITTLE_HORN][1] = "dark"
mod.BossChampionNames[BossType.RAG_MAN] = {}
mod.BossChampionNames[BossType.RAG_MAN][0] = "red"
mod.BossChampionNames[BossType.RAG_MAN][1] = "infested"
mod.BossChampionNames[BossType.THE_FRAIL] = {}
mod.BossChampionNames[BossType.THE_FRAIL][0] = "black"
mod.BossChampionNames[BossType.BROWNIE] = {}
mod.BossChampionNames[BossType.BROWNIE][0] = "infested"
mod.BossChampionNames[BossType.THE_STAIN] = {}
mod.BossChampionNames[BossType.THE_STAIN][0] = "grey"
mod.BossChampionNames[BossType.THE_FORSAKEN] = {}
mod.BossChampionNames[BossType.THE_FORSAKEN][0] = "boom"
mod.BossChampionNames[BossType.SCOLEX] = {}
mod.BossChampionNames[BossType.SCOLEX][BossColors.SCOLEX_BLACK] = "tanky_black"
mod.BossChampionPortraits = {}
mod.BossChampionPortraits[BossType.DUKE_OF_FLIES] = {}
mod.BossChampionPortraits[BossType.DUKE_OF_FLIES][0] = true
function mod.onRenderBossIntro()
	local isRendering = RoomTransition.IsRenderingBossIntro()
	if isRendering and not lastRoomTransMode then
		local game = Game()
		local room = game:GetRoom()
		local roomEnts = Isaac.GetRoomEntities()
		local likelyBossColor = -1
		local likelyBossID = room:GetBossID()
		for _,ent in ipairs(roomEnts) do
			if ent:ToNPC() then
				local npc = ent:ToNPC()
				if npc:IsBoss() and npc:GetBossID() == likelyBossID and npc:GetBossColorIdx() > -1 then
					likelyBossColor = npc:GetBossColorIdx()
				end
			end
		end
		local sprite = RoomTransition.GetVersusScreenSprite()
		if likelyBossColor == -1 then
			sprite:ReplaceSpritesheet(24, "blank.png", true)
		elseif mod.BossChampionNames[likelyBossID] and mod.BossChampionNames[likelyBossID][likelyBossColor] then
			sprite:ReplaceSpritesheet(24, "gfx/ui/boss/champions/" .. tostring(mod.BossChampionNames[likelyBossID][likelyBossColor]) .. ".png", true)
			if mod.BossChampionPortraits[likelyBossID] and mod.BossChampionPortraits[likelyBossID][likelyBossColor] then
				local bosssheet = XMLData.GetEntryById(XMLNode.BOSSPORTRAIT, likelyBossID)
				if bosssheet and type(bosssheet) == "string" then
					print(bosssheet)
					sprite:ReplaceSpritesheet(4, bosssheet .. "_" .. tostring(mod.BossChampionNames[likelyBossID][likelyBossColor]) .. ".png", true)
					sprite:ReplaceSpritesheet(13, bosssheet .. "_" .. tostring(mod.BossChampionNames[likelyBossID][likelyBossColor]) .. ".png", true)
				end
			end
		else
			sprite:ReplaceSpritesheet(24, "gfx/ui/boss/champions/default.png", true)
		end
	end
	lastRoomTransMode = isRendering
end
mod.AddCallback(ModCallbacks.MC_POST_RENDER, mod.onRenderBossIntro)

function mod.PreEntityTakeDMGVanillaBosses(entity, amount, flags, source, cooldown)
	local ignoresArmor = flags & DamageFlag.DAMAGE_IGNORE_ARMOR > 0
	if not ignoresArmor then
		return {DamageFlags = flags | DamageFlag.DAMAGE_IGNORE_ARMOR}
	end
end
mod.AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, mod.PreEntityTakeDMGVanillaBosses)

function mod.onGeminiUpdate(npc)
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
		local runSave = mod.SaveManager.GetRunSave()
		if not runSave.EncounteredSteven then
			runSave.EncounteredSteven = true
			runSave.Weirdness = runSave.Weirdness or mod.StartingWeirdness
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
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onGeminiUpdate, EntityType.ENTITY_GEMINI)

function mod.preGeminiUpdate(npc)
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
mod.AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, mod.preGeminiUpdate, EntityType.ENTITY_GEMINI)

mod.StevenBabyOffsetL = Vector(32,-2)
mod.StevenBabyOffsetR = Vector(-32,-2)
function mod.onGeminiRender(npc, offset)
	if npc.Variant == GeminiVariant.STEVEN and npc.SubType == 0 and npc.ChildNPC and npc.HitPoints >= 60 then
		local flipx = npc:GetSprite().FlipX == true or npc.FlipX == true
		if flipx then
			npc.ChildNPC.Position = npc.Position + mod.StevenBabyOffsetL
		else
			npc.ChildNPC.Position = npc.Position + mod.StevenBabyOffsetR
		end
		npc.ChildNPC.Velocity = npc.Velocity
		npc.ChildNPC.DepthOffset = 10
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NPC_RENDER, mod.onGeminiRender, EntityType.ENTITY_GEMINI)

function mod.onStevenProjectileUpdate(proj)
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
mod.AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, mod.onStevenProjectileUpdate, ProjectileVariant.PROJECTILE_FCUK)

mod.StartingWeirdness = 5
mod.DontReplaceBosses = {}
mod.DontReplaceBosses[BossType.MOM] = true
mod.DontReplaceBosses[BossType.MOMS_HEART] = true
mod.DontReplaceBosses[BossType.FAMINE] = true
mod.DontReplaceBosses[BossType.PESTILENCE] = true
mod.DontReplaceBosses[BossType.WAR] = true
mod.DontReplaceBosses[BossType.DEATH] = true
mod.DontReplaceBosses[BossType.STEVEN] = true
mod.DontReplaceBosses[BossType.HEADLESS_HORSEMAN] = true
mod.DontReplaceBosses[BossType.THE_FALLEN] = true
mod.DontReplaceBosses[BossType.SATAN] = true
mod.DontReplaceBosses[BossType.IT_LIVES] = true
mod.DontReplaceBosses[BossType.CONQUEST] = true
mod.DontReplaceBosses[BossType.ISAAC] = true
mod.DontReplaceBosses[BossType.BLUE_BABY] = true
mod.DontReplaceBosses[BossType.THE_LAMB] = true
mod.DontReplaceBosses[BossType.MEGA_SATAN] = true
mod.DontReplaceBosses[BossType.ULTRA_GREED] = true
mod.DontReplaceBosses[BossType.HUSH] = true
mod.DontReplaceBosses[BossType.DELIRIUM] = true
mod.DontReplaceBosses[BossType.ULTRA_GREEDIER] = true
mod.DontReplaceBosses[BossType.MOTHER] = true
mod.DontReplaceBosses[BossType.MOM_MAUSOLEUM] = true
mod.DontReplaceBosses[BossType.MOMS_HEART_MAUSOLEUM] = true
mod.DontReplaceBosses[BossType.DOGMA] = true
mod.DontReplaceBosses[BossType.THE_BEAST] = true
function mod.preBossSelect(bossType, bossPool, stage, stagetype)
	if not mod.DontReplaceBosses[bossType] then
		local runSave = mod.SaveManager.GetRunSave()
		if not runSave.EncounteredSteven then
			runSave.Weirdness = runSave.Weirdness or mod.StartingWeirdness --might use weirdness for other things
			local bossRNG = bossPool:GetRNG()
			if bossRNG:RandomInt(1, 100) <= runSave.Weirdness then
				return BossType.STEVEN
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_BOSS_SELECT, mod.preBossSelect)

function mod.onBlastocystBigUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Walk") and sprite:IsEventTriggered("Land") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.GROUND_FOREGROUND, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -mod.PickupPoofOffset
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onBlastocystBigUpdate, EntityType.ENTITY_BLASTOCYST_BIG)

function mod.onHeartOfInfamyUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("HeartAttack") and sprite:IsEventTriggered("Shoot") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = -mod.PickupPoofOffset
		if npc.SubType == 1 then
			poofSprite.Color = Color.ProjectileHoming
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onHeartOfInfamyUpdate, EntityType.ENTITY_HEART_OF_INFAMY)

mod.PoofScaleMid = Vector(0.75,0.75)
mod.PoofScaleSmall = Vector(0.5,0.5)
mod.SatanPoofOffset = Vector(0,-40)
mod.SatanPoofOffsetLeft = Vector(-64,-42)
mod.SatanPoofOffsetRight = Vector(64,-42)
mod.BloodPoofColor = Color(0.8,0,0,0.5)
function mod.onSatanUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack01") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.SatanPoofOffset
			poofSprite.Color = mod.BloodPoofColor
		end
		if sprite:IsEventTriggered("Shoot2") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.SatanPoofOffset
			poofSprite.Scale = mod.PoofScaleMid
		end
	end
	if sprite:IsPlaying("Attack02") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.SatanPoofOffset
			poofSprite.Scale = mod.PoofScaleMid
		end
	end
	if sprite:IsPlaying("Attack03") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.SatanPoofOffsetLeft
			poofSprite.Color = mod.BloodPoofColor
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.SatanPoofOffsetRight
			poofSprite.Color = mod.BloodPoofColor
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onSatanUpdate, EntityType.ENTITY_SATAN)

mod.FaminePoofOffset = Vector(2,-18)
function mod.onFamineUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("HeadAttack") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.FaminePoofOffset
			poofSprite.Color = mod.BloodPoofColor
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onFamineUpdate, EntityType.ENTITY_FAMINE)

mod.Monstro2PoofOffset = Vector(0,-18)
function mod.onMonstro2Update(npc)
	if npc.Variant == 0 then
		local sprite = npc:GetSprite()
		if sprite:IsPlaying("Taunt") then
			if sprite:GetFrame() == 20 then
				local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
				local poofSprite = poof:GetSprite()
				poofSprite.Offset = mod.Monstro2PoofOffset
				poofSprite.Scale = mod.PoofScaleMid
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onMonstro2Update, EntityType.ENTITY_MONSTRO2)

function mod.onLokiUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack01") then
		if sprite:GetFrame() == 50 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -mod.PickupPoofOffset
			poofSprite.Scale = mod.PoofScaleSmall
		end
		if sprite:GetFrame() == 25 or sprite:GetFrame() == 75 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -mod.PickupPoofOffset
			poofSprite.Scale = mod.PoofScaleSmall
		end
	end
	if sprite:IsPlaying("Attack03") then
		if sprite:IsEventTriggered("Shoot") then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -mod.PickupPoofOffset
			poofSprite.Scale = mod.PoofScaleMid
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onLokiUpdate, EntityType.ENTITY_LOKI)

mod.HourglassPoofColor = Color(0.5,0.4,0.25,0.5)
mod.HourglassPoofOffset = Vector(23,-30)
mod.HourglassPoofOffsetFlip = Vector(-23,-30)
function mod.onDeathUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack02") then
		if sprite:GetFrame() == 21 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.SMALL, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			if sprite.FlipX then
				poofSprite.Offset = mod.HourglassPoofOffsetFlip
			else
				poofSprite.Offset = mod.HourglassPoofOffset
			end
			poofSprite.Color = mod.HourglassPoofColor
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onDeathUpdate, EntityType.ENTITY_DEATH)

mod.PestilencePoofOffset = Vector(0,-34)
mod.WhiteCreepColor = Color(0,0,0,1,1,1,1)
function mod.onPestilenceUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack1") then
		if sprite:GetFrame() == 17 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.PestilencePoofOffset
			if npc.SubType == 1 then
				poofSprite.Color = mod.WhiteCreepColor
			else
				poofSprite.Color = Color.ProjectileIpecac
			end
		end
	end
	if sprite:IsPlaying("Attack2") then
		if sprite:GetFrame() == 22 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = -mod.PickupPoofOffset
			if npc.SubType == 1 then
				poofSprite.Color = mod.WhiteCreepColor
			else
				poofSprite.Color = Color.ProjectileIpecac
			end
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_FOREGROUND, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.PickupPoofOffset
			if npc.SubType == 1 then
				poofSprite.Color = mod.WhiteCreepColor
			else
				poofSprite.Color = Color.ProjectileIpecac
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onPestilenceUpdate, EntityType.ENTITY_PESTILENCE)

function mod.onWarUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack1") then
		if sprite:GetFrame() == 5 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, Poof02Subtype.BLOOD_CLOUD, npc.Position-mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.PestilencePoofOffset
			poofSprite.Scale = mod.PoofScaleMid
			if npc.Variant == 1 then
				poofSprite.Color = Color.ProjectileHoming
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onWarUpdate, EntityType.ENTITY_WAR)

mod.HeadlessHorsemanHeadPoofOffset = Vector(0,-12)
function mod.onHeadlessHorsemanHeadUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack") then
		if sprite:GetFrame() == 16 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.HeadlessHorsemanHeadPoofOffset
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onHeadlessHorsemanHeadUpdate, EntityType.ENTITY_HORSEMAN_HEAD)

mod.HeadlessHorsemanPoofOffset = Vector(0,-28)
function mod.onHeadlessHorsemanUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack") then
		if sprite:GetFrame() == 8 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.HeadlessHorsemanPoofOffset
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onHeadlessHorsemanUpdate, EntityType.ENTITY_HEADLESS_HORSEMAN)

mod.FallenPoofOffset = Vector(0,-18)
function mod.onFallenUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsEventTriggered("Shoot") or sprite:IsEventTriggered("Shoot2") then
		local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
		local poofSprite = poof:GetSprite()
		poofSprite.Offset = mod.FallenPoofOffset
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onFallenUpdate, EntityType.ENTITY_FALLEN)

function mod.onSlothUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack") then
		if sprite:GetFrame() == 4 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.FallenPoofOffset
			poofSprite.Color = Color.ProjectileIpecac
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onSlothUpdate, EntityType.ENTITY_SLOTH)

mod.PinPoofOffset = Vector(0,-56)
function mod.onPinUpdate(npc)
	local sprite = npc:GetSprite()
	if sprite:IsPlaying("Attack1") then
		if sprite:GetFrame() == 44 then
			local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 2, npc.Position+mod.PoofSpawnOffset, Vector.Zero, npc)
			local poofSprite = poof:GetSprite()
			poofSprite.Offset = mod.PinPoofOffset
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onPinUpdate, EntityType.ENTITY_PIN)

mod.DukeFlyOrbitMaxDist = 120
mod.DukeFlySlowedDist = 100
function mod.onDukeUpdate(npc)
	if npc:GetBossColorIdx() == BossColors.DUKE_ETERNAL then
		local sprite = npc:GetSprite()
		local data = mod.GetData(npc)
		if not data.SpawnedFlies then
			for i=1, 3 do
				local fly = Isaac.Spawn(EntityType.ENTITY_ETERNALFLY, 0, 0, npc.Position, Vector.Zero, npc):ToNPC()
				fly.Parent = npc
				fly.StateFrame = math.floor((360/3)*(i-1))
			end
			data.SpawnedFlies = true
		end
		if sprite:IsPlaying("Attack03") then
			if sprite:GetFrame() == 16 then
				data.FlySpread = true
			end
		elseif not sprite:IsPlaying("Walk") then
			data.FlySpread = false
		end
		if data.FlySpread then
			data.FlyOrbitDist = data.FlyOrbitDist or mod.EternalFlyOrbitDistParents[EntityType.ENTITY_DUKE]
			if data.FlyOrbitDist >= mod.DukeFlySlowedDist then
				data.FlyOrbitDist = math.min(data.FlyOrbitDist+2, mod.DukeFlyOrbitMaxDist)
			else
				data.FlyOrbitDist = math.min(data.FlyOrbitDist+5, mod.DukeFlyOrbitMaxDist)
			end
		elseif data.FlyOrbitDist and data.FlyOrbitDist > mod.EternalFlyOrbitDistParents[EntityType.ENTITY_DUKE] then
			data.FlyOrbitDist = math.max(data.FlyOrbitDist-2, mod.EternalFlyOrbitDistParents[EntityType.ENTITY_DUKE])
		end
	end
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onDukeUpdate, EntityType.ENTITY_DUKE)

function mod.onChubUpdate(npc)
	local data = mod.GetData(npc)
	if npc.State == NpcState.STATE_SUMMON and data.lastState ~= npc.State then
		if npc:GetBossColorIdx() == 1 and npc:QueryNPCsSpawnerType(EntityType.ENTITY_CHUB, EntityType.ENTITY_SPITTY, false).Size >= 2 then
			npc.State = NpcState.STATE_MOVE
		elseif npc.Child and not npc.Child.Child then
			npc.State = NpcState.STATE_MOVE
		end
	end
	if npc.FrameCount >= 2 and not npc.Child and not npc.Parent then
		npc:Kill()
	end
	if npc.Variant == 2 then
		if not data.ReplacedSprite and not npc.Child and npc.Parent and not npc.Parent.Parent then
			if npc.SubType == 1 then
				npc:ReplaceSpritesheet(0, "gfx/bosses/classic/boss_045_carrionqueen_small_pink.png", true)
			else
				npc:ReplaceSpritesheet(0, "gfx/bosses/classic/boss_045_carrionqueen_small.png", true)
			end
			data.ReplacedSprite = true
		end
	end
	data.lastState = npc.State
end
mod.AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onChubUpdate, EntityType.ENTITY_CHUB)
