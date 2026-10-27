local mod = Desecration

local debugrooms = false
function mod.LoadStbFromPath(stageid, mode, path)
	local loadedrooms = RoomConfig.LoadStb(stageid, mode, path)
	if debugrooms then
		local numrooms = #loadedrooms
		if numrooms > 0 then
			print("Loaded rooms for stage " .. stageid .. " to mode " .. mode .. " from " .. path .. " (" .. numrooms .. ")")
		else
			print("FAILED TO LOAD ROOMS for stage " .. stageid .. " to mode " .. mode .. " from " .. path)
		end
	end
	return loadedrooms
end

mod.AntibirthRooms = {
	[StbType.SPECIAL_ROOMS]=true,
	[StbType.BASEMENT]=true,
	[StbType.CELLAR]=true,
	[StbType.BURNING_BASEMENT]=true,
	[StbType.CAVES]=true,
	[StbType.CATACOMBS]=true,
	[StbType.FLOODED_CAVES]=true,
	[StbType.DEPTHS]=true,
	[StbType.NECROPOLIS]=true,
	[StbType.DANK_DEPTHS]=true,
	[StbType.WOMB]=true,
	[StbType.UTERO]=true,
	[StbType.SCARRED_WOMB]=true,
	[StbType.SHEOL]=true,
	[StbType.CATHEDRAL]=true,
	[StbType.DARK_ROOM]=true,
	[StbType.CHEST]=true,
	[StbType.DOWNPOUR]=true,
	[StbType.MINES]=true,
	[StbType.MAUSOLEUM]=true,
	[StbType.CORPSE]=true
}

mod.AntibirthSharedRooms = {
	[StbType.SPECIAL_ROOMS]={StbType.SPECIAL_ROOMS},
	[StbType.BASEMENT]={StbType.BASEMENT,StbType.CELLAR,StbType.BURNING_BASEMENT},
	[StbType.CAVES]={StbType.CAVES,StbType.CATACOMBS,StbType.FLOODED_CAVES},
	[StbType.DEPTHS]={StbType.DEPTHS,StbType.NECROPOLIS,StbType.DANK_DEPTHS},
	[StbType.WOMB]={StbType.WOMB,StbType.UTERO,StbType.SCARRED_WOMB},
	[StbType.DOWNPOUR]={StbType.DOWNPOUR,StbType.DROSS},
	[StbType.MINES]={StbType.MINES,StbType.ASHPIT},
	[StbType.MAUSOLEUM]={StbType.MAUSOLEUM,StbType.GEHENNA}
}

mod.AntibirthSharedWithGreedRooms = {
	[StbType.DOWNPOUR]=mod.AntibirthSharedRooms[StbType.DOWNPOUR],
	[StbType.MINES]=mod.AntibirthSharedRooms[StbType.MINES],
	[StbType.MAUSOLEUM]=mod.AntibirthSharedRooms[StbType.MAUSOLEUM]
}

mod.AntibirthWithGreedRooms = {
	[StbType.CORPSE]=true
}

mod.AntibirthRestoredMonstersRooms = {
	[StbType.BASEMENT]=true,
	[StbType.CELLAR]=true,
	[StbType.BURNING_BASEMENT]=true,
	[StbType.CATACOMBS]=true,
	[StbType.DEPTHS]=true,
	[StbType.UTERO]=true,
	[StbType.SHEOL]=true,
	[StbType.CATHEDRAL]=true,
	[StbType.CHEST]=true,
	[StbType.DOWNPOUR]=true,
	[StbType.MINES]=true,
	[StbType.MAUSOLEUM]=true,
	[StbType.GEHENNA]=true,
	[StbType.CORPSE]=true
}
mod.AntibirthRestoredMonstersSharedRooms = {
	[StbType.BASEMENT]=mod.AntibirthSharedRooms[StbType.BASEMENT],
	[StbType.CAVES]=mod.AntibirthSharedRooms[StbType.CAVES],
	[StbType.DEPTHS]=mod.AntibirthSharedRooms[StbType.DEPTHS],
	[StbType.WOMB]=mod.AntibirthSharedRooms[StbType.WOMB],
	[StbType.DOWNPOUR]=mod.AntibirthSharedRooms[StbType.DOWNPOUR],
	[StbType.MAUSOLEUM]=mod.AntibirthSharedRooms[StbType.MAUSOLEUM]
}

