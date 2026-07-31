--the version of this helper mod script
local currentVersion = 117

--remove any previous versions that may exist
local callbacksAlreadyLoaded = nil
if PickupHelper then
	local thisVersion = 1
	if PickupHelper.Version then
		thisVersion = PickupHelper.Version
	end
	if thisVersion < currentVersion then
		PickupHelper = nil
		Isaac.DebugString("Removed older pickup helper (version " .. thisVersion .. ")")
	end
end

if not PickupHelper then
	PickupHelper = RegisterMod("pickup helper", 1)
	PickupHelper.Version = currentVersion
	PickupHelper.IsPickupHelperMod = true
	Isaac.DebugString("Loading pickup helper version " .. PickupHelper.Version)
	
	if PickupHelper.StandaloneMod == nil then
		PickupHelper.StandaloneMod = false
	end
	if PickupHelper.ReimplementedBigbook == nil then
		PickupHelper.ReimplementedBigbook = false
	end
	
	Vector.Zero = Vector(0,0)
	PickupHelper.VECTOR_ONE = Vector(1,1)
	
	PickupHelper.VECTOR_LEFT = Vector(-1,0)
	PickupHelper.VECTOR_UP = Vector(0,-1)
	PickupHelper.VECTOR_RIGHT = Vector(1,0)
	PickupHelper.VECTOR_DOWN = Vector(0,1)
	PickupHelper.VECTOR_UP_LEFT = Vector(-1,-1)
	PickupHelper.VECTOR_UP_RIGHT = Vector(1,-1)
	PickupHelper.VECTOR_DOWN_LEFT = Vector(-1,1)
	PickupHelper.VECTOR_DOWN_RIGHT = PickupHelper.VECTOR_ONE
	
	PickupHelper.COLOR_DEFAULT = Color(1,1,1,1,0,0,0)
	PickupHelper.COLOR_HALF = Color(1,1,1,0.5,0,0,0)
	PickupHelper.COLOR_INVISIBLE = Color(1,1,1,0,0,0,0)
	PickupHelper.KCOLOR_DEFAULT = KColor(1,1,1,1)
	PickupHelper.KCOLOR_HALF = KColor(1,1,1,0.5)
	PickupHelper.KCOLOR_INVISIBLE = KColor(1,1,1,0)
	
	--------------------
	--CUSTOM CALLBACKS--
	--------------------
	PickupHelperCallbacks = {
		--use these callbacks with PickupHelper.AddCustomCallback(modRef, callbackID, callbackFunction, extraVar)
		--using a vanilla callback id will register the callback to modRef normally but consolidated into a single callback if you use this multiple times
		
		--custom callback functions that run when a mod adds a callback through PickupHelperhelper's custom callback function (crazy huh?)
		--specify a callback id to make your code trigger for only that specific callback
		--function(modRef, callbackID, callbackFunction, extraVar)
		MC_PRE_ADD_CUSTOM_CALLBACK = 300,
		MC_POST_ADD_CUSTOM_CALLBACK = 301,
		
		--ENTITY callbacks which use all callbacks for every entity type
		--specifying an entity type will redirect your addcallback to a vanilla callback id that matches the entity type if it exists
		--this will not work for entity types where there is no possible callback to match (like slots)
		MC_POST_ENTITY_INIT = 302,
		MC_POST_ENTITY_UPDATE = 303,
		MC_POST_ENTITY_RENDER = 304,
		MC_PRE_ENTITY_COLLISION = 305,
		
		--MC_POST_GAME_STARTED that only triggers once, if the player starts another run this callback will not be triggered
		MC_POST_FIRST_GAME_START = 306,
		
		--collected callbacks are triggered when PickupHelperhelper thinks a pickup has been collected or a pickup registered and working within the PickupHelperhelper system is being collected
		--specifying an entity variant will make it so your function is only triggered with pickups of the variant provided
		--return true in MC_PRE_PICKUP_COLLECTED to prevent the pickup from being collected and to prevent stuff being added to the player
		--function(pickup, player)
		MC_PRE_PICKUP_COLLECTED = 307,
		MC_POST_PICKUP_COLLECTED = 308,
		
		--this is triggered when a player tear is inited, works with the player's tears and incubus tears
		--function(tear, player)
		MC_POST_PLAYER_TEAR = 309,
		
		--this is triggered when a player loses a black heart and its effects are triggered
		--function(player)
		MC_POST_LOSE_BLACK_HEART = 310,
		
		--this is triggered when a player loses a bone heart
		--function(player)
		MC_POST_LOSE_BONE_HEART = 311,
		
		--this is triggered when a player loses a holy mantle effect
		--function(player, isPersistent, isCross, isCard, isBlanket)
		MC_POST_LOSE_HOLY_MANTLE = 312,
		
		--this is triggered when the room is cleared
		MC_POST_ROOM_CLEAR = 313,
		
		--this is triggered when a greed wave ends
		MC_POST_GREED_WAVE = 314,
		
		--this is triggered on the first frame for each player after a new floor is loaded, for use to work around items like the holy mantle
		--function(player)
		MC_POST_PLAYER_NEW_LEVEL = 315,
		
		--this is triggered when a player uses an active item, use this callback over the default one
		--function(player, itemID, itemRNG, isCarBatteryUse)
		MC_POST_USE_ITEM = 316,
		
		--this is triggered when a player uses a pill, use this callback over the default one
		--function(player, pillColor, pillEffect, pillEffectRNG)
		MC_POST_USE_PILL = 317,
		
		--this is triggered when a player uses a card, use this callback over the default one
		--function(player, cardID, cardRNG, isTarotClothUse), takes cardID as value
		MC_POST_USE_CARD = 318,
		
		--this is triggered when a player obtains a collectible
		--function(player, itemID)
		MC_POST_ITEM_COLLECTED = 319,
		
		--this is triggered when the room's ambush is finished (like in boss rush)
		MC_POST_AMBUSH_DONE = 320,
		
		--update and render callbacks for slot entities. this works by going through all slots in a MC_POST_UPDATE callback and a MC_POST_RENDER callback.
		--specifying an entity variant will make it so your function is only triggered with slot entities of the variant provided
		--function(entity)
		MC_POST_SLOT_UPDATE = 321,
		MC_POST_SLOT_RENDER = 322
	}

	PickupHelperCallbackData = PickupHelperCallbackData or {}
	function PickupHelper.AddCustomCallback(modRef, callbackID, callbackFunction, extraVar)
		if not modRef then
			error("AddCustomCallback Error: No valid mod reference provided")
			return
		end
		if not callbackID then
			error("AddCustomCallback Error: No valid callback ID provided")
			return
		end
		if not callbackFunction then
			error("AddCustomCallback Error: No valid callback function provided")
			return
		end
		PickupHelperCallbackData = PickupHelperCallbackData or {}
		
		--MC_PRE_ADD_CUSTOM_CALLBACK
		if PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_ADD_CUSTOM_CALLBACK] then
			for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_ADD_CUSTOM_CALLBACK]) do
				if not callbackData.extraVariable or callbackData.extraVariable == callbackID then
					local returned = callbackData.functionToCall(modRef, callbackID, callbackFunction, extraVar)
					if returned == false then
						return
					end
				end
			end
		end
		
		PickupHelperCallbackData[callbackID] = PickupHelperCallbackData[callbackID] or {}
		PickupHelperCallbackData[callbackID][#PickupHelperCallbackData[callbackID]+1] = {modReference = modRef, functionToCall = callbackFunction, extraVariable = extraVar}
		
		--MC_POST_ADD_CUSTOM_CALLBACK
		if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_ADD_CUSTOM_CALLBACK] then
			for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_ADD_CUSTOM_CALLBACK]) do
				if not callbackData.extraVariable or callbackData.extraVariable == callbackID then
					callbackData.functionToCall(modRef, callbackID, callbackFunction, extraVar)
				end
			end
		end
	end
	
	--slot callbacks
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_SLOT_UPDATE] then
			for _, slot in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, -1, -1, false, false)) do
				for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_SLOT_UPDATE]) do
					if not callbackData.extraVariable or callbackData.extraVariable == slot.Variant then
						callbackData.functionToCall(callbackData.modReference, slot)
					end
				end
			end
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_SLOT_RENDER] then
			for _, slot in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, -1, -1, false, false)) do
				for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_SLOT_RENDER]) do
					if not callbackData.extraVariable or callbackData.extraVariable == slot.Variant then
						callbackData.functionToCall(callbackData.modReference, slot)
					end
				end
			end
		end
	end)
	
	--add special handling for vanilla callbacks - merges all the functions into a singular callback
	local callbacksCompareExtraVar = {
		[ModCallbacks.MC_USE_ITEM] = true,
		[ModCallbacks.MC_USE_CARD] = true,
		[ModCallbacks.MC_USE_PILL] = true,
		[ModCallbacks.MC_PRE_USE_ITEM] = true
	}
	local callbacksCompareTypeExtraVar = {
		[ModCallbacks.MC_NPC_UPDATE] = true,
		[ModCallbacks.MC_ENTITY_TAKE_DMG] = true,
		[ModCallbacks.MC_POST_NPC_INIT] = true,
		[ModCallbacks.MC_POST_NPC_RENDER] = true,
		[ModCallbacks.MC_POST_NPC_DEATH] = true,
		[ModCallbacks.MC_PRE_NPC_COLLISION] = true,
		[ModCallbacks.MC_POST_ENTITY_REMOVE] = true,
		[ModCallbacks.MC_POST_ENTITY_KILL] = true,
		[ModCallbacks.MC_PRE_NPC_UPDATE] = true
	}
	local callbacksCompareVariantExtraVar = {
		[ModCallbacks.MC_FAMILIAR_UPDATE] = true,
		[ModCallbacks.MC_FAMILIAR_INIT] = true,
		[ModCallbacks.MC_POST_FAMILIAR_RENDER] = true,
		[ModCallbacks.MC_PRE_FAMILIAR_COLLISION] = true,
		[ModCallbacks.MC_POST_PICKUP_INIT] = true,
		[ModCallbacks.MC_POST_PICKUP_UPDATE] = true,
		[ModCallbacks.MC_POST_PICKUP_RENDER] = true,
		[ModCallbacks.MC_PRE_PICKUP_COLLISION] = true,
		[ModCallbacks.MC_POST_TEAR_INIT] = true,
		[ModCallbacks.MC_POST_TEAR_UPDATE] = true,
		[ModCallbacks.MC_POST_TEAR_RENDER] = true,
		[ModCallbacks.MC_PRE_TEAR_COLLISION] = true,
		[ModCallbacks.MC_POST_PROJECTILE_INIT] = true,
		[ModCallbacks.MC_POST_PROJECTILE_UPDATE] = true,
		[ModCallbacks.MC_POST_PROJECTILE_RENDER] = true,
		[ModCallbacks.MC_PRE_PROJECTILE_COLLISION] = true,
		[ModCallbacks.MC_POST_LASER_INIT] = true,
		[ModCallbacks.MC_POST_LASER_UPDATE] = true,
		[ModCallbacks.MC_POST_LASER_RENDER] = true,
		[ModCallbacks.MC_POST_KNIFE_INIT] = true,
		[ModCallbacks.MC_POST_KNIFE_UPDATE] = true,
		[ModCallbacks.MC_POST_KNIFE_RENDER] = true,
		[ModCallbacks.MC_PRE_KNIFE_COLLISION] = true,
		[ModCallbacks.MC_POST_EFFECT_INIT] = true,
		[ModCallbacks.MC_POST_EFFECT_UPDATE] = true,
		[ModCallbacks.MC_POST_EFFECT_RENDER] = true,
		[ModCallbacks.MC_POST_BOMB_INIT] = true,
		[ModCallbacks.MC_POST_BOMB_UPDATE] = true,
		[ModCallbacks.MC_POST_BOMB_RENDER] = true,
		[ModCallbacks.MC_PRE_BOMB_COLLISION] = true
	}
	PickupHelperCallbackModsSetUp = PickupHelperCallbackModsSetUp or {}
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_ADD_CUSTOM_CALLBACK, function(modRef, callbackID, callbackFunction, extraVar)
		if not modRef.PickupHelperModID then
			modRef.PickupHelperModID = #PickupHelperCallbackModsSetUp+1
			PickupHelperCallbackModsSetUp[#PickupHelperCallbackModsSetUp+1] = modRef
		end
		modRef.PickupHelperMergedCallbacksAdded = modRef.PickupHelperMergedCallbacksAdded or {}
		if callbackID <= ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN and not modRef.PickupHelperMergedCallbacksAdded[callbackID] then
			modRef:AddCallback(callbackID, function(...)
				local args = {...}
				--args[1] is the mod reference
				--args[2] would be the entity or item id
				if PickupHelperCallbackData and PickupHelperCallbackData[callbackID] then
					for _, callbackData in ipairs(PickupHelperCallbackData[callbackID]) do
						if args[1].PickupHelperModID == callbackData.modReference.PickupHelperModID then
							if not callbackData.extraVariable
							or (callbackData.extraVariable
								and ((callbacksCompareExtraVar[callbackID] and args[2] == callbackData.extraVariable)
								or (callbacksCompareTypeExtraVar[callbackID] and args[2].Type == callbackData.extraVariable)
								or (callbacksCompareVariantExtraVar[callbackID] and args[2].Variant == callbackData.extraVariable))
							) then
								local toReturn = callbackData.functionToCall(...)
								if toReturn ~= nil then
									return toReturn
								end
							end
						end
					end
				end
			end)
			modRef.PickupHelperMergedCallbacksAdded[callbackID] = true
		end
	end)
	
	function PickupHelper.ReCacheData()
		PickupHelper.Game = Game()
		PickupHelper.ItemPool = PickupHelper.Game:GetItemPool()
		PickupHelper.Seeds = PickupHelper.Game:GetSeeds()
		PickupHelper.Level = PickupHelper.Game:GetLevel()
		PickupHelper.Room = PickupHelper.Game:GetRoom()
		PickupHelper.ItemConfig = Isaac.GetItemConfig()
		PickupHelper.Music = MusicManager()
		PickupHelper.SFX = SFXManager()
	end
	PickupHelper.ReCacheData()
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		PickupHelper.ReCacheData()
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		PickupHelper.ReCacheData()
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		PickupHelper.ReCacheData()
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_INIT, function()
		PickupHelper.ReCacheData()
	end)

	--ENTITY callbacks setup
	local entityCallbacksToSetUp = {
		{
			ID = PickupHelperCallbacks.MC_POST_ENTITY_INIT,
			Callbacks = {
				ModCallbacks.MC_FAMILIAR_INIT,
				ModCallbacks.MC_POST_PLAYER_INIT,
				ModCallbacks.MC_POST_NPC_INIT,
				ModCallbacks.MC_POST_PICKUP_INIT,
				ModCallbacks.MC_POST_TEAR_INIT,
				ModCallbacks.MC_POST_PROJECTILE_INIT,
				ModCallbacks.MC_POST_LASER_INIT,
				ModCallbacks.MC_POST_KNIFE_INIT,
				ModCallbacks.MC_POST_EFFECT_INIT,
				ModCallbacks.MC_POST_BOMB_INIT
			},
			EntityTypeCallbacks = {
				[EntityType.ENTITY_FAMILIAR] = ModCallbacks.MC_FAMILIAR_INIT,
				[EntityType.ENTITY_PLAYER] = ModCallbacks.MC_POST_PLAYER_INIT,
				[EntityType.ENTITY_PICKUP] = ModCallbacks.MC_POST_PICKUP_INIT,
				[EntityType.ENTITY_TEAR] = ModCallbacks.MC_POST_TEAR_INIT,
				[EntityType.ENTITY_PROJECTILE] = ModCallbacks.MC_POST_PROJECTILE_INIT,
				[EntityType.ENTITY_LASER] = ModCallbacks.MC_POST_LASER_INIT,
				[EntityType.ENTITY_KNIFE] = ModCallbacks.MC_POST_KNIFE_INIT,
				[EntityType.ENTITY_EFFECT] = ModCallbacks.MC_POST_EFFECT_INIT,
				[EntityType.ENTITY_BOMBDROP] = ModCallbacks.MC_POST_BOMB_INIT
			},
			NPCCallback = ModCallbacks.MC_POST_NPC_INIT
		},
		{
			ID = PickupHelperCallbacks.MC_POST_ENTITY_UPDATE,
			Callbacks = {
				ModCallbacks.MC_NPC_UPDATE,
				ModCallbacks.MC_FAMILIAR_UPDATE,
				ModCallbacks.MC_POST_PLAYER_UPDATE,
				ModCallbacks.MC_POST_PICKUP_UPDATE,
				ModCallbacks.MC_POST_TEAR_UPDATE,
				ModCallbacks.MC_POST_PROJECTILE_UPDATE,
				ModCallbacks.MC_POST_LASER_UPDATE,
				ModCallbacks.MC_POST_KNIFE_UPDATE,
				ModCallbacks.MC_POST_EFFECT_UPDATE,
				ModCallbacks.MC_POST_BOMB_UPDATE,
				PickupHelperCallbacks.MC_POST_SLOT_UPDATE
			},
			EntityTypeCallbacks = {
				[EntityType.ENTITY_FAMILIAR] = ModCallbacks.MC_FAMILIAR_UPDATE,
				[EntityType.ENTITY_PLAYER] = ModCallbacks.MC_POST_PLAYER_UPDATE,
				[EntityType.ENTITY_PICKUP] = ModCallbacks.MC_POST_PICKUP_UPDATE,
				[EntityType.ENTITY_TEAR] = ModCallbacks.MC_POST_TEAR_UPDATE,
				[EntityType.ENTITY_PROJECTILE] = ModCallbacks.MC_POST_PROJECTILE_UPDATE,
				[EntityType.ENTITY_LASER] = ModCallbacks.MC_POST_LASER_UPDATE,
				[EntityType.ENTITY_KNIFE] = ModCallbacks.MC_POST_KNIFE_UPDATE,
				[EntityType.ENTITY_EFFECT] = ModCallbacks.MC_POST_EFFECT_UPDATE,
				[EntityType.ENTITY_BOMBDROP] = ModCallbacks.MC_POST_BOMB_UPDATE,
				[EntityType.ENTITY_SLOT] = PickupHelperCallbacks.MC_POST_SLOT_UPDATE
			},
			NPCCallback = ModCallbacks.MC_NPC_UPDATE
		},
		{
			ID = PickupHelperCallbacks.MC_POST_ENTITY_RENDER,
			Callbacks = {
				ModCallbacks.MC_POST_FAMILIAR_RENDER,
				ModCallbacks.MC_POST_NPC_RENDER,
				ModCallbacks.MC_POST_PLAYER_RENDER,
				ModCallbacks.MC_POST_PICKUP_RENDER,
				ModCallbacks.MC_POST_TEAR_RENDER,
				ModCallbacks.MC_POST_PROJECTILE_RENDER,
				ModCallbacks.MC_POST_LASER_RENDER,
				ModCallbacks.MC_POST_KNIFE_RENDER,
				ModCallbacks.MC_POST_EFFECT_RENDER,
				ModCallbacks.MC_POST_BOMB_RENDER,
				PickupHelperCallbacks.MC_POST_SLOT_RENDER
			},
			EntityTypeCallbacks = {
				[EntityType.ENTITY_FAMILIAR] = ModCallbacks.MC_POST_FAMILIAR_RENDER,
				[EntityType.ENTITY_PLAYER] = ModCallbacks.MC_POST_PLAYER_RENDER,
				[EntityType.ENTITY_PICKUP] = ModCallbacks.MC_POST_PICKUP_RENDER,
				[EntityType.ENTITY_TEAR] = ModCallbacks.MC_POST_TEAR_RENDER,
				[EntityType.ENTITY_PROJECTILE] = ModCallbacks.MC_POST_PROJECTILE_RENDER,
				[EntityType.ENTITY_LASER] = ModCallbacks.MC_POST_LASER_RENDER,
				[EntityType.ENTITY_KNIFE] = ModCallbacks.MC_POST_KNIFE_RENDER,
				[EntityType.ENTITY_EFFECT] = ModCallbacks.MC_POST_EFFECT_RENDER,
				[EntityType.ENTITY_BOMBDROP] = ModCallbacks.MC_POST_BOMB_RENDER,
				[EntityType.ENTITY_SLOT] = PickupHelperCallbacks.MC_POST_SLOT_RENDER
			},
			NPCCallback = ModCallbacks.MC_POST_NPC_RENDER
		},
		{
			ID = PickupHelperCallbacks.MC_PRE_ENTITY_COLLISION,
			Callbacks = {
				ModCallbacks.MC_PRE_FAMILIAR_COLLISION,
				ModCallbacks.MC_PRE_NPC_COLLISION,
				ModCallbacks.MC_PRE_PLAYER_COLLISION,
				ModCallbacks.MC_PRE_PICKUP_COLLISION,
				ModCallbacks.MC_PRE_TEAR_COLLISION,
				ModCallbacks.MC_PRE_PROJECTILE_COLLISION,
				ModCallbacks.MC_PRE_KNIFE_COLLISION,
				ModCallbacks.MC_PRE_BOMB_COLLISION
			},
			EntityTypeCallbacks = {
				[EntityType.ENTITY_FAMILIAR] = ModCallbacks.MC_PRE_FAMILIAR_COLLISION,
				[EntityType.ENTITY_PLAYER] = ModCallbacks.MC_PRE_PLAYER_COLLISION,
				[EntityType.ENTITY_PICKUP] = ModCallbacks.MC_PRE_PICKUP_COLLISION,
				[EntityType.ENTITY_TEAR] = ModCallbacks.MC_PRE_TEAR_COLLISION,
				[EntityType.ENTITY_PROJECTILE] = ModCallbacks.MC_PRE_PROJECTILE_COLLISION,
				[EntityType.ENTITY_KNIFE] = ModCallbacks.MC_PRE_KNIFE_COLLISION,
				[EntityType.ENTITY_BOMBDROP] = ModCallbacks.MC_PRE_BOMB_COLLISION
			},
			NPCCallback = ModCallbacks.MC_PRE_NPC_COLLISION
		}
	}
	for _, entityCallbackDataToSetUp in ipairs(entityCallbacksToSetUp) do
		PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_ADD_CUSTOM_CALLBACK, function(modRef, callbackID, callbackFunction, extraVar)
			if extraVar then
				local singleCallback = entityCallbackDataToSetUp.EntityTypeCallbacks[extraVar] or entityCallbackDataToSetUp.NPCCallback
				PickupHelper.AddCustomCallback(modRef, singleCallback, callbackFunction)
			else
				for _, entityCallbackID in ipairs(entityCallbackDataToSetUp.Callbacks) do
					PickupHelper.AddCustomCallback(modRef, entityCallbackID, callbackFunction)
				end
			end
		end, entityCallbackDataToSetUp.ID)
	end
	
	--MC_POST_FIRST_GAME_START
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_ADD_CUSTOM_CALLBACK, function(modRef, callbackID, callbackFunction, extraVar)
		if not modRef.PickupHelperAddedFirstGameStartCallback then
			PickupHelper.AddCustomCallback(modRef, ModCallbacks.MC_POST_GAME_STARTED, function(modRef, fromSave)
				if not modRef.PickupHelperFirstGameStartTracker then
					modRef.PickupHelperFirstGameStartTracker = true
					if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_FIRST_GAME_START] then
						for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_FIRST_GAME_START]) do
							if modRef.PickupHelperModID == callbackData.modReference.PickupHelperModID then
								callbackData.functionToCall(modRef, fromSave)
							end
						end
					end
				end
			end, extraVar)
		end
		modRef.PickupHelperAddedFirstGameStartCallback = true
	end, PickupHelperCallbacks.MC_POST_FIRST_GAME_START)
	
	--------------
	--ITEM USAGE--
	--------------
	
	--returns the player who is probably using an active item or card
	--if strict is false or nil, returns Isaac.GetPlayer(0) if it cant find a player
	--if strict is true, returns nil if it cant find a player
	function PickupHelper.GetPlayerUsingItem(strict)
		local player = nil
		
		for _, thisPlayer in pairs(PickupHelper.GetPlayers()) do
			if Input.IsActionTriggered(ButtonAction.ACTION_ITEM, thisPlayer.ControllerIndex) or Input.IsActionTriggered(ButtonAction.ACTION_PILLCARD, thisPlayer.ControllerIndex) then
				player = thisPlayer
				break
			end
		end
		
		if not strict and player == nil then
			player = Isaac.GetPlayer(0)
		end
		
		return player
	end
	
	--single use item callback that redirects into the custom callbacks, to avoid bugs with multiple players and to make things easier
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_ITEM, function(_, itemID, itemRNG)
		local player = PickupHelper.GetPlayerUsingItem(true)
		if player then
			
			local data = PickupHelper.GetData(player)
			data.ItemsBeingUsed = data.ItemsBeingUsed or {}
			
			local currentFrame = Isaac.GetFrameCount()
			
			if not data.ItemsBeingUsed[itemID] or (data.ItemsBeingUsed[itemID] and data.ItemsBeingUsed[itemID] ~= currentFrame) then
				data.ItemsBeingUsed[itemID] = currentFrame
				
				if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_USE_ITEM] then
					local returned = nil
					for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_USE_ITEM]) do
						if not callbackData.extraVariable or callbackData.extraVariable == itemID then
							local uses = 1 + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CAR_BATTERY)
							
							for i=1, uses do
								returned = callbackData.functionToCall(callbackData.modReference, player, itemID, itemRNG, i > 1)
							end
							if returned == true then
								player:AnimateCollectible(itemID, "UseItem", "PlayerPickup")
							end
						end
					end
					return returned
				end
			end
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_PILL, function(_, pillEffect)
		local player = PickupHelper.GetPlayerUsingItem(true)
		if player then
			
			local pillColor = nil
			for i=0, 200 do
				if PickupHelper.ItemPool:GetPillEffect(i) == pillEffect then
					pillColor = i
					break
				end
			end
			
			if pillColor then
			
				local data = PickupHelper.GetData(player)
				data.PillsBeingUsed = data.PillsBeingUsed or {}
				
				local currentFrame = Isaac.GetFrameCount()
				
				if not data.PillsBeingUsed[pillColor] or (data.PillsBeingUsed[pillColor] and data.PillsBeingUsed[pillColor] ~= currentFrame) then
					data.PillsBeingUsed[pillColor] = currentFrame
					
					if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_USE_PILL] then
						local returned = nil
						for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_USE_PILL]) do
							if not callbackData.extraVariable or callbackData.extraVariable == pillEffect then
								local uses = 1
								local pillEffectRNG = player:GetPillRNG(pillEffect)
								
								for i=1, uses do
									returned = callbackData.functionToCall(callbackData.modReference, player, pillColor, pillEffect, pillEffectRNG)
								end
							end
						end
						return returned
					end
				end
			end
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_CARD, function(_, cardID)
		local player = PickupHelper.GetPlayerUsingItem(true)
		if player then
			local data = PickupHelper.GetData(player)
			data.CardsBeingUsed = data.CardsBeingUsed or {}
			
			local currentFrame = Isaac.GetFrameCount()
			
			if not data.CardsBeingUsed[cardID] or (data.CardsBeingUsed[cardID] and data.CardsBeingUsed[cardID] ~= currentFrame) then
				data.CardsBeingUsed[cardID] = currentFrame
				
				if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_USE_CARD] then
					local returned = nil
					for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_USE_CARD]) do
						if not callbackData.extraVariable or callbackData.extraVariable == cardID then
							local uses = 1 + player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TAROT_CLOTH)
							local cardRNG = player:GetCardRNG(cardID)
							
							for i=1, uses do
								returned = callbackData.functionToCall(callbackData.modReference, player, cardID, cardRNG, i > 1)
							end
						end
					end
					return returned
				end
			end
		end
	end)
	
	-----------------------------------
	--CUSTOM COLLECTED ITEM CALLBACKS--
	-----------------------------------
	
	local forceItemsCollectedEval = {}
	function PickupHelper.EvaluateItemsCollected(player)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		forceItemsCollectedEval[currentPlayer] = true
	end
	function PickupHelper.PlayerHadCollectibleCount(player, collectible)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		
		local collectibleCount = 0
		if PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][collectible] and PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][collectible] > 0 then
			collectibleCount = PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][collectible]
		end
		
		return collectibleCount
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		if PickupHelper.DidPlayerCollectibleCountJustChange(player) or forceItemsCollectedEval[currentPlayer] then
			forceItemsCollectedEval[currentPlayer] = nil
			for i=1, PickupHelperCollectibleType.LAST_COLLECTIBLE do
			
				if not PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][i] then
					PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][i] = 0
				end
				
				local count = player:GetCollectibleNum(i)
				if count < 1 then
					count = 1
				end
				for j=1, count do
					if player:HasCollectible(i) and PickupHelper.PlayerHadCollectibleCount(player, i) < count then
						PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][i] = PickupHelper.PlayerHadCollectibleCount(player, i) + 1
						
						--MC_POST_ITEM_COLLECTED
						if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_ITEM_COLLECTED] then
							for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_ITEM_COLLECTED]) do
								if not callbackData.extraVariable or callbackData.extraVariable == i then
									callbackData.functionToCall(callbackData.modReference, player, i)
								end
							end
						end
						
					elseif not player:HasCollectible(i) then
						if PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][i] then
							PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][i] = 0
						end
						break
						
					elseif count < PickupHelper.PlayerHadCollectibleCount(player, i) then
						PickupHelper.ModSave.Run.HadCollectibleCount[currentPlayer][i] = count
						break
						
					else
						break
					end
				end
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
		PickupHelper.EvaluateItemsCollected(player)
	end)
	
	-----------------------
	--MISC CALLBACK USAGE--
	-----------------------
	
	PickupHelper.OnRenderCounter = 0
	PickupHelper.IsEvenRender = true
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		PickupHelper.OnRenderCounter = PickupHelper.OnRenderCounter + 1
		
		PickupHelper.IsEvenRender = false
		if Isaac.GetFrameCount()%2 == 0 then
			PickupHelper.IsEvenRender = true
		end
	end)
	
	PickupHelper.RoomChangeCounter = 0
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		PickupHelper.RoomChangeCounter = 0
	end)
	
	PickupHelper.LevelChangeCounter = 0
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		PickupHelper.LevelChangeCounter = 0
	end)
	
	PickupHelper.OnUpdateCounter = 0
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		PickupHelper.OnUpdateCounter = PickupHelper.OnUpdateCounter + 1
		PickupHelper.LevelChangeCounter = PickupHelper.LevelChangeCounter + 1
		PickupHelper.RoomChangeCounter = PickupHelper.RoomChangeCounter + 1
	end)
	
	----------------
	--CUSTOM ENUMS--
	----------------
	PickupHelperEntityType = PickupHelperEntityType or {}
	
	PickupHelperPickupVariant = PickupHelperPickupVariant or {}
	PickupHelperPickupVariant.PICKUP_HEART_ALT = 3310
	PickupHelperPickupVariant.PICKUP_COIN_ALT = 3320
	PickupHelperPickupVariant.PICKUP_KEY_ALT = 3330
	PickupHelperPickupVariant.PICKUP_BOMB_ALT = 3340
	PickupHelperPickupVariant.PICKUP_GRAB_BAG_ALT = 3369
	PickupHelperPickupVariant.PICKUP_BATTERY_ALT = 3390
	
	PickupHelperHeartAltSubType = PickupHelperHeartAltSubType or {}
	PickupHelperCoinAltSubType = PickupHelperCoinAltSubType or {}
	PickupHelperKeyAltSubType = PickupHelperKeyAltSubType or {}
	PickupHelperBombAltSubType = PickupHelperBombAltSubType or {}
	PickupHelperGrabBagAltSubType = PickupHelperGrabBagAltSubType or {}
	PickupHelperBatteryAltSubType = PickupHelperBatteryAltSubType or {}
	
	PickupHelperSlotVariant = PickupHelperSlotVariant or {}
	PickupHelperSlotVariant.SLOT_MACHINE = 1
	PickupHelperSlotVariant.BLOOD_DONATION_MACHINE = 2
	PickupHelperSlotVariant.FORTUNE_TELLING_MACHINE = 3
	PickupHelperSlotVariant.BEGGAR = 4
	PickupHelperSlotVariant.DEVIL_BEGGAR = 5
	PickupHelperSlotVariant.SHELL_GAME = 6
	PickupHelperSlotVariant.KEY_MASTER = 7
	PickupHelperSlotVariant.DONATION_MACHINE = 8
	PickupHelperSlotVariant.BOMB_BUM = 9
	PickupHelperSlotVariant.SHOP_RESTOCK_MACHINE = 10
	PickupHelperSlotVariant.GREED_DONATION_MACHINE = 11
	PickupHelperSlotVariant.MOMS_DRESSING_TABLE = 12
	
	PickupHelperFamiliarVariant = PickupHelperFamiliarVariant or {}
	
	PickupHelperEffectVariant = PickupHelperEffectVariant or {}
	
	PickupHelperChallenge = PickupHelperChallenge or {}
	
	PickupHelperCollectibleType = PickupHelperCollectibleType or {}
	PickupHelperCollectibleType.NUM_COLLECTIBLES_VANILLA = 0
	PickupHelperCollectibleType.NUM_COLLECTIBLES = 0
	PickupHelperCollectibleType.LAST_COLLECTIBLE_VANILLA = 0
	PickupHelperCollectibleType.LAST_COLLECTIBLE = 0
	
	PickupHelperTrinketType = PickupHelperTrinketType or {}
	PickupHelperTrinketType.NUM_TRINKETS_VANILLA = 0
	PickupHelperTrinketType.NUM_TRINKETS = 0
	PickupHelperTrinketType.LAST_TRINKET_VANILLA = 0
	PickupHelperTrinketType.LAST_TRINKET = 0

	PickupHelperCard = PickupHelperCard or {}
	PickupHelperCard.NUM_CARDS_VANILLA = 0
	PickupHelperCard.NUM_CARDS = 0
	PickupHelperCard.LAST_CARD_VANILLA = 0
	PickupHelperCard.LAST_CARD = 0
	
	PickupHelperPillColor = PickupHelperPillColor or {}

	PickupHelperPillEffect = PickupHelperPillEffect or {}
	PickupHelperPillEffect.NUM_PILL_EFFECTS_VANILLA = 0
	PickupHelperPillEffect.NUM_PILL_EFFECTS = 0
	PickupHelperPillEffect.LAST_PILL_EFFECT_VANILLA = 0
	PickupHelperPillEffect.LAST_PILL_EFFECT = 0
	
	PickupHelperPlayerType = PickupHelperPlayerType or {}
	
	PickupHelperCostume = PickupHelperCostume or {}
	
	PickupHelperPlayerForm = PickupHelperPlayerForm or {}
	PickupHelperPlayerForm.PLAYERFORM_STOMPY = 13 --this isn't in the official enums but this is what its id is
	
	PickupHelperSoundEffect = PickupHelperSoundEffect or {}
	
	PickupHelperNPCVariant = PickupHelperNPCVariant or {}
	
	PickupHelperNPCSubType = PickupHelperNPCSubType or {}
	
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_FIRST_GAME_START, function()
		--three of wands
		local threeOfWands = Isaac.GetCardIdByName("threeofwands")
		if threeOfWands > 0 then
			PickupHelperCard.CARD_THREE_OF_WANDS = threeOfWands
		end
		
		--turn to toad
		local turnToToad = Isaac.GetCardIdByName("c01_TurnToToad")
		if turnToToad > 0 then
			PickupHelperCard.CARD_TURN_TO_TOAD = turnToToad
		end
		
		--fake id
		local fakeID = Isaac.GetCardIdByName("Fake ID")
		if fakeID > 0 then
			PickupHelperCard.CARD_FAKE_ID = fakeID
		end
		
		--wet card
		local wetCard = Isaac.GetCardIdByName("Wet Card")
		if wetCard > 0 then
			PickupHelperCard.CARD_WET_CARD = wetCard
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_FIRST_GAME_START, function()
		--get the last item ids
		--there are some empty entries in the config so we have to skip these, basically it stops counting if it encounters a second empty entry after another.
		
		--collectibles
		local itemExists = true
		PickupHelperCollectibleType.LAST_COLLECTIBLE_VANILLA = CollectibleType.COLLECTIBLE_MOMS_SHOVEL
		for i=1, 10000 do
			if not PickupHelper.ItemConfig:GetCollectible(i) then
				if not itemExists then
					break
				end
				itemExists = false
				PickupHelperCollectibleType.LAST_COLLECTIBLE = i-1
			else
				itemExists = true
				PickupHelperCollectibleType.NUM_COLLECTIBLES = PickupHelperCollectibleType.NUM_COLLECTIBLES + 1
				if i <= PickupHelperCollectibleType.LAST_COLLECTIBLE_VANILLA then
					PickupHelperCollectibleType.NUM_COLLECTIBLES_VANILLA = PickupHelperCollectibleType.NUM_COLLECTIBLES_VANILLA + 1
				end
			end
		end
		
		--trinkets
		local trinketExists = true
		PickupHelperTrinketType.LAST_TRINKET_VANILLA = TrinketType.TRINKET_FINGER_BONE
		for i=1, 10000 do
			if not PickupHelper.ItemConfig:GetTrinket(i) then
				if not trinketExists then
					break
				end
				trinketExists = false
				PickupHelperTrinketType.LAST_TRINKET = i-1
			else
				trinketExists = true
				PickupHelperTrinketType.NUM_TRINKETS = PickupHelperTrinketType.NUM_TRINKETS + 1
				if i <= PickupHelperTrinketType.LAST_TRINKET_VANILLA then
					PickupHelperTrinketType.NUM_TRINKETS_VANILLA = PickupHelperTrinketType.NUM_TRINKETS_VANILLA + 1
				end
			end
		end
		
		--cards
		local cardExists = true
		PickupHelperCard.LAST_CARD_VANILLA = Card.CARD_ERA_WALK
		for i=1, 10000 do
			if not PickupHelper.ItemConfig:GetCard(i) then
				if not cardExists then
					break
				end
				cardExists = false
				PickupHelperCard.LAST_CARD = i-1
			else
				cardExists = true
				PickupHelperCard.NUM_CARDS = PickupHelperCard.NUM_CARDS + 1
				if i <= PickupHelperCard.LAST_CARD_VANILLA then
					PickupHelperCard.NUM_CARDS_VANILLA = PickupHelperCard.NUM_CARDS_VANILLA + 1
				end
			end
		end
		
		--pills
		local pillExists = true
		PickupHelperPillEffect.LAST_PILL_EFFECT_VANILLA = PillEffect.PILLEFFECT_VURP
		for i=1, 10000 do
			if not PickupHelper.ItemConfig:GetPillEffect(i) then
				if not pillExists then
					break
				end
				pillExists = false
				PickupHelperPillEffect.LAST_PILL_EFFECT = i-1
			else
				pillExists = true
				PickupHelperPillEffect.NUM_PILL_EFFECTS = PickupHelperPillEffect.NUM_PILL_EFFECTS + 1
				if i <= PickupHelperPillEffect.LAST_PILL_EFFECT_VANILLA then
					PickupHelperPillEffect.NUM_PILL_EFFECTS_VANILLA = PickupHelperPillEffect.NUM_PILL_EFFECTS_VANILLA + 1
				end
			end
		end
	end)
	
	-------
	--RNG--
	-------
	PickupHelperRNGsToReset = PickupHelperRNGsToReset or {}
	function PickupHelper.InitializeRNG(rng, noReset)
		if rng then
			local seed = Random()
			if PickupHelper.GameStarted then
				seed = PickupHelper.Seeds:GetStartSeed()
			end
			rng:SetSeed(seed, 1)
			if not noReset then
				PickupHelperRNGsToReset[#PickupHelperRNGsToReset+1] = rng
			end
			return rng
		end
	end
	function PickupHelper.GetInitializedRNG()
		local rng = RNG()
		return PickupHelper.InitializeRNG(rng)
	end
	PickupHelperRNG = PickupHelperRNG or PickupHelper.GetInitializedRNG()
	
	function PickupHelper.ResetRNGSeed(rng)
		if rng then
			local seed = Random()
			if PickupHelper.GameStarted then
				seed = PickupHelper.Seeds:GetStartSeed()
			end
			rng:SetSeed(seed, 1)
		end
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_STARTED, function(_, isSaveGame)
		for _, rng in ipairs(PickupHelperRNGsToReset) do
			PickupHelper.ResetRNGSeed(rng)
		end
	end)
	
	--may be depreciated
	function PickupHelper.GetRNGNext(rng)
		if not rng then
			rng = PickupHelperRNG
		end
		return rng:Next()
	end
	
	--edited alphaapi/stageapi function
	function PickupHelper.GetRandomNumber(numMin, numMax, rng)
		if not numMax then
			numMax = numMin
			numMin = nil
		end
		
		rng = rng or PickupHelperRNG
		if type(rng) == "number" then
			local seed = rng
			rng = RNG()
			rng:SetSeed(seed, 1)
		end
		
		if numMin and numMax then
			return rng:Next() % (numMax - numMin + 1) + numMin
		elseif numMax then
			return rng:Next() % numMin
		end
		return rng:Next()
	end
	
	--returns random index of a table based on weight, based on some revelations code
	function PickupHelper.WeightedRandom(args, rng)
		local weight_value = 0
		local iterated_weight = 1
		for name, weight in pairs(args) do
			weight_value = weight_value + weight
		end

		if weight_value > 0 then
			local random_chance = PickupHelper.GetRandomNumber(1, weight_value, rng)
			for name, weight in pairs(args) do
				iterated_weight = iterated_weight + weight
				if iterated_weight > random_chance then
					return name
				end
			end
		end
	end
	
	-------
	--LUA--
	-------
	function PickupHelper.CopyTable(tableToCopy)
		local table2 = {}
		for i, value in pairs(tableToCopy) do
			if type(value) == "table" then
				table2[i] = PickupHelper.CopyTable(value)
			else
				table2[i] = value
			end
		end
		return table2
	end
	
	function PickupHelper.FillTable(tableToFill, tableToFillFrom)
		for i, value in pairs(tableToFillFrom) do
			if tableToFill[i] ~= nil then
				if type(value) == "table" then
					tableToFill[i] = PickupHelper.FillTable(tableToFill[i], value)
				else
					tableToFill[i] = value
				end
			else
				if type(value) == "table" then
					tableToFill[i] = PickupHelper.FillTable({}, value)
				else
					tableToFill[i] = value
				end
			end
		end
		return tableToFill
	end
	
	local shuffleTableRNG = PickupHelper.GetInitializedRNG()
	function PickupHelper.ShuffleTable(tableToShuffle, rng)
		if not rng then
			rng = shuffleTableRNG
		end
		
		local tableSize = #tableToShuffle
		for i = tableSize, 2, -1 do
			local randomNum = PickupHelper.GetRandomNumber(1, tableSize, rng)
			tableToShuffle[i], tableToShuffle[randomNum] = tableToShuffle[randomNum], tableToShuffle[i]
		end

		return tableToShuffle
	end
	
	--ripairs stuff from revel
	function ripairs_it(t,i)
		i=i-1
		local v=t[i]
		if v==nil then return v end
		return i,v
	end
	function ripairs(t)
		return ripairs_it, t, #t+1
	end
	
	function PickupHelper.IsInTable(valueToCheck, tableToCheck)
		for i, value in pairs(tableToCheck) do
			if value == valueToCheck then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.RemoveFromTable(valueToRemove, tableToCheck)
		for i, value in pairs(tableToCheck) do
			if value == valueToRemove then
				table.remove(tableToCheck, i)
			end
		end
		return tableToCheck
	end
	
	function PickupHelper.RemoveNilFromTable(tableToCheck) --depreciated
		for i, value in pairs(tableToCheck) do
			if value == nil then
				table.remove(tableToCheck, i)
			end
		end
		return tableToCheck
	end
	
	function PickupHelper.DebugPrint(string)
		Isaac.DebugString(string)
		print(string)
	end
	
	--at the end of your script add "PickupHelper.ForceError()"
	function PickupHelper.Exec(luaScript, errorMatch)
		if not errorMatch then
			errorMatch = "ForceError"
		end
		local _, err = pcall(require, luaScript)
		err = tostring(err)
		if not (string.match(err, "%(method '" .. errorMatch .. "'%)") or string.match(err, "%(field '" .. errorMatch .. "'%)") or string.match(err, "%(global '" .. errorMatch .. "'%)")) then
			if string.match(err, "true") then
				err = "Error: require passed in " .. luaScript
			end
			error(err)
		end
	end
	
	function PickupHelper.NumToBool(value)
		if value >= 1 then
			return true
		end
		return false
	end
	
	function PickupHelper.BoolToNum(value)
		if value then
			return 1
		end
		return 0
	end
	
	----------
	--SAVING--
	----------
	PickupHelper.HudOffset = 0
	PickupHelper.DefaultModSave = {
		Run = {
			PickupLuck = {
				0,
				0,
				0,
				0
			},
			PersistentMantleEffects = {
				0,
				0,
				0,
				0
			},
			HadCollectible = {
				{},
				{},
				{},
				{}
			},
			HadCollectibleCount = {
				{},
				{},
				{},
				{}
			},
			SeenCollectible = {},
			ItemsUsed = {
				{},
				{},
				{},
				{}
			},
			CardsUsed = {
				{},
				{},
				{},
				{}
			},
			PillEffectsUsed = {
				{},
				{},
				{},
				{}
			},
			Transformations = {
				{},
				{},
				{},
				{}
			},
			Level = {
				PersistentMantleEffects = {
					0,
					0,
					0,
					0
				},
				Room = {}
			}
		},
		Unlocks = {
			Hairpin = false
		},
		Config = {
			HudOffset = 0,
			Overlays = true,
			ChargeBars = false,
			BigBooks = true
		},
		BatteriesPickedUp = 0
	}
	PickupHelper.ModSave = PickupHelper.CopyTable(PickupHelper.DefaultModSave)
	PickupHelper.OldSave = PickupHelper.CopyTable(PickupHelper.DefaultModSave)
	
	PickupHelperModsToSaveIn = PickupHelperModsToSaveIn or {}
	function PickupHelper.StoreSaveInMod(modData)
		if modData then
			PickupHelperModsToSaveIn[#PickupHelperModsToSaveIn+1] = modData
		end
	end
	
	local json = require("json")
	
	function PickupHelper.ClearRunSave(bypassGameStart)
		if PickupHelper.GameStarted or bypassGameStart then
			PickupHelper.ModSave.Run = PickupHelper.CopyTable(PickupHelper.DefaultModSave.Run)
		end
	end
	function PickupHelper.ClearLevelSave(bypassGameStart)
		if PickupHelper.GameStarted or bypassGameStart then
			PickupHelper.ModSave.Run.Level = PickupHelper.CopyTable(PickupHelper.DefaultModSave.Run.Level)
		end
	end
	function PickupHelper.ClearRoomSave(bypassGameStart)
		if PickupHelper.GameStarted or bypassGameStart then
			PickupHelper.ModSave.Run.Level.Room = PickupHelper.CopyTable(PickupHelper.DefaultModSave.Run.Level.Room)
		end
	end
	function PickupHelper.ClearUnlocks(bypassGameStart)
		if PickupHelper.GameStarted or bypassGameStart then
			PickupHelper.ModSave.Unlocks = PickupHelper.CopyTable(PickupHelper.DefaultModSave.Unlocks)
		end
	end
	function PickupHelper.ClearConfig(bypassGameStart)
		if PickupHelper.GameStarted or bypassGameStart then
			PickupHelper.ModSave.Unlocks = PickupHelper.CopyTable(PickupHelper.DefaultModSave.Unlocks)
		end
	end
	function PickupHelper.ClearSave(bypassGameStart)
		if PickupHelper.GameStarted or bypassGameStart then
			PickupHelper.ModSave = PickupHelper.CopyTable(PickupHelper.DefaultModSave)
		end
	end
	
	function PickupHelper.Save(bypassGameStart)
		if PickupHelper.GameStarted or bypassGameStart then
			PickupHelper.ModSave.Config.HudOffset = PickupHelper.HudOffset
			
			local saveData = PickupHelper.CopyTable(PickupHelper.DefaultModSave)
			saveData = PickupHelper.FillTable(saveData, PickupHelper.ModSave)
			
			for i, mod in pairs(PickupHelperModsToSaveIn) do
				mod:SaveData(json.encode(saveData))
			end
		end
	end
	
	function PickupHelper.Load(fromSave)
		local saveData = PickupHelper.CopyTable(PickupHelper.DefaultModSave)
		
		for i, mod in pairs(PickupHelperModsToSaveIn) do
			if mod:HasData() then
				local loadData = json.decode(mod:LoadData())
				saveData = PickupHelper.FillTable(saveData, loadData)
			end
		end
		
		PickupHelper.ModSave = PickupHelper.CopyTable(saveData)
		PickupHelper.HudOffset = PickupHelper.ModSave.Config.HudOffset
		PickupHelper.Save(true)
	end
	
	PickupHelper.GameStarted = false
	PickupHelper.GameStartCounter = 0
	PickupHelper.IsSaveGame = false
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_STARTED, function(_, isSaveGame)
		PickupHelper.LevelChangeCounter = 0
		PickupHelper.RoomChangeCounter = 0
		PickupHelper.OnUpdateCounter = 0
		PickupHelper.OnRenderCounter = 0
		
		PickupHelper.OldSave = PickupHelper.CopyTable(PickupHelper.ModSave)
		PickupHelper.Load(isSaveGame)
		if not isSaveGame then
			PickupHelper.ClearRunSave(true)
		end
		
		PickupHelper.GameStarted = true
		PickupHelper.GameStartCounter = PickupHelper.GameStartCounter + 1
		PickupHelper.IsSaveGame = isSaveGame
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_ITEM, function(_, itemID, itemRNG)
		if itemID > 0 then
			local player = PickupHelper.GetPlayerUsingItem()
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
			for i=1, PickupHelperCollectibleType.LAST_COLLECTIBLE do
				if not PickupHelper.ModSave.Run.ItemsUsed[currentPlayer][i] then
					PickupHelper.ModSave.Run.ItemsUsed[currentPlayer][i] = 0
				end
			end
			PickupHelper.ModSave.Run.ItemsUsed[currentPlayer][itemID] = PickupHelper.ModSave.Run.ItemsUsed[currentPlayer][itemID] + 1
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_CARD, function(_, cardID)
		if cardID > 0 then
			local player = PickupHelper.GetPlayerUsingItem()
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
			for i=1, PickupHelperCard.LAST_CARD do
				if not PickupHelper.ModSave.Run.CardsUsed[currentPlayer][i] then
					PickupHelper.ModSave.Run.CardsUsed[currentPlayer][i] = 0
				end
			end
			PickupHelper.ModSave.Run.CardsUsed[currentPlayer][cardID] = PickupHelper.ModSave.Run.CardsUsed[currentPlayer][cardID] + 1
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_PILL, function(_, pillEffect)
		if pillEffect > 0 then
			local player = PickupHelper.GetPlayerUsingItem()
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
			for i=1, PickupHelperPillEffect.LAST_PILL_EFFECT do
				if not PickupHelper.ModSave.Run.PillEffectsUsed[currentPlayer][i] then
					PickupHelper.ModSave.Run.PillEffectsUsed[currentPlayer][i] = 0
				end
			end
			PickupHelper.ModSave.Run.PillEffectsUsed[currentPlayer][pillEffect] = PickupHelper.ModSave.Run.PillEffectsUsed[currentPlayer][pillEffect] + 1
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		PickupHelper.ClearRoomSave()
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		PickupHelper.ClearLevelSave()
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_END, function(_, gameOver)
		PickupHelper.Save()
		PickupHelper.GameStarted = false
		PickupHelper.IsSaveGame = false
		PickupHelper.ClearSave(true)
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_PRE_GAME_EXIT, function(_, shouldSave)
		PickupHelper.Save()
		PickupHelper.GameStarted = false
		PickupHelper.IsSaveGame = false
		PickupHelper.ClearSave(true)
	end)
	
	--hook into mod config menu so we make use of its hud offset setting
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_FIRST_GAME_START, function()
		if ModConfigMenu then
			ModConfigMenu.AddHudOffsetChangeCallback(function(currentNum)
				PickupHelper.HudOffset = currentNum
				PickupHelper.ModSave.Config.HudOffset = currentNum
			end)
			ModConfigMenu.AddOverlayChangeCallback(function(currentBool)
				PickupHelper.ModSave.Config.Overlays = currentBool
			end)
			ModConfigMenu.AddChargeBarChangeCallback(function(currentBool)
				PickupHelper.ModSave.Config.ChargeBars = currentBool
			end)
			ModConfigMenu.AddBigBookChangeCallback(function(currentBool)
				PickupHelper.ModSave.Config.BigBooks = currentBool
			end)
		end
	end)
	
	---------
	--INPUT--
	---------
	
	--based on some revelations menu code, handles some dumb controller input nonsense
	function PickupHelper.SafeKeyboardTriggered(key, controllerIndex)
		return Input.IsButtonTriggered(key, controllerIndex) and not Input.IsButtonTriggered(key % 32, controllerIndex)
	end
	function PickupHelper.SafeKeyboardPressed(key, controllerIndex)
		return Input.IsButtonPressed(key, controllerIndex) and not Input.IsButtonPressed(key % 32, controllerIndex)
	end
	
	-----------
	--CONSOLE--
	-----------
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_EXECUTE_CMD, function(_, command, args)
		local commandFunction = {
			["PickupHelperhelp"] = function(args)
				print("pickup helper commands:")
				print("\"hudoffset\": Changes the pickup helper hud offset")
				print("\"PickupHelpersave\": Manipulates pickup helper's save data")
				print("\"PickupHelperunlock\": Unlocks pickup helper unlocks")
			end,
			["hudoffset"] = function(args)
				if tonumber(args) then
					args = math.floor(tonumber(args))
					if args > 10 then
						args = 10
					end
					if args < 0 then
						args = 0
					end
					PickupHelper.HudOffset = args
					print("Set hud offset to " .. args)
					PickupHelper.Save()
				else
					print("Provide a number as the arg")
				end
			end,
			["PickupHelpersave"] = function(args)
				local argsFunction = {
					["clear"] = function()
						PickupHelper.ClearSave(true)
						print("Cleared entire save")
					end,
					["clearunlocks"] = function()
						PickupHelper.ClearUnlocks(true)
						print("Cleared all unlocks")
					end,
					["clearconfig"] = function()
						PickupHelper.ClearConfig(true)
						print("Cleared config")
					end,
					["clearroom"] = function()
						PickupHelper.ClearRoomSave(true)
						print("Cleared room save")
					end,
					["clearlevel"] = function()
						PickupHelper.ClearLevelSave(true)
						print("Cleared level save")
					end,
					["clearrun"] = function()
						PickupHelper.ClearRunSave(true)
						print("Cleared run save")
					end
				}
				args = tostring(args):lower()
				if argsFunction[args] then
					argsFunction[args]()
				else
					print("PickupHelpersave usage:")
					print("\"clear\": Clears the entire save.")
					print("\"clearunlocks\": Clears all unlocks.")
					print("\"clearconfig\": Clears any settings/configuration.")
					print("\"clearroom\": Clears save data used in this room.")
					print("\"clearlevel\": Clears save data used in this level.")
					print("\"clearrun\": Clears save data used in this run.")
				end
			end,
			["PickupHelperunlock"] = function(args)
				if args == "" then
					print("PickupHelperunlock usage:")
					print("\"clear\": Clear all unlocks.")
					print("\"*\": Unlocks all unlockables.")
					print("\"[any text]*\": Unlocks all unlockables with that prefix.")
					print("\"[any text]\": Unlocks that specific unlockable.")
					return
				end
				
				if args == "clear" then
					PickupHelper.ClearUnlocks(true)
					print("Cleared all unlocks")
					return
				end
				
				local searchText = args
				local findWildcard = string.find(args, "*")
				local unlockAll = false
				if findWildcard then
					if findWildcard <= 1 then
						unlockAll = true
						print("Unlocking all unlocks")
					else
						searchText = string.sub(args, 0, findWildcard-1)
						print("Searching for unlocks starting with \"" .. searchText .. "\"")
					end
				end
				
				local foundUnlockString = "Unlocked"
				local foundUnlock = false
				for unlockName, unlocked in pairs(PickupHelper.ModSave.Unlocks) do
					if type(unlocked) == "boolean" and not unlocked then
						local checkName = string.sub(unlockName, 0, string.len(searchText))
						if unlockAll or string.match(checkName, searchText) then
							PickupHelper.ModSave.Unlocks[unlockName] = true
							foundUnlock = true
							foundUnlockString = foundUnlockString .. " \"" .. unlockName .. "\""
						end
					end
				end
				
				if foundUnlock then
					print(foundUnlockString)
					PickupHelper.Save()
				elseif findWildcard then
					print("Did not find any locked unlock starting with \"" .. searchText .. "\"")
				elseif unlockAll then
					print("Did not find any locked unlocks")
				else
					print("Did not find any locked unlock matching \"" .. searchText .. "\"")
				end
			end
		}
		command = command:lower()
		if commandFunction[command] then
			commandFunction[command](args)
		end
	end)
	
	--------
	--GAME--
	--------
	function PickupHelper.IsHardMode()
		local difficulty = PickupHelper.Game.Difficulty
		if difficulty == Difficulty.DIFFICULTY_HARD or difficulty == Difficulty.DIFFICULTY_GREEDIER then
			return true
		end
		return false
	end
	
	function PickupHelper.ShouldRender(ignoreMusic, ignoreNoHud)
		local currentMusic = PickupHelper.Music:GetCurrentMusicID()
		if (ignoreMusic or (currentMusic ~= Music.MUSIC_JINGLE_BOSS and currentMusic ~= Music.MUSIC_JINGLE_NIGHTMARE)) and (ignoreNoHud or not PickupHelper.Seeds:HasSeedEffect(SeedEffect.SEED_NO_HUD)) then
			return true
		end
		return false
	end
	
	------------------------
	--ENTITY SPAWN TRACKER--
	------------------------
	local entitySpawnData = {}
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_PRE_ENTITY_SPAWN, function(_, type, variant, subType, position, velocity, spawner, seed)
		entitySpawnData[seed] = {
			Type = type,
			Variant = variant,
			SubType = subType,
			Position = position,
			Velocity = velocity,
			SpawnerEntity = spawner,
			InitSeed = seed
		}
	end)
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_ENTITY_INIT, function(_, entity)
		local seed = entity.InitSeed
		local data = PickupHelper.GetData(entity)
		data.SpawnData = entitySpawnData[seed]
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_ENTITY_REMOVE, function(_, entity)
		local data = PickupHelper.GetData(entity)
		data.SpawnData = nil
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		entitySpawnData = {}
	end)
	
	local lastRoomSeed = 0
	local replacedRoomNpcTrackerByLastRoomSeed = {}
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_PRE_ROOM_ENTITY_SPAWN, function(_, type, variant, subType, gridIndex, seed)
		if type < 1000 then
			lastRoomSeed = seed
			replacedRoomNpcTrackerByLastRoomSeed[lastRoomSeed] = {
				Type = type,
				Variant = variant,
				SubType = subType,
				GridIndex = gridIndex,
				InitSeed = seed
			}
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_ENTITY_INIT, function(_, entity)
		if PickupHelper.Room:GetFrameCount() < 2 then
			if lastRoomSeed ~= 0 and replacedRoomNpcTrackerByLastRoomSeed[lastRoomSeed] then --UGHHH THIS SEEMS TO BE THE ONLY THING THAT WORKS
				local data = PickupHelper.GetData(entity)
				data.RoomSpawnData = replacedRoomNpcTrackerByLastRoomSeed[lastRoomSeed]
			end
			lastRoomSeed = 0
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_ENTITY_REMOVE, function(_, entity)
		local data = PickupHelper.GetData(entity)
		data.RoomSpawnData = nil
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		replacedRoomNpcTrackerByLastRoomSeed = {}
	end)
	
	local naturallySpawnedPickupTracker = {}
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_PRE_ENTITY_SPAWN, function(_, type, variant, subType, position, velocity, spawner, seed)
		if type == EntityType.ENTITY_PICKUP and (variant == 0 or subType == 0) then
			naturallySpawnedPickupTracker[seed] = {
				Variant = variant,
				SubType = subType,
				InitSeed = seed
			}
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
		local seed = pickup.InitSeed
		local data = PickupHelper.GetData(pickup)
		data.NaturallySpawnedData = naturallySpawnedPickupTracker[seed]
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_ENTITY_REMOVE, function(_, entity)
		local data = PickupHelper.GetData(entity)
		data.NaturallySpawnedData = nil
	end, EntityType.ENTITY_PICKUP)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		naturallySpawnedPickupTracker = {}
	end)
	
	------------------------
	--Entity/NPC functions--
	------------------------
	function PickupHelper.GetPtrHashEntity(entity)
		if entity then
			if entity.Entity then
				entity = entity.Entity
			end
			for _, matchEntity in pairs(Isaac.FindByType(entity.Type, entity.Variant, entity.SubType, false, false)) do
				if GetPtrHash(entity) == GetPtrHash(matchEntity) then
					return matchEntity
				end
			end
		end
		return nil
	end
	
	function PickupHelper.GetData(entity)
		if entity and entity.GetData then
			local data = entity:GetData()
			if not data.PickupHelper then
				data.PickupHelper = {}
			end
			return data.PickupHelper
		end
		return nil
	end
	
	function PickupHelper.GetSpawnData(entity)
		if entity and entity.GetData then
			local data = PickupHelper.GetData(entity)
			return data.SpawnData
		end
		return nil
	end
	
	function PickupHelper.GetSpawner(entity)
		if entity and entity.GetData then
			local spawnData = PickupHelper.GetSpawnData(entity)
			if spawnData and spawnData.SpawnerEntity then
				local spawner = PickupHelper.GetPtrHashEntity(spawnData.SpawnerEntity)
				return spawner
			end
		end
		return nil
	end
	
	function PickupHelper.ReplaceEntity(entity, type, variant, subType, position, velocity, spawner, dontClearFlags)
		if entity and entity:Exists() then
			local spawnData = PickupHelper.GetSpawnData(entity)
			
			if type == nil then
				type = 10
			end
			
			if variant == nil then
				variant = 0
			end
			
			if subType == nil then
				subType = 0
			end
			
			if position == nil then
				position = entity.Position
				if position.X == 0 and position.Y == 0 and entity.FrameCount <= 0 and spawnData then
					position = spawnData.Position
				end
			end
			
			if velocity == nil then
				velocity = entity.Velocity
				if velocity.X == 0 and velocity.Y == 0 and entity.FrameCount <= 0 and spawnData then
					velocity = spawnData.Velocity
				end
			end
			
			if spawner == nil then
				spawner = entity.SpawnerEntity
			end
			
			local flags = entity:GetEntityFlags()
			
			entity:Remove()
			
			local newEntity = Isaac.Spawn(type, variant, subType, position, velocity, spawner)
			
			if not dontClearFlags then
				newEntity:ClearEntityFlags(~0)
			end
			
			newEntity:AddEntityFlags(flags)
			
			return newEntity
		end
	end
	
	function PickupHelper.WasNpcReplaced(npc)
		if npc and npc:Exists() then
			local data = PickupHelper.GetData(npc)
			local originalNpc = data.SpawnData
			if originalNpc and (originalNpc.Type ~= npc.Type or originalNpc.Variant ~= npc.Variant or originalNpc.SubType ~= npc.SubType) then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.GetReplacedData(npc)
		if npc and npc:Exists() and PickupHelper.WasNpcReplaced(npc) then
			return PickupHelper.GetData(npc).SpawnData
		end
		return nil
	end
	
	function PickupHelper.RevertReplacedNpc(npc)
		if npc and npc:Exists() and PickupHelper.WasNpcReplaced(npc) then
			local data = PickupHelper.GetData(npc)
			local originalNpc = data.SpawnData
			return PickupHelper.ReplaceEntity(npc, originalNpc.Type, originalNpc.Variant, originalNpc.SubType)
		end
	end
	
	function PickupHelper.WasNpcReplacedAtRoomSpawn(npc)
		if npc and npc:Exists() then
			local data = PickupHelper.GetData(npc)
			local originalNpc = data.RoomSpawnData
			if originalNpc and (originalNpc.Type ~= npc.Type or originalNpc.Variant ~= npc.Variant or originalNpc.SubType ~= npc.SubType) then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.GetReplacedAtRoomSpawnData(npc)
		if npc and npc:Exists() and PickupHelper.WasNpcReplacedAtRoomSpawn(npc) then
			return PickupHelper.GetData(npc).RoomSpawnData
		end
		return nil
	end
	
	function PickupHelper.RevertRoomSpawnReplacedNpc(npc)
		if npc and npc:Exists() and PickupHelper.WasNpcReplacedAtRoomSpawn(npc) then
			local data = PickupHelper.GetData(npc)
			local originalNpc = data.RoomSpawnData
			return PickupHelper.ReplaceEntity(npc, originalNpc.Type, originalNpc.Variant, originalNpc.SubType)
		end
	end
	
	--JustTookDamageData
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, amount, flags, source, countdown)
		local data = PickupHelper.GetData(entity)
		data.JustTookDamageData = {
			Frame = Isaac.GetFrameCount(),
			DamageAmount = amount,
			DamageFlags = flags,
			SourceEntity = source,
			DamageCountdown = countdown
		}
	end)
	
	function PickupHelper.GetDamagedData(ent)
		if ent and ent:Exists() then
			local data = PickupHelper.GetData(ent)
			if data.JustTookDamageData then
				return data.JustTookDamageData
			end
		end
		return nil
	end
	
	function PickupHelper.WasEntityDamaged(ent)
		if ent and ent:Exists() then
			local damagedData = PickupHelper.GetDamagedData(ent)
			if damagedData and damagedData.Frame and Isaac.GetFrameCount() <= damagedData.Frame + 2 then
				return true
			end
		end
		return false
	end
	
	--slots
	function PickupHelper.IsMachine(entity)
		if entity.Type == EntityType.ENTITY_SLOT
		and (entity.Variant == PickupHelperSlotVariant.SLOT_MACHINE
		or entity.Variant == PickupHelperSlotVariant.BLOOD_DONATION_MACHINE
		or entity.Variant == PickupHelperSlotVariant.FORTUNE_TELLING_MACHINE
		or entity.Variant == PickupHelperSlotVariant.DONATION_MACHINE
		or entity.Variant == PickupHelperSlotVariant.SHOP_RESTOCK_MACHINE
		or entity.Variant == PickupHelperSlotVariant.GREED_DONATION_MACHINE
		or entity.Variant == PickupHelperSlotVariant.MOMS_DRESSING_TABLE) then
			return true
		end
		return false
	end
	
	function PickupHelper.IsBeggar(entity)
		if entity.Type == EntityType.ENTITY_SLOT
		and (entity.Variant == PickupHelperSlotVariant.BEGGAR
		or entity.Variant == PickupHelperSlotVariant.DEVIL_BEGGAR
		or entity.Variant == PickupHelperSlotVariant.SHELL_GAME
		or entity.Variant == PickupHelperSlotVariant.KEY_MASTER
		or entity.Variant == PickupHelperSlotVariant.BOMB_BUM) then
			return true
		end
		return false
	end
	
	---------------------------
	--CurrentPlayer functions--
	---------------------------
	--gets currentPlayer from a player entity
	function PickupHelper.GetCurrentPlayer(player)
		if not player or (player and not player.GetData) then
			return nil
		end
		local data = PickupHelper.GetData(player)
		if not data.currentPlayer then
			data.currentPlayer = 1
			for i=1, PickupHelper.Game:GetNumPlayers() do
				local otherPlayer = Isaac.GetPlayer(i-1)
				local searchPlayer = i
				if otherPlayer.ControllerIndex == player.ControllerIndex then
					data.currentPlayer = searchPlayer
				end
			end
		end
		return data.currentPlayer
	end
	
	--gets the player entity from currentPlayer
	function PickupHelper.GetCurrentPlayerEntity(currentPlayer)
		local player = Isaac.GetPlayer(0)
		for i=1, PickupHelper.Game:GetNumPlayers() do
			local otherPlayer = Isaac.GetPlayer(i-1)
			local searchPlayer = i
			if searchPlayer == PickupHelper.GetCurrentPlayer(player) then
				player = otherPlayer
			end
		end
		return player
	end
	
	--------------
	--Item Pools--
	--------------
	--returns the item pool of the current room
	local getCurrentItemPoolRNG = PickupHelper.GetInitializedRNG()
	function PickupHelper.GetCurrentItemPool()
		local roomType = PickupHelper.Room:GetType()
		local itemPool = PickupHelper.ItemPool:GetPoolForRoom(roomType, getCurrentItemPoolRNG:Next())
		return itemPool
	end
	
	--returns a random collectible based on the room's item pool
	local getRandomCollectibleRNG = PickupHelper.GetInitializedRNG()
	function PickupHelper.GetRandomCollectible(pool, decrease, seed)
		if pool == nil then
			pool = PickupHelper.GetCurrentItemPool()
		end
		if decrease == nil then
			decrease = true
		end
		if not seed or type(seed) ~= "number" then
			local rng = getRandomCollectibleRNG
			if seed and type(seed) ~= "number" then
				rng = seed
			end
			seed = rng:Next()
		end
		local collectible = PickupHelper.ItemPool:GetCollectible(pool, decrease, seed)
		return collectible
	end
	
	--returns a random trinket
	function PickupHelper.GetRandomTrinket()
		local trinket = PickupHelper.ItemPool:GetTrinket()
		return trinket
	end
	
	--returns a random card
	local getRandomCardRNG = PickupHelper.GetInitializedRNG()
	function PickupHelper.GetRandomCard(allowPlayingCards, allowRunes, onlyRunes, seed)
		if allowPlayingCards == nil then
			allowPlayingCards = true
		end
		if allowRunes == nil then
			allowRunes = true
		end
		if onlyRunes == nil then
			onlyRunes = false
		end
		if not seed or type(seed) ~= "number" then
			local rng = getRandomCardRNG
			if type(seed) ~= "number" then
				rng = seed
			end
			seed = rng:Next()
		end
		local card = PickupHelper.ItemPool:GetCard(seed, allowPlayingCards, allowRunes, onlyRunes)
		return card
	end
	
	--returns a random pill
	local getRandomPillRNG = PickupHelper.GetInitializedRNG(seed)
	function PickupHelper.GetRandomPill()
		if not seed or type(seed) ~= "number" then
			local rng = getRandomPillRNG
			if type(seed) ~= "number" then
				rng = seed
			end
			seed = rng:Next()
		end
		local pill = PickupHelper.ItemPool:GetPill(seed)
		return pill
	end

	------------------
	--Card Functions--
	------------------
	
	--adds cards to a table, if toPool is nil or true then it will be added to the pool table
	function PickupHelper.AddCardToTables(isCardTable, cardPoolTable, cardID, toPool)
		if cardID > 0 then
			if toPool == nil then
				toPool = true
			end
			if PickupHelper.Game:IsGreedMode() and not PickupHelper.ItemConfig:GetCard(cardID).GreedModeAllowed then
				toPool = false
			end
			
			isCardTable[#isCardTable+1] = cardID
			if toPool then
				cardPoolTable[#cardPoolTable+1] = cardID
			end
		end
	end
	
	--returns true if the card id is present in the table
	function PickupHelper.IsCardInTable(isCardTable, cardID)
		if cardID > 0 then
			for i=1, #isCardTable do
				if cardID == isCardTable[i] then
					return true
				end
			end
		end
		return false
	end
	
	--returns a random card id from the table
	function PickupHelper.GetRandomCardFromTable(cardPoolTable, rng)
		rng = rng or getRandomCardRNG
		return cardPoolTable[PickupHelper.GetRandomNumber(1, #cardPoolTable, rng)]
	end
	
	--tarot cards
	PickupHelper.TarotCards = {}
	PickupHelper.TarotCardsPool = {}
	function PickupHelper.AddTarotCard(cardID, toPool)
		PickupHelper.AddCardToTables(PickupHelper.TarotCards, PickupHelper.TarotCardsPool, cardID, toPool)
	end
	function PickupHelper.IsTarotCard(cardID)
		return PickupHelper.IsCardInTable(PickupHelper.TarotCards, cardID)
	end
	function PickupHelper.GetRandomTarotCard(rng)
		return PickupHelper.GetRandomCardFromTable(PickupHelper.TarotCardsPool, rng)
	end
	function PickupHelper.RemoveTarotCardFromPool(cardID)
		PickupHelper.RemoveFromTable(cardID, PickupHelper.TarotCardsPool)
	end
	
	--playing cards
	PickupHelper.PlayingCards = {}
	PickupHelper.PlayingCardsPool = {}
	PickupHelper.PlayingCardsNotSpecial = {}
	PickupHelper.PlayingCardsPoolNotSpecial = {}
	function PickupHelper.AddPlayingCard(cardID, toPool, isSpecial)
		PickupHelper.AddCardToTables(PickupHelper.PlayingCards, PickupHelper.PlayingCardsPool, cardID, toPool)
		if not isSpecial then
			PickupHelper.AddCardToTables(PickupHelper.PlayingCardsNotSpecial, PickupHelper.PlayingCardsPoolNotSpecial, cardID, toPool)
		end
	end
	function PickupHelper.IsPlayingCard(cardID, notSpecial)
		if notSpecial then
			return PickupHelper.IsCardInTable(PickupHelper.PlayingCardsNotSpecial, cardID)
		else
			return PickupHelper.IsCardInTable(PickupHelper.PlayingCards, cardID)
		end
	end
	function PickupHelper.GetRandomPlayingCard(rng, notSpecial)
		if notSpecial then
			return PickupHelper.GetRandomCardFromTable(PickupHelper.PlayingCardsPoolNotSpecial, rng)
		else
			return PickupHelper.GetRandomCardFromTable(PickupHelper.PlayingCardsPool, rng)
		end
	end
	function PickupHelper.RemovePlayingCardFromPool(cardID)
		PickupHelper.RemoveFromTable(cardID, PickupHelper.PlayingCardsPool)
		PickupHelper.RemoveFromTable(cardID, PickupHelper.PlayingCardsPoolNotSpecial)
	end
	
	--magic cards
	PickupHelper.MagicCards = {}
	PickupHelper.MagicCardsPool = {}
	function PickupHelper.AddMagicCard(cardID, toPool)
		PickupHelper.AddCardToTables(PickupHelper.MagicCards, PickupHelper.MagicCardsPool, cardID, toPool)
	end
	function PickupHelper.IsMagicCard(cardID)
		return PickupHelper.IsCardInTable(PickupHelper.MagicCards, cardID)
	end
	function PickupHelper.GetRandomMagicCard(rng)
		return PickupHelper.GetRandomCardFromTable(PickupHelper.MagicCardsPool, rng)
	end
	function PickupHelper.RemoveMagicCardFromPool(cardID)
		PickupHelper.RemoveFromTable(cardID, PickupHelper.MagicCardsPool)
	end
	
	--holy cards
	PickupHelper.HolyCards = {}
	PickupHelper.HolyCardsPool = {}
	function PickupHelper.AddHolyCard(cardID, toPool)
		PickupHelper.AddCardToTables(PickupHelper.HolyCards, PickupHelper.HolyCardsPool, cardID, toPool)
	end
	function PickupHelper.IsHolyCard(cardID)
		return PickupHelper.IsCardInTable(PickupHelper.HolyCards, cardID)
	end
	function PickupHelper.GetRandomHolyCard(rng)
		return PickupHelper.GetRandomCardFromTable(PickupHelper.HolyCardsPool, rng)
	end
	function PickupHelper.RemoveHolyCardFromPool(cardID)
		PickupHelper.RemoveFromTable(cardID, PickupHelper.HolyCardsPool)
	end
	
	--runes
	PickupHelper.Runes = {}
	PickupHelper.RunesPool = {}
	function PickupHelper.AddRune(cardID, toPool)
		PickupHelper.AddCardToTables(PickupHelper.Runes, PickupHelper.RunesPool, cardID, toPool)
	end
	function PickupHelper.IsRune(cardID)
		return PickupHelper.IsCardInTable(PickupHelper.Runes, cardID)
	end
	function PickupHelper.GetRandomRune(rng)
		return PickupHelper.GetRandomCardFromTable(PickupHelper.RunesPool, rng)
	end
	function PickupHelper.RemoveRuneFromPool(cardID)
		PickupHelper.RemoveFromTable(cardID, PickupHelper.RunesPool)
	end
	
	--dice shards
	PickupHelper.DiceShards = {}
	PickupHelper.DiceShardsPool = {}
	function PickupHelper.AddDiceShard(cardID, toPool)
		PickupHelper.AddCardToTables(PickupHelper.DiceShards, PickupHelper.DiceShardsPool, cardID, toPool)
	end
	function PickupHelper.IsDiceShard(cardID)
		return PickupHelper.IsCardInTable(PickupHelper.DiceShards, cardID)
	end
	function PickupHelper.GetRandomDiceShard(rng)
		return PickupHelper.GetRandomCardFromTable(PickupHelper.DiceShardsPool, rng)
	end
	function PickupHelper.RemoveDiceShardFromPool(cardID)
		PickupHelper.RemoveFromTable(cardID, PickupHelper.DiceShardsPool)
	end
	
	--adds default PickupHelper cards to the card lists
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_FIRST_GAME_START, function()
		PickupHelper.TarotCards = {}
		PickupHelper.TarotCardsPool = {}
		PickupHelper.PlayingCards = {}
		PickupHelper.PlayingCardsPool = {}
		PickupHelper.PlayingCardsNotSpecial = {}
		PickupHelper.PlayingCardsPoolNotSpecial = {}
		PickupHelper.MagicCards = {}
		PickupHelper.MagicCardsPool = {}
		PickupHelper.HolyCards = {}
		PickupHelper.HolyCardsPool = {}
		PickupHelper.Runes = {}
		PickupHelper.RunesPool = {}
		PickupHelper.DiceShards = {}
		PickupHelper.DiceShardsPool = {}
		
		--tarot cards
		PickupHelper.AddTarotCard(Card.CARD_FOOL)
		PickupHelper.AddTarotCard(Card.CARD_MAGICIAN)
		PickupHelper.AddTarotCard(Card.CARD_HIGH_PRIESTESS)
		PickupHelper.AddTarotCard(Card.CARD_EMPRESS)
		PickupHelper.AddTarotCard(Card.CARD_EMPEROR)
		PickupHelper.AddTarotCard(Card.CARD_HIEROPHANT)
		PickupHelper.AddTarotCard(Card.CARD_LOVERS)
		PickupHelper.AddTarotCard(Card.CARD_CHARIOT)
		PickupHelper.AddTarotCard(Card.CARD_JUSTICE)
		PickupHelper.AddTarotCard(Card.CARD_HERMIT)
		PickupHelper.AddTarotCard(Card.CARD_WHEEL_OF_FORTUNE)
		PickupHelper.AddTarotCard(Card.CARD_STRENGTH)
		PickupHelper.AddTarotCard(Card.CARD_HANGED_MAN)
		PickupHelper.AddTarotCard(Card.CARD_DEATH)
		PickupHelper.AddTarotCard(Card.CARD_TEMPERANCE)
		PickupHelper.AddTarotCard(Card.CARD_DEVIL)
		PickupHelper.AddTarotCard(Card.CARD_TOWER)
		PickupHelper.AddTarotCard(Card.CARD_STARS)
		PickupHelper.AddTarotCard(Card.CARD_MOON)
		PickupHelper.AddTarotCard(Card.CARD_SUN)
		PickupHelper.AddTarotCard(Card.CARD_JUDGEMENT)
		PickupHelper.AddTarotCard(Card.CARD_WORLD)
		if PickupHelperCard.CARD_THREE_OF_WANDS then
			PickupHelper.AddTarotCard(PickupHelperCard.CARD_THREE_OF_WANDS)
		end
		
		--playing cards
		PickupHelper.AddPlayingCard(Card.CARD_CLUBS_2)
		PickupHelper.AddPlayingCard(Card.CARD_DIAMONDS_2)
		PickupHelper.AddPlayingCard(Card.CARD_SPADES_2)
		PickupHelper.AddPlayingCard(Card.CARD_HEARTS_2)
		PickupHelper.AddPlayingCard(Card.CARD_ACE_OF_CLUBS)
		PickupHelper.AddPlayingCard(Card.CARD_ACE_OF_DIAMONDS)
		PickupHelper.AddPlayingCard(Card.CARD_ACE_OF_SPADES)
		PickupHelper.AddPlayingCard(Card.CARD_ACE_OF_HEARTS)
		PickupHelper.AddPlayingCard(Card.CARD_JOKER, nil, true)
		PickupHelper.AddPlayingCard(Card.CARD_RULES, nil, true)
		PickupHelper.AddPlayingCard(Card.CARD_SUICIDE_KING, nil, true)
		
		--magic cards
		PickupHelper.AddMagicCard(Card.CARD_CHAOS)
		PickupHelper.AddMagicCard(Card.CARD_HUGE_GROWTH)
		PickupHelper.AddMagicCard(Card.CARD_ANCIENT_RECALL)
		PickupHelper.AddMagicCard(Card.CARD_ERA_WALK)
		if PickupHelperCard.CARD_TURN_TO_TOAD then
			PickupHelper.AddMagicCard(PickupHelperCard.CARD_TURN_TO_TOAD)
		end
		
		--holy cards
		PickupHelper.AddHolyCard(Card.CARD_HOLY)
		if PickupHelperCard.CARD_WET_CARD then
			PickupHelper.AddMagicCard(PickupHelperCard.CARD_WET_CARD)
		end
		
		--runes
		PickupHelper.AddRune(Card.RUNE_HAGALAZ)
		PickupHelper.AddRune(Card.RUNE_JERA)
		PickupHelper.AddRune(Card.RUNE_EHWAZ)
		PickupHelper.AddRune(Card.RUNE_DAGAZ)
		PickupHelper.AddRune(Card.RUNE_ANSUZ)
		PickupHelper.AddRune(Card.RUNE_PERTHRO)
		PickupHelper.AddRune(Card.RUNE_BERKANO)
		PickupHelper.AddRune(Card.RUNE_ALGIZ)
		PickupHelper.AddRune(Card.RUNE_BLANK)
		PickupHelper.AddRune(Card.RUNE_BLACK)
		
		--dice shards
		PickupHelper.AddDiceShard(Card.CARD_DICE_SHARD)
	end)
	
	-------------------
	--Stage Functions--
	-------------------
	PickupHelperStage = {
		BASEMENT = 1,
		CELLAR = 2,
		BURNING_BASEMENT = 3,
		CAVES = 4,
		CATACOMBS = 5,
		FLOODED_CAVES = 6,
		DEPTHS = 7,
		NECROPOLIS = 8,
		DANK_DEPTHS = 9,
		WOMB = 10,
		UTERO = 11,
		SCARRED_WOMB = 12,
		BLUE_WOMB = 13,
		SHEOL = 14,
		CATHEDRAL = 15,
		DARK_ROOM = 16,
		CHEST = 17,
		VOID = 18
	}

	function PickupHelper.GetCurrentStage(allowVoid)
		local stage = PickupHelper.Level:GetStage()
		local currentStage = PickupHelperStage.BASEMENT
		if PickupHelper.Game:IsGreedMode() then
			if stage == 1 then
				currentStage = PickupHelperStage.BASEMENT
			elseif stage == 2 then
				currentStage = PickupHelperStage.CAVES
			elseif stage == 3 then
				currentStage = PickupHelperStage.DEPTHS
			elseif stage == 4 then
				currentStage = PickupHelperStage.WOMB
			elseif stage == 5 then
				currentStage = PickupHelperStage.SHEOL
			elseif stage == 6 then
				currentStage = PickupHelperStage.CHEST
			elseif stage == 7 then
				currentStage = PickupHelperStage.CHEST
			end
		elseif stage == 12 and not allowVoid then
			local roomStage = PickupHelper.Room:GetRoomConfigStage()
			
			currentStage = PickupHelperStage.VOID
			if roomStage >= 1 and roomStage <= 17 then
				currentStage = roomStage
			end
		else
			local currentStageType = PickupHelper.Level:GetStageType()
			if stage == 1 or stage == 2 then
				if currentStageType == 0 then
					currentStage = PickupHelperStage.BASEMENT
				elseif currentStageType == 1 then
					currentStage = PickupHelperStage.CELLAR
				elseif currentStageType == 2 then
					currentStage = PickupHelperStage.BURNING_BASEMENT
				end
			elseif stage == 3 or stage == 4 then
				if currentStageType == 0 then
					currentStage = PickupHelperStage.CAVES
				elseif currentStageType == 1 then
					currentStage = PickupHelperStage.CATACOMBS
				elseif currentStageType == 2 then
					currentStage = PickupHelperStage.FLOODED_CAVES
				end
			elseif stage == 5 or stage == 6 then
				if currentStageType == 0 then
					currentStage = PickupHelperStage.DEPTHS
				elseif currentStageType == 1 then
					currentStage = PickupHelperStage.NECROPOLIS
				elseif currentStageType == 2 then
					currentStage = PickupHelperStage.DANK_DEPTHS
				end
			elseif stage == 7 or stage == 8 then
				if currentStageType == 0 then
					currentStage = PickupHelperStage.WOMB
				elseif currentStageType == 1 then
					currentStage = PickupHelperStage.UTERO
				elseif currentStageType == 2 then
					currentStage = PickupHelperStage.SCARRED_WOMB
				end
			elseif stage == 9 then
				currentStage = PickupHelperStage.BLUE_WOMB
			elseif stage == 10 then
				if currentStageType == 0 then
					currentStage = PickupHelperStage.SHEOL
				elseif currentStageType == 1 then
					currentStage = PickupHelperStage.CATHEDRAL
				end
			elseif stage == 11 then
				if currentStageType == 0 then
					currentStage = PickupHelperStage.DARK_ROOM
				elseif currentStageType == 1 then
					currentStage = PickupHelperStage.CHEST
				end
			elseif stage == 12 then
				currentStage = PickupHelperStage.VOID
			end
		end
		
		return currentStage
	end
	
	PickupHelperBackdrop = {
		BASEMENT = 1,
		CELLAR = 2,
		BURNING_BASEMENT = 3,
		CAVES = 4,
		CATACOMBS = 5,
		FLOODED_CAVES = 6,
		DEPTHS = 7,
		NECROPOLIS = 8,
		DANK_DEPTHS = 9,
		WOMB = 10,
		UTERO = 11,
		SCARRED_WOMB = 12,
		BLUE_WOMB = 13,
		SHEOL = 14,
		CATHEDRAL = 15,
		DARK_ROOM = 16,
		CHEST = 17,
		MEGA_SATAN = 18,
		LIBRARY = 19,
		SHOP = 20,
		ISAACS_ROOM = 21,
		BARREN_ROOM = 22,
		SECRET_ROOM = 23,
		DICE_ROOM = 24,
		ARCADE = 25,
		ERROR_ROOM = 26,
		BLUE_SECRET = 27,
		ULTRA_GREED = 28
	}
	
	---------------
	--Force Input--
	---------------
	local forcingActionTriggered = {}
	function PickupHelper.ForceIsActionTriggered(player, buttonAction, value)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		forcingActionTriggered[currentPlayer] = forcingActionTriggered[currentPlayer] or {}
		forcingActionTriggered[currentPlayer][buttonAction] = value
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_INPUT_ACTION, function(_, entity, inputHook, buttonAction)
		if entity and entity:ToPlayer() then
			local player = entity:ToPlayer()
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		
			if inputHook == InputHook.IS_ACTION_TRIGGERED and forcingActionTriggered[currentPlayer] and forcingActionTriggered[currentPlayer][buttonAction] ~= nil then
				local toReturn = forcingActionTriggered[currentPlayer][buttonAction]
				forcingActionTriggered[currentPlayer][buttonAction] = nil
				return toReturn
			end
			
		end
	end)
	
	--------------------
	--Player Functions--
	--------------------
	function PickupHelper.PlayerHasCollectibleOrEffect(player, collectibleID)
		return player:HasCollectible(collectibleID) or player:GetEffects():HasCollectibleEffect(collectibleID)
	end
	function PickupHelper.PlayerGetCollectibleOrEffectNum(player, collectibleID)
		return math.max(player:GetCollectibleNum(collectibleID), player:GetEffects():GetCollectibleEffectNum(collectibleID))
	end
	function PickupHelper.PlayerGetCollectibleAndEffectNum(player, collectibleID)
		return player:GetCollectibleNum(collectibleID) + player:GetEffects():GetCollectibleEffectNum(collectibleID)
	end
	function PickupHelper.PlayerHasTrinketOrEffect(player, trinketID)
		return player:HasTrinket(trinketID) or player:GetEffects():HasTrinketEffect(trinketID)
	end
	function PickupHelper.PlayerGetTrinketNum(player, trinketID)
		local currentTrinketCount = 0
		if player:GetTrinket(0) == trinketID then
			currentTrinketCount = currentTrinketCount + 1
		end
		if player:GetTrinket(1) == trinketID then
			currentTrinketCount = currentTrinketCount + 1
		end
		return currentTrinketCount
	end
	function PickupHelper.PlayerGetTrinketOrEffectNum(player, trinketID)
		return math.max(PickupHelper.PlayerGetTrinketNum(player, trinketID), player:GetEffects():GetTrinketEffectNum(trinketID))
	end
	function PickupHelper.PlayerGetTrinketAndEffectNum(player, trinketID)
		return PickupHelper.PlayerGetTrinketNum(player, trinketID) + player:GetEffects():GetTrinketEffectNum(trinketID)
	end
	function PickupHelper.PlayerHasCard(player, cardID)
		if player:GetCard(0) == cardID then
			return true
		end
		if player:GetCard(1) == cardID then
			return true
		end
	end
	function PickupHelper.PlayerGetCardNum(player, cardID)
		local cardNum = 0
		if player:GetCard(0) == cardID then
			cardNum = cardNum + 1
		end
		if player:GetCard(1) == cardID then
			cardNum = cardNum + 1
		end
		return cardNum
	end
	function PickupHelper.PlayerRemoveCard(player, cardID)
		if player:GetCard(1) == cardID then
			player:SetCard(1,0)
		elseif player:GetCard(0) == cardID then
			player:SetCard(0,player:GetCard(1))
			player:SetCard(1,0)
		end
	end
	
	
	--returns a table of players, can optionally provide a function with args to nail down which players you want
	function PickupHelper.GetPlayers(functionCheck, ...)
		local args = {...}
		local players = {}
		for i=1, PickupHelper.Game:GetNumPlayers() do
			local player = Isaac.GetPlayer(i-1)
			local argsPassed = true
			if type(functionCheck) == "function" then
				for j=1, #args do
					if args[j] == "player" then
						args[j] = player
					elseif args[j] == "currentPlayer" then
						args[j] = i
					end
				end
				if not functionCheck(table.unpack(args)) then
					argsPassed = false
				end
			end
			if argsPassed then
				players[#players+1] = player
			end
		end
		return players
	end
	
	--these functions are more readable shortcuts to the getPlayers function
	function PickupHelper.GetAlivePlayers()
		return PickupHelper.GetPlayers(function(player)
			return not PickupHelper.IsPlayerGhost(player)
		end, "player")
	end
	function PickupHelper.GetPlayersOfType(playerType)
		return PickupHelper.GetPlayers(function(player, playerType)
			return player:GetPlayerType() == playerType
		end, "player", playerType)
	end
	function PickupHelper.GetPlayersWithCollectible(collectibleID, includeEffect)
		if includeEffect == nil then
			includeEffect = true
		end
		if includeEffect then
			return PickupHelper.GetPlayers(function(player, collectibleID)
				return PickupHelper.PlayerHasCollectibleOrEffect(player, collectibleID)
			end, "player", collectibleID)
		else
			return PickupHelper.GetPlayers(function(player, collectibleID)
				return player:HasCollectible(collectibleID)
			end, "player", collectibleID)
		end
	end
	function PickupHelper.GetPlayersWithCollectibleOrEffect(collectibleID, includeEffect)
		return PickupHelper.GetPlayersWithCollectible(collectibleID, true)
	end
	function PickupHelper.GetPlayersWithTrinket(trinketID, includeEffect)
		if includeEffect == nil then
			includeEffect = true
		end
		if includeEffect then
			return PickupHelper.GetPlayers(function(player, trinketID)
				return PickupHelper.PlayerHasTrinketOrEffect(player, trinketID)
			end, "player", trinketID)
		else
			return PickupHelper.GetPlayers(function(player, trinketID)
				return player:HasTrinket(trinketID)
			end, "player", trinketID)
		end
	end
	function PickupHelper.GetPlayersWithTrinketOrEffect(trinketID)
		return PickupHelper.GetPlayersWithTrinket(trinketID, true)
	end
	function PickupHelper.GetPlayersWithTransformation(playerForm)
		return PickupHelper.GetPlayers(function(player, playerForm)
			return PickupHelper.IsPlayerTransformed(player, playerForm)
		end, "player", playerForm)
	end
	function PickupHelper.GetPlayersWithCollectibleEffect(collectibleID)
		return PickupHelper.GetPlayers(function(player, collectibleID)
			return player:GetEffects():HasCollectibleEffect(collectibleID)
		end, "player", collectibleID)
	end
	function PickupHelper.GetPlayersWithTrinketEffect(trinketID)
		return PickupHelper.GetPlayers(function(player, trinketID)
			return player:GetEffects():HasTrinketEffect(trinketID)
		end, "player", trinketID)
	end
	function PickupHelper.GetPlayersWithNullEffect(nullID)
		return PickupHelper.GetPlayers(function(player, nullID)
			return player:GetEffects():HasNullEffect(nullID)
		end, "player", nullID)
	end

	--this function returns true if the player is a ghost (true co-op feature)
	function PickupHelper.IsPlayerGhost(player)
		if InfinityTrueCoopInterface then
			local data = player:GetData()
			if data.TrueCoop then
				if data.TrueCoop.Save.IsGhost then
					return true
				end
			end
		end
		return false
	end
	
	--sets the player's position to this for a single update then puts them back
	function PickupHelper.SetPlayerPositionForSingleUpdate(player, position)
		local data = PickupHelper.GetData(player)
		data.movePlayerBackTo = player.Position
		player.Position = position
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		if data.movePlayerBackTo then
			player.Position = data.movePlayerBackTo
			data.movePlayerBackTo = nil
		end
	end)
	
	--use this to make sure your code doesn't run if the player is going in a trapdoor or something
	function PickupHelper.IsPlayerPlayingGameFreezingAnimation()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local sprite, data = player:GetSprite(), PickupHelper.GetData(player)
			
			if sprite:IsPlaying("Trapdoor") then
				data.floorTransition = true
			end
			
			if sprite:IsPlaying("Appear") then
				return true
			elseif sprite:IsPlaying("Trapdoor") then
				return true
			elseif sprite:IsPlaying("LightTravel") then
				return true
			elseif data.floorTransition then
				return true
			end
		end
		return false
	end
	
	--removes the player's current trinkets, gives the player the one you provided, uses the smelter, then gives the player back the original trinkets.
	function PickupHelper.AddSmeltedTrinket(trinket, player)
		if not player then
			player = Isaac.GetPlayer(0)
		end

		--get the trinkets they're currently holding
		local trinket0 = player:GetTrinket(0)
		local trinket1 = player:GetTrinket(1)

		--remove them
		if trinket0 ~= 0 then
			player:TryRemoveTrinket(trinket0)
		end
		if trinket1 ~= 0 then
			player:TryRemoveTrinket(trinket1)
		end

		--make sure they don't already have it smelted
		if not player:HasTrinket(trinket) then
			player:AddTrinket(trinket) --add the trinket
			player:UseActiveItem(CollectibleType.COLLECTIBLE_SMELTER, false, false, false, false) --smelt it
		end

		--give their trinkets back
		if trinket0 ~= 0 then
			player:AddTrinket(trinket0)
		end
		if trinket1 ~= 0 then
			player:AddTrinket(trinket1)
		end
	end
	
	function PickupHelper.GetPlayerBlackHearts(player)
		local soulHearts = player:GetSoulHearts()
		local blackHearts = 0
		local currentSoulHeart = 0
		for i=0, PickupHelper.GetPlayerExtraHearts(player, true)-1 do
			if not player:IsBoneHeart(i) then
				if player:IsBlackHeart(currentSoulHeart+1) then
					if soulHearts - currentSoulHeart >= 2 then
						blackHearts = blackHearts + 2
					elseif soulHearts - currentSoulHeart == 1 then
						blackHearts = blackHearts + 1
					end
				end
				currentSoulHeart = currentSoulHeart + 2
			end
		end
		return blackHearts
	end
	
	--just lost black heart
	function PickupHelper.DidPlayerJustLoseBlackHeart(player)
		local data = PickupHelper.GetData(player)
		if data.justLostBlackHeart and not PickupHelper.DidPlayerCharacterJustChange(player) then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		if not data.lastBlackHeartAmount then
			data.lastBlackHeartAmount = 0
		end
		if not data.lastNecronomiconUses then
			data.lastNecronomiconUses = 0
		end
		data.justLostBlackHeart = false
		local blackHearts = PickupHelper.GetPlayerBlackHearts(player)
		local necronomiconUses = PickupHelper.DidPlayerUseActiveItemNum(Isaac.GetPlayer(0), CollectibleType.COLLECTIBLE_NECRONOMICON)
		if math.floor((blackHearts + 1) / 2) < math.floor((data.lastBlackHeartAmount + 1) / 2) then
			if data.lastNecronomiconUses < necronomiconUses then
				data.justLostBlackHeart = true
				
				if not PickupHelper.DidPlayerCharacterJustChange(player) then
					--MC_POST_LOSE_BLACK_HEART
					if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_LOSE_BLACK_HEART] then
						for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_LOSE_BLACK_HEART]) do
							callbackData.functionToCall(callbackData.modReference, player)
						end
					end
				end
			end
		end
		data.lastBlackHeartAmount = blackHearts
		data.lastNecronomiconUses = necronomiconUses
	end)
	
	--just lost bone heart
	function PickupHelper.DidPlayerJustLoseBoneHeart(player)
		local data = PickupHelper.GetData(player)
		if data.justLostBoneHeart and not PickupHelper.DidPlayerCharacterJustChange(player) then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		if not data.lastBoneHeartAmount then
			data.lastBoneHeartAmount = 0
		end
		data.justLostBoneHeart = false
		local boneHearts = player:GetBoneHearts()
		if boneHearts < data.lastBoneHeartAmount then
			data.justLostBoneHeart = true
			
			--MC_POST_LOSE_BONE_HEART
			if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_LOSE_BONE_HEART] then
				for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_LOSE_BONE_HEART]) do
					callbackData.functionToCall(callbackData.modReference, player)
				end
			end
		end
		data.lastBoneHeartAmount = boneHearts
	end)
	
	--can pick functions
	function PickupHelper.CanPlayerPickEternalHearts(player)
		if (player:GetEffectiveMaxHearts() + player:GetEternalHearts()) < 25 then
			return true
		end
		return false
	end
	
	function PickupHelper.CanPlayerPickMaxHearts(player)
		if player:GetEffectiveMaxHearts() < player:GetHeartLimit() then
			return true
		end
		return false
	end
	
	function PickupHelper.GetPlayerRoomForMaxHearts(player)
		return player:GetHeartLimit() - player:GetEffectiveMaxHearts()
	end
	
	function PickupHelper.GetPlayerRoomForSoulHearts(player)
		return PickupHelper.GetPlayerRoomForMaxHearts(player) - player:GetSoulHearts()
	end

	function PickupHelper.GetPlayerEmptyHearts(player)
		return player:GetEffectiveMaxHearts() - player:GetHearts()
	end

	function PickupHelper.GetPlayerFullHealth(player, ignoreEternalHearts)
		local eternalHearts = 0
		if not ignoreEternalHearts then
			eternalHearts = player:GetEternalHearts()
		end
		return player:GetHearts() + player:GetSoulHearts() + eternalHearts
	end

	function PickupHelper.GetPlayerExtraHearts(player, ignoreEternalHearts)
		local eternalHearts = 0
		if not ignoreEternalHearts then
			eternalHearts = player:GetEternalHearts()
		end
		return math.ceil(player:GetSoulHearts() / 2) + player:GetBoneHearts() + eternalHearts
	end

	function PickupHelper.IsPlayerLastHeartBone(player)
		local lastHeartIsBone = false
		for i=0, PickupHelper.GetPlayerExtraHearts(player, true)-1 do
			if player:IsBoneHeart(i) then
				lastHeartIsBone = true
			else
				lastHeartIsBone = false
			end
		end
		return lastHeartIsBone
	end

	function PickupHelper.GetPlayerRedHeartsInBoneHearts(player)
		return math.max(0, player:GetHearts() - player:GetMaxHearts())
	end

	--player take full damage
	function PickupHelper.SetPlayerTakeFullDamage(player, bool)
		local data = PickupHelper.GetData(player)
		data.TakeFullDamage = bool
	end

	function PickupHelper.GetPlayerTakeFullDamage(player)
		local data = PickupHelper.GetData(player)
		return (data.TakeFullDamage or PickupHelper.Level:GetStage() > 6)
	end
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, amount, flags, source, countdown)
		local player = entity:ToPlayer()
		local data = PickupHelper.GetData(player)
		if data.TakeFullDamage and flags & DamageFlag.DAMAGE_FAKE == 0 and amount == 1 and not player:HasCollectible(CollectibleType.COLLECTIBLE_WAFER) then
			local data = PickupHelperRebalancePack.GetData(player)
			local hearts = player:GetHearts()
			local soulHearts = player:GetSoulHearts()
			local boneHearts = player:GetBoneHearts()
			local lastHeartIsBone = PickupHelper.IsPlayerLastHeartBone(player)
			if soulHearts >= 2 and not lastHeartIsBone and not (flags & DamageFlag.DAMAGE_RED_HEARTS ~= 0 and hearts > 2) then
				player:AddSoulHearts(-1)
				data.JustTookSoulHeartFullDamage = soulHearts
			elseif (soulHearts <= 0 or lastHeartIsBone or (flags & DamageFlag.DAMAGE_RED_HEARTS ~= 0 and hearts > 2)) and hearts + player:GetEternalHearts() >= 2 and (boneHearts <= 0 or (boneHearts > 0 and hearts == player:GetEffectiveMaxHearts()) or flags & DamageFlag.DAMAGE_RED_HEARTS ~= 0) then
				player:AddHearts(-1)
				data.JustTookRedHeartFullDamage = hearts
			end
		end
	end, EntityType.ENTITY_PLAYER)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		if data.TakeFullDamage then
			if data.JustTookSoulHeartFullDamage and (player:GetSoulHearts() - data.JustTookSoulHeartFullDamage) == 0 then
				player:AddSoulHearts(1)
			elseif data.JustTookRedHeartFullDamage and (player:GetHearts() - data.JustTookRedHeartFullDamage) == 0 then
				player:AddHearts(1)
			end
			data.JustTookSoulHeartFullDamage = nil
			data.JustTookRedHeartFullDamage = nil
		end
	end)
	
	--active items used tracker
	function PickupHelper.DidPlayerUseActiveItem(player, itemID)
		local data = PickupHelper.GetData(player)
		if not data.ItemsUsedInThisRoom then
			data.ItemsUsedInThisRoom = {}
		end
		if data.ItemsUsedInThisRoom[itemID] then
			if data.ItemsUsedInThisRoom[itemID] > 0 then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.DidPlayerUseActiveItemNum(player, itemID)
		local data = PickupHelper.GetData(player)
		if not data.ItemsUsedInThisRoom then
			data.ItemsUsedInThisRoom = {}
		end
		if not data.ItemsUsedInThisRoom[itemID] then
			return 0
		elseif data.ItemsUsedInThisRoom[itemID] > 0 then
			return data.ItemsUsedInThisRoom[itemID]
		end
		return 0
	end
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
		local data = PickupHelper.GetData(player)
		data.ItemsUsedInThisRoom = {}
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_ITEM, function(_, itemID, itemRNG)
		local player = PickupHelper.GetPlayerUsingItem()
		local data = PickupHelper.GetData(player)
		if not data.ItemsUsedInThisRoom then
			data.ItemsUsedInThisRoom = {}
		end
		if not data.ItemsUsedInThisRoom[itemID] then
			data.ItemsUsedInThisRoom[itemID] = 0
		end
		data.ItemsUsedInThisRoom[itemID] = data.ItemsUsedInThisRoom[itemID] + 1
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local data = PickupHelper.GetData(player)
			data.ItemsUsedInThisRoom = {}
		end
	end)
	
	--cards used tracker
	function PickupHelper.DidPlayerUseCard(player, cardID)
		local data = PickupHelper.GetData(player)
		if not data.CardsUsedInThisRoom then
			data.CardsUsedInThisRoom = {}
		end
		if data.CardsUsedInThisRoom[cardID] then
			if data.CardsUsedInThisRoom[cardID] > 0 then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.DidPlayerUseCardNum(player, cardID)
		local data = PickupHelper.GetData(player)
		if not data.CardsUsedInThisRoom then
			data.CardsUsedInThisRoom = {}
		end
		if not data.CardsUsedInThisRoom[cardID] then
			return 0
		elseif data.CardsUsedInThisRoom[cardID] > 0 then
			return data.CardsUsedInThisRoom[cardID]
		end
		return 0
	end
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
		local data = PickupHelper.GetData(player)
		data.CardsUsedInThisRoom = {}
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_CARD, function(_, cardID)
		local player = PickupHelper.GetPlayerUsingItem()
		local data = PickupHelper.GetData(player)
		if not data.CardsUsedInThisRoom then
			data.CardsUsedInThisRoom = {}
		end
		if not data.CardsUsedInThisRoom[cardID] then
			data.CardsUsedInThisRoom[cardID] = 0
		end
		data.CardsUsedInThisRoom[cardID] = data.CardsUsedInThisRoom[cardID] + 1
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local data = PickupHelper.GetData(player)
			data.CardsUsedInThisRoom = {}
		end
	end)
	
	--pill effects used tracker
	function PickupHelper.DidPlayerUsePillEffect(player, pillEffect)
		local data = PickupHelper.GetData(player)
		if not data.PillEffectsUsedInThisRoom then
			data.PillEffectsUsedInThisRoom = {}
		end
		if data.PillEffectsUsedInThisRoom[pillEffect] then
			if data.PillEffectsUsedInThisRoom[pillEffect] > 0 then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.DidPlayerUsePillEffectNum(player, pillEffect)
		local data = PickupHelper.GetData(player)
		if not data.PillEffectsUsedInThisRoom then
			data.PillEffectsUsedInThisRoom = {}
		end
		if not data.PillEffectsUsedInThisRoom[pillEffect] then
			return 0
		elseif data.PillEffectsUsedInThisRoom[pillEffect] > 0 then
			return data.PillEffectsUsedInThisRoom[pillEffect]
		end
		return 0
	end
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
		local data = PickupHelper.GetData(player)
		data.PillEffectsUsedInThisRoom = {}
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_PILL, function(_, pillEffect)
		local player = PickupHelper.GetPlayerUsingItem()
		local data = PickupHelper.GetData(player)
		if not data.PillEffectsUsedInThisRoom then
			data.PillEffectsUsedInThisRoom = {}
		end
		if not data.PillEffectsUsedInThisRoom[pillEffect] then
			data.PillEffectsUsedInThisRoom[pillEffect] = 0
		end
		data.PillEffectsUsedInThisRoom[pillEffect] = data.PillEffectsUsedInThisRoom[pillEffect] + 1
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local data = PickupHelper.GetData(player)
			data.PillEffectsUsedInThisRoom = {}
		end
	end)
	
	--true coop compat
	function PickupHelper.IsPlayerTrueCoopCharacter(player, playerType, playerName) --depreciated
		if player:GetPlayerType() == playerType then
			return true
		elseif player:GetName() == playerName then
			return true
		elseif InfinityTrueCoopInterface then
			local data = player:GetData()
			if data.TrueCoop then
				if data.TrueCoop.Save.PlayerName == playerName then
					return true
				end
			end
		end
		return false
	end
	
	--just lose holy mantle functions
	function PickupHelper.DidPlayerJustLoseMantleEffect(player)
		local data = PickupHelper.GetData(player)
		if data.justLostMantleEffect and not PickupHelper.DidPlayerCharacterJustChange(player) then
			return true
		end
		return false
	end
	
	function PickupHelper.DidPlayerJustLoseWoodenCrossEffect(player)
		local data = PickupHelper.GetData(player)
		if data.justLostWoodenCrossEffect and PickupHelper.DidPlayerJustLoseMantleEffect(player) then
			return true
		end
		return false
	end
	
	function PickupHelper.DidPlayerJustLoseHolyCardEffect(player)
		local data = PickupHelper.GetData(player)
		if data.justLostHolyCardEffect and PickupHelper.DidPlayerJustLoseMantleEffect(player) then
			return true
		end
		return false
	end
	
	function PickupHelper.DidPlayerJustLoseBlanketEffect(player)
		local data = PickupHelper.GetData(player)
		if data.justLostBlanketEffect and PickupHelper.DidPlayerJustLoseMantleEffect(player) then
			return true
		end
		return false
	end
	
	function PickupHelper.DidPlayerJustLosePersistentMantleEffect(player)
		local data = PickupHelper.GetData(player)
		if data.justLostPersistentMantleEffect and PickupHelper.DidPlayerJustLoseMantleEffect(player) then
			return true
		end
		return false
	end
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_INIT, function(_, player)
		local data = PickupHelper.GetData(player)
		data.holyMantleEffectsLost = 0
		data.holyCardEffectsLost = 0
		data.blanketEffectsLost = 0
		data.blanketEffects = 0
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		if not PickupHelper.IsPlayerPlayingGameFreezingAnimation() and PickupHelper.LevelChangeCounter > 0 and PickupHelper.RoomChangeCounter > 0 then
			local data, currentPlayer, effects = PickupHelper.GetData(player), PickupHelper.GetCurrentPlayer(player), player:GetEffects()
			
			--for use with didPlayerJustLoseMantleEffect
			if not data.lastMantleEffectAmount then
				data.lastMantleEffectAmount = 0
			end
			if not data.holyMantleEffectsLost then
				data.holyMantleEffectsLost = 0
			end
			if not data.levelHolyMantleEffectsLost then
				data.levelHolyMantleEffectsLost = 0
			end
			data.justLostMantleEffect = false
			local mantleEffects = effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
			if mantleEffects < data.lastMantleEffectAmount then
				data.justLostMantleEffect = true
				data.holyMantleEffectsLost = data.holyMantleEffectsLost + 1
				data.levelHolyMantleEffectsLost = data.levelHolyMantleEffectsLost + 1
			end
			data.lastMantleEffectAmount = mantleEffects
			
			--wooden cross
			data.justLostWoodenCrossEffect = false
			if data.hasWoodenCrossEffect and data.justLostMantleEffect then
				data.justLostWoodenCrossEffect = true
				data.hasWoodenCrossEffect = false
			end
			
			--holy card
			if not data.holyCardEffectsLost then
				data.holyCardEffectsLost = 0
			end
			if not data.CardsUsedInThisRoom then
				data.CardsUsedInThisRoom = {}
			end
			if not data.CardsUsedInThisRoom[Card.CARD_HOLY] then
				data.CardsUsedInThisRoom[Card.CARD_HOLY] = 0
			end
			data.justLostHolyCardEffect = false
			data.activeHolyCardEffects = data.CardsUsedInThisRoom[Card.CARD_HOLY] - data.holyCardEffectsLost
			if not data.justLostWoodenCrossEffect and data.justLostMantleEffect and data.activeHolyCardEffects > 0 then
				data.justLostHolyCardEffect = true
				data.holyCardEffectsLost = data.holyCardEffectsLost + 1
				data.activeHolyCardEffects = data.activeHolyCardEffects - 1
			end
			
			--blanket
			if not data.blanketEffectsLost then
				data.blanketEffectsLost = 0
			end
			if not data.blanketEffects then
				data.blanketEffects = 0
			end
			data.justLostBlanketEffect = false
			data.activeBlanketEffects = data.blanketEffects - data.blanketEffectsLost
			if not data.justLostWoodenCrossEffect and not data.justLostHolyCardEffect and data.justLostMantleEffect and data.activeBlanketEffects > 0 then
				data.justLostBlanketEffect = true
				data.blanketEffectsLost = data.blanketEffectsLost + 1
				data.activeBlanketEffects = data.activeBlanketEffects - 1
			end
			
			--persistent mantle
			local pMantleEffects = PickupHelper.GetPlayerPersistentMantleEffects(player)
			data.justLostPersistentMantleEffect = false
			if not data.justLostWoodenCrossEffect and not data.justLostHolyCardEffect and not data.justLostBlanketEffect and data.justLostMantleEffect and pMantleEffects > 0 then
				if PickupHelper.ModSave.Run.Level.PersistentMantleEffects[currentPlayer] > 0 then
					PickupHelper.ModSave.Run.Level.PersistentMantleEffects[currentPlayer] = PickupHelper.ModSave.Run.Level.PersistentMantleEffects[currentPlayer] - 1
				elseif PickupHelper.ModSave.Run.PersistentMantleEffects[currentPlayer] > 0 then
					PickupHelper.ModSave.Run.PersistentMantleEffects[currentPlayer] = PickupHelper.ModSave.Run.PersistentMantleEffects[currentPlayer] - 1
				end
				data.justLostPersistentMantleEffect = true
			end
			
			--callback
			if data.justLostMantleEffect then
				--MC_POST_LOSE_HOLY_MANTLE
				if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_LOSE_HOLY_MANTLE] then
					for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_LOSE_HOLY_MANTLE]) do
						callbackData.functionToCall(callbackData.modReference, player, data.justLostPersistentMantleEffect, data.justLostWoodenCrossEffect, data.justLostHolyCardEffect, data.justLostBlanketEffect)
					end
				end
			end
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local data = PickupHelper.GetData(player)
			data.levelHolyMantleEffectsLost = 0
			data.holyMantleEffectsLost = 0
			data.holyCardEffectsLost = 0
			data.blanketEffectsLost = 0
			data.blanketEffects = 0
			data.hasWoodenCrossEffect = false
			if player:HasTrinket(TrinketType.TRINKET_WOODEN_CROSS) then
				data.hasWoodenCrossEffect = false
			end
		end
	end)
	
	--trinket count
	function PickupHelper.GetPlayerTrinketCount(player)
		local currentTrinketCount = 0
		if player:GetTrinket(0) > 0 then
			currentTrinketCount = currentTrinketCount + 1
		end
		if player:GetTrinket(1) > 0 then
			currentTrinketCount = currentTrinketCount + 1
		end
		return currentTrinketCount
	end
	
	--collectible count just change
	function PickupHelper.DidPlayerCollectibleCountJustChange(player)
		local data = PickupHelper.GetData(player)
		if data.didCollectibleCountJustChange then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		local currentCollectibleCount = player:GetCollectibleCount()
		if not data.lastCollectibleCount then
			data.lastCollectibleCount = currentCollectibleCount
		end
		data.didCollectibleCountJustChange = false
		if data.lastCollectibleCount ~= currentCollectibleCount then
			data.didCollectibleCountJustChange = true
		end
		data.lastCollectibleCount = currentCollectibleCount
	end)
	
	--trinket count just change
	function PickupHelper.DidPlayerTrinketCountJustChange(player)
		local data = PickupHelper.GetData(player)
		if data.didTrinketCountJustChange then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		local currentTrinketCount = PickupHelper.GetPlayerTrinketCount(player)
		if not data.lastTrinketCount then
			data.lastTrinketCount = currentTrinketCount
		end
		data.didTrinketCountJustChange = false
		if data.lastTrinketCount ~= currentTrinketCount then
			data.didTrinketCountJustChange = true
		end
		data.lastTrinketCount = currentTrinketCount
	end)
	
	--effect count just change
	function PickupHelper.DidPlayerEffectCountJustChange(player)
		local data = PickupHelper.GetData(player)
		if data.didEffectCountJustChange then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data, effects = PickupHelper.GetData(player), player:GetEffects()
		local currentEffectList = effects:GetEffectsList()
		local currentEffectCount = #currentEffectList
		if not data.lastEffectCount then
			data.lastEffectCount = currentEffectCount
		end
		data.didEffectCountJustChange = false
		if data.lastEffectCount ~= currentEffectCount then
			data.didEffectCountJustChange = true
		end
		data.lastEffectCount = currentEffectCount
	end)
	
	--active item just change
	function PickupHelper.DidPlayerActiveItemJustChange(player)
		local data = PickupHelper.GetData(player)
		if data.didActiveItemJustChange then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		local currentActiveItem = player:GetActiveItem()
		local secondActiveItem = -1
		if player.SecondaryActiveItem then
			local secondActiveItem = player.SecondaryActiveItem["Item"]
		end
		if not data.lastActiveItem then
			data.lastActiveItem = currentActiveItem
		end
		if not data.lastSecondActiveItem then
			data.lastSecondActiveItem = secondActiveItem
		end
		data.didActiveItemJustChange = false
		if data.lastActiveItem ~= currentActiveItem or data.lastSecondActiveItem ~= secondActiveItem then
			data.didActiveItemJustChange = true
		end
		data.lastActiveItem = currentActiveItem
		data.lastSecondActiveItem = secondActiveItem
	end)
	
	--trinket just change
	function PickupHelper.DidPlayerTrinketJustChange(player)
		local data = PickupHelper.GetData(player)
		if data.didTrinketJustChange then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		local currentTrinket = player:GetTrinket(0)
		local secondTrinket = player:GetTrinket(1)
		if not data.lastTrinket then
			data.lastTrinket = currentTrinket
		end
		if not data.lastSecondTrinket then
			data.lastSecondTrinket = secondTrinket
		end
		data.didTrinketJustChange = false
		if data.lastTrinket ~= currentTrinket or data.lastSecondTrinket ~= secondTrinket then
			data.didTrinketJustChange = true
		end
		data.lastTrinket = currentTrinket
		data.lastSecondTrinket = secondTrinket
	end)
	
	--character just change
	function PickupHelper.DidPlayerCharacterJustChange(player)
		local data = PickupHelper.GetData(player)
		if data.playerTypeJustChanged then
			return true
		end
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		local playerType = player:GetPlayerType()
		if not data.lastPlayerType then
			data.lastPlayerType = playerType
		end
		data.playerTypeJustChanged = false
		if data.lastPlayerType ~= playerType then
			data.playerTypeJustChanged = true
		end
		data.lastPlayerType = playerType
	end)
	
	--visible hearts
	function PickupHelper.GetPlayerVisibleHearts(player)
		local maxHearts = math.max(player:GetEffectiveMaxHearts(),player:GetBoneHearts()*2)
		local visibleHearts = math.ceil((maxHearts+player:GetSoulHearts())/2)
		if visibleHearts < 1 then
			visibleHearts = 1
		end
		return visibleHearts
	end
	
	--holy mantle stuff
	function PickupHelper.PlayerHasWoodenCrossEffect(player)
		local data = PickupHelper.GetData(player)
		if data.hasWoodenCrossEffect then
			return true
		end
		return false
	end
	
	function PickupHelper.GetPlayerHolyCardEffects(player)
		local data = PickupHelper.GetData(player)
		return data.activeHolyCardEffects
	end
	
	function PickupHelper.GetPlayerBlanketEffects(player)
		return data.activeBlanketEffects
	end
	
	function PickupHelper.GetPlayerPersistentMantleEffects(player, ignoreJustThisFloor, ignoreEntireRun)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		local pMantleEffects = 0
		if not ignoreJustThisFloor then
			pMantleEffects = pMantleEffects + PickupHelper.ModSave.Run.Level.PersistentMantleEffects[currentPlayer]
		end
		if not ignoreEntireRun then
			pMantleEffects = pMantleEffects + PickupHelper.ModSave.Run.PersistentMantleEffects[currentPlayer]
		end
		return pMantleEffects
	end
	
	function PickupHelper.AddPlayerPersistentMantleEffects(player, amount, limit, justThisFloor, dontAddEffects)
		if not amount then
			amount = 1
		end
		if not limit then
			limit = -1
		end
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		local pMantleEffects = PickupHelper.GetPlayerPersistentMantleEffects(player)
		local pMantleEffectsToAdd = 0
		local pMantleEffectsCanAdd = limit - pMantleEffects
		if limit < 0 or pMantleEffectsCanAdd >= amount then
			pMantleEffectsToAdd = amount
		elseif pMantleEffectsCanAdd > 0 then
			pMantleEffectsToAdd = pMantleEffectsCanAdd
		end
		if pMantleEffectsToAdd > 0 then
			if justThisFloor then
				PickupHelper.ModSave.Run.Level.PersistentMantleEffects[currentPlayer] = PickupHelper.ModSave.Run.Level.PersistentMantleEffects[currentPlayer] + pMantleEffectsToAdd
			else
				PickupHelper.ModSave.Run.PersistentMantleEffects[currentPlayer] = PickupHelper.ModSave.Run.PersistentMantleEffects[currentPlayer] + pMantleEffectsToAdd
			end
			if not dontAddEffects then
				local effects = player:GetEffects()
				for i=1, pMantleEffectsToAdd do
					effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, true)
				end
			end
		end
		return pMantleEffectsToAdd
	end
	
	--returns true if the player had the collectible at some point in the run
	function PickupHelper.PlayerHadCollectible(player, collectible)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		
		if PickupHelper.ModSave.Run.HadCollectible[currentPlayer][collectible] then
			return true
		end
		
		PickupHelper.ModSave.Run.HadCollectible[currentPlayer][collectible] = false
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		for i=1, PickupHelperCollectibleType.LAST_COLLECTIBLE do
		
			if PickupHelper.ModSave.Run.HadCollectible[currentPlayer][i] == nil then
				PickupHelper.ModSave.Run.HadCollectible[currentPlayer][i] = false
			end
			
			if player:HasCollectible(i) and not PickupHelper.ModSave.Run.HadCollectible[currentPlayer][i] then
				PickupHelper.ModSave.Run.HadCollectible[currentPlayer][i] = true
			end
			
		end
	end)
	
	--returns true if the collectible appeared at some point in the run
	function PickupHelper.HasSeenCollectible(collectible)
		if PickupHelper.ModSave.Run.SeenCollectible[collectible] then
			return true
		end
		
		PickupHelper.ModSave.Run.SeenCollectible[collectible] = false
		return false
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		for i=1, PickupHelperCollectibleType.LAST_COLLECTIBLE do
			if PickupHelper.ModSave.Run.SeenCollectible[i] == nil then
				PickupHelper.ModSave.Run.SeenCollectible[i] = false
			end
			
			if PickupHelper.PlayerHadCollectible(player, i) and not PickupHelper.HasSeenCollectible(i) then
				PickupHelper.ModSave.Run.SeenCollectible[i] = true
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, pickup)
		if pickup.SubType > 0 and not PickupHelper.HasSeenCollectible(pickup.SubType) then
			PickupHelper.ModSave.Run.SeenCollectible[pickup.SubType] = true
		end
	end, PickupVariant.PICKUP_COLLECTIBLE)
	
	--transformation stuff
	PickupHelperPlayerFormData = PickupHelperPlayerFormData or {}
	function PickupHelper.RegisterTransformation(data)
		if data.ID then
			PickupHelperPlayerFormData[data.ID] = data
			return data
		end
		-- {
			--ID = integer
			-- The number you want to assign to your transformation
			
			--Name = string
			-- The name of your transformation (leave nil if you dont want a streak)
			
			--Items = table
			-- Items you want to contribute to the transformation
			-- {
				--integer
				-- Item ID to check
				
				--function(player)
				-- If you put a function in the table, you can return true to make it count as an item that the player has
			-- }
			
			--ItemsNeeded = integer
			-- The number of items needed to transform
			
			--IsTransformedFunction = function(player)
			-- A custom function you can insert to use instead of PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm]
			
			--TriggerTransformationFunction = function(player)
			-- This function is called when the transformation should be applied to the player
		-- }
	end
	function PickupHelper.AddTransformationItems(id, itemTable) --use this function to add items to an existing transformation, can be a single item or a table containing items. same function trickery can still be used.
		if type(itemTable) ~= "table" then
			itemTable = {itemTable}
		end
		
		local oldItems = PickupHelper.CopyTable(PickupHelperPlayerFormData[id].Items)
		PickupHelperPlayerFormData[id].Items = {}
		for _, value in pairs(oldItems) do
			PickupHelperPlayerFormData[id].Items[#PickupHelperPlayerFormData[id].Items+1] = value
		end
		for _, value in pairs(itemTable) do
			PickupHelperPlayerFormData[id].Items[#PickupHelperPlayerFormData[id].Items+1] = value
		end
	end
	local function transformationWorkaroundFunction(player, playerForm)
		local activeItem = player:GetActiveItem()
		local activeCharge = player:GetActiveCharge()
		local batteryCharge = player:GetBatteryCharge()
		local secondItem = player.SecondaryActiveItem
		local wasActiveAdded = false
		
		if PickupHelperPlayerFormData[playerForm] then
			for _, value in pairs(PickupHelperPlayerFormData[playerForm].Items) do
				if type(value) == "number" and not PickupHelper.PlayerHadCollectible(player, value) then
					player:AddCollectible(value, 0, false)
					player:RemoveCollectible(value)
					if PickupHelper.ItemConfig:GetCollectible(value).Type == ItemType.ITEM_ACTIVE then
						wasActiveAdded = true
					end
				end
				if PickupHelper.IsPlayerTransformed(player, playerForm) then
					break
				end
			end
		end
		
		if wasActiveAdded then
			player:RemoveCollectible(player:GetActiveItem())
			player:RemoveCollectible(player:GetActiveItem())
			player:AddCollectible(activeItem, 9999, true)
			player:SetActiveCharge(activeCharge + batteryCharge)
			player.SecondaryActiveItem = secondItem
			PickupHelper.SFX:Stop(SoundEffect.SOUND_BEEP)
			PickupHelper.SFX:Stop(SoundEffect.SOUND_BATTERYCHARGE)
		end
	end
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_GUPPY,
		Items = {
			CollectibleType.COLLECTIBLE_DEAD_CAT,
			CollectibleType.COLLECTIBLE_GUPPYS_PAW,
			CollectibleType.COLLECTIBLE_GUPPYS_TAIL,
			CollectibleType.COLLECTIBLE_GUPPYS_HEAD,
			CollectibleType.COLLECTIBLE_GUPPYS_HAIRBALL,
			CollectibleType.COLLECTIBLE_GUPPYS_COLLAR
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_GUPPY)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_GUPPY)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_LORD_OF_THE_FLIES,
		Items = {
			CollectibleType.COLLECTIBLE_SKATOLE,
			CollectibleType.COLLECTIBLE_HALO_OF_FLIES,
			CollectibleType.COLLECTIBLE_DISTANT_ADMIRATION,
			CollectibleType.COLLECTIBLE_FOREVER_ALONE,
			CollectibleType.COLLECTIBLE_INFESTATION,
			CollectibleType.COLLECTIBLE_MULLIGAN,
			CollectibleType.COLLECTIBLE_HIVE_MIND,
			CollectibleType.COLLECTIBLE_SMART_FLY,
			CollectibleType.COLLECTIBLE_BBF,
			CollectibleType.COLLECTIBLE_BEST_BUD,
			CollectibleType.COLLECTIBLE_BIG_FAN,
			CollectibleType.COLLECTIBLE_BLUEBABYS_ONLY_FRIEND,
			CollectibleType.COLLECTIBLE_FRIEND_ZONE,
			CollectibleType.COLLECTIBLE_LOST_FLY,
			CollectibleType.COLLECTIBLE_OBSESSED_FAN,
			CollectibleType.COLLECTIBLE_PAPA_FLY,
			CollectibleType.COLLECTIBLE_JAR_OF_FLIES,
			CollectibleType.COLLECTIBLE_ANGRY_FLY
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_LORD_OF_THE_FLIES)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_LORD_OF_THE_FLIES)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_MUSHROOM,
		Items = {
			CollectibleType.COLLECTIBLE_ONE_UP,
			CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM,
			CollectibleType.COLLECTIBLE_MINI_MUSH,
			CollectibleType.COLLECTIBLE_ODD_MUSHROOM_RATE,
			CollectibleType.COLLECTIBLE_ODD_MUSHROOM_DAMAGE,
			CollectibleType.COLLECTIBLE_BLUE_CAP,
			CollectibleType.COLLECTIBLE_GODS_FLESH
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_MUSHROOM)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_MUSHROOM)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_ANGEL,
		Items = {
			CollectibleType.COLLECTIBLE_BIBLE,
			CollectibleType.COLLECTIBLE_ROSARY,
			CollectibleType.COLLECTIBLE_HALO,
			CollectibleType.COLLECTIBLE_GUARDIAN_ANGEL,
			CollectibleType.COLLECTIBLE_MITRE,
			CollectibleType.COLLECTIBLE_HOLY_GRAIL,
			CollectibleType.COLLECTIBLE_DEAD_DOVE,
			CollectibleType.COLLECTIBLE_HOLY_MANTLE,
			CollectibleType.COLLECTIBLE_SWORN_PROTECTOR
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_ANGEL)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_ANGEL)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_BOB,
		Items = {
			CollectibleType.COLLECTIBLE_BOBS_ROTTEN_HEAD,
			CollectibleType.COLLECTIBLE_BOBS_CURSE,
			CollectibleType.COLLECTIBLE_IPECAC,
			CollectibleType.COLLECTIBLE_BOBS_BRAIN
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_BOB)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_BOB)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_DRUGS,
		Items = {
			CollectibleType.COLLECTIBLE_VIRUS,
			CollectibleType.COLLECTIBLE_ROID_RAGE,
			CollectibleType.COLLECTIBLE_GROWTH_HORMONES,
			CollectibleType.COLLECTIBLE_SPEED_BALL,
			CollectibleType.COLLECTIBLE_EXPERIMENTAL_TREATMENT,
			CollectibleType.COLLECTIBLE_SYNTHOIL,
			CollectibleType.COLLECTIBLE_ADDERLINE,
			CollectibleType.COLLECTIBLE_EUTHANASIA
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_DRUGS)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_DRUGS)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_MOM,
		Items = {
			CollectibleType.COLLECTIBLE_MOMS_UNDERWEAR,
			CollectibleType.COLLECTIBLE_MOMS_HEELS,
			CollectibleType.COLLECTIBLE_MOMS_LIPSTICK,
			CollectibleType.COLLECTIBLE_MOMS_BRA,
			CollectibleType.COLLECTIBLE_MOMS_PAD,
			CollectibleType.COLLECTIBLE_MOMS_EYE,
			CollectibleType.COLLECTIBLE_MOMS_BOTTLE_PILLS,
			CollectibleType.COLLECTIBLE_MOMS_CONTACTS,
			CollectibleType.COLLECTIBLE_MOMS_KNIFE,
			CollectibleType.COLLECTIBLE_MOMS_PURSE,
			CollectibleType.COLLECTIBLE_MOMS_COIN_PURSE,
			CollectibleType.COLLECTIBLE_MOMS_KEY,
			CollectibleType.COLLECTIBLE_MOMS_EYESHADOW,
			CollectibleType.COLLECTIBLE_MOMS_WIG,
			CollectibleType.COLLECTIBLE_MOMS_PERFUME,
			CollectibleType.COLLECTIBLE_MOMS_PEARLS,
			CollectibleType.COLLECTIBLE_MOMS_RAZOR,
			CollectibleType.COLLECTIBLE_MOMS_SHOVEL
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_MOM)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_MOM)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_BABY,
		Items = {
			CollectibleType.COLLECTIBLE_BROTHER_BOBBY,
			CollectibleType.COLLECTIBLE_SISTER_MAGGY,
			CollectibleType.COLLECTIBLE_LITTLE_STEVEN,
			CollectibleType.COLLECTIBLE_HARLEQUIN_BABY,
			CollectibleType.COLLECTIBLE_ROTTEN_BABY,
			CollectibleType.COLLECTIBLE_HEADLESS_BABY,
			CollectibleType.COLLECTIBLE_MONGO_BABY
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_BABY)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_BABY)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_EVIL_ANGEL,
		Items = {
			CollectibleType.COLLECTIBLE_PENTAGRAM,
			CollectibleType.COLLECTIBLE_MARK,
			CollectibleType.COLLECTIBLE_PACT,
			CollectibleType.COLLECTIBLE_THE_NAIL,
			CollectibleType.COLLECTIBLE_BRIMSTONE,
			CollectibleType.COLLECTIBLE_SPIRIT_NIGHT,
			CollectibleType.COLLECTIBLE_ABADDON,
			CollectibleType.COLLECTIBLE_MAW_OF_VOID
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_EVIL_ANGEL)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_EVIL_ANGEL)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_POOP,
		Items = {
			CollectibleType.COLLECTIBLE_POOP,
			CollectibleType.COLLECTIBLE_FLUSH,
			CollectibleType.COLLECTIBLE_E_COLI
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_POOP)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_POOP)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_BOOK_WORM,
		Items = {
			CollectibleType.COLLECTIBLE_BIBLE,
			CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL,
			CollectibleType.COLLECTIBLE_NECRONOMICON,
			CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS,
			CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK,
			CollectibleType.COLLECTIBLE_BOOK_REVELATIONS,
			CollectibleType.COLLECTIBLE_BOOK_OF_SIN,
			CollectibleType.COLLECTIBLE_MONSTER_MANUAL,
			CollectibleType.COLLECTIBLE_TELEPATHY_BOOK,
			CollectibleType.COLLECTIBLE_HOW_TO_JUMP,
			CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS,
			CollectibleType.COLLECTIBLE_SATANIC_BIBLE,
			CollectibleType.COLLECTIBLE_BOOK_OF_THE_DEAD
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_BOOK_WORM)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_BOOK_WORM)
		end
	})
	local function pillTransformationFunction(player, pillEffect, amount)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		if PickupHelper.ModSave.Run.PillEffectsUsed[currentPlayer][pillEffect] and PickupHelper.ModSave.Run.PillEffectsUsed[currentPlayer][pillEffect] >= amount then
			return true
		end
		return false
	end
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_ADULTHOOD,
		Items = {
			function(player)
				pillTransformationFunction(player, PillEffect.PILLEFFECT_PUBERTY, 1)
			end,
			function(player)
				pillTransformationFunction(player, PillEffect.PILLEFFECT_PUBERTY, 2)
			end,
			function(player)
				pillTransformationFunction(player, PillEffect.PILLEFFECT_PUBERTY, 3)
			end
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_ADULTHOOD)
		end,
		TriggerTransformationFunction = function(player)
			player:UsePill(PillEffect.PILLEFFECT_PUBERTY, PillColor.PILL_NULL)
			player:UsePill(PillEffect.PILLEFFECT_PUBERTY, PillColor.PILL_NULL)
			player:UsePill(PillEffect.PILLEFFECT_PUBERTY, PillColor.PILL_NULL)
		end
	})
	PickupHelper.RegisterTransformation({
		ID = PlayerForm.PLAYERFORM_SPIDERBABY,
		Items = {
			CollectibleType.COLLECTIBLE_SPIDER_BITE,
			CollectibleType.COLLECTIBLE_MUTANT_SPIDER,
			CollectibleType.COLLECTIBLE_SPIDER_BUTT,
			CollectibleType.COLLECTIBLE_SPIDERBABY,
			CollectibleType.COLLECTIBLE_BOX_OF_SPIDERS
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PlayerForm.PLAYERFORM_SPIDERBABY)
		end,
		TriggerTransformationFunction = function(player)
			transformationWorkaroundFunction(player, PlayerForm.PLAYERFORM_SPIDERBABY)
		end
	})
	local function numCollectiblesTransformationFunction(player, collectible, amount)
		if player:GetCollectibleNum(collectible) >= amount then
			return true
		end
		return false
	end
	PickupHelper.RegisterTransformation({
		ID = PickupHelperPlayerForm.PLAYERFORM_STOMPY,
		Items = {
			function(player)
				numCollectiblesTransformationFunction(player, CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, 1)
			end,
			function(player)
				numCollectiblesTransformationFunction(player, CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, 2)
			end,
			function(player)
				numCollectiblesTransformationFunction(player, CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, 3)
			end,
			function(player)
				numCollectiblesTransformationFunction(player, CollectibleType.COLLECTIBLE_LEO, 1)
			end,
			function(player)
				numCollectiblesTransformationFunction(player, CollectibleType.COLLECTIBLE_LEO, 2)
			end,
			function(player)
				numCollectiblesTransformationFunction(player, CollectibleType.COLLECTIBLE_LEO, 3)
			end,
			function(player)
				pillTransformationFunction(player, PillEffect.PILLEFFECT_LARGER, 1)
			end,
			function(player)
				pillTransformationFunction(player, PillEffect.PILLEFFECT_LARGER, 2)
			end,
			function(player)
				pillTransformationFunction(player, PillEffect.PILLEFFECT_LARGER, 3)
			end
		},
		ItemsNeeded = 3,
		IsTransformedFunction = function(player)
			return player:HasPlayerForm(PickupHelperPlayerForm.PLAYERFORM_STOMPY)
		end,
		TriggerTransformationFunction = function(player)
			player:AddCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, 0, false)
			player:AddCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, 0, false)
			player:AddCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM, 0, false)
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
		end
	})
	function PickupHelper.CanPlayerTransform(player, playerForm)
		if PickupHelperPlayerFormData[playerForm] then
			local itemsHave = 0
			for _, value in ipairs(PickupHelperPlayerFormData[playerForm].Items) do
				if type(value) == "number" and PickupHelper.PlayerHadCollectible(player, value) then
					itemsHave = itemsHave + 1
				elseif type(value) == "function" and value(player) then
					itemsHave = itemsHave + 1
				end
			end
			if itemsHave >= PickupHelperPlayerFormData[playerForm].ItemsNeeded then
				return true
			end
		end
		return false
	end
	function PickupHelper.IsPlayerTransformed(player, playerForm)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		
		if PickupHelperPlayerFormData[playerForm] and PickupHelperPlayerFormData[playerForm].IsTransformedFunction and PickupHelperPlayerFormData[playerForm].IsTransformedFunction(player) then
			return true
		end
		
		if PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm] then
			return true
		end
		
		PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm] = false
		return false
	end
	function PickupHelper.DoPlayerTransformation(player, playerForm)
		local currentPlayer = PickupHelper.GetCurrentPlayer(player)
		if PickupHelperPlayerFormData[playerForm] then
			PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm] = true
			if PickupHelperPlayerFormData[playerForm].Name then
				PickupHelper.Streak(PickupHelperPlayerFormData[playerForm].Name .. "!")
				PickupHelper.SFX:Play(SoundEffect.SOUND_POWERUP_SPEWER, 1, 0, false, 1)
			end
			if PickupHelperPlayerFormData[playerForm].TriggerTransformationFunction then
				PickupHelperPlayerFormData[playerForm].TriggerTransformationFunction(player)
			end
		end
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		if PickupHelper.OnUpdateCounter > 10 then
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
			for _, transformationData in pairs(PickupHelperPlayerFormData) do
				local playerForm = transformationData.ID
				
				if PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm] == nil then
					PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm] = false
				end
				
				if PickupHelper.IsPlayerTransformed(player, playerForm) and not PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm] then
					PickupHelper.ModSave.Run.Transformations[currentPlayer][playerForm] = true
				end
				
				if PickupHelper.CanPlayerTransform(player, playerForm) and not PickupHelper.IsPlayerTransformed(player, playerForm) then
					PickupHelper.DoPlayerTransformation(player, playerForm)
				end
			end
		end
	end)
	
	------------------------------
	--Someone/Everyone Functions--
	------------------------------
	function PickupHelper.SomeoneHasCollectible(collectibleID, includeEffect)
		return PickupHelper.NumToBool(#PickupHelper.GetPlayersWithCollectible(collectibleID, includeEffect))
	end
	function PickupHelper.SomeoneHasCollectibleEffect(collectibleID)
		return PickupHelper.NumToBool(#PickupHelper.GetPlayersWithCollectibleEffect(collectibleID))
	end
	function PickupHelper.SomeoneHasCollectibleOrEffect(collectibleID)
		return PickupHelper.SomeoneHasCollectible(collectibleID, true)
	end
	
	function PickupHelper.EveryoneHasCollectibleNum(collectibleID)
		local collectibleCount = 0
		for _, player in pairs(PickupHelper.GetPlayersWithCollectible(collectibleID, false)) do
			collectibleCount = collectibleCount + player:GetCollectibleNum(collectibleID)
		end
		return collectibleCount
	end
	function PickupHelper.EveryoneHasCollectibleEffectNum(collectibleID)
		local collectibleEffectCount = 0
		for _, player in pairs(PickupHelper.GetPlayersWithCollectibleEffect(collectibleID)) do
			collectibleEffectCount = collectibleEffectCount + player:GetEffects():GetCollectibleEffectNum(collectibleID)
		end
		return collectibleEffectCount
	end
	function PickupHelper.EveryoneHasCollectibleOrEffectNum(collectibleID)
		return math.max(PickupHelper.EveryoneHasCollectibleNum(collectibleID), PickupHelper.EveryoneHasCollectibleEffectNum(collectibleID))
	end
	function PickupHelper.EveryoneHasCollectibleAndEffectNum(collectibleID)
		return PickupHelper.EveryoneHasCollectibleNum(collectibleID) + PickupHelper.EveryoneHasCollectibleEffectNum(collectibleID)
	end
	
	function PickupHelper.SomeoneHasTrinket(trinketID, includeEffect)
		return PickupHelper.NumToBool(#PickupHelper.GetPlayersWithTrinket(trinketID, includeEffect))
	end
	function PickupHelper.SomeoneHasTrinketEffect(trinketID)
		return PickupHelper.NumToBool(#PickupHelper.GetPlayersWithTrinketEffect(trinketID))
	end
	function PickupHelper.SomeoneHasTrinketOrEffect(trinketID)
		return PickupHelper.SomeoneHasTrinket(trinketID, true)
	end
	
	function PickupHelper.EveryoneHasTrinketNum(trinketID)
		local trinketCount = 0
		for _, player in pairs(PickupHelper.GetPlayersWithTrinket(trinketID, false)) do
			trinketCount = trinketCount + PickupHelper.PlayerGetTrinketNum(player, trinketID)
		end
		return trinketCount
	end
	function PickupHelper.EveryoneHasTrinketEffectNum(trinketID)
		local trinketEffectCount = 0
		for _, player in pairs(PickupHelper.GetPlayersWithTrinketEffect(trinketID)) do
			trinketEffectCount = trinketEffectCount + player:GetEffects():GetTrinketEffectNum(trinketID)
		end
		return trinketEffectCount
	end
	function PickupHelper.EveryoneHasTrinketOrEffectNum(trinketID)
		return math.max(PickupHelper.EveryoneHasTrinketNum(trinketID), PickupHelper.EveryoneHasTrinketEffectNum(trinketID))
	end
	function PickupHelper.EveryoneHasTrinketAndEffectNum(trinketID)
		return PickupHelper.EveryoneHasTrinketNum(trinketID) + PickupHelper.EveryoneHasTrinketEffectNum(trinketID)
	end
	
	function PickupHelper.SomeoneHasTrinketAndMomsBox(trinketType)
		for _, player in pairs(PickupHelper.GetPlayersWithTrinket(trinketType)) do
			if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.EveryoneHasTrinketAndMomsBoxNum(trinketType)
		local trinketCount = 0
		for _, player in pairs(PickupHelper.GetPlayersWithTrinket(trinketType)) do
			if player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) then
				trinketCount = trinketCount + 1
			end
		end
		return trinketCount
	end
	
	function PickupHelper.SomeoneHasTrinketButNotMomsBox(trinketType)
		for _, player in pairs(PickupHelper.GetPlayersWithTrinket(trinketType)) do
			if not player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.EveryoneHasTrinketButNotMomsBoxNum(trinketType)
		local trinketCount = 0
		for _, player in pairs(PickupHelper.GetPlayersWithTrinket(trinketType)) do
			if not player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_BOX) then
				trinketCount = trinketCount + 1
			end
		end
		return trinketCount
	end
	
	function PickupHelper.EveryoneHasEqualPickups()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local playerCoins = player:GetNumCoins()
			local playerBombs = player:GetNumBombs()
			local playerKeys = player:GetNumKeys()
			if playerCoins ~= playerBombs or playerBombs ~= playerKeys or playerCoins ~= playerKeys then
				return false
			end
		end
		return true
	end
	function PickupHelper.SomeoneHasCard(cardID)
		for _, player in pairs(PickupHelper.GetPlayers()) do
			if PickupHelper.PlayerHasCard(player, cardID) then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.AnimateHappyAll()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			player:AnimateHappy()
		end
	end
	
	function PickupHelper.AnimateSadAll()
		for _, player in pairs(PickupHelper.GetPlayers()) do
			player:AnimateSad()
		end
	end
	
	function PickupHelper.SomeoneIsPlayerType(playerType)
		return PickupHelper.NumToBool(#PickupHelper.GetPlayersOfType(playerType))
	end
	
	------------------
	--Tear Functions--
	------------------
	function PickupHelper.GetPlayerFromTear(tear)
		for i=1, 3 do
			local check = nil
			if i == 1 then
				check = tear.Parent
			elseif i == 2 then
				check = PickupHelper.GetSpawner(tear)
			elseif i == 3 then
				check = tear.SpawnerEntity
			end
			if check then
				if check.Type == EntityType.ENTITY_PLAYER then
					return PickupHelper.GetPtrHashEntity(check):ToPlayer()
				elseif check.Type == EntityType.ENTITY_FAMILIAR and check.Variant == FamiliarVariant.INCUBUS then
					local data = PickupHelper.GetData(tear)
					data.IsIncubusTear = true
					return check:ToFamiliar().Player:ToPlayer()
				end
			end
		end
		return nil
	end
	
	function PickupHelper.IsRespritableTear(tear, includeBlood)
		local sprite = tear:GetSprite()
		local filename = sprite:GetFilename()
		if filename == "gfx/002.000_Tear.anm2" or filename == "gfx/009.000_Projectile.anm2"
		or (includeBlood and (filename == "gfx/002.001_Blood Tear.anm2" or filename == "gfx/009.004_Tear Projectile.anm2")) then
			return true
		end
		return false
	end
	
	function PickupHelper.IsBloodTearVariant(tearVariant)
		if tearVariant == TearVariant.BLOOD
		or tearVariant == TearVariant.CUPID_BLOOD
		or tearVariant == TearVariant.PUPULA_BLOOD
		or tearVariant == TearVariant.GODS_FLESH_BLOOD
		or tearVariant == TearVariant.NAIL_BLOOD
		or tearVariant == TearVariant.GLAUCOMA_BLOOD
		or tearVariant == TearVariant.BELIAL
		or tearVariant == TearVariant.EYE_BLOOD
		or tearVariant == TearVariant.BALLOON
		or tearVariant == TearVariant.BALLOON_BRIMSTONE
		or tearVariant == TearVariant.BALLOON_BOMB then
			return true
		end
		return false
	end
	
	--MC_POST_PLAYER_TEAR callback
	function PickupHelper.OnPlayerTearInit(tear, player)
		local data = PickupHelper.GetData(tear)
		data.TearInit = true
		
		--MC_POST_PLAYER_TEAR
		if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PLAYER_TEAR] then
			for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PLAYER_TEAR]) do
				if not callbackData.extraVariable or callbackData.extraVariable == tear.variant then
					callbackData.functionToCall(callbackData.modReference, tear, player)
				end
			end
		end
	end

	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
		local data = PickupHelper.GetData(tear)
		if not data.TearInit then
			if tear.SpawnerType == 1 then
				local player = tear.Parent:ToPlayer()
				if player then
					PickupHelper.OnPlayerTearInit(tear, player)
				end
			end
		end
	end)

	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_TEAR_RENDER, function(_, tear)
		local data = PickupHelper.GetData(tear)
		if not data.TearInit then
			local parent = tear.Parent
			if parent and parent.Type == EntityType.ENTITY_FAMILIAR and parent.Variant == FamiliarVariant.INCUBUS and not data.IsIncubusTear then
				data.IsIncubusTear = true
				local player = parent:ToFamiliar().Player

				if player then
					PickupHelper.OnPlayerTearInit(tear, player)
				end
			end
		end
	end)
	
	--------------------
	--Effect Functions--
	--------------------
	function PickupHelper.IsTearPoof(effect, includeBlood)
		local variant = effect.Variant
		if variant == EffectVariant.TEAR_POOF_A
		or variant == EffectVariant.TEAR_POOF_B
		or variant == EffectVariant.CROSS_POOF
		or variant == EffectVariant.TEAR_POOF_SMALL
		or variant == EffectVariant.TEAR_POOF_VERYSMALL
		or (includeBlood and (variant == EffectVariant.BULLET_POOF)) then
			return true
		end
		return false
	end
	
	function PickupHelper.IsRespritableTearPoof(effect, includeBlood)
		local sprite = effect:GetSprite()
		local filename = sprite:GetFilename()
		if filename == "gfx/1000.012_Tear PoofA.anm2"
		or filename == "gfx/1000.013_Tear PoofB.anm2"
		or (includeBlood and (filename == "gfx/1000.011_Bullet Poof.anm2")) then
			return true
		end
		return false
	end
	
	--------------------
	--Pickup Functions--
	--------------------
	
	--pickup value data to enable humbling bundle - like items
	PickupHelper.GlobalPickupValueModifiers = {
		function()
			return Isaac.GetPlayer(0):GetCollectibleNum(CollectibleType.COLLECTIBLE_HUMBLEING_BUNDLE) --all of these seem to be given to player 1
		end,
		function()
			if PickupHelper.EveryoneHasEqualPickups() then
				return PickupHelper.EveryoneHasTrinketNum(TrinketType.TRINKET_EQUALITY)
			end
		end
	}
	
	PickupHelper.PickupValueData = {
		Bombs = {
			AllowGlobalModifiers = true,
			Values = {
				[1] = {Variant = PickupVariant.PICKUP_BOMB, SubType = BombSubType.BOMB_NORMAL},
				[2] = {Variant = PickupVariant.PICKUP_BOMB, SubType = BombSubType.BOMB_DOUBLEPACK}
			},
			Modifiers = {
				function()
					return Isaac.GetPlayer(0):GetCollectibleNum(CollectibleType.COLLECTIBLE_BOGO_BOMBS) --all of these seem to be given to player 1
				end
			}
		},
		Hearts = {
			AllowGlobalModifiers = true,
			Values = {
				[1] = {Variant = PickupVariant.PICKUP_HEART, SubType = HeartSubType.HEART_FULL},
				[2] = {Variant = PickupVariant.PICKUP_HEART, SubType = HeartSubType.HEART_DOUBLEPACK}
			},
			Modifiers = {}
		},
		Coins = {
			AllowGlobalModifiers = true,
			Values = {
				[1] = {Variant = PickupVariant.PICKUP_COIN, SubType = CoinSubType.COIN_PENNY},
				[2] = {Variant = PickupVariant.PICKUP_COIN, SubType = CoinSubType.COIN_DOUBLEPACK}
			},
			Modifiers = {}
		},
		Keys = {
			AllowGlobalModifiers = true,
			Values = {
				[1] = {Variant = PickupVariant.PICKUP_KEY, SubType = KeySubType.KEY_NORMAL},
				[2] = {Variant = PickupVariant.PICKUP_KEY, SubType = KeySubType.KEY_DOUBLEPACK}
			},
			Modifiers = {}
		}
	}
	PickupHelper.EnablePickupValueMorphing = true
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PICKUP_INIT, function(_, pickup)
		if PickupHelper.EnablePickupValueMorphing then
			local variant, subType = pickup.Variant, pickup.SubType
			local valueShouldBe, valueCurrent, shouldBeVariant, shouldBeSubType = PickupHelper.GetPickupValues(variant, subType, nil, pickup)
			if valueCurrent < valueShouldBe and (variant ~= shouldBeVariant or subType ~= shouldBeSubType) then
				pickup:Morph(EntityType.ENTITY_PICKUP, shouldBeVariant, shouldBeSubType, true)
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, PickupHelperCallbacks.MC_POST_FIRST_GAME_START, function()
		PickupHelper.EnablePickupValueMorphing = true
	end)
	
	--returns values that pickups should be (with humbling bundle etc)
	function PickupHelper.GetPickupValues(variant, subType, bypassCap, pickup)
		local onlyReturnShouldBeValue = false
		if type(variant) == "boolean" and variant == true then --legacy
			variant = PickupVariant.PICKUP_BOMB
			subType = BombSubType.BOMB_NORMAL
			onlyReturnShouldBeValue = true
		end
		
		local onlyGlobal = false
		if not variant then
			onlyGlobal = true
		end
		
		local globalMod = 0
		for _, globalModFunction in pairs(PickupHelper.GlobalPickupValueModifiers) do
			if globalModFunction and type(globalModFunction) == "function" then
				local valueToAdd = globalModFunction(pickup)
				if type(valueToAdd) == "boolean" or not valueToAdd then
					valueToAdd = PickupHelper.BoolToNum(valueToAdd)
				end
				globalMod = globalMod + valueToAdd
			end
		end
		
		local valueCurrent = 1
		local valueShouldBe = 1
		local shouldBeVariant = variant
		local shouldBeSubType = subType
		if not onlyGlobal then
			local foundMatchingTypes = false
			for _, dataTable in pairs(PickupHelper.PickupValueData) do
				if dataTable and dataTable.Values and dataTable.Modifiers then
					for value, valueData in pairs(dataTable.Values) do
						if valueData and valueData.Variant and valueData.SubType and valueData.Variant == variant and valueData.SubType == subType then
							valueCurrent = value
							
							--get what value this should be
							if dataTable.AllowGlobalModifiers then
								valueShouldBe = valueShouldBe + globalMod
							end
							for _, modifierFunction in pairs(dataTable.Modifiers) do
								if modifierFunction and type(modifierFunction) == "function" then
									local valueToAdd = modifierFunction(pickup)
									if type(valueToAdd) == "boolean" or not valueToAdd then
										valueToAdd = PickupHelper.BoolToNum(valueToAdd)
									end
									valueShouldBe = valueShouldBe + valueToAdd
								end
							end
							
							local maxCap = 0
							if not bypassCap and dataTable.ForceMax then
								maxCap = dataTable.ForceMax
							end
							
							--get the variant and subtype of what this should be
							local cap = 0
							for cappedValue=1, #dataTable.Values do
								local cappedValueData = dataTable.Values[cappedValue]
								if cappedValueData and cappedValueData.Variant and cappedValueData.SubType and cappedValue <= valueShouldBe then
									cap = cappedValue
									shouldBeVariant = cappedValueData.Variant
									shouldBeSubType = cappedValueData.SubType
									if cappedValue == valueShouldBe or (maxCap > 0 and cap == maxCap) then
										break
									end
								end
							end
							if not bypassCap then
								valueShouldBe = cap
							end
							
							foundMatchingTypes = true
							break
						end
					end
				end
				if foundMatchingTypes then
					break
				end
			end
		end
		
		if onlyReturnShouldBeValue then
			return valueShouldBe
		end
		if onlyGlobal then
			return globalMod+1
		end
		return valueShouldBe, valueCurrent, shouldBeVariant, shouldBeSubType
	end
	
	--returns what the default price of this item should be in a shop, ignoring sales
	function PickupHelper.GetBasePickupValue(pickup)
		if pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			return 15
		elseif not (pickup.Variant == PickupVariant.PICKUP_HEART and (pickup.SubType == HeartSubType.HEART_FULL or pickup.SubType == HeartSubType.HEART_HALF)) then
			return 5
		elseif pickup.Variant == PickupVariant.PICKUP_HEART and (pickup.SubType == HeartSubType.HEART_FULL or pickup.SubType == HeartSubType.HEART_HALF) then
			return 3
		end
		return 0
	end
	
	--returns true if the pickup can be picked up
	function PickupHelper.IsPickupPickupable(pickup, allowShopItem)
		if pickup and pickup:Exists() then
			local sprite = pickup:GetSprite()
			local data = PickupHelper.GetData(pickup)
			if (data.CanBePickedUp or sprite:WasEventTriggered("DropSound") or sprite:IsPlaying("Idle"))
			and (allowShopItem or (not allowShopItem and not pickup:IsShopItem())) then
				return true
			end
		end
		return false
	end
	
	--this function returns the player entity who's probably touching the pickup provided
	--may be depreciated in favor of using MC_PRE_PICKUP_COLLISION
	function PickupHelper.GetPlayerTouchingPickup(pickup, allowShopItem, ignorePrice, onlyBone)
		if pickup and pickup:Exists() then
			local isShopItem = pickup:IsShopItem()
			local price = 0
			if isShopItem then
				price = pickup.Price
			end
			
			if PickupHelper.IsPickupPickupable(pickup, allowShopItem) then
				--get all the players
				if not onlyBone then
					for _, player in pairs(PickupHelper.GetAlivePlayers()) do
						if (player.Position - pickup.Position):Length() < player.Size + pickup.Size + 3 then --check if the player is touching it
							if (isShopItem and player:GetNumCoins() >= price) or not isShopItem or ignorePrice then --check if the player can afford it if it's a shop item
								return player
							end
						end
					end
				end
			
				--try to get a player from bone club swings
				if not isShopItem then
					for _, knife in pairs(Isaac.FindByType(EntityType.ENTITY_KNIFE, -1, 4, false, false)) do
						if knife.FrameCount > 0 and knife.Parent then
							local parent = knife.Parent
							if parent:ToPlayer() then
								local player = parent:ToPlayer()
								
								--find the center of the swing object
								knife = knife:ToKnife()
								local position = knife.Position
								local scale = 30
								if knife.Variant == 2 then --knife + bone
									scale = 42
								end
								scale = scale * knife.SpriteScale.X
								local offset = Vector(scale,0)
								offset = offset:Rotated(knife.Rotation)
								position = position + offset
								
								--do player checks
								if not PickupHelper.IsPlayerGhost(player) then --dead players shouldn't be able to pick up stuff
									if (position - pickup.Position):Length() < pickup.Size + scale then --check if the player is touching it
										return player
									end
								end
							end
						end
					end
				end
			end
		end
		
		--didnt find any player touching the pickup
		return false
	end

	--this function removes the pickup and makes it play the collect animation
	function PickupHelper.CollectPickup(pickup, player, doNotRestock)
		if pickup and pickup:Exists() then
			if player and pickup:IsShopItem() then
				PickupHelper.BuyPickup(pickup, player, doNotRestock)
			else
				pickup = pickup:ToPickup()
				pickup.Velocity = Vector.Zero
				pickup.Touched = true
				pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				pickup:GetSprite():Play("Collect", true)
				pickup:Die() --this will remove the pickup but let it continue playing the animation
			end
		end
	end
	
	local pickupToRestock = {}
	function PickupHelper.RestockPickup(variant, subtype, position, price)
		if not price then
			price = 5
		end
		local pickupData = {
			Variant = variant,
			SubType = subtype,
			Position = position,
			Price = price,
			Frame = Isaac.GetFrameCount(),
			RoomSeed = PickupHelper.Room:GetDecorationSeed(),
			DoPoof = true
		}
		pickupToRestock[#pickupToRestock+1] = pickupData
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_STARTED, function(_, isSaveGame)
		pickupToRestock = {}
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		pickupToRestock = {}
	end)
	
	function PickupHelper.CheckPickupRestock()
		if #pickupToRestock >= 1 then
			for i=1, #pickupToRestock do
				if pickupToRestock[i] then
					if pickupToRestock[i].RoomSeed == PickupHelper.Room:GetDecorationSeed() then
						if Isaac.GetFrameCount() >= pickupToRestock[i].Frame + 60 then
							local position = pickupToRestock[i].Position
							local respawnedPickup = PickupHelper.Game:Spawn(EntityType.ENTITY_PICKUP, pickupToRestock[i].Variant or 0, position, Vector.Zero, nil, pickupToRestock[i].SubType or 0, PickupHelper.GetRNGNext()):ToPickup()
							if pickupToRestock[i].DoPoof then
								PickupHelper.Game:Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, position, Vector.Zero, nil, 0, PickupHelper.GetRNGNext())
							end
							if respawnedPickup and respawnedPickup:Exists() then
								respawnedPickup.Price = pickupToRestock[i].Price or 5
							end
							pickupToRestock[i] = nil
						end
					else
						pickupToRestock[i].DoPoof = false
					end
				else
					pickupToRestock[i] = nil
				end
			end
		end
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		PickupHelper.CheckPickupRestock()
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		PickupHelper.CheckPickupRestock()
	end)
	
	function PickupHelper.BuyPickup(pickup, player, doNotRestock)
		if pickup and pickup:Exists() then
			if pickup:IsShopItem() then
				local price = pickup.Price
				if price > 0 then
					local coinsToRemove = price
					if player:GetNumCoins() < coinsToRemove then
						coinsToRemove = player:GetNumCoins()
					end
					player:AddCoins(-coinsToRemove)
				else
					price = 5
				end
				
				for _, player in pairs(PickupHelper.GetPlayersWithTrinket(TrinketType.TRINKET_STORE_CREDIT)) do
					player:TryRemoveTrinket(TrinketType.TRINKET_STORE_CREDIT)
					break
				end
				
				if not doNotRestock then
					if PickupHelper.ShouldRestock() then
						PickupHelper.RestockPickup(pickup.Variant, pickup.SubType, pickup.Position, price)
					end
				end
				pickup:Remove()
			end
		end
	end
	
	function PickupHelper.ShouldPickupPlayAppearAnimation(pickup)
		if pickup and pickup:Exists() then
			if (PickupHelper.Room:GetFrameCount() <= 0 and not PickupHelper.Room:IsFirstVisit()) or pickup:IsShopItem() then
				return false
			end
			return true
		end
		return false
	end

	--this function returns true if someone has restock or if we're in greed mode
	function PickupHelper.ShouldRestock()
		if PickupHelper.Game:IsGreedMode() then
			return true
		end
		if PickupHelper.SomeoneHasCollectible(CollectibleType.COLLECTIBLE_RESTOCK) then
			return true
		end
		return false
	end
	
	function PickupHelper.IsPickupNaturallySpawned(pickup)
		if pickup and pickup:Exists() then
			local data = PickupHelper.GetData(pickup)
			if data.NaturallySpawnedData then
				return true
			end
		end
		return false
	end
	
	function PickupHelper.GetPickupNaturallySpawnedData(pickup)
		if pickup and pickup:Exists() then
			local data = PickupHelper.GetData(pickup)
			if data.NaturallySpawnedData then
				return data.NaturallySpawnedData
			end
		end
		return nil
	end

	local getRandomChestRNG = PickupHelper.GetInitializedRNG()
	function PickupHelper.GetRandomChestVariant()
		local variant = PickupVariant.PICKUP_CHEST
		local chestType = PickupHelper.GetRandomNumber(1, 7, getRandomChestRNG)
		if chestType == 1 then
			variant = PickupVariant.PICKUP_CHEST
		elseif chestType == 2 then
			variant = PickupVariant.PICKUP_BOMBCHEST
		elseif chestType == 3 then
			variant = PickupVariant.PICKUP_SPIKEDCHEST
		elseif chestType == 4 then
			variant = PickupVariant.PICKUP_ETERNALCHEST
		elseif chestType == 5 then
			variant = PickupVariant.PICKUP_MIMICCHEST
		elseif chestType == 6 then
			variant = PickupVariant.PICKUP_LOCKEDCHEST
		elseif chestType == 7 then
			variant = PickupVariant.PICKUP_REDCHEST
		end
		
		return variant
	end
	
	function PickupHelper.IsPickupChest(pickup)
		if pickup.Variant == PickupVariant.PICKUP_CHEST
		or pickup.Variant == PickupVariant.PICKUP_BOMBCHEST
		or pickup.Variant == PickupVariant.PICKUP_SPIKEDCHEST
		or pickup.Variant == PickupVariant.PICKUP_ETERNALCHEST
		or pickup.Variant == PickupVariant.PICKUP_MIMICCHEST
		or pickup.Variant == PickupVariant.PICKUP_LOCKEDCHEST
		or pickup.Variant == PickupVariant.PICKUP_REDCHEST then
			return true
		end
		return false
	end
	
	------------------
	--Room Functions--
	------------------
	--returns the entity that's in the center of the room
	function PickupHelper.GetCenterEntity()
		for _, entity in pairs(Isaac.GetRoomEntities()) do
			if (PickupHelper.Room:GetCenterPos() - entity.Position):Length() < 40 then
				return entity
			end
		end
		
		return nil
	end
	
	--returns true if a collectible is in the room
	function PickupHelper.IsCollectibleInRoom()
		for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, -1, -1, false, false)) do
			local variant = pickup.Variant
			
			if variant == PickupVariant.PICKUP_COLLECTIBLE then
				return true
			end
		end
		
		return false
	end
	
	--returns the room index of a room of the room type provided
	local roomTypeRNG = PickupHelper.GetInitializedRNG()
	function PickupHelper.GetRoomTypeIndex(roomType)
		local roomIndex = PickupHelper.Level:QueryRoomTypeIndex(roomType, false, roomTypeRNG)
		return roomIndex
	end
	
	--teleports the players to the room index provided
	function PickupHelper.TeleportToRoomIndex(roomIndex)
		PickupHelper.Level.EnterDoor = -1
		PickupHelper.Level.LeaveDoor = -1
		PickupHelper.Game:StartRoomTransition(roomIndex, Direction.NO_DIRECTION, 3)
	end
	
	--teleports the players to a room with the room type provided
	function PickupHelper.TeleportToRoomType(roomType)
		local roomIndex = PickupHelper.GetRoomTypeIndex(roomType)
		PickupHelper.TeleportToRoomIndex(roomIndex)
	end
	
	--opens all the doors
	function PickupHelper.OpenAllDoors()
		for door = 0, 7 do
			if PickupHelper.Room:GetDoor(door) then
				PickupHelper.Room:GetDoor(door):Open()
			end
		end
	end
	
	--closes all the doors
	function PickupHelper.CloseAllDoors(force)
		if force == nil then
			force = false
		end
		for door = 0, 7 do
			if PickupHelper.Room:GetDoor(door) then
				PickupHelper.Room:GetDoor(door):Close(force)
			end
		end
	end
	
	--bars all the doors
	function PickupHelper.BarAllDoors()
		for door = 0, 7 do
			if PickupHelper.Room:GetDoor(door) then
				PickupHelper.Room:GetDoor(door):Bar()
			end
		end
	end
	
	--blows open all the doors
	function PickupHelper.BlowOpenAllDoors(fromExplosion)
		if fromExplosion == nil then
			fromExplosion = false
		end
		for door = 0, 7 do
			if PickupHelper.Room:GetDoor(door) then
				PickupHelper.Room:GetDoor(door):TryBlowOpen(fromExplosion)
			end
		end
	end
	
	--unlocks all the doors
	function PickupHelper.UnlockAllDoors(force)
		if force == nil then
			force = false
		end
		for door = 0, 7 do
			if PickupHelper.Room:GetDoor(door) then
				PickupHelper.Room:GetDoor(door):TryUnlock(force)
			end
		end
	end
	
	--locks all the doors
	function PickupHelper.LockAllDoors()
		for door = 0, 7 do
			if PickupHelper.Room:GetDoor(door) then
				PickupHelper.Room:GetDoor(door):SetLocked(true)
			end
		end
	end

	--returns true if the room was just cleared
	local roomWasCleared = true
	local roomWasJustCleared = false
	function PickupHelper.WasRoomJustCleared()
		return roomWasJustCleared
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		local roomIsCleared = PickupHelper.Room:IsClear()
		
		roomWasJustCleared = false
		if roomIsCleared and not roomWasCleared then
			roomWasJustCleared = true
			
			--MC_POST_ROOM_CLEAR
			if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_ROOM_CLEAR] then
				for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_ROOM_CLEAR]) do
					callbackData.functionToCall(callbackData.modReference)
				end
			end
		end
		
		roomWasCleared = roomIsCleared
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		roomWasJustCleared = false
		roomWasCleared = true
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		roomWasJustCleared = false
		roomWasCleared = true
	end)
	
	function PickupHelper.GetClampedToTilePosition(pos)
		local gridIndex = PickupHelper.Room:GetGridIndex(pos)
		local posClamped = PickupHelper.Room:GetGridPosition(gridIndex)
		return posClamped
	end
	
	--returns true if a greed mode wave was completed
	local lastGreedModeWave = nil
	local greedWaveWasCompleted = false
	function PickupHelper.WasGreedWaveCompleted()
		return greedWaveWasCompleted
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		local greedModeWave = PickupHelper.Level.GreedModeWave
		
		if not lastGreedModeWave then
			lastGreedModeWave = greedModeWave
		end
		
		greedWaveWasCompleted = false
		if greedModeWave > lastGreedModeWave then
			greedWaveWasCompleted = true
			lastGreedModeWave = greedModeWave
			
			--MC_POST_GREED_WAVE
			if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_GREED_WAVE] then
				for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_GREED_WAVE]) do
					callbackData.functionToCall(callbackData.modReference)
				end
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		lastGreedModeWave = 0
	end)

	--returns true if the room's ambush is done
	local roomAmbushWasDone = true
	local roomAmbushWasJustDone = false
	function PickupHelper.WasRoomAmbushDone()
		return roomAmbushWasJustDone
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		local roomAmbushDone = PickupHelper.Room:IsAmbushDone()
		
		roomAmbushWasJustDone = false
		if roomAmbushDone and not roomAmbushWasDone then
			roomAmbushWasJustDone = true
			
			--MC_POST_AMBUSH_DONE
			if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_AMBUSH_DONE] then
				for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_AMBUSH_DONE]) do
					callbackData.functionToCall(callbackData.modReference)
				end
			end
		end
		
		roomAmbushWasDone = roomAmbushDone
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_LEVEL, function()
		roomAmbushWasJustDone = false
		roomAmbushWasDone = true
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		roomAmbushWasJustDone = false
		roomAmbushWasDone = true
	end)
	
	--returns true if the room is clear and there are no active enemies and there are no projectiles
	function PickupHelper.RoomIsSafe()
		local roomHasDanger = false
		for _, entity in pairs(Isaac.GetRoomEntities()) do
			if (entity:IsActiveEnemy() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY))
			or entity.Type == EntityType.ENTITY_PROJECTILE
			or entity.Type == EntityType.ENTITY_BOMBDROP then
				roomHasDanger = true
				break
			end
		end
		if PickupHelper.Room:IsClear() and not roomHasDanger then
			return true
		end
		return false
	end
	
	-------------------------
	--FORCE PLAYER COSTUMES--
	-------------------------
	function PickupHelper.BaseForceCostumeFunction(costumeTable, id, costume, costumeType)
		if type(costume) ~= "table" then
			costume = {costume}
		end
		if not costumeType then
			costumeType = ItemType.ITEM_NULL
		end
		local tableToInsert = {
			ID = id,
			Costume = costume,
			Type = costumeType
		}
		costumeTable[#costumeTable+1] = tableToInsert
	end
	local characterCostumes = {}
	function PickupHelper.ForceCostumeWithCharacter(playerType, costume, costumeType)
		PickupHelper.BaseForceCostumeFunction(characterCostumes, playerType, costume, costumeType)
	end
	local collectibleCostumes = {}
	function PickupHelper.ForceCostumeWithCollectible(collectible, costume, costumeType, includeEffect)
		if includeEffect == nil then
			includeEffect = true
		end
		PickupHelper.BaseForceCostumeFunction(collectibleCostumes, collectible, costume, costumeType)
		if includeEffect then
			PickupHelper.ForceCostumeWithCollectibleEffect(collectible, costume, costumeType)
		end
	end
	local trinketCostumes = {}
	function PickupHelper.ForceCostumeWithTrinket(trinket, costume, costumeType, includeEffect)
		if includeEffect == nil then
			includeEffect = true
		end
		PickupHelper.BaseForceCostumeFunction(trinketCostumes, trinket, costume, costumeType)
		if includeEffect then
			PickupHelper.ForceCostumeWithTrinketEffect(trinket, costume, costumeType)
		end
	end
	local activeItemCostumes = {}
	function PickupHelper.ForceCostumeWithActiveItem(collectible, costume, costumeType, includeEffect)
		if includeEffect == nil then
			includeEffect = true
		end
		PickupHelper.BaseForceCostumeFunction(activeItemCostumes, collectible, costume, costumeType)
		if includeEffect then
			PickupHelper.ForceCostumeWithCollectibleEffect(collectible, costume, costumeType)
		end
	end
	local cardCostumes = {}
	function PickupHelper.ForceCostumeWithCard(card, costume, costumeType)
		PickupHelper.BaseForceCostumeFunction(cardCostumes, card, costume, costumeType)
	end
	local pillEffectCostumes = {}
	function PickupHelper.ForceCostumeWithPillEffect(pillEffect, costume, costumeType)
		PickupHelper.BaseForceCostumeFunction(pillEffectCostumes, pillEffect, costume, costumeType)
	end
	local transformationCostumes = {}
	function PickupHelper.ForceCostumeWithTransformation(playerForm, costume, costumeType)
		PickupHelper.BaseForceCostumeFunction(transformationCostumes, playerForm, costume, costumeType)
	end
	local collectibleEffectCostumes = {}
	function PickupHelper.ForceCostumeWithCollectibleEffect(collectible, costume, costumeType)
		PickupHelper.BaseForceCostumeFunction(collectibleEffectCostumes, collectible, costume, costumeType)
	end
	local trinketEffectCostumes = {}
	function PickupHelper.ForceCostumeWithTrinketEffect(trinket, costume, costumeType)
		PickupHelper.BaseForceCostumeFunction(trinketEffectCostumes, trinket, costume, costumeType)
	end
	local nullEffectCostumes = {}
	function PickupHelper.ForceCostumeWithNullEffect(nullItem, costume, costumeType)
		PickupHelper.BaseForceCostumeFunction(nullEffectCostumes, nullItem, costume, costumeType)
	end
	function PickupHelper.HandleForceCostumeTable(player, costumeTable, dataCostumeTable, valueToCheck, compare, functionArg1, functionArg2, functionArg3)
		if #costumeTable >= 1 then
			for j=1, #costumeTable do
				if costumeTable[j]
				and costumeTable[j].ID
				and costumeTable[j].Costume
				and costumeTable[j].Type then
					local currentValueToCheck = valueToCheck
					if type(currentValueToCheck) == "function" then
						local function setArg(arg)
							if arg == "ID" then
								arg = costumeTable[j].ID
							elseif arg == "Costume" then
								arg = costumeTable[j].Costume
							elseif arg == "Type" then
								arg = costumeTable[j].Type
							end
							return arg
						end
						currentValueToCheck = currentValueToCheck(setArg(functionArg1), setArg(functionArg2), setArg(functionArg3))
					end
					if compare then
						currentValueToCheck = currentValueToCheck == costumeTable[j].ID
					end
					local currentValueIsBool = type(currentValueToCheck) == "nil" or type(currentValueToCheck) == "boolean"
					local currentValueIsNumber = type(currentValueToCheck) == "number"
					if currentValueIsNumber and not dataCostumeTable[j] then
						dataCostumeTable[j] = 0
					end
					if (currentValueIsBool and not dataCostumeTable[j])
					or (currentValueIsNumber and dataCostumeTable[j] < currentValueToCheck) then
						if (currentValueIsBool and currentValueToCheck)
						or (currentValueIsNumber and currentValueToCheck > 0) then
							for i, costume in pairs(costumeTable[j].Costume) do
								if costumeTable[j].Type == ItemType.ITEM_PASSIVE then
									player:AddCostume(PickupHelper.ItemConfig:GetCollectible(costume), false)
								elseif costumeTable[j].Type == ItemType.ITEM_TRINKET then
									player:AddCostume(PickupHelper.ItemConfig:GetTrinket(costume), false)
								else
									player:AddNullCostume(costume)
								end
							end
							if currentValueIsBool then
								dataCostumeTable[j] = true
							elseif currentValueIsNumber then
								dataCostumeTable[j] = dataCostumeTable[j] + 1
							end
						end
					elseif (currentValueIsBool and not currentValueToCheck)
					or (currentValueIsNumber and dataCostumeTable[j] > 0 and currentValueToCheck <= 0) then
						for i, costume in pairs(costumeTable[j].Costume) do
							if costumeTable[j].Type == ItemType.ITEM_PASSIVE then
								player:RemoveCostume(PickupHelper.ItemConfig:GetCollectible(costume))
							elseif costumeTable[j].Type == ItemType.ITEM_TRINKET then
								player:RemoveCostume(PickupHelper.ItemConfig:GetTrinket(costume))
							else
								player:TryRemoveNullCostume(costume)
							end
						end
						if currentValueIsBool then
							dataCostumeTable[j] = false
						elseif currentValueIsNumber then
							dataCostumeTable[j] = 0
						end
					end
				end
			end
		end
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
		local data = PickupHelper.GetData(player)
		data.CharacterCostumesAdded = data.CharacterCostumesAdded or {}
		data.CollectibleCostumesAdded = data.CollectibleCostumesAdded or {}
		data.TrinketCostumesAdded = data.TrinketCostumesAdded or {}
		data.ActiveItemCostumesAdded = data.ActiveItemCostumesAdded or {}
		data.CardCostumesAdded = data.CardCostumesAdded or {}
		data.PillEffectCostumesAdded = data.PillEffectCostumesAdded or {}
		data.TransformationCostumesAdded = data.TransformationCostumesAdded or {}
		data.CollectibleEffectCostumesAdded = data.CollectibleEffectCostumesAdded or {}
		data.TrinketEffectCostumesAdded = data.TrinketEffectCostumesAdded or {}
		data.NullEffectCostumesAdded = data.NullEffectCostumesAdded or {}
		PickupHelper.HandleForceCostumeTable(player, characterCostumes, data.CharacterCostumesAdded, player.GetPlayerType, true, player)
		PickupHelper.HandleForceCostumeTable(player, collectibleCostumes, data.CollectibleCostumesAdded, player.GetCollectibleNum, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, trinketCostumes, data.TrinketCostumesAdded, player.HasTrinket, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, activeItemCostumes, data.ActiveItemCostumesAdded, PickupHelper.DidPlayerUseActiveItem, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, cardCostumes, data.CardCostumesAdded, PickupHelper.DidPlayerUseCard, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, pillEffectCostumes, data.PillEffectCostumesAdded, PickupHelper.DidPlayerUsePillEffect, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, transformationCostumes, data.TransformationCostumesAdded, PickupHelper.IsPlayerTransformed, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, collectibleEffectCostumes, data.CollectibleEffectCostumesAdded, function(player, id)
			return player:GetEffects():GetCollectibleEffectNum(id)
		end, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, trinketEffectCostumes, data.TrinketEffectCostumesAdded, function(player, id)
			return player:GetEffects():GetTrinketEffectNum(id)
		end, nil, player, "ID")
		PickupHelper.HandleForceCostumeTable(player, nullEffectCostumes, data.NullEffectCostumesAdded, function(player, id)
			return player:GetEffects():GetNullEffectNum(id)
		end, nil, player, "ID")
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_ITEM, function(_, itemID, itemRNG)
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local data = PickupHelper.GetData(player)
			data.CharacterCostumesAdded = {}
			data.CollectibleCostumesAdded = {}
			data.TrinketCostumesAdded = {}
			data.ActiveItemCostumesAdded = {}
			data.CardCostumesAdded = {}
			data.PillEffectCostumesAdded = {}
			data.TransformationCostumesAdded = {}
			data.CollectibleEffectCostumesAdded = {}
			data.TrinketEffectCostumesAdded = {}
			data.NullEffectCostumesAdded = {}
		end
	end, CollectibleType.COLLECTIBLE_D4)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_ITEM, function(_, itemID, itemRNG)
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local data = PickupHelper.GetData(player)
			data.CharacterCostumesAdded = {}
			data.CollectibleCostumesAdded = {}
			data.TrinketCostumesAdded = {}
			data.ActiveItemCostumesAdded = {}
			data.CardCostumesAdded = {}
			data.PillEffectCostumesAdded = {}
			data.TransformationCostumesAdded = {}
			data.CollectibleEffectCostumesAdded = {}
			data.TrinketEffectCostumesAdded = {}
			data.NullEffectCostumesAdded = {}
		end
	end, CollectibleType.COLLECTIBLE_D100)
	
	--------------------------------
	--Collectible Effect Functions--
	--------------------------------
	function PickupHelper.BaseForceEffectFunction(effectTable, id, effectID, effectType)
		if effectID == nil then
			effectID = id
		end
		if type(effectID) ~= "table" then
			effectID = {effectID}
		end
		if not effectType then
			effectType = ItemType.ITEM_NULL
		end
		local tableToInsert = {
			ID = id,
			Effect = effectID,
			Type = effectType
		}
		effectTable[#effectTable+1] = tableToInsert
	end
	local characterEffects = {}
	function PickupHelper.ForceEffectWithCharacter(playerType, effectID, effectType)
		PickupHelper.BaseForceEffectFunction(characterEffects, playerType, effectID, effectType)
	end
	local collectibleEffects = {}
	function PickupHelper.ForceEffectWithCollectible(collectible, effectID, effectType)
		PickupHelper.BaseForceEffectFunction(collectibleEffects, collectible, effectID, effectType)
	end
	local trinketEffects = {}
	function PickupHelper.ForceEffectWithTrinket(trinket, effectID, effectType)
		PickupHelper.BaseForceEffectFunction(trinketEffects, trinket, effectID, effectType)
	end
	local activeItemEffects = {}
	function PickupHelper.ForceEffectWithActiveItem(collectible, effectID, effectType)
		PickupHelper.BaseForceEffectFunction(activeItemEffects, collectible, effectID, effectType)
	end
	local cardEffects = {}
	function PickupHelper.ForceEffectWithCard(card, effectID, effectType)
		PickupHelper.BaseForceEffectFunction(cardEffects, card, effectID, effectType)
	end
	local pillEffectEffects = {}
	function PickupHelper.ForceEffectWithPillEffect(pillEffect, effectID, effectType)
		PickupHelper.BaseForceEffectFunction(pillEffectEffects, pillEffect, effectID, effectType)
	end
	local transformationEffects = {}
	function PickupHelper.ForceEffectWithTransformation(playerForm, effectID, effectType)
		PickupHelper.BaseForceEffectFunction(transformationEffects, playerForm, effectID, effectType)
	end
	
	-----------------------------
	--Screen Position Functions--
	-----------------------------
	function PickupHelper.GetScreenCenterPosition()
		local shape = PickupHelper.Room:GetRoomShape()
		local centerOffset = (PickupHelper.Room:GetCenterPos()) - PickupHelper.Room:GetTopLeftPos()
		local pos = PickupHelper.Room:GetCenterPos()
		if centerOffset.X > 260 then
			pos.X = pos.X - 260
		end
		if shape == RoomShape.ROOMSHAPE_LBL or shape == RoomShape.ROOMSHAPE_LTL then
			pos.X = pos.X - 260
		end
		if centerOffset.Y > 140 then
			pos.Y = pos.Y - 140
		end
		if shape == RoomShape.ROOMSHAPE_LTR or shape == RoomShape.ROOMSHAPE_LTL then
			pos.Y = pos.Y - 140
		end
		return Isaac.WorldToRenderPosition(pos, false)
	end
	
	function PickupHelper.GetScreenBottomRight(offset, doHealthOffset, doCardOffset)
		local pos = PickupHelper.GetScreenCenterPosition() * 2
		
		if not offset then
			offset = PickupHelper.HudOffset
		end
		
		local hudOffset = Vector(-offset * 2.2, -offset * 1.6)
		if doHealthOffset then
			hudOffset = Vector((-offset * 1.6) - ((offset - 10) * 0.2), -offset * 0.6)
		elseif doCardOffset then
			hudOffset = Vector(-offset * 1.6, -offset * 0.6)
		end
		pos = pos + hudOffset

		return pos
	end

	function PickupHelper.GetScreenBottomLeft(offset)
		local pos = Vector(0, PickupHelper.GetScreenBottomRight(0).Y)
		
		if not offset then
			offset = PickupHelper.HudOffset
		end
		
		local hudOffset = Vector(offset * 2.2, -offset * 1.6)
		pos = pos + hudOffset
		
		return pos
	end

	function PickupHelper.GetScreenTopRight(offset, doHealthOffset)
		local pos = Vector(PickupHelper.GetScreenBottomRight(0).X, 0)
		
		if not offset then
			offset = PickupHelper.HudOffset
		end
		
		local hudOffset = Vector(-offset * 2.2, offset * 1.2)
		if doHealthOffset then
			hudOffset = Vector((-offset * 2.2) - ((offset - 10) * 0.2), offset * 1.2)
		end
		pos = pos + hudOffset

		return pos
	end
	
	function PickupHelper.GetScreenTopLeft(offset)
		local pos = Vector.Zero
		
		if not offset then
			offset = PickupHelper.HudOffset
		end
		
		local hudOffset = Vector(offset * 2, offset * 1.2)
		pos = pos + hudOffset
		
		return pos
	end
	
	----------------
	--Game Pausing--
	----------------
	local hideBerkano = false
	function PickupHelper.DoBigbookPause()
		if PickupHelper.ReimplementedBigbook then
			local player = Isaac.GetPlayer(0)
			
			hideBerkano = true
			player:UseCard(Card.RUNE_BERKANO) --we undo berkano's effects later, this is done purely for the bigbook which our housing mod should have made blank if we got here
			PickupHelper.SFX:Stop(SoundEffect.SOUND_BERKANO)
			player:AnimateSad()
			PickupHelper.SFX:Stop(SoundEffect.SOUND_THUMBS_DOWN)
			player:StopExtraAnimation()
			
			--decrement our CardsUsedInThisRoom value
			local data = PickupHelper.GetData(player)
			if not data.CardsUsedInThisRoom then
				data.CardsUsedInThisRoom = {}
			end
			if not data.CardsUsedInThisRoom[Card.RUNE_BERKANO] then
				data.CardsUsedInThisRoom[Card.RUNE_BERKANO] = 1
			end
			data.CardsUsedInThisRoom[Card.RUNE_BERKANO] = data.CardsUsedInThisRoom[Card.RUNE_BERKANO] - 1
			
			--remove the blue flies and spiders that just spawned
			for _, bluefly in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, -1, false, false)) do
				if bluefly:Exists() and bluefly.FrameCount <= 0 then
					bluefly:Remove()
				end
			end
			for _, bluespider in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, -1, false, false)) do
				if bluespider:Exists() and bluespider.FrameCount <= 0 then
					bluespider:Remove()
				end
			end
		end
	end
	local isPausingGame = false
	local isPausingGameTimer = 0
	function PickupHelper.KeepPaused()
		isPausingGame = true
		isPausingGameTimer = 0
	end
	function PickupHelper.StopPausing()
		isPausingGame = false
		isPausingGameTimer = 0
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		if isPausingGame then
			isPausingGameTimer = isPausingGameTimer - 1
			if isPausingGameTimer <= 0 then
				isPausingGameTimer = 30
				PickupHelper.DoBigbookPause()
			end
		end
	end)
	
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_USE_CARD, function(_, cardID)
		if not hideBerkano then
			PickupHelper.DelayFunction(function()
				local stuffWasSpawned = false
				
				for _, bluefly in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, -1, false, false)) do
					if bluefly:Exists() and bluefly.FrameCount <= 1 then
						stuffWasSpawned = true
						break
					end
				end
				
				for _, bluespider in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, -1, false, false)) do
					if bluespider:Exists() and bluespider.FrameCount <= 1 then
						stuffWasSpawned = true
						break
					end
				end
				
				if stuffWasSpawned then
					PickupHelper.DoBigbook("gfx/ui/giantbook/rune_07_berkano.png", nil, nil, nil, false)
				end
			end, 1, nil, false, true)
		end
		hideBerkano = false
	end, Card.RUNE_BERKANO)

	---------------------
	--Overlay Functions--
	---------------------
	--streak overlays
	local shouldRenderStreak = false
	local streakUI = Sprite()
	streakUI:Load("gfx/ui/ui_streak.anm2", true)
	local streakFont1 = Font()
	streakFont1:Load("font/upheaval.fnt")
	local streakFont2 = Font()
	streakFont2:Load("font/pftempestasevencondensed.fnt")
	local streakTextPosition = Vector.Zero
	local streakTextScale = Vector.Zero
	local streakText1 = " "
	local streakText2 = " "
	local streakText3 = " "
	function PickupHelper.Streak(text1, text2, text3, spritesheet)
		if not text1 then
			text1 = " "
		end
		streakText1 = tostring(text1)
		
		if not text2 then
			text2 = " "
		end
		streakText2 = tostring(text2)
		
		if not text3 then
			text3 = " "
		end
		streakText3 = tostring(text3)
		
		if not spritesheet then
			spritesheet = "gfx/ui/effect_024_streak.png"
		end
		streakUI:ReplaceSpritesheet(0, spritesheet)
		
		streakUI:LoadGraphics()
		streakUI:Play("Text", true)
		shouldRenderStreak = true
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		streakUI:Update()
		if streakUI:IsFinished("Text") then
			shouldRenderStreak = false
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		if PickupHelper.ShouldRender() then
			local centerPos = PickupHelper.GetScreenCenterPosition()
			
			if shouldRenderStreak then
				streakPosition = centerPos
				streakPosition.Y = 48
				streakUI:RenderLayer(0, streakPosition)
				
				local streakFrameTable = {
					[0] = {Position = Vector(-800, 0), Scale = Vector(300, 20)},
					[1] = {Position = Vector(-639, 0), Scale = Vector(260, 36)},
					[2] = {Position = Vector(-450, 0), Scale = Vector(220, 52)},
					[3] = {Position = Vector(-250, 0), Scale = Vector(180, 68)},
					[4] = {Position = Vector(-70, 0), Scale = Vector(140, 84)},
					[5] = {Position = Vector(10, 0), Scale = Vector(95, 105)},
					[6] = {Position = Vector(6, 0), Scale = Vector(97, 103)},
					[7] = {Position = Vector(3, 0), Scale = Vector(98, 102)},
					[61] = {Position = Vector(-5, 0), Scale = Vector(99, 103)},
					[62] = {Position = Vector(-10, 0), Scale = Vector(98, 105)},
					[63] = {Position = Vector(-15, 0), Scale = Vector(96, 108)},
					[64] = {Position = Vector(-20, 0), Scale = Vector(95, 110)},
					[65] = {Position = Vector(144, 0), Scale = Vector(136, 92)},
					[66] = {Position = Vector(308, 0), Scale = Vector(177, 74)},
					[67] = {Position = Vector(472, 0), Scale = Vector(218, 56)},
					[68] = {Position = Vector(636, 0), Scale = Vector(259, 38)},
					[69] = {Position = Vector(800, 0), Scale = Vector(300, 20)}
				}
				local streakFrame = streakUI:GetFrame()
				local streakTextPosition = Vector.Zero
				local streakTextScale = Vector(100, 100)
				if streakFrameTable[streakFrame] then
					streakTextPosition = streakFrameTable[streakFrame].Position
					streakTextScale = streakFrameTable[streakFrame].Scale
				end
				streakFont1:DrawStringScaled(streakText1, streakPosition.X + streakTextPosition.X - (streakFont1:GetStringWidthUTF8(streakText1)/2), streakPosition.Y + streakTextPosition.Y - 9, (streakTextScale.X * 0.01), (streakTextScale.Y * 0.01), PickupHelper.KCOLOR_DEFAULT, 0, true)
				streakFont2:DrawStringScaled(streakText2, streakPosition.X + streakTextPosition.X - (streakFont1:GetStringWidthUTF8(streakText2)/2), streakPosition.Y + streakTextPosition.Y + 9, (streakTextScale.X * 0.01), (streakTextScale.Y * 0.01), PickupHelper.KCOLOR_DEFAULT, 0, true)
				streakFont2:DrawStringScaled(streakText3, streakPosition.X + streakTextPosition.X - (streakFont1:GetStringWidthUTF8(streakText3)/2), streakPosition.Y + streakTextPosition.Y + 21, (streakTextScale.X * 0.01), (streakTextScale.Y * 0.01), PickupHelper.KCOLOR_DEFAULT, 0, true)
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_STARTED, function(_, isSaveGame)
		shouldRenderStreak = false
	end)
	
	--giantbook overlays
	local shouldRenderGiantbook = false
	local giantbookUI = Sprite()
	giantbookUI:Load("gfx/ui/giantbook/giantbook.anm2", true)
	local giantbookAnimation = "Appear"
	function PickupHelper.DoBigbook(spritesheet, sound, animationToPlay, animationFile, doPause)
		if doPause == nil then
			doPause = true
		end
		if doPause then
			PickupHelper.DoBigbookPause()
		end
		
		if not animationToPlay then
			animationToPlay = "Appear"
		end
		
		if not animationFile then
			animationFile = "gfx/ui/giantbook/giantbook.anm2"
			if animationToPlay == "Appear" or animationToPlay == "Shake" then
				animationFile = "gfx/ui/giantbook/giantbook.anm2"
			elseif animationToPlay == "Static" then
				animationToPlay = "Effect"
				animationFile = "gfx/ui/giantbook/giantbook_clicker.anm2"
			elseif animationToPlay == "Flash" then
				animationToPlay = "Idle"
				animationFile = "gfx/ui/giantbook/giantbook_mama_mega.anm2"
			elseif animationToPlay == "Sleep" then
				animationToPlay = "Idle"
				animationFile = "gfx/ui/giantbook/giantbook_sleep.anm2"
			elseif animationToPlay == "AppearBig" or animationToPlay == "ShakeBig" then
				if animationToPlay == "AppearBig" then
					animationToPlay = "Appear"
				elseif animationToPlay == "ShakeBig" then
					animationToPlay = "Shake"
				end
				animationFile = "gfx/ui/giantbook/giantbookbig.anm2"
			end
		end
		
		giantbookAnimation = animationToPlay
		giantbookUI:Load(animationFile, true)
		if spritesheet then
			giantbookUI:ReplaceSpritesheet(0, spritesheet)
			giantbookUI:LoadGraphics()
		end
		giantbookUI:Play(animationToPlay, true)
		shouldRenderGiantbook = true
		
		if sound then
			PickupHelper.SFX:Play(sound, 1, 0, false, 1)
		end
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		if PickupHelper.ShouldRender() then
			local centerPos = PickupHelper.GetScreenCenterPosition()
			
			if PickupHelper.IsEvenRender then
				giantbookUI:Update()
				if giantbookUI:IsFinished(giantbookAnimation) then
					shouldRenderGiantbook = false
				end
			end
			
			if shouldRenderGiantbook then
				giantbookUI:Render(centerPos, Vector.Zero, Vector.Zero)
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_STARTED, function(_, isSaveGame)
		shouldRenderGiantbook = false
	end)
	
	--achievement overlays
	local shouldRenderAchievement = false
	local achievementUI = Sprite()
	achievementUI:Load("gfx/ui/achievement/achievements.anm2", true)
	local achievementUIDelay = 0
	function PickupHelper.DoAchievement(spritesheet, sound, doPause)
		if not spritesheet then
			error("PickupHelper.DoAchievement requires a spritesheet")
			return
		end
		
		if shouldRenderAchievement then
			PickupHelper.DelayFunction(PickupHelper.DoAchievement, 12, {spritesheet, sound, doPause}, false, true)
			return
		end
		
		if doPause == nil then
			doPause = true
		end
		if doPause then
			PickupHelper.DoBigbookPause()
			PickupHelper.DelayFunction(PickupHelper.DoBigbookPause, 50, nil, false, true)
			PickupHelper.DelayFunction(PickupHelper.DoBigbookPause, 88, nil, false, true)
		end
		
		achievementUI:ReplaceSpritesheet(3, spritesheet)
		achievementUI:LoadGraphics()
		achievementUI:Play("Appear", true)
		shouldRenderAchievement = true
		achievementUIDelay = 60
		
		if not sound then
			sound = SoundEffect.SOUND_CHOIR_UNLOCK
		end
		PickupHelper.SFX:Play(sound, 1, 0, false, 1)
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		if PickupHelper.ShouldRender() then
			local centerPos = PickupHelper.GetScreenCenterPosition()
			
			if PickupHelper.IsEvenRender then
				achievementUI:Update()
				if achievementUI:IsFinished("Appear") then
					achievementUI:Play("Idle", true)
				end
				if achievementUI:IsPlaying("Idle") then
					if achievementUIDelay > 0 then
						achievementUIDelay = achievementUIDelay - 1
					else
						achievementUIDelay = 0
						achievementUI:Play("Dissapear", true)
					end
				end
				if achievementUI:IsFinished("Dissapear") then
					shouldRenderAchievement = false
				end
			end
			
			if shouldRenderAchievement then
				achievementUI:Render(centerPos, Vector.Zero, Vector.Zero)
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_STARTED, function(_, isSaveGame)
		shouldRenderAchievement = false
	end)
	
	-------------
	--SCHEDULES-- (DEPRECIATED, REDIRECTS INTO DELAYFUNCTION)
	-------------
	function PickupHelper.Schedule(delay, onRender, functionToCall, ...)
		PickupHelper.DelayFunction(functionToCall, delay, {...}, false, onRender)
	end
	
	---------------------
	--DELAYED FUNCTIONS--
	---------------------
	--based on some revelations code with some changes
	PickupHelper.DelayedFunctions = {}

	function PickupHelper.DelayFunction(func, delay, args, removeOnNewRoom, useRender)
		local delayFunctionData = {
			Function = func,
			Delay = delay,
			Args = args,
			RemoveOnNewRoom = removeOnNewRoom,
			OnRender = useRender
		}
		table.insert(PickupHelper.DelayedFunctions, delayFunctionData)
	end

	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		for i, delayFunctionData in ripairs(PickupHelper.DelayedFunctions) do
			if delayFunctionData.RemoveOnNewRoom then
				table.remove(PickupHelper.DelayedFunctions, i)
			end
		end
	end)

	local function delayFunctionHandling(onRender)
		if #PickupHelper.DelayedFunctions ~= 0 then
			for i, delayFunctionData in ripairs(PickupHelper.DelayedFunctions) do
				if (delayFunctionData.OnRender and onRender) or (not delayFunctionData.OnRender and not onRender) then
					if delayFunctionData.Delay <= 0 then
						if delayFunctionData.Function then
							if delayFunctionData.Args then
								delayFunctionData.Function(table.unpack(delayFunctionData.Args))
							else
								delayFunctionData.Function()
							end
						end
						table.remove(PickupHelper.DelayedFunctions, i)
					else
						delayFunctionData.Delay = delayFunctionData.Delay - 1
					end
				end
			end
		end
	end

	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_UPDATE, function()
		delayFunctionHandling(false)
	end)

	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_RENDER, function()
		delayFunctionHandling(true)
	end)
	
	-------------------
	--P20 MOD SUPPORT--
	-------------------
	if not __eidItemDescriptions then
		__eidItemDescriptions = {}
	end
	if not __eidTrinketDescriptions then
		__eidTrinketDescriptions = {}
	end
	if not __eidCardDescriptions then
		__eidCardDescriptions  = {}
	end
	if not __eidItemTransformations then
		__eidItemTransformations = {}
	end
	
	if not __infinityTrueCoop then
		__infinityTrueCoop = {}
	end
	if not PickupHelperCardBacksPreLoad then
		PickupHelperCardBacksPreLoad = {}
	end
	function PickupHelper.AddModInitFunction(valueToCheck, functionTable, initFunction)
		if valueToCheck then
			initFunction()
		elseif functionTable then
			functionTable[#functionTable+1] = initFunction
		end
	end
	
	--------------------------
	--P20 PICKUP DATA SYSTEM--
	--------------------------
	PickupHelperPickupData = PickupHelperPickupData or {}
	PickupHelperPickupDataDefault = {
		----------
		--SOUNDS--
		----------
		--number equal to sound effect, played when the pickup lands on the ground.
		DropSound = nil,
		
		--function(entitypickup), called after the drop sound is played.
		OnDropFunction = nil,
		
		--number equal to sound effect, played when the pickup is collected.
		CollectSound = nil,
		
		----------
		--HEARTS--
		----------
		
		--number equal to the amount of max hearts you want to give the player.
		AddMaxHearts = 0,
		
		--number equal to the amount of red hearts you want to give the player.
		AddHearts = 0,
		
		--number equal to the amount of eternal hearts you want to give the player.
		AddEternalHearts = 0,
		
		--number equal to the amount of soul hearts you want to give the player.
		AddSoulHearts = 0,
		
		--number equal to the amount of black hearts you want to give the player.
		AddBlackHearts = 0,
		
		--number equal to the amount of gold hearts you want to give the player.
		AddGoldHearts = 0,
		
		--number equal to the amount of bone hearts you want to give the player.
		AddBoneHearts = 0,
		
		--boolean, true to make this heart act as a blended one, false to add all hearts possible.
		--explanation: blended hearts can add souls and reds, but will only add red if you have an empty heart container, will only add soul if you have full heart contains, and will add half of each if you only have half a container.
		--PickupHelperhelper will do its best to approximate this interation based on the add___heart values you have provided.
		ActAsBlendedHeart = false,
		
		--boolean, true to play a sound pickuphelper determines should be played if this heart is acting as a blended heart, false to not.
		--CollectSound will also be played if you have set it to something.
		PlayBlendedHeartSounds = false,
		
		--boolean, true to play a sound per heart type added to the player.
		--CollectSound will also be played if you have set it to something.
		PlayAllHeartSounds = false,
		
		--boolean, true to multiply the amount of red hearts given by 2 if the player who picks this up has maggy's bow, false to ignore maggy's bow.
		CanAddMaggysBowHearts = false,
		
		--boolean, true to replace this pickup with a red heart in womb super secret rooms
		ReplaceInWombSuperSecretRoom = false,
		
		--boolean, true to replace this pickup with an eternal heart in cathedral super secret rooms
		ReplaceInCathedralSuperSecretRoom = false,
		
		--boolean, true to replace this pickup with a black heart in library super secret rooms
		ReplaceInLibrarySuperSecretRoom = false,
		
		--number of blue flies that will spawn in place of this pickup if a player is keeper. keep at 0 or less to disable this.
		AddFliesAsKeeper = 0,
		
		---------
		--COINS--
		---------
		
		--number equal to the amount of coins you want to give the player.
		AddCoins = 0,
		
		--number equal to the amount of luck you want to give the player.
		AddLuck = 0,
		
		--boolean, true to do trinket effects if the player has the trinket and this trinket adds coins, false to not.
		CanDoPennyTrinketEffects = true,
		
		--------
		--KEYS--
		--------
		
		--number equal to the amount of keys you want to give the player.
		AddKeys = 0,
		
		--boolean, true to add a gold key to the player, false to not.
		AddGoldKey = false,
		
		---------
		--BOMBS--
		---------
		
		--number equal to the amount of bombs you want to give the player.
		AddBombs = 0,
		
		--boolean, true to add a gold bomb to the player, false to not.
		AddGoldBomb = false,
		
		-------------
		--BATTERIES--
		-------------
		
		--number equal to the amount of active item charge you want to give the player.
		AddCharge = 0,
		
		--number larger than AddCharge value. will make the code choose a random number between AddCharge and this value to add to the player's active item charge.
		AddChargeRandomMax = 0,
		
		--boolean, true to fully charge the player's active item, false to not.
		FullCharge = false,
		
		--boolean, true to only charge active items by 3 if its charge value is greater than 6 (usually this affects 12 room charge items, however mega blast will not be fully charged even if you set FullCharge to true and this to false)
		DoNotFullCharge12Charge = true,
		
		--boolean, true to enable the AddCharge value to charge the player's active item beyond the regular charge meter without requiring the battery.
		OverCharge = false,
		
		--boolean, true to add 1 to PickupHelperhelper's BatteriesPickedUp value, which when reaches 20 will unlock the Hairpin achievement.
		DoBatteryAchievement = false,
		
		----------
		--PLAYER--
		----------
		
		--boolean, true to allow default PickupHelper code that checks for stuff like CanPickRedHearts if the pickup adds red hearts, false to disable all this.
		PlayerCollectChecks = true,
		
		--function(entitypickup, entityplayer, boolean can player pick up), called after all PickupHelper checks, return true or false to overwrite can player pick up.
		PlayerCollectChecksFunction = nil,
		
		--boolean, true to allow default PickupHelper code that adds the pickups to the player, false to disable all this.
		PlayerCollect = true,
		
		--function(entitypickup, entityplayer), called after all the PickupHelper player collect code but before the pickup is removed. return false if you dont want the pickup to play the collect animation and be removed.
		PlayerCollectFunction = nil,
		
		--------------
		--BUM FRIEND--
		--------------
		--these also affect superbum and bumbo
		
		--boolean, true to make bum friend follow this pickup, false to make bum friend ignore it
		CanBumFriendPickUp = false,
		
		--boolean, true to allow default PickupHelper code that checks if the pickup adds coins, false to disable this.
		BumFriendCollectChecks = true,
		
		--function(entitypickup, entityfamiliar, boolean can bum friend pick up), called after all PickupHelper checks, return true or false to overwrite can bum friend pick up.
		BumFriendCollectChecksFunction = nil,
		
		--boolean, true to allow default PickupHelper code that adds the coins to the bum friend, false to disable this.
		BumFriendCollect = true,
		
		--function(entitypickup, entityfamiliar), called after all the PickupHelper bum friend collect code but before the pickup is removed. return false if you dont want the pickup to play the collect animation and be removed.
		BumFriendCollectFunction = nil,
		
		------------
		--DARK BUM--
		------------
		--these also affect superbum
		
		--boolean, true to make dark bum follow this pickup, false to make dark bum ignore it
		CanDarkBumPickUp = false,
		
		--boolean, true to allow default PickupHelper code that checks if the pickup adds red hearts, false to disable this.
		DarkBumCollectChecks = true,
		
		--function(entitypickup, entityfamiliar, boolean can dark bum pick up), called after all PickupHelper checks, return true or false to overwrite can dark bum pick up.
		DarkBumCollectChecksFunction = nil,
		
		--boolean, true to allow default PickupHelper code that adds the hearts to the dark bum, false to disable this.
		DarkBumCollect = true,
		
		--function(entitypickup, entityfamiliar), called after all the PickupHelper dark bum collect code but before the pickup is removed. return false if you dont want the pickup to play the collect animation and be removed.
		DarkBumCollectFunction = nil,
		
		------------
		--KEY BUM--
		------------
		--these also affect superbum
		
		--boolean, true to make key bum follow this pickup, false to make key bum ignore it
		CanKeyBumPickUp = false,
		
		--boolean, true to allow default PickupHelper code that checks if the pickup adds keys, false to disable this.
		KeyBumCollectChecks = true,
		
		--function(entitypickup, entityfamiliar, boolean can key bum pick up), called after all PickupHelper checks, return true or false to overwrite can key bum pick up.
		KeyBumCollectChecksFunction = nil,
		
		--boolean, true to allow default PickupHelper code that adds the keys to the key bum, false to disable this.
		KeyBumCollect = true,
		
		--function(entitypickup, entityfamiliar), called after all the PickupHelper key bum collect code but before the pickup is removed. return false if you dont want the pickup to play the collect animation and be removed.
		KeyBumCollectFunction = nil,
		
		-----------
		--THE JAR--
		-----------
		
		--boolean, true to allow the jar to pick this up if the player cant, false to disallow
		CanJarPickUp = false,
		
		--boolean, true to allow default PickupHelper code that checks if the pickup adds red hearts, false to disable this.
		JarCollectChecks = true,
		
		--function(entitypickup, entityplayer, boolean can jar pick up), called after all PickupHelper checks, return true or false to overwrite can jar pick up.
		JarCollectChecksFunction = nil,
		
		--boolean, true to allow default PickupHelper code that adds the hearts to the jar, false to disable this.
		JarCollect = true,
		
		--function(entitypickup, entityplayer), called after all the PickupHelper jar collect code but before the pickup is removed. return false if you dont want the pickup to play the collect animation and be removed.
		JarCollectFunction = nil
	}
	function PickupHelper.GetPickupData(variant, subType)
		if type(variant) == "number" and type(subType) == "number" then
			local PickupHelperdata = {}
			if variant == PickupVariant.PICKUP_HEART then
				PickupHelperdata = PickupHelper.GetDefaultPickupData()
				PickupHelperdata.DropSound = SoundEffect.SOUND_MEAT_FEET_SLOW0
				PickupHelperdata.CollectSound = SoundEffect.SOUND_BOSS2_BUBBLES
				if subType == HeartSubType.HEART_FULL then
					PickupHelperdata.AddHearts = 2
					PickupHelperdata.CanDarkBumPickUp = true
					PickupHelperdata.CanJarPickUp = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 2
					PickupHelperdata.CanAddMaggysBowHearts = true
				elseif subType == HeartSubType.HEART_HALF then
					PickupHelperdata.AddHearts = 1
					PickupHelperdata.CanDarkBumPickUp = true
					PickupHelperdata.CanJarPickUp = true
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 1
					PickupHelperdata.CanAddMaggysBowHearts = true
				elseif subType == HeartSubType.HEART_SOUL then
					PickupHelperdata.CollectSound = SoundEffect.SOUND_HOLY
					PickupHelperdata.AddSoulHearts = 2
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 3
				elseif subType == HeartSubType.HEART_ETERNAL then
					PickupHelperdata.CollectSound = SoundEffect.SOUND_SUPERHOLY
					PickupHelperdata.AddEternalHearts = 1
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 5
				elseif subType == HeartSubType.HEART_DOUBLEPACK then
					PickupHelperdata.AddHearts = 4
					PickupHelperdata.CanDarkBumPickUp = true
					PickupHelperdata.CanJarPickUp = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 4
					PickupHelperdata.CanAddMaggysBowHearts = true
				elseif subType == HeartSubType.HEART_BLACK then
					PickupHelperdata.CollectSound = SoundEffect.SOUND_UNHOLY
					PickupHelperdata.AddBlackHearts = 2
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 4
				elseif subType == HeartSubType.HEART_GOLDEN then
					PickupHelperdata.DropSound = SoundEffect.SOUND_GOLD_HEART_DROP
					PickupHelperdata.CollectSound = SoundEffect.SOUND_GOLD_HEART
					PickupHelperdata.AddGoldHearts = 1
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 5
				elseif subType == HeartSubType.HEART_HALF_SOUL then
					PickupHelperdata.CollectSound = SoundEffect.SOUND_HOLY
					PickupHelperdata.AddSoulHearts = 1
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 3
				elseif subType == HeartSubType.HEART_SCARED then
					PickupHelperdata.AddHearts = 2
					PickupHelperdata.CanDarkBumPickUp = true
					PickupHelperdata.CanJarPickUp = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 2
				elseif subType == HeartSubType.HEART_BLENDED then
					PickupHelperdata.CollectSound = nil
					PickupHelperdata.AddHearts = 2
					PickupHelperdata.AddSoulHearts = 2
					PickupHelperdata.ActAsBlendedHeart = true
					PickupHelperdata.PlayBlendedHeartSounds = true
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 3
				elseif subType == HeartSubType.HEART_BONE then
					PickupHelperdata.DropSound = SoundEffect.SOUND_BONE_DROP
					PickupHelperdata.CollectSound = SoundEffect.SOUND_BONE_HEART
					PickupHelperdata.AddBoneHearts = 1
					PickupHelperdata.ReplaceInWombSuperSecretRoom = true
					PickupHelperdata.ReplaceInCathedralSuperSecretRoom = true
					PickupHelperdata.ReplaceInLibrarySuperSecretRoom = true
					PickupHelperdata.AddFliesAsKeeper = 4
				end
			elseif variant == PickupVariant.PICKUP_COIN then
				PickupHelperdata = PickupHelper.GetDefaultPickupData()
				PickupHelperdata.DropSound = SoundEffect.SOUND_PENNYDROP
				PickupHelperdata.CollectSound = SoundEffect.SOUND_PENNYPICKUP
				if subType == CoinSubType.COIN_PENNY then
					PickupHelperdata.AddCoins = 1
					PickupHelperdata.CanBumFriendPickUp = true
				elseif subType == CoinSubType.COIN_NICKEL then
					PickupHelperdata.DropSound = SoundEffect.SOUND_NICKELDROP
					PickupHelperdata.CollectSound = SoundEffect.SOUND_NICKELPICKUP
					PickupHelperdata.AddCoins = 5
					PickupHelperdata.CanBumFriendPickUp = true
				elseif subType == CoinSubType.COIN_DIME then
					PickupHelperdata.DropSound = SoundEffect.SOUND_DIMEDROP
					PickupHelperdata.CollectSound = SoundEffect.SOUND_DIMEPICKUP
					PickupHelperdata.AddCoins = 10
					PickupHelperdata.CanBumFriendPickUp = true
				elseif subType == CoinSubType.COIN_DOUBLEPACK then
					PickupHelperdata.AddCoins = 2
					PickupHelperdata.CanBumFriendPickUp = true
				elseif subType == CoinSubType.COIN_LUCKYPENNY then
					PickupHelperdata.DropSound = SoundEffect.SOUND_PENNYDROP
					PickupHelperdata.CollectSound = SoundEffect.SOUND_PENNYPICKUP
					PickupHelperdata.AddCoins = 1
					PickupHelperdata.AddLuck = 1
					PickupHelperdata.CanBumFriendPickUp = true
				elseif subType == CoinSubType.COIN_STICKYNICKEL then
					PickupHelperdata.DropSound = SoundEffect.SOUND_NICKELDROP
					PickupHelperdata.CollectSound = SoundEffect.SOUND_NICKELPICKUP
				end
			elseif variant == PickupVariant.PICKUP_KEY then
				PickupHelperdata = PickupHelper.GetDefaultPickupData()
				PickupHelperdata.DropSound = SoundEffect.SOUND_KEY_DROP0
				PickupHelperdata.CollectSound = SoundEffect.SOUND_KEYPICKUP_GAUNTLET
				if subType == KeySubType.KEY_NORMAL then
					PickupHelperdata.AddKeys = 1
					PickupHelperdata.CanKeyBumPickUp = true
				elseif subType == KeySubType.KEY_GOLDEN then
					PickupHelperdata.CollectSound = SoundEffect.SOUND_GOLDENKEY
					PickupHelperdata.AddGoldKey = true
				elseif subType == KeySubType.KEY_DOUBLEPACK then
					PickupHelperdata.AddKeys = 2
					PickupHelperdata.CanKeyBumPickUp = true
				elseif subType == KeySubType.KEY_CHARGED then
					PickupHelperdata.AddKeys = 1
					PickupHelperdata.CanKeyBumPickUp = true
					PickupHelperdata.FullCharge = true
				end
			elseif variant == PickupVariant.PICKUP_BOMB then
				PickupHelperdata = PickupHelper.GetDefaultPickupData()
				PickupHelperdata.DropSound = SoundEffect.SOUND_FETUS_LAND
				PickupHelperdata.CollectSound = SoundEffect.SOUND_FETUS_FEET
				if subType == BombSubType.BOMB_NORMAL then
					PickupHelperdata.AddBombs = 1
				elseif subType == BombSubType.BOMB_DOUBLEPACK then
					PickupHelperdata.AddBombs = 2
				elseif subType == BombSubType.BOMB_GOLDEN then
					PickupHelperdata.DropSound = SoundEffect.SOUND_GOLD_HEART_DROP
					PickupHelperdata.CollectSound = SoundEffect.SOUND_GOLDENBOMB
					PickupHelperdata.AddGoldBomb = true
				end
			elseif variant == PickupVariant.PICKUP_GRAB_BAG then
				PickupHelperdata = PickupHelper.GetDefaultPickupData()
				PickupHelperdata.DropSound = SoundEffect.SOUND_FETUS_JUMP
				PickupHelperdata.CollectSound = SoundEffect.SOUND_SHELLGAME
				PickupHelperdata.PlayerCollectChecks = false
				PickupHelperdata.PlayerCollectChecksFunction = function(pickup, player, canPlayerCollect)
					return true
				end
				PickupHelperdata.PlayerCollectFunction = function(pickup, player)
					for i=1, PickupHelper.GetRandomNumber(2, 3, pickup.InitSeed) do
						Isaac.Spawn(EntityType.ENTITY_PICKUP, 0, 1, pickup.Position, RandomVector() * 2, pickup)
					end
				end
			elseif variant == PickupVariant.PICKUP_LIL_BATTERY then
				PickupHelperdata = PickupHelper.GetDefaultPickupData()
				PickupHelperdata.DropSound = SoundEffect.SOUND_FETUS_JUMP
				PickupHelperdata.FullCharge = true
				PickupHelperdata.DoBatteryAchievement = true
			else
				if PickupHelperPickupData[variant] then
					if PickupHelperPickupData[variant][subType] then
						PickupHelperdata = PickupHelper.CopyTable(PickupHelperPickupData[variant][subType])
					end
				end
			end
			
			return PickupHelperdata
		end
		return nil
	end
	function PickupHelper.SetPickupData(variant, subType, PickupHelperdata)
		if type(variant) == "number" and type(subType) == "number" then
			if not PickupHelperPickupData[variant] then
				PickupHelperPickupData[variant] = {}
			end
			if not PickupHelperPickupData[variant][subType] then
				PickupHelperPickupData[variant][subType] = {}
			end
			
			PickupHelperPickupData[variant][subType] = PickupHelperdata
			PickupHelperdata = PickupHelper.CopyTable(PickupHelperPickupData[variant][subType])
			
			return PickupHelperdata
		end
		return nil
	end
	function PickupHelper.GetDefaultPickupData()
		local PickupHelperdata = PickupHelper.CopyTable(PickupHelperPickupDataDefault)
		return PickupHelperdata
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_EVALUATE_CACHE, function(_, player, cacheFlag)
		if cacheFlag == CacheFlag.CACHE_LUCK then
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
			player.Luck = player.Luck + PickupHelper.ModSave.Run.PickupLuck[currentPlayer]
		end
	end)
	local pickupRNG = PickupHelper.GetInitializedRNG()
	function PickupHelper.HandlePlayerTouchingCustomPickup(pickup, player)
		local toReturn = nil

		local variant = pickup.Variant
		local subType = pickup.SubType
		if PickupHelperPickupData[variant] and PickupHelperPickupData[variant][subType] then
			local PickupHelperdata = PickupHelperPickupData[variant][subType]
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
			
			local doingCharge = false
			local secondItem = player.SecondaryActiveItem
			local removeBattery = false
			if PickupHelperdata.OverCharge then
				if not player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY) then
					player:AddCollectible(CollectibleType.COLLECTIBLE_BATTERY, 0, false)
					removeBattery = true
				end
			end
			
			------------------
			--COLLECT CHECKS--
			------------------
			
			--PLAYER--
			local canPlayerCollect = false
			if PickupHelperdata.PlayerCollectChecks then
				--HEARTS--
				if (PickupHelperdata.AddMaxHearts and PickupHelperdata.AddMaxHearts > 0 and PickupHelper.CanPlayerPickMaxHearts(player))
				or (PickupHelperdata.AddHearts and PickupHelperdata.AddHearts > 0 and player:CanPickRedHearts())
				or (PickupHelperdata.AddEternalHearts and PickupHelperdata.AddEternalHearts > 0 and PickupHelper.CanPlayerPickEternalHearts(player))
				or (PickupHelperdata.AddSoulHearts and PickupHelperdata.AddSoulHearts > 0 and player:CanPickSoulHearts())
				or (PickupHelperdata.AddBlackHearts and PickupHelperdata.AddBlackHearts > 0 and player:CanPickBlackHearts())
				or (PickupHelperdata.AddGoldHearts and PickupHelperdata.AddGoldHearts > 0 and player:CanPickGoldenHearts())
				or (PickupHelperdata.AddBoneHearts and PickupHelperdata.AddBoneHearts > 0 and player:CanPickBoneHearts()) then
					canPlayerCollect = true
				end
				
				--COINS--
				if (PickupHelperdata.AddCoins and PickupHelperdata.AddCoins > 0)
				or (PickupHelperdata.AddLuck and PickupHelperdata.AddLuck ~= 0) then
					canPlayerCollect = true
				end
				
				--KEYS--
				if (PickupHelperdata.AddKeys and PickupHelperdata.AddKeys > 0)
				or (PickupHelperdata.AddGoldKey) then
					canPlayerCollect = true
				end
				
				--BOMBS--
				if (PickupHelperdata.AddBombs and PickupHelperdata.AddBombs > 0)
				or (PickupHelperdata.AddGoldBomb) then
					canPlayerCollect = true
				end
				
				--BATTERIES--
				if (PickupHelperdata.AddCharge and PickupHelperdata.AddCharge > 0 and player:NeedsCharge())
				or (PickupHelperdata.AddChargeRandomMax and PickupHelperdata.AddChargeRandomMax > 0 and player:NeedsCharge())
				or (PickupHelperdata.FullCharge and player:NeedsCharge()) then
					canPlayerCollect = true
					doingCharge = true
				end
			end
			
			if PickupHelperdata.PlayerCollectChecksFunction then
				local returned = PickupHelperdata.PlayerCollectChecksFunction(pickup, player, canPlayerCollect)
				if returned ~= nil then
					if returned then
						canPlayerCollect = true
					else
						canPlayerCollect = false
					end
				end
			end
			
			--THE JAR--
			local canJarCollect = false
			if PickupHelperdata.CanJarPickUp and player:GetActiveItem() == CollectibleType.COLLECTIBLE_THE_JAR then
				if PickupHelperdata.JarCollectChecks then
					if PickupHelperdata.AddHearts and PickupHelperdata.AddHearts > 0 and player:GetJarHearts() < 8 then
						canJarCollect = true
					end
				end
				
				if PickupHelperdata.JarCollectChecksFunction then
					local returned = PickupHelperdata.JarCollectChecksFunction(pickup, player, canJarCollect)
					if returned ~= nil then
						if returned then
							canJarCollect = true
						else
							canJarCollect = false
						end
					end
				end
			end
			
			------------------
			--PLAYER COLLECT--
			------------------
			if canPlayerCollect then
				--MC_PRE_PICKUP_COLLECTED
				if PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_PICKUP_COLLECTED] then
					for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_PICKUP_COLLECTED]) do
						if not callbackData.extraVariable or callbackData.extraVariable == variant then
							toReturn = callbackData.functionToCall(callbackData.modReference, pickup, player)
						end
					end
				end
				
				if toReturn ~= true then
					if PickupHelperdata.PlayerCollect then
						--HEARTS--
						if PickupHelperdata.ActAsBlendedHeart then
							local maxHeartsToAdd = 0
							if PickupHelperdata.AddMaxHearts and PickupHelperdata.AddMaxHearts > 0 then
								maxHeartsToAdd = PickupHelperdata.AddMaxHearts
							end
							local boneHeartsToAdd = 0
							if PickupHelperdata.AddBoneHearts and PickupHelperdata.AddBoneHearts > 0 then
								boneHeartsToAdd = PickupHelperdata.AddBoneHearts
							end
							local heartsToAdd = 0
							if PickupHelperdata.AddHearts and PickupHelperdata.AddHearts > 0 then
								heartsToAdd = PickupHelperdata.AddHearts
							end
							local soulHeartsToAdd = 0
							if PickupHelperdata.AddSoulHearts and PickupHelperdata.AddSoulHearts > 0 then
								soulHeartsToAdd = PickupHelperdata.AddSoulHearts
							end
							local blackHeartsToAdd = 0
							if PickupHelperdata.AddBlackHearts and PickupHelperdata.AddBlackHearts > 0 then
								blackHeartsToAdd = PickupHelperdata.AddBlackHearts
							end
							
							local maxHeartsCanAdd = 0
							local boneHeartsCanAdd = 0
							local heartsCanAdd = 0
							local soulHeartsCanAdd = 0
							local blackHeartsCanAdd = 0
							if heartsToAdd > 0 and (player:CanPickRedHearts() or PickupHelper.CanPlayerPickMaxHearts(player) or player:CanPickBoneHearts()) then
								local roomForMaxHearts = 0
								if maxHeartsToAdd > 0 and PickupHelper.CanPlayerPickMaxHearts(player) then
									roomForMaxHearts = PickupHelper.GetPlayerRoomForMaxHearts(player)
									if roomForMaxHearts > maxHeartsToAdd then
										roomForMaxHearts = maxHeartsToAdd
									end
								end
								local roomForBoneHearts = 0
								if boneHeartsToAdd > 0 and player:CanPickBoneHearts() then
									roomForBoneHearts = math.ceil((PickupHelper.GetPlayerRoomForMaxHearts(player) - roomForMaxHearts) * 0.5)
									if roomForBoneHearts > boneHeartsToAdd then
										roomForBoneHearts = boneHeartsToAdd
									end
								end
								local emptyHearts = PickupHelper.GetPlayerEmptyHearts(player)
								local roomForHearts = emptyHearts + roomForMaxHearts + (roomForBoneHearts * 2)
								if heartsToAdd >= emptyHearts then
									if heartsToAdd >= roomForHearts then
										heartsCanAdd = roomForHearts
										maxHeartsCanAdd = roomForMaxHearts
										boneHeartsCanAdd = roomForBoneHearts
									elseif roomForMaxHearts > 0 then
										maxHeartsCanAdd = heartsToAdd - emptyHearts
										heartsCanAdd = emptyHearts + maxHeartsCanAdd
									elseif roomForBoneHearts > 0 then
										boneHeartsCanAdd = heartsToAdd - emptyHearts
										heartsCanAdd = emptyHearts + boneHeartsCanAdd
										boneHeartsCanAdd = math.ceil(boneHeartsCanAdd * 0.5)
									else
										heartsCanAdd = emptyHearts
									end
								else
									heartsCanAdd = heartsToAdd
								end
								if maxHeartsCanAdd > 0 then
									maxHeartsCanAdd = math.ceil(maxHeartsCanAdd * 0.5) * 2
								end
							end
							if soulHeartsToAdd > 0 and player:CanPickSoulHearts() then
								local soulHeartsToAddAfterReds = soulHeartsToAdd
								if heartsCanAdd > 0 then
									soulHeartsToAddAfterReds = soulHeartsToAddAfterReds - heartsCanAdd
								end
								if soulHeartsToAddAfterReds > 0 then
									local roomForSoulHearts = PickupHelper.GetPlayerRoomForSoulHearts(player) - maxHeartsCanAdd - (boneHeartsCanAdd * 2)
									if soulHeartsToAddAfterReds >= roomForSoulHearts then
										soulHeartsCanAdd = roomForSoulHearts
									else
										soulHeartsCanAdd = soulHeartsToAddAfterReds
									end
								end
							end
							if blackHeartsToAdd > 0 and player:CanPickBlackHearts() then
								local blackHeartsToAddAfterReds = blackHeartsToAdd
								if heartsCanAdd > 0 then
									blackHeartsToAddAfterReds = blackHeartsToAddAfterReds - heartsCanAdd
								end
								if blackHeartsToAddAfterReds > 0 then
									blackHeartsCanAdd = blackHeartsToAddAfterReds
								end
								
								local blackHeartsToAddAfterSouls = blackHeartsCanAdd
								if soulHeartsCanAdd > 0 then
									blackHeartsToAddAfterSouls = blackHeartsToAddAfterSouls - soulHeartsCanAdd
									local soulHearts = player:GetSoulHearts()
									local evenSoulHeartsCheck = soulHearts + soulHeartsCanAdd
									if math.floor(evenSoulHeartsCheck * 0.5) * 2 ~= evenSoulHeartsCheck then
										soulHeartsCanAdd = soulHeartsCanAdd - 1
										blackHeartsToAddAfterSouls = blackHeartsToAddAfterSouls + 1
									end
								end
								
								blackHeartsCanAdd = blackHeartsToAddAfterSouls
							end
							
							local soundToPlay = nil
							if maxHeartsCanAdd > 0 then
								player:AddMaxHearts(maxHeartsCanAdd)
							end
							if boneHeartsCanAdd > 0 then
								player:AddBoneHearts(boneHeartsCanAdd)
								soundToPlay = SoundEffect.SOUND_BONE_HEART
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(soundToPlay, 1, 0, false, 1.0)
								end
							end
							if heartsCanAdd > 0 then
								player:AddHearts(heartsCanAdd)
								soundToPlay = SoundEffect.SOUND_BOSS2_BUBBLES
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(soundToPlay, 1, 0, false, 1.0)
								end
							end
							if soulHeartsCanAdd > 0 then
								player:AddSoulHearts(soulHeartsCanAdd)
								soundToPlay = SoundEffect.SOUND_HOLY
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(soundToPlay, 1, 0, false, 1.0)
								end
							end
							if blackHeartsCanAdd > 0 then
								player:AddBlackHearts(blackHeartsCanAdd)
								soundToPlay = SoundEffect.SOUND_UNHOLY
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(soundToPlay, 1, 0, false, 1.0)
								end
							end
							
							if soundToPlay then
								if PickupHelperdata.PlayBlendedHeartSounds then
									PickupHelper.SFX:Play(soundToPlay, 1, 0, false, 1.0)
								end
							end
						else
							if PickupHelperdata.AddMaxHearts and PickupHelperdata.AddMaxHearts > 0 then
								player:AddMaxHearts(math.ceil(PickupHelperdata.AddMaxHearts * 0.5) * 2)
							end
							if PickupHelperdata.AddBoneHearts and PickupHelperdata.AddBoneHearts > 0 then
								player:AddBoneHearts(PickupHelperdata.AddBoneHearts)
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(SoundEffect.SOUND_BONE_HEART, 1, 0, false, 1.0)
								end
							end
							if PickupHelperdata.AddHearts and PickupHelperdata.AddHearts > 0 then
								local heartsToAdd = PickupHelperdata.AddHearts
								if PickupHelperdata.CanAddMaggysBowHearts and player:HasCollectible(CollectibleType.COLLECTIBLE_MAGGYS_BOW) then
									heartsToAdd = heartsToAdd * 2
								end
								player:AddHearts(heartsToAdd)
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false, 1.0)
								end
							end
							if PickupHelperdata.AddSoulHearts and PickupHelperdata.AddSoulHearts > 0 then
								player:AddSoulHearts(PickupHelperdata.AddSoulHearts)
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(SoundEffect.SOUND_HOLY, 1, 0, false, 1.0)
								end
							end
							if PickupHelperdata.AddBlackHearts and PickupHelperdata.AddBlackHearts > 0 then
								player:AddBlackHearts(PickupHelperdata.AddBlackHearts)
								if PickupHelperdata.PlayAllHeartSounds then
									PickupHelper.SFX:Play(SoundEffect.SOUND_UNHOLY, 1, 0, false, 1.0)
								end
							end
						end
						
						if PickupHelperdata.AddEternalHearts and PickupHelperdata.AddEternalHearts > 0 and PickupHelper.CanPlayerPickEternalHearts(player) then
							player:AddEternalHearts(PickupHelperdata.AddEternalHearts)
							if PickupHelperdata.PlayAllHeartSounds or PickupHelperdata.PlayBlendedHeartSounds then
								PickupHelper.SFX:Play(SoundEffect.SOUND_SUPERHOLY, 1, 0, false, 1.0)
							end
						end
						if PickupHelperdata.AddGoldHearts and PickupHelperdata.AddGoldHearts > 0 and PickupHelper.CanPickGoldenHearts(player) then
							player:AddGoldenHearts(PickupHelperdata.AddGoldHearts)
							if PickupHelperdata.PlayAllHeartSounds or PickupHelperdata.PlayBlendedHeartSounds then
								PickupHelper.SFX:Play(SoundEffect.SOUND_GOLD_HEART, 1, 0, false, 1.0)
							end
						end
						
						--COINS--
						if PickupHelperdata.AddCoins and PickupHelperdata.AddCoins > 0 then
							player:AddCoins(PickupHelperdata.AddCoins)
							if PickupHelperdata.CanDoPennyTrinketEffects then
								if player:HasTrinket(TrinketType.TRINKET_BUTT_PENNY) then
									player:UseActiveItem(CollectibleType.COLLECTIBLE_BUTTER_BEAN, false, false, false, false)
								end
								if player:HasTrinket(TrinketType.TRINKET_BLOODY_PENNY) then
									if PickupHelper.GetRandomNumber(1, 2, pickupRNG) == 1 then
										Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF, PickupHelper.Room:FindFreePickupSpawnPosition(pickup.Position, 0, true), Vector.Zero, pickup)
									end
								end
								if player:HasTrinket(TrinketType.TRINKET_BURNT_PENNY) then
									if PickupHelper.GetRandomNumber(1, 2, pickupRNG) == 1 then
										Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, PickupHelper.Room:FindFreePickupSpawnPosition(pickup.Position, 0, true), Vector.Zero, pickup)
									end
								end
								if player:HasTrinket(TrinketType.TRINKET_FLAT_PENNY) then
									if PickupHelper.GetRandomNumber(1, 2, pickupRNG) == 1 then
										Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL, PickupHelper.Room:FindFreePickupSpawnPosition(pickup.Position, 0, true), Vector.Zero, pickup)
									end
								end
								if player:HasTrinket(TrinketType.TRINKET_COUNTERFEIT_PENNY) then
									if PickupHelper.GetRandomNumber(1, 2, pickupRNG) == 1 then
										player:AddCoins(1)
									end
								end
								if player:HasTrinket(TrinketType.TRINKET_ROTTEN_PENNY) then
									player:AddBlueFlies(1, pickup.Position, player)
								end
							end
						end
						if PickupHelperdata.AddLuck and PickupHelperdata.AddLuck ~= 0 then
							PickupHelper.ModSave.Run.PickupLuck[currentPlayer] = PickupHelper.ModSave.Run.PickupLuck[currentPlayer] + PickupHelperdata.AddLuck
							player:AddCacheFlags(CacheFlag.CACHE_LUCK)
							player:EvaluateItems()
							if PickupHelperdata.AddLuck > 0 then
								PickupHelper.Streak("Luck Up")
								player:AnimateHappy()
							else
								PickupHelper.Streak("Luck Down")
								player:AnimateSad()
							end
						end
						
						--KEYS--
						if PickupHelperdata.AddKeys and PickupHelperdata.AddKeys > 0 then
							player:AddKeys(PickupHelperdata.AddKeys)
						end
						if PickupHelperdata.AddGoldKey then
							player:AddGoldenKey()
						end
						
						--BOMBS--
						if PickupHelperdata.AddBombs and PickupHelperdata.AddBombs > 0 then
							player:AddBombs(PickupHelperdata.AddBombs)
						end
						if PickupHelperdata.AddGoldBomb then
							player:AddGoldenBomb()
						end
						
						--BATTERIES
						if player:NeedsCharge() then
							local maxCharge = PickupHelper.ItemConfig:GetCollectible(player:GetActiveItem()).MaxCharges
							
							if PickupHelperdata.FullCharge and not PickupHelperdata.DoNotFullCharge12Charge or (PickupHelperdata.FullCharge and PickupHelperdata.DoNotFullCharge12Charge and maxCharge <= 6) then
								player:FullCharge()
							else
								local chargeToAdd = 0
								if PickupHelperdata.FullCharge and PickupHelperdata.DoNotFullCharge12Charge and maxCharge > 6 then
									chargeToAdd = 3
								else
									if PickupHelperdata.AddCharge and PickupHelperdata.AddCharge > 0 then
										chargeToAdd = PickupHelperdata.AddCharge
									end
									if PickupHelperdata.AddChargeRandomMax and PickupHelperdata.AddChargeRandomMax > 0 then
										chargeToAdd = PickupHelper.GetRandomNumber(PickupHelperdata.AddCharge, PickupHelperdata.AddChargeRandomMax, pickup.InitSeed)
									end
								end
								if chargeToAdd > 0 then
									if player:HasTimedItem() then
										player:FullCharge()
										if chargeToAdd > 1 then
											player:FullCharge()
										end
									else
										local currentCharge = player:GetActiveCharge()
										player:SetActiveCharge(currentCharge + chargeToAdd)
									end
									
									if PickupHelperdata.OverCharge then
										PickupHelper.SFX:Play(SoundEffect.SOUND_THUMBSUP, 0.5, 0, false, 1.0)
									end
								end
							end
						end
						
						if PickupHelperdata.DoBatteryAchievement then
							PickupHelper.ModSave.BatteriesPickedUp = PickupHelper.ModSave.BatteriesPickedUp + 1
							if PickupHelper.ModSave.BatteriesPickedUp >= 20 and not PickupHelper.ModSave.Unlocks.Hairpin then
								PickupHelper.ModSave.Unlocks.Hairpin = true
								Isaac.ExecuteCommand("achievement 358")
								PickupHelper.Save()
							end
						end
					end
					
					--COLLECTED--
					if PickupHelperdata.CollectSound then
						PickupHelper.SFX:Play(PickupHelperdata.CollectSound, 1, 0, false, 1.0)
					end
					
					local doCollect = true
					if PickupHelperdata.PlayerCollectFunction then
						if PickupHelperdata.PlayerCollectFunction(pickup, player) == false then
							doCollect = false
						end
					end
					
					if doCollect then
						if pickup:Exists() then
							pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
							pickup.Velocity = Vector.Zero
							PickupHelper.CollectPickup(pickup, player)
							
							--MC_POST_PICKUP_COLLECTED
							if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PICKUP_COLLECTED] then
								for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PICKUP_COLLECTED]) do
									if not callbackData.extraVariable or callbackData.extraVariable == variant then
										callbackData.functionToCall(callbackData.modReference, pickup, player)
									end
								end
							end
							
							toReturn = true
						end
					end
					
					if removeBattery then
						player:RemoveCollectible(CollectibleType.COLLECTIBLE_BATTERY)
					end
					if doingCharge then
						player.SecondaryActiveItem = secondItem
					end
				end
				
			---------------
			--JAR COLLECT--
			---------------
			elseif canJarCollect then
				--MC_PRE_PICKUP_COLLECTED
				if PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_PICKUP_COLLECTED] then
					for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_PICKUP_COLLECTED]) do
						if not callbackData.extraVariable or callbackData.extraVariable == variant then
							toReturn = callbackData.functionToCall(callbackData.modReference, pickup, player)
						end
					end
				end
				
				if toReturn ~= true then
					if PickupHelperdata.JarCollect then
						--HEARTS--
						if PickupHelperdata.AddHearts and PickupHelperdata.AddHearts > 0 then
							local heartsToAdd = PickupHelperdata.AddHearts
							if PickupHelperdata.CanAddMaggysBowHearts and player:HasCollectible(CollectibleType.COLLECTIBLE_MAGGYS_BOW) then
								heartsToAdd = heartsToAdd * 2
							end
							player:AddJarHearts(heartsToAdd)
						end
					end
					
					--COLLECTED--
					if PickupHelperdata.CollectSound then
						PickupHelper.SFX:Play(PickupHelperdata.CollectSound, 1, 0, false, 1.0)
					end
					
					local doCollect = true
					if PickupHelperdata.JarCollectFunction then
						if PickupHelperdata.JarCollectFunction(pickup, player) == false then
							doCollect = false
						end
					end
					
					if doCollect then
						if pickup:Exists() then
							pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
							pickup.Velocity = Vector.Zero
							PickupHelper.CollectPickup(pickup, player)
							
							--MC_POST_PICKUP_COLLECTED
							if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PICKUP_COLLECTED] then
								for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PICKUP_COLLECTED]) do
									if not callbackData.extraVariable or callbackData.extraVariable == variant then
										callbackData.functionToCall(callbackData.modReference, pickup, player)
									end
								end
							end
							
							toReturn = true
						end
					end
				end
			end
		end
		
		if toReturn ~= nil then
			return toReturn
		end
	end
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_GAME_STARTED, function(_, isSaveGame)
		for _, player in pairs(PickupHelper.GetPlayers()) do
			local currentPlayer = PickupHelper.GetCurrentPlayer(player)
			if PickupHelper.OldSave.Run.PickupLuck[currentPlayer] ~= 0 then
				player:AddCacheFlags(CacheFlag.CACHE_LUCK)
				player:EvaluateItems()
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_PRE_PICKUP_COLLISION, function(_, pickup, collider, low)
		local toReturn = nil
		if collider and collider.Type == EntityType.ENTITY_PLAYER and collider:ToPlayer() then
			local player = collider:ToPlayer()
			local sprite = pickup:GetSprite()
			local variant = pickup.Variant
			local subType = pickup.SubType
			
			if PickupHelperPickupData[variant] and PickupHelperPickupData[variant][subType] then
				local data = PickupHelper.GetData(pickup)
				if sprite:IsEventTriggered("DropSound") or sprite:IsPlaying("Idle") then
					data.CanBePickedUp = true
				end
				if sprite:IsPlaying("Appear") or sprite:IsPlaying("Collect") then
					data.CanBePickedUp = false
				end
				
				if sprite:IsPlaying("Collect") then
					pickup.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
					pickup.Velocity = Vector.Zero
					return false
				end
				
				local allowShopItem = true
				local isShopItem = pickup:IsShopItem()
				local price = 0
				if isShopItem then
					price = pickup.Price
				end
				
				if isShopItem and player:GetNumCoins() < price then
					allowShopItem = false
				end
				
				if PickupHelper.IsPickupPickupable(pickup, allowShopItem) then
					toReturn = PickupHelper.HandlePlayerTouchingCustomPickup(pickup, player)
				end
			elseif not sprite:IsPlaying("Collect") and pickup:Exists() then
				PickupHelper.DelayFunction(function(pickup, player)
					if not pickup:Exists() or pickup:GetSprite():IsPlaying("Collect") then
						local toReturn = nil
						
						--MC_PRE_PICKUP_COLLECTED
						if PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_PICKUP_COLLECTED] then
							for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_PRE_PICKUP_COLLECTED]) do
								if not callbackData.extraVariable or callbackData.extraVariable == variant then
									toReturn = callbackData.functionToCall(callbackData.modReference, pickup, player)
								end
							end
						end
						
						if toReturn ~= true then
							--MC_POST_PICKUP_COLLECTED
							if PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PICKUP_COLLECTED] then
								for _, callbackData in ipairs(PickupHelperCallbackData[PickupHelperCallbacks.MC_POST_PICKUP_COLLECTED]) do
									if not callbackData.extraVariable or callbackData.extraVariable == variant then
										callbackData.functionToCall(callbackData.modReference, pickup, player)
									end
								end
							end
						end
					end
				end, 1, {pickup, player}, false, true)
			end
		end
		
		if toReturn ~= nil then
			return toReturn
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, pickup)
		local variant = pickup.Variant
		local subType = pickup.SubType
		if PickupHelperPickupData[variant] and PickupHelperPickupData[variant][subType] then
			local PickupHelperdata = PickupHelperPickupData[variant][subType]
			
			local sprite = pickup:GetSprite()
			local data = PickupHelper.GetData(pickup)
			if sprite:IsEventTriggered("DropSound") or sprite:IsPlaying("Idle") then
				data.CanBePickedUp = true
			end
			if sprite:IsPlaying("Appear") or sprite:IsPlaying("Collect") then
				data.CanBePickedUp = false
			end
			
			----------------
			--KEEPER FLIES--
			----------------
			if PlayerManager.AnyoneIsPlayerType(PlayerType.PLAYER_KEEPER) and PickupHelperdata.AddFliesAsKeeper and PickupHelperdata.AddFliesAsKeeper > 0 then
				local keeperPlayer = PlayerManager.FirstPlayerByType(PlayerType.PLAYER_KEEPER)
				pickup:Remove()
				keeperPlayer:AddBlueFlies(PickupHelperdata.AddFliesAsKeeper, pickup.Position, keeperPlayer)
			end
			
			----------------
			--SECRET ROOMS--
			----------------
			local roomType = PickupHelper.Room:GetType()
			if roomType == RoomType.ROOM_SUPERSECRET then
				local roomDescriptor = PickupHelper.Level:GetCurrentRoomDesc()
				local roomConfigRoom = roomDescriptor.Data
				if not PickupHelper.Game:IsGreedMode() then
					if PickupHelperdata.ReplaceInRedHeartSuperSecretRoom and roomConfigRoom.Variant == 0 then
						pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_FULL, true)
					end
					if PickupHelperdata.ReplaceInEternalHeartSuperSecretRoom and (roomConfigRoom.Variant == 1 or roomConfigRoom.Variant == 16) then
						pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ETERNAL, true)
					end
					if PickupHelperdata.ReplaceInBlackHeartSuperSecretRoom and (roomConfigRoom.Variant == 6 or roomConfigRoom.Variant == 13) then
						pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, true)
					end
					if PickupHelperdata.ReplaceInSoulHeartSuperSecretRoom and roomConfigRoom.Variant == 12 then
						pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, true)
					end
					if PickupHelperdata.ReplaceInRottenHeartSuperSecretRoom and roomConfigRoom.Variant == 23 then
						pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ROTTEN, true)
					end
				end
			end

			--------
			--DROP--
			--------
			if sprite:IsEventTriggered("DropSound") then
				if PickupHelperdata.DropSound then
					PickupHelper.SFX:Play(PickupHelperdata.DropSound, 1, 0, false, 1.0)
				end
				if PickupHelperdata.OnDropFunction then
					PickupHelperdata.OnDropFunction(pickup)
				end
			end
			
			if sprite:IsPlaying("Collect") then
				pickup.Velocity = Vector.Zero
			end
			
			local touchingPlayer = PickupHelper.GetPlayerTouchingPickup(pickup, false, nil, true)
			if touchingPlayer then
				PickupHelper.HandlePlayerTouchingCustomPickup(pickup, touchingPlayer)
			end
		end
	end)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_POST_NEW_ROOM, function()
		for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, -1, -1, false, false)) do
			local sprite = pickup:GetSprite()
			local data = PickupHelper.GetData(pickup)
			if not sprite:IsPlaying("Appear") then
				data.CanBePickedUp = true
			end
		end
	end)
	
	function PickupHelper.BumUpdate(_, familiar, takesCoins, takesHearts, takesKeys)
		local goTo = nil
		for _, pickup in pairs(Isaac.FindInRadius(familiar.Position, 188, EntityPartition.PICKUP)) do
			if pickup:ToPickup() then
				pickup = pickup:ToPickup()

				local pickupVariant = pickup.Variant
				local pickupSubType = pickup.SubType

				local coinCheck = pickupVariant ~= PickupVariant.PICKUP_COIN or (pickupVariant == PickupVariant.PICKUP_COIN and pickupSubType ~= CoinSubType.COIN_PENNY and pickupSubType ~= CoinSubType.COIN_NICKEL and pickupSubType ~= CoinSubType.COIN_DIME and pickupSubType ~= CoinSubType.COIN_DOUBLEPACK and pickupSubType ~= CoinSubType.COIN_LUCKYPENNY)
				local heartCheck = pickupVariant ~= PickupVariant.PICKUP_HEART or (pickupVariant == PickupVariant.PICKUP_HEART and pickupSubType ~= HeartSubType.HEART_FULL and pickupSubType ~= HeartSubType.HEART_HALF and pickupSubType ~= HeartSubType.HEART_DOUBLEPACK and pickupSubType ~= HeartSubType.HEART_SCARED)
				local keyCheck = pickupVariant ~= PickupVariant.PICKUP_KEY or (pickupVariant == PickupVariant.PICKUP_KEY and pickupSubType ~= KeySubType.KEY_NORMAL and pickupSubType ~= KeySubType.KEY_DOUBLEPACK and pickupSubType ~= KeySubType.KEY_CHARGED)

				if ((takesCoins and coinCheck) or (takesHearts and heartCheck) or (takesKeys and keyCheck)) and not pickup:IsShopItem() then
					if PickupHelperPickupData[pickupVariant] then
						if PickupHelperPickupData[pickupVariant][pickupSubType] then
							local PickupHelperdata = PickupHelperPickupData[pickupVariant][pickupSubType]
							if (takesCoins and PickupHelperdata.CanBumFriendPickUp) or (takesHearts and PickupHelperdata.CanDarkBumPickUp) or (takesKeys and PickupHelperdata.CanKeyBumPickUp) then
								if PickupHelper.IsPickupPickupable(pickup, false) then
									if not goTo or (goTo and familiar.Position:Distance(pickup.Position) < familiar.Position:Distance(goTo.Position)) then
										goTo = pickup
									end
								end
							end
						end
					end
				else
					goTo = nil
				end
			end
		end

		if goTo then
			familiar:FollowPosition(goTo.Position)
			familiar.Velocity = familiar.Velocity:Normalized() * 5
			if familiar.Position:Distance(goTo.Position) <= 15 then
				local goToVariant = goTo.Variant
				local goToSubType = goTo.SubType
				if PickupHelperPickupData[goToVariant] then
					if PickupHelperPickupData[goToVariant][goToSubType] then
						local PickupHelperdata = PickupHelperPickupData[goToVariant][goToSubType]

						local canBumCollect = false
						if takesCoins and PickupHelperdata.BumFriendCollectChecks then
							if PickupHelperdata.AddCoins and PickupHelperdata.AddCoins > 0 then
								canBumCollect = true
							end
						end
						if takesHearts and PickupHelperdata.DarkBumCollectChecks then
							if PickupHelperdata.AddHearts and PickupHelperdata.AddHearts > 0 then
								canBumCollect = true
							end
						end
						if takesKeys and PickupHelperdata.KeyBumCollectChecks then
							if PickupHelperdata.AddKeys and PickupHelperdata.AddKeys > 0 then
								canBumCollect = true
							end
						end

						if PickupHelperdata.DarkBumCollectChecksFunction then
							if takesCoins then
								canBumCollect = PickupHelperdata.BumFriendCollectChecksFunction(goTo, familiar, canBumCollect)
							end
							if takesHearts then
								canBumCollect = PickupHelperdata.DarkBumCollectChecksFunction(goTo, familiar, canBumCollect)
							end
							if takesKeys then
								canBumCollect = PickupHelperdata.KeyBumCollectChecksFunction(goTo, familiar, canBumCollect)
							end
						end

						if canBumCollect then
							if takesCoins and PickupHelperdata.BumFriendCollect then
								if PickupHelperdata.AddCoins and PickupHelperdata.AddCoins > 0 then
									familiar:AddCoins(PickupHelperdata.AddCoins)
								end
							end
							if takesHearts and PickupHelperdata.DarkBumCollect then
								if PickupHelperdata.AddHearts and PickupHelperdata.AddHearts > 0 then
									familiar:AddHearts(PickupHelperdata.AddHearts)
								end
							end
							if takesKeys and PickupHelperdata.KeyBumCollect then
								if PickupHelperdata.AddKeys and PickupHelperdata.AddKeys > 0 then
									familiar:AddKeys(PickupHelperdata.AddKeys)
								end
							end

							if PickupHelperdata.CollectSound then
								PickupHelper.SFX:Play(PickupHelperdata.CollectSound, 1, 0, false, 1.0)
							end

							local doCollect = true
							if takesCoins and PickupHelperdata.BumFriendCollectFunction then
								if PickupHelperdata.BumFriendCollectFunction(goTo, familiar) == false then
									doCollect = false
								end
							end
							if takesHearts and PickupHelperdata.DarkBumCollectFunction then
								if PickupHelperdata.DarkBumCollectFunction(goTo, familiar) == false then
									doCollect = false
								end
							end
							if takesKeys and PickupHelperdata.KeyBumCollectFunction then
								if PickupHelperdata.KeyBumCollectFunction(goTo, familiar) == false then
									doCollect = false
								end
							end

							if doCollect then
								if goTo:Exists() then
									PickupHelper.CollectPickup(goTo)
								end
							end
						end
					end
				end
			end
		end
	end
	--_, familiar, takesCoins, takesHearts, takesKeys
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_FAMILIAR_UPDATE, function(_,familiar)
		PickupHelper.BumUpdate(_, familiar, true, false, false)
	end, FamiliarVariant.BUM_FRIEND)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_FAMILIAR_UPDATE, function(_,familiar)
		PickupHelper.BumUpdate(_, familiar, false, true, false)
	end, FamiliarVariant.DARK_BUM)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_FAMILIAR_UPDATE, function(_,familiar)
		PickupHelper.BumUpdate(_, familiar, false, false, true)
	end, FamiliarVariant.KEY_BUM)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_FAMILIAR_UPDATE, function(_,familiar)
		PickupHelper.BumUpdate(_, familiar, true, true, true)
	end, FamiliarVariant.SUPER_BUM)
	PickupHelper.AddCustomCallback(PickupHelper, ModCallbacks.MC_FAMILIAR_UPDATE, function(_,familiar)
		PickupHelper.BumUpdate(_, familiar, true, false, false)
	end, FamiliarVariant.BUMBO)

end
