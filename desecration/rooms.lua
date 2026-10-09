local mod = Desecration

mod.RoomsSharedFilename = {}
mod.RoomsSharedFilename[StbType.SPECIAL_ROOMS] = "00.special rooms_shared.stb"
mod.RoomsSharedFilename[StbType.BASEMENT] = "01.basement_shared.stb"
mod.RoomsSharedFilename[StbType.CAVES] = "04.caves_shared.stb"
mod.RoomsSharedFilename[StbType.DEPTHS] = "07.depths_shared.stb"
mod.RoomsSharedFilename[StbType.WOMB] = "10.womb_shared.stb"
mod.RoomsSharedFilename[StbType.DOWNPOUR] = "27.downpour_shared.stb"
mod.RoomsSharedFilename[StbType.MINES] = "29.mines_shared.stb"
mod.RoomsSharedFilename[StbType.MAUSOLEUM] = "31.mausoleum_shared.stb"

mod.RoomsSharedStage = {}
mod.RoomsSharedStage[StbType.SPECIAL_ROOMS] = StbType.SPECIAL_ROOMS
mod.RoomsSharedStage[StbType.BASEMENT] = StbType.BASEMENT
mod.RoomsSharedStage[StbType.CELLAR] = StbType.BASEMENT
mod.RoomsSharedStage[StbType.BURNING_BASEMENT] = StbType.BASEMENT
mod.RoomsSharedStage[StbType.CAVES] = StbType.CAVES
mod.RoomsSharedStage[StbType.CATACOMBS] = StbType.CAVES
mod.RoomsSharedStage[StbType.FLOODED_CAVES] = StbType.CAVES
mod.RoomsSharedStage[StbType.DEPTHS] = StbType.DEPTHS
mod.RoomsSharedStage[StbType.NECROPOLIS] = StbType.DEPTHS
mod.RoomsSharedStage[StbType.DANK_DEPTHS] = StbType.DEPTHS
mod.RoomsSharedStage[StbType.WOMB] = StbType.WOMB
mod.RoomsSharedStage[StbType.UTERO] = StbType.WOMB
mod.RoomsSharedStage[StbType.SCARRED_WOMB] = StbType.WOMB
mod.RoomsSharedStage[StbType.DOWNPOUR] = StbType.DOWNPOUR
mod.RoomsSharedStage[StbType.DROSS] = StbType.DOWNPOUR
mod.RoomsSharedStage[StbType.MINES] = StbType.MINES
mod.RoomsSharedStage[StbType.ASHPIT] = StbType.MINES
mod.RoomsSharedStage[StbType.MAUSOLEUM] = StbType.MAUSOLEUM
mod.RoomsSharedStage[StbType.GEHENNA] = StbType.MAUSOLEUM

mod.RoomsFilename = {}