mod.AntibirthNoRestoredMonstersRooms = {
	[StbType.DEPTHS]=true,
	[StbType.MAUSOLEUM]=true,
	[StbType.GEHENNA]=true
}
mod.AntibirthNoRestoredMonstersSharedRooms = {
	[StbType.BASEMENT]=mod.AntibirthSharedRooms[StbType.BASEMENT],
	[StbType.CAVES]=mod.AntibirthSharedRooms[StbType.CAVES],
	[StbType.DEPTHS]=mod.AntibirthSharedRooms[StbType.DEPTHS],
	[StbType.DOWNPOUR]=mod.AntibirthSharedRooms[StbType.DOWNPOUR]
}

mod.AntibirthRestoredHeartsRooms = {
	[StbType.CORPSE]=true
}
mod.AntibirthRestoredHeartsSharedRooms = {
	[StbType.SPECIAL_ROOMS]=mod.AntibirthSharedRooms[StbType.SPECIAL_ROOMS]
}

mod.VanillaEditsRooms = {
	[StbType.SPECIAL_ROOMS]=true,
	[StbType.BASEMENT]=true,
	[StbType.CELLAR]=true,
	[StbType.BURNING_BASEMENT]=true,
	[StbType.CAVES]=true,
	[StbType.CATACOMBS]=true,
	[StbType.FLOODED_CAVES]=true,
	[StbType.DEPTHS]=true,
	[StbType.NECROPOLIS]=true,
	[StbType.DANK_DEPTHS]=true,
	[StbType.WOMB]=true,
	[StbType.UTERO]=true,
	[StbType.SCARRED_WOMB]=true,
	[StbType.BLUE_WOMB]=true,
	[StbType.SHEOL]=true,
	[StbType.CATHEDRAL]=true,
	[StbType.DARK_ROOM]=true,
	[StbType.CHEST]=true,
	[StbType.DOWNPOUR]=true,
	[StbType.DROSS]=true,
	[StbType.MINES]=true,
	[StbType.ASHPIT]=true,
	[StbType.MAUSOLEUM]=true,
	[StbType.GEHENNA]=true,
	[StbType.CORPSE]=true
}

mod.VanillaEditsSharedRooms = {
	[StbType.BASEMENT]=mod.AntibirthSharedRooms[StbType.BASEMENT],
	[StbType.CAVES]=mod.AntibirthSharedRooms[StbType.CAVES],
	[StbType.WOMB]=mod.AntibirthSharedRooms[StbType.WOMB]
}

mod.VanillaEditsGreedRooms = {
	[StbType.DOWNPOUR]=true,
	[StbType.DROSS]=true,
	[StbType.MINES]=true,
	[StbType.ASHPIT]=true,
	[StbType.MAUSOLEUM]=true,
	[StbType.GEHENNA]=true,
	[StbType.CORPSE]=true
}

