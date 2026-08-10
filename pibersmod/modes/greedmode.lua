function PibersMod:GetPlanetariumChance()
	local game = Game()
	local level = game:GetLevel()
	local realChance = level:GetPlanetariumChance()
	if realChance > 0 then
		return realChance
	end

	local gamedata = Isaac.GetPersistentGameData()
	if not gamedata:Unlocked(Achievement.PLANETARIUMS) then
		return 0
	end

	local stage = level:GetStage()
	local stageType = level:GetStageType()
	if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
		stage = stage+1
	end
	if stage >= LevelStage.STAGE4_3 then
		return 0
	end

	local telescopeLens = PlayerManager.AnyoneHasTrinket(TrinketType.TRINKET_TELESCOPE_LENS)
	if stage >= LevelStage.STAGE4_1 and not telescopeLens then
		return 0
	end

	local chance = 0.01
	local visited = game:GetPlanetariumsVisited()
	if visited ~= 0 then
		if telescopeLens then
			chance = chance + 0.09
		end
		return math.max(math.min(10000, (chance*100)), 1) * 0.01
	end

	local crystalBall = PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_CRYSTAL_BALL)
	local magic8Ball = PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_MAGIC_8_BALL)
	local sausage = PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_SAUSAGE)

	local challengeParams = game:GetChallengeParams()
	local roomFilter = challengeParams:GetRoomFilter()
	local treasureRoomsAllowed = not roomFilter[RoomType.ROOM_TREASURE]

	local treasureRoomsMissed = (stage-1) - game:GetTreasureRoomVisitCount()
	if treasureRoomsAllowed and treasureRoomsMissed > 0 then
		chance = chance + (treasureRoomsMissed*0.2)
		if crystalBall then
			chance = chance + 1
		end
	end

	if magic8Ball then
		chance = chance + 0.15
	end
	if crystalBall then
		chance = chance + 0.15
	end
	if sausage then
		chance = chance + 0.069
	end
	if telescopeLens then
		chance = chance + 0.24
	end

	return math.max(math.min(10000, (chance*100)), 1) * 0.01
end

function PibersMod:GetSacrificeChance()
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage >= LevelStage.STAGE6 then
		return 0
	end

	local challengeParams = game:GetChallengeParams()
	local roomFilter = challengeParams:GetRoomFilter()
	local roomAllowed = not roomFilter[RoomType.ROOM_SACRIFICE]
	if not roomAllowed then
		return 0
	end

	local chance = 0.15
	if PlayerManager.AnyoneIsPlayerType(PlayerType.PLAYER_LAZARUS) or PlayerManager.AnyoneIsPlayerType(PlayerType.PLAYER_LAZARUS2) then
		chance = chance + 0.1
	else
		local hasFull = true
		for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
			if not player:HasFullHeartsAndSoulHearts() then
				hasFull = false
				break
			end
		end
		if hasFull then
			chance = chance + 0.1
		end
	end

	return math.max(math.min(10000, (chance*100)), 1) * 0.01
end

function PibersMod:GetDiceChance()
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage >= LevelStage.STAGE6 then
		return 0
	end

	local challengeParams = game:GetChallengeParams()
	local roomFilter = challengeParams:GetRoomFilter()
	local roomAllowed = not roomFilter[RoomType.ROOM_DICE]
	if not roomAllowed then
		return 0
	end

	local sacChance = PibersMod:GetSacrificeChance()
	local chance = sacChance/50
	for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
		if player:GetNumKeys() > 0 then
			chance = chance + (sacChance/5)
			break
		end
	end

	return math.max(math.min(10000, (chance*100)), 1) * 0.01
end

