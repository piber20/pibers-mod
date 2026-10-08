local mod = Desecration

function mod.OnNewRoomItems()
	for _, player in ipairs(PlayerManager.GetPlayers()) do
		local playerData = mod.GetData(player)
		playerData.newRoom = true
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomItems)

mod.LastMainPlayerType = PlayerType.PLAYER_ISAAC
function mod.OnUpdateItems()
	local player1 = Isaac.GetPlayer(0)
	if player1 and player1:Exists() then
		mod.LastMainPlayerType = player1:GetPlayerType()
	end
end
mod.AddCallback(ModCallbacks.MC_POST_UPDATE, mod.OnUpdateItems)

function mod.PreAddCounterfeitDollar(itemID, charge, firsttime, slot, varData, player)
	local runSave = mod.SaveManager.GetRunSave()
	runSave.CounterfeitCoins = runSave.CounterfeitCoins or 0
	runSave.PreCounterfeitCoins = player:GetNumCoins()
end
mod.AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, mod.PreAddCounterfeitDollar, CollectibleType.COUNTERFEIT_DOLLAR)

function mod.PostAddCounterfeitDollar(itemID, charge, firsttime, slot, varData, player)
	local runSave = mod.SaveManager.GetRunSave()
	runSave.PreCounterfeitCoins = runSave.PreCounterfeitCoins or 0
	runSave.CounterfeitCoins = runSave.CounterfeitCoins or 0
	runSave.CounterfeitCoins = runSave.CounterfeitCoins + (player:GetNumCoins() - runSave.PreCounterfeitCoins)
end
mod.AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.PostAddCounterfeitDollar, CollectibleType.COUNTERFEIT_DOLLAR)

function mod.GetCollectibleOwners(itemID)
	local players = PlayerManager.GetPlayers()
	local ownerPlayers = {}
	for _,player in ipairs(players) do
		if player:HasCollectible(CollectibleType.COUNTERFEIT_DOLLAR) then
			ownerPlayers[#ownerPlayers+1] = player
		end
	end
	return ownerPlayers
end

function mod.OnRoomClearItems(silent)
	if PlayerManager.AnyoneHasCollectible(CollectibleType.COUNTERFEIT_DOLLAR) and not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
		local runSave = mod.SaveManager.GetRunSave()
		runSave.CounterfeitCoins = runSave.CounterfeitCoins or 0
		if runSave.CounterfeitCoins > 0 then
			local players = mod.GetCollectibleOwners(CollectibleType.COUNTERFEIT_DOLLAR)
			local highestLuck = -99
			local minCoins = runSave.CounterfeitCoins
			for _,player in ipairs(players) do
				highestLuck = math.max(highestLuck,player.Luck)
				minCoins = math.min(minCoins,player:GetNumCoins())
			end
			if minCoins > 0 then
				local rng = players[1]:GetCollectibleRNG(CollectibleType.COUNTERFEIT_DOLLAR)
				if rng:RandomInt(1,20) > 5+highestLuck then
					local coinsToRemove = rng:RandomInt(1,math.min(5,minCoins))
					players[1]:AddCoins(coinsToRemove*-1)
					runSave.CounterfeitCoins = runSave.CounterfeitCoins - coinsToRemove
					for _,player in ipairs(players) do
						player:AnimateSad()
					end
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_ROOM_TRIGGER_CLEAR, mod.OnRoomClearItems)

function mod.BloodyFeatherEffect(player)
	local position = Isaac:GetRandomPosition()
	local percentChance = 60
	if player then
		percentChance = percentChance + (player.Luck * 2)
	end
	local homingChance = player:GetCollectibleRNG(CollectibleType.BLOODY_FEATHER):RandomInt(1,100)
	if homingChance <= percentChance then
		local vulnEnemies = {}
		for _, entity in pairs(Isaac.GetRoomEntities()) do
			if entity:IsVulnerableEnemy() then
				vulnEnemies[#vulnEnemies+1] = entity.Position+entity.Velocity
			end
		end
		if #vulnEnemies > 0 then
			local doThisGuy = player:GetCollectibleRNG(CollectibleType.BLOODY_FEATHER):RandomInt(1,#vulnEnemies)
			position = vulnEnemies[doThisGuy]
		end
	end
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, position, Vector.Zero, player)
end

function mod.PreEntityTakeDMGItems(entity, amount, flags, source, cooldown)
	if entity and entity.Type == EntityType.ENTITY_PLAYER then
		local player = entity:ToPlayer()
		for i=1, player:GetCollectibleNum(CollectibleType.BLOODY_FEATHER) do
			mod.BloodyFeatherEffect(player)
		end
	end
end
mod.AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, mod.PreEntityTakeDMGItems)

