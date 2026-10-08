local mod = Desecration

function mod.OnNewRoomHome()

	local game = Game()
	local room = game:GetRoom()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE8 then
		local roomDescriptor = level:GetCurrentRoomDesc()
		local roomConfigRoom = roomDescriptor.Data
		if roomConfigRoom.Subtype == 330 then
			room:SetBackdropType(BackdropType.CORPSE, 1) --placeholder (outside)
		elseif roomConfigRoom.Subtype == 331 or roomConfigRoom.Subtype == 333 then
			room:SetBackdropType(BackdropType.CORPSE2, 1) --placeholder (woods entrance and woods)
		elseif roomConfigRoom.Subtype == 332 then
			room:SetBackdropType(BackdropType.MINES, 1) --placeholder (kitchen)
		end
		local dimension = level:GetDimension()
		if MinimapAPI and dimension == Dimension.NORMAL then
			local isaacsroom = MinimapAPI:GetRoomByIdx(GridRooms.ROOM_HOME_ISAACSROOM_IDX)
			if isaacsroom then
				isaacsroom.PermanentIcons = {"IsaacsRoom"}
			end
			local momsroom = MinimapAPI:GetRoomByIdx(GridRooms.ROOM_HOME_MOMSROOM_IDX)
			if momsroom then
				momsroom.PermanentIcons = {"MomsBedroom"}
			end
		end
	end

	local backdropType = room:GetBackdropType()
	if backdropType == BackdropType.MOMS_BEDROOM then
		for doorSlot=0, DoorSlot.NUM_DOOR_SLOTS-1 do
			local door = room:GetDoor(doorSlot)
			if door then
				local doorSprite = door:GetSprite()
				if string.lower(doorSprite:GetFilename()) == "gfx/grid/door_house.anm2" then
					for layer=0,4 do
						doorSprite:ReplaceSpritesheet(layer, "gfx/grid/door_house_mom.png")
					end
					doorSprite:LoadGraphics()
				end
			end
		end
	end

end
mod.AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoomHome)

function mod.PostSleepNightmareShow(giantbookID, player)
	local game = Game()
	local level = game:GetLevel()
	local stage = level:GetStage()
	if stage == LevelStage.STAGE8 then
		if MinimapAPI then
			local minimapRoom = MinimapAPI:GetRoomByIdx(GridRooms.ROOM_HOME_LIVINGROOM_IDX)
			if minimapRoom then
				minimapRoom.PermanentIcons = {"TVOn"}
			end
		end
	end
end
mod.AddCallback(ModCallbacks.MC_POST_ITEM_OVERLAY_SHOW, mod.PostSleepNightmareShow, Giantbook.SLEEP_NIGHTMARE)