mod.RoomsMods = {}
mod.RoomsMods.IncludeShared = 800
mod.RoomsMods.OnlyShared = 900
mod.RoomsMods.IncludeGreed = 8000
mod.RoomsMods.OnlyGreed = 9000
mod.RoomsMods["repentance"] = {
	StbType.SPECIAL_ROOMS+mod.RoomsMods.IncludeGreed,
	StbType.BASEMENT+mod.RoomsMods.IncludeShared,
	StbType.CELLAR,
	StbType.BURNING_BASEMENT,
	StbType.CAVES,
	StbType.CATACOMBS,
	StbType.FLOODED_CAVES,
	StbType.DEPTHS,
	StbType.NECROPOLIS,
	StbType.DANK_DEPTHS,
	StbType.WOMB,
	StbType.UTERO,
	StbType.SCARRED_WOMB,
	StbType.BLUE_WOMB,
	StbType.SHEOL,
	StbType.CATHEDRAL,
	StbType.DARK_ROOM,
	StbType.CHEST,
	StbType.DOWNPOUR,
	StbType.DROSS,
	StbType.MINES,
	StbType.ASHPIT,
	StbType.MAUSOLEUM,
	StbType.GEHENNA,
	StbType.CORPSE
}
mod.RoomsMods["antibirth"] = {
	StbType.BASEMENT,
	StbType.CELLAR,
	StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
	StbType.CAVES,
	StbType.CATACOMBS,
	StbType.DEPTHS,
	StbType.NECROPOLIS,
	StbType.WOMB+mod.RoomsMods.IncludeShared,
	StbType.UTERO,
	StbType.SHEOL,
	StbType.CATHEDRAL,
	StbType.DOWNPOUR+mod.RoomsMods.IncludeShared,
	StbType.MINES+mod.RoomsMods.IncludeShared,
	StbType.CORPSE,
	["kilburn"] = {
		StbType.SPECIAL_ROOMS+mod.RoomsMods.IncludeShared,
		StbType.BASEMENT+mod.RoomsMods.OnlyShared,
		StbType.CAVES+mod.RoomsMods.OnlyShared,
		StbType.DEPTHS+mod.RoomsMods.OnlyShared,
		StbType.SHEOL,
		StbType.CATHEDRAL,
		StbType.DARK_ROOM,
		StbType.DOWNPOUR+mod.RoomsMods.IncludeShared,
		StbType.MINES+mod.RoomsMods.IncludeShared,
		StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
		StbType.CORPSE
	},
	["sal"] = {
		StbType.BASEMENT,
		StbType.CAVES+mod.RoomsMods.OnlyShared,
		StbType.DEPTHS+mod.RoomsMods.OnlyShared,
		StbType.CATHEDRAL,
		StbType.DOWNPOUR+mod.RoomsMods.IncludeShared,
		StbType.MINES+mod.RoomsMods.IncludeShared,
		StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared
	},
	["leather"] = {
		StbType.BASEMENT,
		StbType.CELLAR,
		StbType.BURNING_BASEMENT,
		StbType.CAVES+mod.RoomsMods.IncludeShared,
		StbType.CATACOMBS,
		StbType.DEPTHS+mod.RoomsMods.OnlyShared,
		StbType.DANK_DEPTHS,
		StbType.WOMB+mod.RoomsMods.OnlyShared,
		StbType.SHEOL,
		StbType.CATHEDRAL,
		StbType.DARK_ROOM,
		StbType.CHEST,
		StbType.DOWNPOUR+mod.RoomsMods.IncludeShared,
		StbType.MINES+mod.RoomsMods.IncludeShared,
		StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
		StbType.CORPSE
	},
	["sag"] = {
		StbType.DEPTHS+mod.RoomsMods.OnlyShared,
		StbType.SHEOL
	},
	["ikana"] = {
		StbType.DOWNPOUR+mod.RoomsMods.IncludeShared,
		StbType.MINES+mod.RoomsMods.IncludeShared,
		StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
		StbType.CORPSE
	},
	["luke"] = {
		StbType.CAVES,
		StbType.WOMB+mod.RoomsMods.OnlyShared,
		StbType.DOWNPOUR,
		StbType.MINES,
		StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared
	},
	["noodle"] = {
		StbType.DOWNPOUR+mod.RoomsMods.IncludeShared,
		StbType.MINES+mod.RoomsMods.IncludeShared,
		StbType.MAUSOLEUM+mod.RoomsMods.OnlyShared
	},
	["compat"] = {
		["lastjudgement"] = {
			StbType.WOMB+mod.RoomsMods.OnlyShared,
			["kilburn"] = {
				StbType.CAVES+mod.RoomsMods.OnlyShared,
				StbType.WOMB+mod.RoomsMods.OnlyShared,
				StbType.MINES,
				StbType.MAUSOLEUM,
				StbType.CORPSE
			},
			["sal"] = {
				StbType.CAVES+mod.RoomsMods.OnlyShared,
				StbType.DEPTHS+mod.RoomsMods.OnlyShared,
				StbType.CATHEDRAL,
				StbType.MAUSOLEUM
			},
			["leather"] = {
				StbType.CAVES+mod.RoomsMods.IncludeShared,
				StbType.CATACOMBS,
				StbType.DEPTHS+mod.RoomsMods.OnlyShared,
				StbType.WOMB+mod.RoomsMods.OnlyShared,
				StbType.SHEOL,
				StbType.MINES,
				StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
				StbType.CORPSE
			},
			["ikana"] = {
				StbType.MINES,
				StbType.MAUSOLEUM+mod.RoomsMods.OnlyShared,
				StbType.CORPSE
			},
			["luke"] = {
				StbType.CAVES
			}
			--["edd"]
		},
		["lastjudgementandrestoredmonsters"] = {
			StbType.WOMB+mod.RoomsMods.OnlyShared,
			StbType.MAUSOLEUM,
			["kilburn"] = {
				StbType.MAUSOLEUM
			},
			["sal"] = {
				StbType.DEPTHS+mod.RoomsMods.OnlyShared
			},
			["leather"] = {
				StbType.WOMB+mod.RoomsMods.OnlyShared,
				StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
				StbType.CORPSE
			},
			["ikana"] = {
				StbType.CORPSE
			}
		},
		["restoredhearts"] = {
			["kilburn"] = {
				StbType.SPECIAL_ROOMS+mod.RoomsMods.OnlyShared
			},
			["leather"] = {
				StbType.CORPSE
			}
		},
		["restoredmonsters"] = {
			StbType.WOMB+mod.RoomsMods.OnlyShared,
			StbType.DOWNPOUR+mod.RoomsMods.OnlyShared,
			StbType.MAUSOLEUM+mod.RoomsMods.OnlyShared,
			StbType.CORPSE,
			["kilburn"] = {
				StbType.BASEMENT+mod.RoomsMods.OnlyShared,
				StbType.CAVES+mod.RoomsMods.OnlyShared,
				StbType.DEPTHS+mod.RoomsMods.OnlyShared,
				StbType.CHEST,
				StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
				StbType.GEHENNA,
				StbType.CORPSE
			},
			["sal"] = {
				StbType.BASEMENT,
				StbType.BURNING_BASEMENT,
				StbType.CAVES+mod.RoomsMods.OnlyShared,
				StbType.DEPTHS+mod.RoomsMods.OnlyShared,
				StbType.CATHEDRAL,
				StbType.MAUSOLEUM+mod.RoomsMods.OnlyShared
			},
			["leather"] = {
				StbType.BASEMENT,
				StbType.CELLAR,
				StbType.BURNING_BASEMENT,
				StbType.CAVES+mod.RoomsMods.IncludeShared,
				StbType.CATACOMBS,
				StbType.DEPTHS+mod.RoomsMods.OnlyShared,
				StbType.WOMB+mod.RoomsMods.OnlyShared,
				StbType.SHEOL,
				StbType.CATHEDRAL,
				StbType.CHEST,
				StbType.DOWNPOUR+mod.RoomsMods.IncludeShared,
				StbType.MINES,
				StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
				StbType.CORPSE
			},
			["ikana"] = {
				StbType.DOWNPOUR+mod.RoomsMods.OnlyShared,
				StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared,
				StbType.CORPSE
			},
			["luke"] = {
				StbType.MAUSOLEUM+mod.RoomsMods.IncludeShared
			}
		},
		["norestoredmonsters"] = {
			StbType.DOWNPOUR+mod.RoomsMods.OnlyShared,
			["kilburn"] = {
				StbType.CAVES+mod.RoomsMods.OnlyShared,
				StbType.MAUSOLEUM,
				StbType.GEHENNA
			},
			["sal"] = {
				StbType.BASEMENT,
				StbType.DEPTHS+mod.RoomsMods.OnlyShared
			},
			["leather"] = {
				StbType.BASEMENT,
				StbType.BURNING_BASEMENT,
				StbType.DEPTHS+mod.RoomsMods.OnlyShared
			},
			["ikana"] = {
				StbType.DOWNPOUR+mod.RoomsMods.OnlyShared
			}
		}
	}
}
mod.RoomsMods["desecration"] = {
	["piber"] = {
		StbType.SPECIAL_ROOMS,
		StbType.BASEMENT
	},
	["buttercarsen"] = {
		StbType.BLUE_WOMB
	}
}