function PibersMod:GetArcadeChance(ignoreEven, ignoreCoins)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage >= LevelStage.STAGE6 then
		return 0
	end

	local challengeParams = game:GetChallengeParams()
	local roomFilter = challengeParams:GetRoomFilter()
	local roomAllowed = not roomFilter[RoomType.ROOM_ARCADE]
	if not roomAllowed then
		return 0
	end

	if PlayerManager.AnyPlayerTypeHasBirthright(PlayerType.PLAYER_CAIN) then
		ignoreEven = true
	end

	if not ignoreEven and stage ~= LevelStage.STAGE1_2 and stage ~= LevelStage.STAGE2_2 and stage ~= LevelStage.STAGE3_2 and stage ~= LevelStage.STAGE4_2 then
		return 0
	end

	local chance = 0
	if ignoreCoins then
		chance = 1
	else
		local coins = 0
		for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
			coins = coins + player:GetNumCoins()
			if coins >= 5 then
				chance = 1
				break
			end
		end
	end

	return math.max(math.min(10000, (chance*100)), 1) * 0.01
end

function PibersMod:GetChestChance(ignoreEven)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage >= LevelStage.STAGE6 then
		return 0
	end

	local challengeParams = game:GetChallengeParams()
	local roomFilter = challengeParams:GetRoomFilter()
	local roomAllowed = not roomFilter[RoomType.ROOM_CHEST] and not PlayerManager.AnyPlayerTypeHasBirthright(PlayerType.PLAYER_CAIN)
	if not roomAllowed then
		return 0
	end

	local arcChance = PibersMod:GetArcadeChance(ignoreEven, true)
	local chance = arcChance/10
	local keys = 0
	for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
		keys = keys + player:GetNumKeys()
		if keys >= 2 then
			chance = chance + (arcChance/4)
			break
		end
	end

	return math.max(math.min(10000, (chance*100)), 1) * 0.01
end

function PibersMod:GetLibraryChance()
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage >= LevelStage.STAGE6 then
		return 0
	end

	local challengeParams = game:GetChallengeParams()
	local roomFilter = challengeParams:GetRoomFilter()
	local roomAllowed = not roomFilter[RoomType.ROOM_LIBRARY]
	if not roomAllowed then
		return 0
	end

	local chance = 0.05
	if game:GetStateFlag(GameStateFlag.STATE_BOOK_PICKED_UP) then
		chance = chance + 0.2
	end

	return math.max(math.min(10000, (chance*100)), 1) * 0.01
end

function PibersMod:GetBedroomChance()
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage >= LevelStage.STAGE6 then
		return 0
	end

	local challengeParams = game:GetChallengeParams()
	local roomFilter = challengeParams:GetRoomFilter()
	local roomAllowed = not roomFilter[RoomType.ROOM_BARREN] and not roomFilter[RoomType.ROOM_ISAACS] and not roomFilter[RoomType.ROOM_MINIBOSS]
	if not roomAllowed then
		return 0
	end

	local chance = 0.02
	for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
		if (player:GetHearts() < 2 and player:GetSoulHearts() < 1) or (player:GetEffectiveMaxHearts() < 1 and player:GetSoulHearts() < 3) then
			chance = chance + 0.18
			break
		end
	end

	return math.max(math.min(10000, (chance*100)), 1) * 0.01
end

