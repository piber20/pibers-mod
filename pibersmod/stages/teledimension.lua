local mod = PibersMod

mod.TeleportingToMausAlt = false
function mod.OnNewRoomTeleDimension()

	local game = Game()
	local room = game:GetRoom()
	local level = game:GetLevel()
	local stage = level:GetStage()

	if mod.TeleportingToMausAlt then
		for i=0, room:GetGridSize() do
			local gridEntity = room:GetGridEntity(i)
			if gridEntity then
				if gridEntity:GetType() == GridEntityType.GRID_TELEPORTER then
					if gridEntity.State == mod.TeleportingToMausAlt then
						for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
							player.Position = gridEntity.Position
						end
						break
					end
				end
			end
		end
		mod.TeleportingToMausAlt = false
	end

	if stage == LevelStage.STAGE3_2 then
		local stageType = level:GetStageType()
		if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
			local dimension = level:GetDimension()
			if dimension == Dimension.MIRROR then
				local backdropType = room:GetBackdropType()
				if backdropType == BackdropType.MAUSOLEUM or backdropType == BackdropType.MAUSOLEUM2 or backdropType == BackdropType.MAUSOLEUM4 then
					room:SetBackdropType(BackdropType.MAUSOLEUM3, 1)
				end
				for doorSlot=0, DoorSlot.NUM_DOOR_SLOTS-1 do
					local door = room:GetDoor(doorSlot)
					if door then
						local doorSprite = door:GetSprite()
						if string.lower(doorSprite:GetFilename()) == "gfx/grid/door_02_treasureroomdoor.anm2" then
							for layer=0,4 do
								doorSprite:ReplaceSpritesheet(layer, "gfx/grid/door_02_treasureroomdoor_mom.png")
							end
							doorSprite:LoadGraphics()
						end
					end
				end
			end
			if MinimapAPI then
				local rooms = level:GetRooms()
				for i=0, rooms.Size-1 do
					local roomDesc = rooms:Get(i)
					local floorSaveNoRevert = mod.SaveManager.GetFloorSave(nil, true)
					if roomDesc:GetDimension() == dimension then
						local minimapRoom = MinimapAPI:GetRoomByIdx(roomDesc.GridIndex)
						if minimapRoom then
							if stageType == StageType.STAGETYPE_REPENTANCE_B and (roomDesc.Data.Type == RoomType.ROOM_TELEPORTER or roomDesc.Data.Type == RoomType.ROOM_TELEPORTER_EXIT) then
								minimapRoom.PermanentIcons = {"TeleporterRoomRed"}
							end
							if dimension == Dimension.NORMAL then
								if floorSaveNoRevert["TeleDimensionEntrance"] and roomDesc.GridIndex == floorSaveNoRevert["TeleDimensionEntrance"] then
									if stageType == StageType.STAGETYPE_REPENTANCE_B then
										minimapRoom.PermanentIcons = {"TeleporterRoom1Red"}
									else
										minimapRoom.PermanentIcons = {"TeleporterRoom1"}
									end
								end
							elseif dimension == Dimension.MIRROR then
								if floorSaveNoRevert["TeleDimension1Start"] and roomDesc.GridIndex == floorSaveNoRevert["TeleDimension1Start"] then
									if stageType == StageType.STAGETYPE_REPENTANCE_B then
										minimapRoom.PermanentIcons = {"TeleporterRoom1Red"}
									else
										minimapRoom.PermanentIcons = {"TeleporterRoom1"}
									end
								end
								if (floorSaveNoRevert["TeleDimension1End"] and roomDesc.GridIndex == floorSaveNoRevert["TeleDimension1End"])
								or (floorSaveNoRevert["TeleDimension2Start"] and roomDesc.GridIndex == floorSaveNoRevert["TeleDimension2Start"]) then
									if stageType == StageType.STAGETYPE_REPENTANCE_B then
										minimapRoom.PermanentIcons = {"TeleporterRoom2Red"}
									else
										minimapRoom.PermanentIcons = {"TeleporterRoom2"}
									end
								end
								if (floorSaveNoRevert["TeleDimension2End"] and roomDesc.GridIndex == floorSaveNoRevert["TeleDimension2End"])
								or (floorSaveNoRevert["TeleDimension3Start"] and roomDesc.GridIndex == floorSaveNoRevert["TeleDimension3Start"]) then
									if stageType == StageType.STAGETYPE_REPENTANCE_B then
										minimapRoom.PermanentIcons = {"TeleporterRoom3Red"}
									else
										minimapRoom.PermanentIcons = {"TeleporterRoom3"}
									end
								end
								if floorSaveNoRevert["TeleDimension3End"] and roomDesc.GridIndex == floorSaveNoRevert["TeleDimension3End"] then
									minimapRoom.NoUpdate = true
									minimapRoom.PermanentIcons = {"MomTreasureRoom"}
									if roomDesc.VisitedCount > 0 then
										minimapRoom.Visited = true
									else
										minimapRoom.Visited = false
									end
									if roomDesc.ClearCount > 0 or roomDesc.Clear then
										minimapRoom.Clear = true
									else
										minimapRoom.Clear = false
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomTeleDimension)