local debugrooms = false
function mod.LoadStbFromPath(stageid, mode, path)
	local loadedrooms = RoomConfig.LoadStb(stageid, mode, path)
	local numrooms = #loadedrooms
	if debugrooms then
		if numrooms > 0 then
			print("Loaded rooms for stage " .. stageid .. " to mode " .. mode .. " from " .. path .. " (" .. numrooms .. ")")
		else
			print("Failed to load rooms for stage " .. stageid .. " to mode " .. mode .. " from " .. path)
		end
	end
	return loadedrooms
end

function mod.LoadSharedRooms(stageid, mode, path, filename)
	path = path or ""
	if filename and mod.RoomsSharedFilename[stageid] then
		mod.RoomsSharedFilename[stageid] = string.gsub(filename,".stb","_shared.stb")
	end
	if mod.RoomsSharedStage[stageid] and mod.RoomsSharedFilename[mod.RoomsSharedStage[stageid]] then
		if stageid == StbType.SPECIAL_ROOMS and mode == 0 then
			mode = 1
		end
		return mod.LoadStbFromPath(stageid, mode, path .. mod.RoomsSharedFilename[mod.RoomsSharedStage[stageid]])
	end
end

function mod.HandleModLoadedRoom(stageid, path)
	path = path or ""
	local doShared = false
	local doSelf = true
	local doGreed = false
	if stageid >= mod.RoomsMods.OnlyGreed then
		stageid = stageid - mod.RoomsMods.OnlyGreed
		doGreed = true
		doSelf = false
	elseif stageid >= mod.RoomsMods.IncludeGreed then
		stageid = stageid - mod.RoomsMods.IncludeGreed
		doGreed = true
	end
	if stageid >= mod.RoomsMods.OnlyShared then
		stageid = stageid - mod.RoomsMods.OnlyShared
		doShared = true
		doSelf = false
	elseif stageid >= mod.RoomsMods.IncludeShared then
		stageid = stageid - mod.RoomsMods.IncludeShared
		doSelf = true
	end
	if not mod.RoomsFilename[stageid] then
		local stageconfig = RoomConfig.GetStage(stageid)
		if stageconfig then
			mod.RoomsFilename[stageid] = string.gsub(string.lower(stageconfig:GetXMLName()),".xml",".stb")
		end
	end
	if doShared then
		for otherstage,sharedstage in pairs(mod.RoomsSharedStage) do
			if sharedstage == stageid then
				mod.LoadStbFromPath(otherstage, 0, path .. mod.RoomsSharedFilename[stageid])
				if stageid == StbType.SPECIAL_ROOMS then
					mod.LoadStbFromPath(otherstage, 1, path .. mod.RoomsSharedFilename[stageid])
				end
			end
		end
	end
	if doSelf then
		mod.LoadStbFromPath(stageid, 0, path .. mod.RoomsFilename[stageid])
	end
	if doGreed then
		mod.LoadStbFromPath(stageid, 1, path .. string.gsub(mod.RoomsFilename[stageid],".stb","_greed.stb"))
	end