PibersMod.GreedStageBoss = {}
PibersMod.GreedStageBoss[LevelStage.STAGE3_1] = BossType.MOM
PibersMod.GreedStageBoss[LevelStage.STAGE4_1] = BossType.MOMS_HEART
PibersMod.GreedStageBoss[LevelStage.STAGE5] = BossType.SATAN
function PibersMod:OnNewLevelGreedMode()
	local game = Game()
	local isGreed = game:IsGreedMode()
	if isGreed then
		local level = game:GetLevel()
		local stage = level:GetAbsoluteStage()
		local stageType = level:GetStageType()
		local gamedata = Isaac.GetPersistentGameData()
		if PibersMod.GreedStageBoss[stage] then
			if PibersMod.GreedStageBoss[stage] == BossType.MOMS_HEART and gamedata:Unlocked(Achievement.IT_LIVES) then
				PibersMod.GreedStageBoss[stage] = BossType.IT_LIVES
			end
			if PibersMod.GreedStageBoss[stage] == BossType.IT_LIVES and not gamedata:Unlocked(Achievement.IT_LIVES) then
				PibersMod.GreedStageBoss[stage] = BossType.MOMS_HEART
			end
			if PibersMod.GreedStageBoss[stage] == BossType.MOM and (stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B) then
				PibersMod.GreedStageBoss[stage] = BossType.MOM_MAUSOLEUM
			end
			if PibersMod.GreedStageBoss[stage] == BossType.MOM_MAUSOLEUM and stageType ~= StageType.STAGETYPE_REPENTANCE and stageType ~= StageType.STAGETYPE_REPENTANCE_B then
				PibersMod.GreedStageBoss[stage] = BossType.MOM
			end
			--[[
			if (PibersMod.GreedStageBoss[stage] == BossType.MOMS_HEART or PibersMod.GreedStageBoss[stage] == BossType.IT_LIVES) and (stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B) then
				PibersMod.GreedStageBoss[stage] = BossType.MOMS_HEART_MAUSOLEUM
			end
			if PibersMod.GreedStageBoss[stage] == BossType.MOMS_HEART_MAUSOLEUM and stageType ~= StageType.STAGETYPE_REPENTANCE and stageType ~= StageType.STAGETYPE_REPENTANCE_B then
				PibersMod.GreedStageBoss[stage] = BossType.MOMS_HEART
				if gamedata:Unlocked(Achievement.IT_LIVES) then
					PibersMod.GreedStageBoss[stage] = BossType.IT_LIVES
				end
			end
			]]
		end
		local isHard = game:IsHardMode()
		local maxDifficulty = 10
		if isHard then
			maxDifficulty = 15
		end
		local levelRNG = RNG(level:GetDungeonPlacementSeed())
		local room = game:GetRoom()
		local curseDoor = room:GetDoor(DoorSlot.LEFT0)
		local exitDoor = room:GetDoor(DoorSlot.DOWN0)
		local rooms = level:GetRooms()
		for i=0, rooms.Size-1 do
			local roomDesc = rooms:Get(i)
			if roomDesc and roomDesc.Data then
				if roomDesc.Data.Type == RoomType.ROOM_CURSE then
					if PibersMod:GetPlanetariumChance() >= levelRNG:RandomFloat() then
						roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_PLANETARIUM, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
						if curseDoor then
							curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_PLANETARIUM)
							curseDoor:SetLocked(true)
						end
					elseif PibersMod:GetBedroomChance() >= levelRNG:RandomFloat() then
						if levelRNG:RandomInt(1, 2) == 1 then
							roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_ISAACS, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
							if curseDoor then
								curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_ISAACS)
								curseDoor:SetLocked(true)
							end
						else
							roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_BARREN, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
							if curseDoor then
								curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_BARREN)
								curseDoor:SetLocked(true)
							end
						end
					elseif PibersMod:GetChestChance(true) >= levelRNG:RandomFloat() then
						roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_CHEST, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
						if curseDoor then
							curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_CHEST)
							curseDoor:SetLocked(true)
						end
					elseif PibersMod:GetDiceChance() >= levelRNG:RandomFloat() then
						roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_DICE, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
						if curseDoor then
							curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_DICE)
							curseDoor:SetLocked(true)
						end
					elseif PibersMod:GetLibraryChance() >= levelRNG:RandomFloat() then
						roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_LIBRARY, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
						if curseDoor then
							curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_LIBRARY)
							curseDoor:SetLocked(true)
						end
					elseif PibersMod:GetSacrificeChance() >= levelRNG:RandomFloat() then
						roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_SACRIFICE, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
						if curseDoor then
							curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_SACRIFICE)
						end
					elseif PibersMod:GetArcadeChance(true)/3 >= levelRNG:RandomFloat() then
						roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_ARCADE, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, 0, 1)
						if curseDoor then
							curseDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_ARCADE)
							curseDoor:SetLocked(true)
						end
					end
				elseif roomDesc.Data.Type == RoomType.ROOM_GREED_EXIT then
					local truestage = level:GetStage()
					if PibersMod.GreedStageBoss[stage] then
						--[[
						roomDesc.Data = RoomConfig.GetRandomRoom(roomDesc.SpawnSeed, false, StbType.SPECIAL_ROOMS, RoomType.ROOM_BOSS, RoomShape.ROOMSHAPE_1x1, nil, nil, 0, maxDifficulty, nil, PibersMod.GreedStageBoss[stage], 0)
						if exitDoor then
							exitDoor:SetRoomTypes(RoomType.ROOM_DEFAULT, RoomType.ROOM_GREED_EXIT)
						end
						]]
						PibersMod:TryForcePlaceRandomRoom(RoomType.ROOM_BOSS, RoomShape.ROOMSHAPE_1x1, PibersMod.GreedStageBoss[stage], Dimension.NORMAL, levelRNG, roomDesc.GridIndex+GridRooms.WIDTH, 0, maxDifficulty, nil, nil, nil, nil, true)
					elseif truestage <= 3 and gamedata:Unlocked(Achievement.SECRET_EXIT) then
						local exitsub = truestage
						if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
							exitsub = exitsub + 1
						end
						PibersMod:TryForcePlaceRandomRoom(RoomType.ROOM_SECRET_EXIT, RoomShape.ROOMSHAPE_1x1, exitsub, Dimension.NORMAL, levelRNG, roomDesc.GridIndex+GridRooms.WIDTH, 0, maxDifficulty)
					end
					break
				end
			end
		end
		if MinimapAPI then
			MinimapAPI:LoadDefaultMap()
			MinimapAPI:updatePlayerPos()
			MinimapAPI:UpdateExternalMap()
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, PibersMod.OnNewLevelGreedMode)