mod.AddedFakeKnifePiece = false
function mod.OnNewLevelTeleDimension()
	local game = Game()
	local isGreed = game:IsGreedMode()
	if not isGreed then
		if mod.AddedFakeKnifePiece then
			for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
				player:RemoveCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
			end
			mod.AddedFakeKnifePiece = false
		end
		local level = game:GetLevel()
		local stage = level:GetAbsoluteStage()
		if stage == LevelStage.STAGE3_2 then
			local stageType = level:GetStageType()
			local isAscent = level:IsAscent()
			if (stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B) and not isAscent then
				local floorSaveNoRevert = mod.SaveManager.GetFloorSave(nil, true)
				local teleRNG = RNG(level:GetDungeonPlacementSeed())
				local teleporterRoomDesc = mod.TryForcePlaceRandomRoom(RoomType.ROOM_TELEPORTER, -1, -1, Dimension.NORMAL, teleRNG)
				if teleporterRoomDesc then
					local teleporterRoomGrid = teleporterRoomDesc.GridIndex
					floorSaveNoRevert["TeleDimensionEntrance"] = teleporterRoomGrid
					local stbType = Isaac.GetCurrentStageConfigId()
					if MinimapAPI then
						MinimapAPI:LoadDefaultMap()
						MinimapAPI:updatePlayerPos()
						MinimapAPI:UpdateExternalMap()
						local minimapRoom = MinimapAPI:GetRoomByIdx(teleporterRoomGrid)
						if minimapRoom then
							if stageType == StageType.STAGETYPE_REPENTANCE_B then
								minimapRoom.PermanentIcons = {"TeleporterRoom1Red"}
							else
								minimapRoom.PermanentIcons = {"TeleporterRoom1"}
							end
						end
					end

					local teleporterRoomDescExit = mod.TryForcePlaceRandomRoom(RoomType.ROOM_TELEPORTER_EXIT, RoomShape.ROOMSHAPE_1x1, -1, Dimension.MIRROR, teleRNG, -2)
					if teleporterRoomDescExit then
						local teleporterRoomGridExit = teleporterRoomDescExit.GridIndex
						floorSaveNoRevert["TeleDimension1Start"] = teleporterRoomGridExit
						local placedTeles = {teleporterRoomGridExit}
						local extrateleAttempts = 0
						while extrateleAttempts < 20 and #placedTeles < 3 do
							local extrateleRoomDesc = mod.TryForcePlaceRandomRoom(RoomType.ROOM_TELEPORTER_EXIT, RoomShape.ROOMSHAPE_1x1, -1, Dimension.MIRROR, teleRNG, -2, -1, -1, false, placedTeles, 5, 3)
							if extrateleRoomDesc then
								placedTeles[#placedTeles+1] = extrateleRoomDesc.GridIndex
								floorSaveNoRevert["TeleDimension" .. #placedTeles .. "Start"] = extrateleRoomDesc.GridIndex
							end
						end
						for numTele, homeTele in ipairs(placedTeles) do
							local avoidTeles = {}
							for _, otherTele in ipairs(placedTeles) do
								if homeTele ~= otherTele then
									avoidTeles[#avoidTeles+1] = otherTele
								end
							end
							local numRooms = teleRNG:RandomInt(1, 3)
							for i=0, numRooms do
								mod.TryForcePlaceRandomRoom(-1, RoomShape.ROOMSHAPE_1x1, -1, Dimension.MIRROR, teleRNG, nil, 10, 15, true, avoidTeles, 5, 3)
							end

							if numTele == #placedTeles then
								local momroomDesc = mod.TryForcePlaceRandomRoom(RoomType.ROOM_TREASURE, RoomShape.ROOMSHAPE_1x1, 330, Dimension.MIRROR, teleRNG, nil, -1, -1, false, avoidTeles, 5, 3)
								if momroomDesc then
									floorSaveNoRevert["TeleDimension" .. numTele .. "End"] = momroomDesc.GridIndex
								end
							else
								local newTeleDesc = mod.TryForcePlaceRandomRoom(RoomType.ROOM_TELEPORTER_EXIT, RoomShape.ROOMSHAPE_1x1, -1, Dimension.MIRROR, teleRNG, nil, -1, -1, false, avoidTeles, 5, 3)
								if newTeleDesc then
									floorSaveNoRevert["TeleDimension" .. numTele .. "End"] = newTeleDesc.GridIndex
								end
							end
						end

						if teleRNG:RandomFloat() < (level:GetPlanetariumChance()*2) then
							mod.TryForcePlaceRandomRoom(RoomType.ROOM_PLANETARIUM, RoomShape.ROOMSHAPE_1x1, -1, Dimension.MIRROR, teleRNG, nil, -1, -1, false, nil, 5, 3)
						end

						local doRare = teleRNG:RandomInt(1, 20)
						if doRare == 1 then
							local specialRoomRare = teleRNG:RandomInt(1, 4)
							if specialRoomRare == 1 then
								specialRoomRare = RoomType.ROOM_ISAACS
							elseif specialRoomRare == 2 then
								specialRoomRare = RoomType.ROOM_BARREN
							elseif specialRoomRare == 3 then
								specialRoomRare = RoomType.ROOM_CHEST
							elseif specialRoomRare == 4 then
								specialRoomRare = RoomType.ROOM_DICE
							end
							mod.TryForcePlaceRandomRoom(specialRoomRare, RoomShape.ROOMSHAPE_1x1, -1, Dimension.MIRROR, teleRNG, nil, -1, -1, false, nil, 5, 3)
						end

						local specialRoom = teleRNG:RandomInt(1, 4)
						if specialRoom == 1 then
							specialRoom = RoomType.ROOM_SHOP
						elseif specialRoom == 2 then
							specialRoom = RoomType.ROOM_ARCADE
						elseif specialRoom == 3 then
							specialRoom = RoomType.ROOM_CURSE
						elseif specialRoom == 4 then
							specialRoom = RoomType.ROOM_LIBRARY
						end
						mod.TryForcePlaceRandomRoom(specialRoom, RoomShape.ROOMSHAPE_1x1, -1, Dimension.MIRROR, teleRNG, nil, -1, -1, false, nil, 5, 3)
					end
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.OnNewLevelTeleDimension)

function mod.PreTeleporterUpdate(grident)
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE3_2 then
		local stageType = level:GetStageType()
		if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
			local game = Game()
			local room = game:GetRoom()
			local roomType = room:GetType()
			if roomType == RoomType.ROOM_TELEPORTER or roomType == RoomType.ROOM_TELEPORTER_EXIT then
				local player = game:GetNearestPlayer(grident.Position)
				local doTele = false
				if room:GetGridIndex(player.Position) == grident:GetGridIndex() then
					doTele = true
				end
				local floorSaveNoRevert = mod.SaveManager.GetFloorSave(nil, true)
				local dimension = level:GetDimension()

				local ourRoom = false
				local doTeleDimension = Dimension.MIRROR
				local currentDesc = level:GetCurrentRoomDesc()
				if dimension == Dimension.NORMAL then
					if floorSaveNoRevert["TeleDimensionEntrance"] and floorSaveNoRevert["TeleDimension1Start"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimensionEntrance"] then
						ourRoom = currentDesc.GridIndex
						if doTele and grident.State == 0 then
							doTele = floorSaveNoRevert["TeleDimension1Start"]
							mod.TeleportingToMausAlt = 2
						end
					end
				elseif dimension == Dimension.MIRROR then
					if floorSaveNoRevert["TeleDimension1Start"] and floorSaveNoRevert["TeleDimensionEntrance"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension1Start"] then
						ourRoom = currentDesc.GridIndex
						if doTele and grident.State == 0 then
							doTele = floorSaveNoRevert["TeleDimensionEntrance"]
							doTeleDimension = Dimension.NORMAL
							mod.TeleportingToMausAlt = 2
						end
					elseif floorSaveNoRevert["TeleDimension1End"] and floorSaveNoRevert["TeleDimension2Start"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension1End"] then
						ourRoom = currentDesc.GridIndex
						if doTele and grident.State == 2 then
							doTele = floorSaveNoRevert["TeleDimension2Start"]
							mod.TeleportingToMausAlt = 2
						end
					elseif floorSaveNoRevert["TeleDimension2Start"] and floorSaveNoRevert["TeleDimension1End"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension2Start"] then
						ourRoom = currentDesc.GridIndex
						if doTele and grident.State == 0 then
							doTele = floorSaveNoRevert["TeleDimension1End"]
							mod.TeleportingToMausAlt = 0
						end
					elseif floorSaveNoRevert["TeleDimension2End"] and floorSaveNoRevert["TeleDimension3Start"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension2End"] then
						ourRoom = currentDesc.GridIndex
						if doTele and grident.State == 2 then
							doTele = floorSaveNoRevert["TeleDimension3Start"]
							mod.TeleportingToMausAlt = 2
						end
					elseif floorSaveNoRevert["TeleDimension3Start"] and floorSaveNoRevert["TeleDimension2End"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension3Start"] then
						ourRoom = currentDesc.GridIndex
						if doTele and grident.State == 0 then
							doTele = floorSaveNoRevert["TeleDimension2End"]
							mod.TeleportingToMausAlt = 0
						end
					end
				end
				if ourRoom then
					local sprite = grident:GetSprite()
					sprite:Update()
					if type(doTele) == "number" then
						game:StartRoomTransition(doTele, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, doTeleDimension)
					end
					return false
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_GRID_ENTITY_TELEPORTER_UPDATE, mod.PreTeleporterUpdate)

function mod.PreTeleporterRender(grident)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE3_2 then
		local stageType = level:GetStageType()
		if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
			local room = game:GetRoom()
			local roomType = room:GetType()
			if roomType == RoomType.ROOM_TELEPORTER or roomType == RoomType.ROOM_TELEPORTER_EXIT then
				local floorSaveNoRevert = mod.SaveManager.GetFloorSave(nil, true)
				local dimension = level:GetDimension()

				local ourRoom = false
				local teleIsOn = false
				local currentDesc = level:GetCurrentRoomDesc()
				if dimension == Dimension.NORMAL then
					if floorSaveNoRevert["TeleDimensionEntrance"] and floorSaveNoRevert["TeleDimension1Start"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimensionEntrance"] then
						ourRoom = currentDesc.GridIndex
						if grident.State == 0 then
							teleIsOn = true
						end
					end
				elseif dimension == Dimension.MIRROR then
					if floorSaveNoRevert["TeleDimension1Start"] and floorSaveNoRevert["TeleDimensionEntrance"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension1Start"] then
						ourRoom = currentDesc.GridIndex
						if grident.State == 0 then
							teleIsOn = true
						end
					elseif floorSaveNoRevert["TeleDimension1End"] and floorSaveNoRevert["TeleDimension2Start"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension1End"] then
						ourRoom = currentDesc.GridIndex
						if grident.State == 2 then
							teleIsOn = true
						end
					elseif floorSaveNoRevert["TeleDimension2Start"] and floorSaveNoRevert["TeleDimension1End"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension2Start"] then
						ourRoom = currentDesc.GridIndex
						if grident.State == 0 then
							teleIsOn = true
						end
					elseif floorSaveNoRevert["TeleDimension2End"] and floorSaveNoRevert["TeleDimension3Start"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension2End"] then
						ourRoom = currentDesc.GridIndex
						if grident.State == 2 then
							teleIsOn = true
						end
					elseif floorSaveNoRevert["TeleDimension3Start"] and floorSaveNoRevert["TeleDimension2End"] and currentDesc.GridIndex == floorSaveNoRevert["TeleDimension3Start"] then
						ourRoom = currentDesc.GridIndex
						if grident.State == 0 then
							teleIsOn = true
						end
					end
				end
				if type(ourRoom) == "number" then
					local sprite = grident:GetSprite()
					local desiredAnimNum = nil
					if teleIsOn then
						if ourRoom == floorSaveNoRevert["TeleDimensionEntrance"] then
							desiredAnimNum = 2
						elseif ourRoom == floorSaveNoRevert["TeleDimension1Start"] then
							desiredAnimNum = 3
						elseif ourRoom == floorSaveNoRevert["TeleDimension1End"] then
							desiredAnimNum = 7
						elseif ourRoom == floorSaveNoRevert["TeleDimension2Start"] then
							desiredAnimNum = 2
						elseif ourRoom == floorSaveNoRevert["TeleDimension2End"] then
							desiredAnimNum = 4
						elseif ourRoom == floorSaveNoRevert["TeleDimension3Start"] then
							desiredAnimNum = 7
						end
					else
						if ourRoom == floorSaveNoRevert["TeleDimensionEntrance"] then
							desiredAnimNum = 3
						elseif ourRoom == floorSaveNoRevert["TeleDimension1Start"] then
							desiredAnimNum = 2
						elseif ourRoom == floorSaveNoRevert["TeleDimension1End"] then
							desiredAnimNum = 2
						elseif ourRoom == floorSaveNoRevert["TeleDimension2Start"] then
							desiredAnimNum = 7
						elseif ourRoom == floorSaveNoRevert["TeleDimension2End"] then
							desiredAnimNum = 7
						elseif ourRoom == floorSaveNoRevert["TeleDimension3Start"] then
							desiredAnimNum = 4
						end
					end
					if desiredAnimNum then
						local desiredAnim = ""
						if stageType == StageType.STAGETYPE_REPENTANCE_B then
							desiredAnim = "gfx/grid/grid_teleporter" .. desiredAnimNum .. "_gehenna.anm2"
						else
							desiredAnim = "gfx/grid/grid_teleporter" .. desiredAnimNum .. ".anm2"
						end
						if string.lower(sprite:GetFilename()) ~= desiredAnim then
							sprite:Load(desiredAnim, true)
						end
					end
					if teleIsOn then
						if not sprite:IsPlaying("IdleOn") then
							sprite:Play("IdleOn", true)
						end
					else
						if not sprite:IsPlaying("IdleOff") then
							sprite:Play("IdleOff", true)
						end
					end
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_GRID_ENTITY_TELEPORTER_RENDER, mod.PreTeleporterRender)

function mod.IsMausTreasureRoom()
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE3_2 then
		local stageType = level:GetStageType()
		if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
			if level:GetDimension() == Dimension.MIRROR then
				local room = game:GetRoom()
				local roomType = room:GetType()
				if roomType == RoomType.ROOM_TREASURE then
					return true
				end
			end
		end
	end
end

function mod.PreLevelSelect(stage, stageType)
	local game = Game()
	local isGreed = game:IsGreedMode()
	if not isGreed then
		if stage == LevelStage.STAGE2_2 and (stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B) and not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1) then
			for playerIndex, player in ipairs(PlayerManager.GetPlayers()) do
				player:AddCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1)
			end
			mod.AddedFakeKnifePiece = true
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_LEVEL_SELECT, mod.PreLevelSelect)

function mod.PreUseCardMausTeleporterStart(cardID, player, useFlags)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE3_2 then
		local stageType = level:GetStageType()
		if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
			local dimension = level:GetDimension()
			if dimension == Dimension.MIRROR then
				local floorSaveNoRevert = mod.SaveManager.GetFloorSave(nil, true)
				if floorSaveNoRevert["TeleDimension1Start"] then
					game:StartRoomTransition(floorSaveNoRevert["TeleDimension1Start"], Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, Dimension.MIRROR)
					return true
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_USE_CARD, mod.PreUseCardMausTeleporterStart, Card.CARD_FOOL)

function mod.PreUseCardMausTeleporterEnd(cardID, player, useFlags)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE3_2 then
		local stageType = level:GetStageType()
		if stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
			local dimension = level:GetDimension()
			if dimension == Dimension.MIRROR then
				local floorSaveNoRevert = mod.SaveManager.GetFloorSave(nil, true)
				if floorSaveNoRevert["TeleDimension3End"] then
					game:StartRoomTransition(floorSaveNoRevert["TeleDimension3End"], Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, Dimension.MIRROR)
					return true
				end
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_USE_CARD, mod.PreUseCardMausTeleporterEnd, Card.CARD_EMPEROR)
mod.AddCallback(ModCallbacks.MC_PRE_USE_CARD, mod.PreUseCardMausTeleporterEnd, Card.CARD_REVERSE_MOON)

function mod.PreOpenMomsChest(pickup, player)
	if mod.IsMausTreasureRoom() then
		local pickupData = mod.GetData(pickup)
		pickupData.BecomeItem = true
		return false
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_OPEN_CHEST, mod.PreOpenMomsChest, PickupVariant.PICKUP_MOMSCHEST)

function mod.OnUpdateMomsChest(pickup)
	if mod.IsMausTreasureRoom() then
		local pickupData = mod.GetData(pickup)
		if pickupData.BecomeItem then
			pickupData.BecomeItem = false
			local loot = pickup:GetLootList(shouldAdvance)
			local lootEntries = loot:GetEntries()
			for _, lootEntry in ipairs(lootEntries) do
				pickup:Morph(lootEntry:GetType(), lootEntry:GetVariant(), lootEntry:GetSubType(), true, true, true)
				pickup:SetAlternatePedestal(PedestalType.MOMS_CHEST)
				SFXManager():Play(SoundEffect.SOUND_CHEST_OPEN, Options.SFXVolume*2)
				break
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.OnUpdateMomsChest, PickupVariant.PICKUP_MOMSCHEST)

function mod.PreGetLootList(pickup, advance)
	if pickup.Variant == PickupVariant.PICKUP_MOMSCHEST and mod.IsMausTreasureRoom() then
		local itemID = CollectibleType.COLLECTIBLE_KNIFE_PIECE_1
		if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_1) and not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_KNIFE_PIECE_2) then
			itemID = CollectibleType.COLLECTIBLE_KNIFE_PIECE_2
		else
			itemID = game:GetItemPool():GetCollectible(ItemPoolType.POOL_MOMS_CHEST, true, pickup.DropSeed)
		end
		local loot = LootList()
		loot:PushEntry(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, itemID, pickup.DropSeed)
		return loot
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_PICKUP_GET_LOOT_LIST, mod.PreGetLootList)
