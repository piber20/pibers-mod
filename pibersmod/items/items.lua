local mod = PibersMod

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

function mod.PostDevilCalculate(chance)
	local game = Game()
	local level = game:GetLevel()
	local floorSave = mod.SaveManager.GetFloorSave()
	if PlayerManager.AnyoneHasTrinket(TrinketType.ORTHODOX_CROSS) then
		if not floorSave.AppliedOrthodox then
			level:AddAngelRoomChance(1.0)
			floorSave.AppliedOrthodox = true
		end
		return 1.0
	elseif floorSave.AppliedOrthodox then
		level:AddAngelRoomChance(-1.0)
		floorSave.AppliedOrthodox = false
	end
end
mod.AddCallback(ModCallbacks.MC_POST_DEVIL_CALCULATE, mod.PostDevilCalculate)