function PibersMod:OnRoomClearGreed(silent)
	local game = Game()
	local isGreed = game:IsGreedMode()
	if isGreed then
		local room = game:GetRoom()
		if room:GetType() == RoomType.ROOM_BOSS then
			local level = game:GetLevel()
			local stage = level:GetAbsoluteStage()
			local bossid = room:GetBossID()
			local gamedata = Isaac.GetPersistentGameData()
			local centerPos = Isaac.GetFreeNearPosition(room:GetCenterPos(), 1)
			local isHard = game:IsHardMode()
			if stage == LevelStage.STAGE3_1 and (bossid == BossType.MOM or bossid == BossType.MOM_MAUSOLEUM) then
				if (bossid == BossType.MOM and gamedata:Unlocked(Achievement.THE_WOMB)) or (bossid == BossType.MOM_MAUSOLEUM and gamedata:Unlocked(Achievement.ROTTEN_HEARTS)) then
					local gridEnt = Isaac.GridSpawn(GridEntityType.GRID_TRAPDOOR, 0, centerPos, true)
				else
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BIGCHEST, 0, centerPos, Vector.Zero, nil)
				end
				if not gamedata:Unlocked(Achievement.THE_WOMB) then
					gamedata:TryUnlock(Achievement.THE_WOMB)
				end
			end
			if stage == LevelStage.STAGE4_1 and (bossid == BossType.MOMS_HEART or bossid == BossType.IT_LIVES or bossid == BossType.MOMS_HEART_MAUSOLEUM) then
				gamedata:IncreaseEventCounter(EventCounter.MOM_KILLS, 1)
				if gamedata:Unlocked(Achievement.IT_LIVES) then
					Isaac.GridSpawn(GridEntityType.GRID_TRAPDOOR, 0, centerPos, true)
				else
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BIGCHEST, 0, centerPos, Vector.Zero, nil)
				end
				for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
					local playerType = player:GetPlayerType()
					if isHard and Isaac.GetCompletionMark(playerType, CompletionType.MOMS_HEART) < 2 then
						Isaac.SetCompletionMark(playerType, CompletionType.MOMS_HEART, 2)
					end
					if not isHard and Isaac.GetCompletionMark(playerType, CompletionType.MOMS_HEART) < 1 then
						Isaac.SetCompletionMark(playerType, CompletionType.MOMS_HEART, 1)
					end
				end
			end
			if stage == LevelStage.STAGE5 and bossid == BossType.SATAN then
				gamedata:IncreaseEventCounter(EventCounter.SATAN_KILLS, 1)
				if gamedata:Unlocked(Achievement.THE_NEGATIVE) then
					Isaac.GridSpawn(GridEntityType.GRID_TRAPDOOR, 0, centerPos, true)
				else
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BIGCHEST, 0, centerPos, Vector.Zero, nil)
				end
				for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
					local playerType = player:GetPlayerType()
					if isHard and Isaac.GetCompletionMark(playerType, CompletionType.SATAN) < 2 then
						Isaac.SetCompletionMark(playerType, CompletionType.SATAN, 2)
					end
					if not isHard and Isaac.GetCompletionMark(playerType, CompletionType.SATAN) < 1 then
						Isaac.SetCompletionMark(playerType, CompletionType.SATAN, 1)
					end
				end
				if not gamedata:Unlocked(Achievement.JUDAS) then
					gamedata:TryUnlock(Achievement.JUDAS)
				end
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_ROOM_TRIGGER_CLEAR, PibersMod.OnRoomClearGreed)

