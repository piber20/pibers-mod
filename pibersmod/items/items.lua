function PibersMod:OnNewRoomItems()
	for _, player in ipairs(PlayerManager.GetPlayers()) do
		local playerData = PibersMod.GetData(player)
		playerData.newRoom = true
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, PibersMod.OnNewRoomItems)

PibersMod.LastMainPlayerType = PlayerType.PLAYER_ISAAC
function PibersMod:OnUpdateItems()
	local player1 = Isaac.GetPlayer(0)
	if player1 and player1:Exists() then
		PibersMod.LastMainPlayerType = player1:GetPlayerType()
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_UPDATE, PibersMod.OnUpdateItems)

function PibersMod:PreAddCounterfeitDollar(itemID, charge, firsttime, slot, varData, player)
	local runSave = PibersMod.SaveManager.GetRunSave()
	runSave.CounterfeitCoins = runSave.CounterfeitCoins or 0
	runSave.PreCounterfeitCoins = player:GetNumCoins()
end
PibersMod:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, PibersMod.PreAddCounterfeitDollar, CollectibleType.COUNTERFEIT_DOLLAR)

function PibersMod:PostAddCounterfeitDollar(itemID, charge, firsttime, slot, varData, player)
	local runSave = PibersMod.SaveManager.GetRunSave()
	runSave.PreCounterfeitCoins = runSave.PreCounterfeitCoins or 0
	runSave.CounterfeitCoins = runSave.CounterfeitCoins or 0
	runSave.CounterfeitCoins = runSave.CounterfeitCoins + (player:GetNumCoins() - runSave.PreCounterfeitCoins)
end
PibersMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, PibersMod.PostAddCounterfeitDollar, CollectibleType.COUNTERFEIT_DOLLAR)

function PibersMod.GetCollectibleOwners(itemID)
	local players = PlayerManager.GetPlayers()
	local ownerPlayers = {}
	for _,player in ipairs(players) do
		if player:HasCollectible(CollectibleType.COUNTERFEIT_DOLLAR) then
			ownerPlayers[#ownerPlayers+1] = player
		end
	end
	return ownerPlayers
end

function PibersMod:OnRoomClearItems(silent)
	if PlayerManager.AnyoneHasCollectible(CollectibleType.COUNTERFEIT_DOLLAR) and not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
		local runSave = PibersMod.SaveManager.GetRunSave()
		runSave.CounterfeitCoins = runSave.CounterfeitCoins or 0
		if runSave.CounterfeitCoins > 0 then
			local players = PibersMod.GetCollectibleOwners(CollectibleType.COUNTERFEIT_DOLLAR)
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
PibersMod:AddCallback(ModCallbacks.MC_POST_ROOM_TRIGGER_CLEAR, PibersMod.OnRoomClearItems)

function PibersMod.BloodyFeatherEffect(player)
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

function PibersMod:PreEntityTakeDMGItems(entity, amount, flags, source, cooldown)
	if entity and entity.Type == EntityType.ENTITY_PLAYER then
		local player = entity:ToPlayer()
		for i=1, player:GetCollectibleNum(CollectibleType.BLOODY_FEATHER) do
			PibersMod.BloodyFeatherEffect(player)
		end
	end
end
PibersMod:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, PibersMod.PreEntityTakeDMGItems)

PibersMod.VeggiesColor = Color(0.2, 1.0, 0.1, 1.0)
function PibersMod:PostAddCollectibleVeggies(collectibleID, charge, firstTime, slot, varData, player)
	if collectibleID == CollectibleType.MIXED_VEGGIES then
		player.Color = PibersMod.VeggiesColor
	end
end
PibersMod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, PibersMod.PostAddCollectibleVeggies)

function PibersMod:PostDevilCalculate(chance)
	local game = Game()
	local level = game:GetLevel()
	local floorSave = PibersMod.SaveManager.GetFloorSave()
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
PibersMod:AddCallback(ModCallbacks.MC_POST_DEVIL_CALCULATE, PibersMod.PostDevilCalculate)