end

function mod.HandleModLoadedRoomCompat(authordata, compatstring, modname)
	if authordata[compatstring] then
		for compatname,compatdata in pairs(authordata[compatstring]) do
			if type(compatdata) == "number" then
				mod.HandleModLoadedRoom(compatdata, modname .. "/compat/" .. compatstring .. "/")
			elseif type(compatdata) == "table" then
				for _,stageid in pairs(compatdata) do
					mod.HandleModLoadedRoom(stageid, modname .. "/compat/" .. compatstring .. "/" .. compatname .. "/")
				end
			end
		end
	end
end

function mod.OnModsLoadedRooms()
	for _,stageid in pairs(StbType) do
		if stageid ~= StbType.MORTIS then --crashes without this check
			local stageconfig = RoomConfig.GetStage(stageid)
			if stageconfig then
				mod.RoomsFilename[stageid] = string.gsub(string.lower(stageconfig:GetXMLName()),".xml",".stb")
				mod.LoadSharedRooms(stageid, 0, nil, mod.RoomsFilename[stageid])
			end
		end
	end
	for modname,moddata in pairs(mod.RoomsMods) do
		if type(moddata) == "table" then
			for authorname,authordata in pairs(moddata) do
				if type(authordata) == "number" then
					mod.HandleModLoadedRoom(authordata, modname .. "/")
				elseif type(authordata) == "table" then
					if authorname == "compat" then
						if LastJudgement then
							mod.HandleModLoadedRoomCompat(authordata, "lastjudgement", modname)
							if RestoredMonsterPack then
								mod.HandleModLoadedRoomCompat(authordata, "lastjudgementandrestoredmonsters", modname)
							end
						else
							mod.HandleModLoadedRoomCompat(authordata, "nolastjudgement", modname)
							if RestoredMonsterPack then
								mod.HandleModLoadedRoomCompat(authordata, "restoredmonstersnolastjudgement", modname)
							else
								mod.HandleModLoadedRoomCompat(authordata, "norestoredmonstersnolastjudgement", modname)
								mod.HandleModLoadedRoomCompat(authordata, "nolastjudgementnorestoredmonsters", modname)
							end
						end
						if RestoredMonsterPack then
							mod.HandleModLoadedRoomCompat(authordata, "restoredmonsters", modname)
						else
							mod.HandleModLoadedRoomCompat(authordata, "norestoredmonsters", modname)
						end
						if RestoredHearts then
							mod.HandleModLoadedRoomCompat(authordata, "restoredhearts", modname)
						else
							mod.HandleModLoadedRoomCompat(authordata, "norrestoredhearts", modname)
						end
					else
						for _,stageid in pairs(authordata) do
							mod.HandleModLoadedRoom(stageid, modname .. "/" .. authorname .. "/")
						end
					end
				end
			end
		end
	end
end
mod.AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, mod.OnModsLoadedRooms)