function PibersMod:PreTrapdoorUpdate(grident)
	local game = Game()
	local isGreed = game:IsGreedMode()
	if isGreed then
		local level = game:GetLevel()
		local stage = level:GetAbsoluteStage()
		if PibersMod.GreedStageBoss[stage] then
			local currentDesc = level:GetCurrentRoomDesc()
			if currentDesc.GridIndex == GridRooms.ROOM_GREEDMODE_EXIT_IDX then
				local room = game:GetRoom()
				room:RemoveGridEntityImmediate(grident:GetGridIndex(), 0, true)
			end
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_GRID_ENTITY_TRAPDOOR_UPDATE, PibersMod.PreTrapdoorUpdate)

PibersMod.NightmareGreedmodeState = false
PibersMod.NightmareCharacterState = PlayerType.PLAYER_ISAAC
function PibersMod:OnNightmareRender()
	local progressSprite = NightmareScene.GetProgressBarSprite()

	if PibersMod.LastMainPlayerType and PibersMod.LastMainPlayerType ~= PibersMod.NightmareCharacterState then
		local progressSheet = "Progress_Isaac.png"
		local playerData = XMLData.GetEntryById(XMLNode.PLAYER, PibersMod.LastMainPlayerType)
		if playerData and playerData.portrait then
			progressSheet = string.gsub(playerData.portrait, "PlayerPortrait_", "Progress_")
			progressSprite:ReplaceSpritesheet(3,"gfx/ui/stage/" .. progressSheet, true)
		end
		PibersMod.NightmareCharacterState = PibersMod.LastMainPlayerType
	end

	local game = Game()
	local isGreed = game:IsGreedMode()
	if PibersMod.NightmareGreedmodeState ~= isGreed then
		if isGreed then
			if not PibersMod.NightmareGreedmodeState then
				progressSprite:ReplaceSpritesheet(2,"gfx/ui/stage/progress_shop.png", true)
			end
		else
			if PibersMod.NightmareGreedmodeState then
				progressSprite:ReplaceSpritesheet(2,"gfx/ui/stage/progress.png", true)
			end
		end
		PibersMod.NightmareGreedmodeState = isGreed
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NIGHTMARE_SCENE_RENDER, PibersMod.OnNightmareRender)