mod.VeggiesColor = Color(0.2, 1.0, 0.1, 1.0)
function mod.PostAddCollectibleVeggies(collectibleID, charge, firstTime, slot, varData, player)
	if collectibleID == CollectibleType.MIXED_VEGGIES then
		player.Color = mod.VeggiesColor
	end
end
mod.AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.PostAddCollectibleVeggies)

mod.AllowedBabySpawns = {}
for i=0, 58 do
	mod.AllowedBabySpawns[#mod.AllowedBabySpawns+1] = i
end
for i=64, 69 do
	mod.AllowedBabySpawns[#mod.AllowedBabySpawns+1] = i
end
local tryaltmethod = false
function mod.OnUseMysticalEgg(itemID, rng, player, flags, slot, customvardata)
	PlayerManager.SpawnSelectedBaby(mod.AllowedBabySpawns[rng:RandomInt(1, #mod.AllowedBabySpawns)], player.ControllerIndex)
	return true
end
mod.AddCallback(ModCallbacks.MC_USE_ITEM, mod.OnUseMysticalEgg, CollectibleType.MYSTICAL_EGG)

function mod.OnBabyPlayerUpdate(player)
	if not player.Parent then
		for _, otherplayer in ipairs(PlayerManager.GetPlayers()) do
			if player.ControllerIndex == otherplayer.ControllerIndex and otherplayer.Variant == 0 then
				player.Parent = otherplayer
				Game():GetHUD():AssignPlayerHUDs()
				break
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.OnBabyPlayerUpdate, 1)

function mod.OnBabyDeath(player)
	if player.Variant == 1 and player.Parent then
		local hearts = player:GetMaxHearts()
		if hearts > 0 then
			player.Parent:ToPlayer():AddMaxHearts(hearts)
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_TRIGGER_PLAYER_DEATH, mod.OnBabyDeath)

mod.FaithUpItems = {}
mod.FaithUpItems[CollectibleType.COLLECTIBLE_ROSARY] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_JAR_OF_WISPS] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_SOUL_LOCKET] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_REVELATION] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_CRACK_THE_SKY] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_HOLY_WATER] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_HOLY_GRAIL] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_WHITE_PONY] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_HOLY_MANTLE] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_HOLY_LIGHT] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_BIBLE] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_PRAYER_CARD] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_BOOK_OF_VIRTUES] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_FATE] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_POLAROID] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_PURITY] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_IMMACULATE_CONCEPTION] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_DUALITY] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_EUCHARIST] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_HALLOWED_GROUND] = true
mod.FaithUpItems[CollectibleType.COLLECTIBLE_ACT_OF_CONTRITION] = true
mod.FaithUpTrinkets = {}
mod.FaithUpTrinkets[TrinketType.TRINKET_ROSARY_BEAD] = true
mod.FaithUpTrinkets[TrinketType.TRINKET_BIBLE_TRACT] = true
mod.FaithUpTrinkets[TrinketType.TRINKET_MAGGYS_FAITH] = true
mod.FaithUpTrinkets[TrinketType.TRINKET_WOODEN_CROSS] = true
mod.FaithUpTrinkets[TrinketType.TRINKET_BETHS_FAITH] = true
mod.FaithUpTrinkets[TrinketType.TRINKET_HOLY_CROWN] = true
function mod.OnEvaluateFlatTearsItems(player, stage, value)
	local mult = player:GetTrinketMultiplier(TrinketType.ORTHODOX_CROSS) * 0.2
	if mult > 0 then
		local faiths = 0
		for itemID, isholy in pairs(mod.FaithUpItems) do
			if isholy then
				faiths = faiths + player:GetCollectibleNum(itemID, true)
			end
		end
		for trinketID, isholy in pairs(mod.FaithUpTrinkets) do
			if isholy then
				faiths = faiths + player:GetTrinketMultiplier(trinketID)
			end
		end
		return value + (faiths*mult)
	end
end
mod.AddCallback(ModCallbacks.MC_EVALUATE_STAT, mod.OnEvaluateFlatTearsItems, EvaluateStatStage.FLAT_TEARS)

function mod.PostAddItemForOrthodoxCross(itemID, charge, firsttime, slot, varData, player)
	if mod.FaithUpItems[itemID] and player:HasTrinket(TrinketType.ORTHODOX_CROSS) then
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY, true)
	end
end
mod.AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.PostAddItemForOrthodoxCross)

function mod.PreAddTrinketForForOrthodoxCross(player, trinketID, firsttime)
	if mod.FaithUpTrinkets[trinketID] and player:HasTrinket(TrinketType.ORTHODOX_CROSS) then
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY, true)
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_ADD_TRINKET, mod.PreAddTrinketForForOrthodoxCross)