function mod.OnModsLoadedRooms()
	for _,stageid in pairs(StbType) do
		if stageid ~= StbType.MORTIS then
			local stageconfig = RoomConfig.GetStage(stageid)
			if stageconfig then
				local filename = string.gsub(string.lower(stageconfig:GetXMLName()),".xml",".stb")
				local filenameshared = string.gsub(filename,".stb","_shared.stb")
				local filenamesharedwithgreed = string.gsub(filenameshared,".stb","_withgreed.stb")
				local filenamewithgreed = string.gsub(filename,".stb","_withgreed.stb")

				if mod.AntibirthSharedRooms[stageid] then
					for _,sharedid in ipairs(mod.AntibirthSharedRooms[stageid]) do
						mod.LoadStbFromPath(sharedid, 0, "antibirth/" .. filenameshared)
					end
					if stageid == StbType.SPECIAL_ROOMS then
						mod.LoadStbFromPath(stageid, 1, "antibirth/" .. filenameshared)
					end

					if RestoredMonsterPack then
						if mod.AntibirthRestoredMonstersSharedRooms[stageid] then
							mod.LoadStbFromPath(stageid, 0, "antibirth/restoredmonsters/" .. filenameshared)
							if stageid == StbType.SPECIAL_ROOMS then
								mod.LoadStbFromPath(stageid, 1, "antibirth/restoredmonsters/" .. filenameshared)
							end
						end
					elseif mod.AntibirthNoRestoredMonstersSharedRooms[stageid] then
						mod.LoadStbFromPath(stageid, 0, "antibirth/norestoredmonsters/" .. filenameshared)
						if stageid == StbType.SPECIAL_ROOMS then
							mod.LoadStbFromPath(stageid, 1, "antibirth/norestoredmonsters/" .. filenameshared)
						end
					end

					if RestoredHearts then
						if mod.AntibirthRestoredHeartsSharedRooms[stageid] then
							mod.LoadStbFromPath(stageid, 0, "antibirth/restoredhearts/" .. filenameshared)
							if stageid == StbType.SPECIAL_ROOMS then
								mod.LoadStbFromPath(stageid, 1, "antibirth/restoredhearts/" .. filenameshared)
							end
						end
					end

					if mod.AntibirthSharedWithGreedRooms[stageid] then
						for _,sharedwithgreedid in ipairs(mod.AntibirthSharedWithGreedRooms[stageid]) do
							mod.LoadStbFromPath(sharedwithgreedid, 0, "antibirth/" .. filenamesharedwithgreed)
							mod.LoadStbFromPath(sharedwithgreedid, 1, "antibirth/" .. filenamesharedwithgreed)
						end
					end
				end

				if mod.VanillaEditsSharedRooms[stageid] then
					for _,sharedid in ipairs(mod.VanillaEditsSharedRooms[stageid]) do
						mod.LoadStbFromPath(sharedid, 0, "vanillaedits/" .. filenameshared)
					end
					if stageid == StbType.SPECIAL_ROOMS then
						mod.LoadStbFromPath(stageid, 1, "vanillaedits/" .. filenameshared)
					end
				end

				if mod.AntibirthWithGreedRooms[stageid] then
					mod.LoadStbFromPath(stageid, 0, "antibirth/" .. filenamewithgreed)
					mod.LoadStbFromPath(stageid, 1, "antibirth/" .. filenamewithgreed)
				end

				if mod.AntibirthRooms[stageid] then
					mod.LoadStbFromPath(stageid, 0, "antibirth/" .. filename)
				end
				if mod.VanillaEditsRooms[stageid] then
					mod.LoadStbFromPath(stageid, 0, "vanillaedits/" .. filename)
				end
				if mod.VanillaEditsGreedRooms[stageid] then
					mod.LoadStbFromPath(stageid, 1, "vanillaedits/greed/" .. filename)
				end

				if RestoredMonsterPack then
					if mod.AntibirthRestoredMonstersRooms[stageid] then
						mod.LoadStbFromPath(stageid, 0, "antibirth/restoredmonsters/" .. filename)
					end
				elseif mod.AntibirthNoRestoredMonstersRooms[stageid] then
					mod.LoadStbFromPath(stageid, 0, "antibirth/norestoredmonsters/" .. filename)
				end

				if RestoredHearts then
					if mod.AntibirthRestoredHeartsRooms[stageid] then
						mod.LoadStbFromPath(stageid, 0, "antibirth/restoredhearts/" .. filename)
					end
				end
			end
		end
	end
end
mod.AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, mod.OnModsLoadedRooms)