PibersMod.DoGreedSecretExit = false
PibersMod.SecretExitTrapdoorAnm2 = {}
PibersMod.SecretExitTrapdoorAnm2[1] = "gfx/grid/trapdoor_downpour.anm2"
PibersMod.SecretExitTrapdoorAnm2[2] = "gfx/grid/trapdoor_mines.anm2"
PibersMod.SecretExitTrapdoorAnm2[3] = "gfx/grid/trapdoor_mausoleum.anm2"
PibersMod.SecretExitTrapdoorAnm2[BossType.MOM] = "gfx/grid/door_11_corpsehole.anm2"
function PibersMod:OnTrapdoorUpdate(grident)
	local game = Game()
	local isGreed = game:IsGreedMode()
	if isGreed then
		local room = game:GetRoom()
		local roomType = room:GetType()
		local bossID = room:GetBossID()
		local level = game:GetLevel()
		local currentStageType = level:GetStageType()
		if roomType == RoomType.ROOM_SECRET_EXIT or (bossID == BossType.MOM and (currentStageType == StageType.STAGETYPE_REPENTANCE or currentStageType == StageType.STAGETYPE_REPENTANCE_B)) then
			if not PibersMod.DoGreedSecretExit then
				local roomDesc = level:GetCurrentRoomDesc()
				local roomSubType = roomDesc.Data.Subtype
				if PibersMod.SecretExitTrapdoorAnm2[roomSubType] then
					local sprite = grident:GetSprite()
					sprite:Load(PibersMod.SecretExitTrapdoorAnm2[roomSubType], true)
				elseif PibersMod.SecretExitTrapdoorAnm2[bossID] then
					local sprite = grident:GetSprite()
					sprite:Load(PibersMod.SecretExitTrapdoorAnm2[bossID], true)
				end
				PibersMod.DoGreedSecretExit = true
			end
		else
			PibersMod.DoGreedSecretExit = false
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_GRID_ENTITY_TRAPDOOR_UPDATE, PibersMod.OnTrapdoorUpdate)

function PibersMod:PreLevelSelectGreedMode(stage, stageType)
	local game = Game()
	local isGreed = game:IsGreedMode()
	if isGreed then
		local level = game:GetLevel()
		local currentStageType = level:GetStageType()
		local newStage = 0
		local newStageType = 0
		if PibersMod.DoGreedSecretExit then
			PibersMod.DoGreedSecretExit = false
			if currentStageType == StageType.STAGETYPE_REPENTANCE or currentStageType == StageType.STAGETYPE_REPENTANCE_B then
				newStage = stage
				newStageType = StageType.STAGETYPE_REPENTANCE
			else
				newStage = stage-1
				newStageType = StageType.STAGETYPE_REPENTANCE
			end
		elseif currentStageType == StageType.STAGETYPE_REPENTANCE or currentStageType == StageType.STAGETYPE_REPENTANCE_B then
			if stage >= 4 then
				newStage = stage+1
				newStageType = 0
			else
				newStage = stage+1
				newStageType = stageType
			end
		end
		if newStage > 0 then
			if newStageType == StageType.STAGETYPE_REPENTANCE then
				local gamedata = Isaac.GetPersistentGameData()
				if (newStage == 1 and gamedata:Unlocked(Achievement.DROSS))
				or (newStage == 2 and gamedata:Unlocked(Achievement.ASHPIT))
				or (newStage == 3 and gamedata:Unlocked(Achievement.GEHENNA)) then
					newStageType = RNG(level:GetDungeonPlacementSeed()):RandomInt(StageType.STAGETYPE_REPENTANCE, StageType.STAGETYPE_REPENTANCE_B)
				end
			end
			return {newStage, newStageType}
		end
	end
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_LEVEL_SELECT, PibersMod.PreLevelSelectGreedMode)
