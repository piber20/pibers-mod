local mod = Desecration

function mod.ReplaceShadingBackdropSheet(sprite, filename)
	if filename then
		for i=1,12 do
			sprite:ReplaceSpritesheet(i, "gfx/backdrop/" .. filename, false)
		end
		for i=16,19 do
			sprite:ReplaceSpritesheet(i, "gfx/backdrop/" .. filename, false)
		end
		sprite:LoadGraphics()
	end
	return sprite
end

function mod.ReplaceShadingSheet(sprite, filename)
	if filename then
		sprite:ReplaceSpritesheet(0, "gfx/backdrop/shading/" .. filename, false)
		for i=13,15 do
			sprite:ReplaceSpritesheet(i, "gfx/backdrop/shading/" .. filename, false)
		end
		sprite:LoadGraphics()
	end
	return sprite
end

function mod.CreateShadingSprite(filename)
	filename = filename or "shading.png"
	local sprite = Sprite("gfx/backdrop/shading/shading.anm2", true)
	sprite:Play("Shading")
	mod.ReplaceShadingSheet(sprite, filename)
	return sprite
end

function mod.CreateWallShadingSprites(name, renderpos, shadingname, shadingaligns, forceanim, cover)
	if shadingaligns == nil then
		shadingaligns = true
	end
	local group = {}
	group.Floor = Sprite("gfx/backdrop/shading/shading.anm2", true)
	group.Floor:Play(name .. "Floors")
	group.Wall = Sprite("gfx/backdrop/shading/shading.anm2", true)
	group.Wall:Play(name .. "Walls")
	if shadingname and not forceanim then
		group.Shading = mod.CreateShadingSprite(shadingname)
	else
		group.Shading = Sprite("gfx/backdrop/shading/shading.anm2", true)
		group.Shading:Play(name .. "Shading")
		if shadingname then
			mod.ReplaceShadingSheet(group.Shading, shadingname)
		end
	end
	if renderpos then
		group.RenderPos = renderpos
		if shadingaligns then
			group.ShadingPos = renderpos
		end
	end
	if cover then
		group.CoverPos = cover
	end
	return group
end

mod.ShadingBg = {}
for enum, value in pairs(RoomShape) do
	if value == RoomShape.ROOMSHAPE_1x1 then
		mod.ShadingBg[value] = {}
		mod.ShadingBg[value].Shading = mod.CreateShadingSprite()
	elseif value < RoomShape.NUM_ROOMSHAPES then
		mod.ShadingBg[value] = {}
		mod.ShadingBg[value].Shading = mod.CreateShadingSprite(string.gsub(enum,"ROOMSHAPE_","shading_") .. ".png")
	end
end

mod.ShadingBg[RoomShape.ROOMSHAPE_IH].AltWalls = {
	[1] = {
		["TinySquareL"] = {
			49,50,51,52,53,54,55,56,57,58,
			64,65,66,67,68,69,70,71,72,73,
			79,80,81,82,83,84,85,86,87,88
		},
		["TinySquareR"] = {
			46,47,48,49,50,51,52,53,54,55,
			61,62,63,64,65,66,67,68,69,70,
			76,77,78,79,80,81,82,83,84,85
		}
	},
	[2] = {
		["TinySquareL_TinySquareR"] = {
			49,50,51,52,53,54,55,
			64,65,66,67,68,69,70,
			79,80,81,82,83,84,85
		}
	},
	[3] = {
		["TinyClosetL"] = {
			51,52,53,54,55,56,57,58,
			66,67,68,69,70,71,72,73,
			81,82,83,84,85,86,87,88
		},
		["TinyClosetR"] = {
			46,47,48,49,50,51,52,53,
			61,62,63,64,65,66,67,68,
			76,77,78,79,80,81,82,83
		}
	},
	[4] = {
		["TinyClosetL_TinySquareR"] = {
			51,52,53,54,55,
			66,67,68,69,70,
			81,82,83,84,85
		},
		["TinySquareL_TinyClosetR"] = {
			49,50,51,52,53,
			64,65,66,67,68,
			79,80,81,82,83
		}
	},
	[5] = {
		["ClosetL"] = {
			53,54,55,56,57,58,
			68,69,70,71,72,73,
			83,84,85,86,87,88
		},
		["ClosetR"] = {
			46,47,48,49,50,51,
			61,62,63,64,65,66,
			76,77,78,79,80,81
		}
	}
}

mod.ShadingBg[RoomShape.ROOMSHAPE_IV].AltWalls = {
	[1] = {
		["TinySquareU"] = {
			20,			24,
			35,			39,
			50,			54,
			65,66,67,68,69,
			80,81,82,83,84,
			95,96,97,98,99,
			110,111,112,113,114
		},
		["TinySquareD"] = {
			20,21,22,23,24,
			35,36,37,38,39,
			50,51,52,53,54,
			65,66,67,68,69,
			80,			84,
			95,			99,
			110,		114
		}
	},
	[2] = {
		["TinyTallClosetU"] = {
			20,			24,
			35,			39,
			50,			54,
			65,			69,
			80,			84,
			95,96,97,98,99,
			110,111,112,113,114
		},
		["TinyTallClosetD"] = {
			20,21,22,23,24,
			35,36,37,38,39,
			50,			54,
			65,			69,
			80,			84,
			95,			99,
			110,		114
		}
	},
	[3] = {
		["SkinnyHallway"] = {
			20,			24,
			35,			39,
			50,			54,
			65,			69,
			80,			84,
			95,			99,
			110,		114
		}
	},
	[4] = {
		["TinyClosetU"] = {
			65,66,67,68,69,
			80,81,82,83,84,
			95,96,97,98,99,
			110,111,112,113,114
		},
		["TinyClosetD"] = {
			20,21,22,23,24,
			35,36,37,38,39,
			50,51,52,53,54,
			65,66,67,68,69
		}
	},
	[5] = {
		["SquareU"] = {
			95,96,97,98,99,
			110,111,112,113,114
		},
		["SquareD"] = {
			20,21,22,23,24,
			35,36,37,38,39,
		}
	}
}

mod.ShadingBg[RoomShape.ROOMSHAPE_1x1].AltWalls = {
	[1] = {
		["TinyTallClosetL"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
					 34,35,36,37,38,39,40,41,42,43,
					 49,50,51,52,53,54,55,56,57,58,
					 64,65,66,67,68,69,70,71,72,73,
					 79,80,81,82,83,84,85,86,87,88,
					 94,95,96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["TinyTallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,39,40,
			46,47,48,49,50,51,52,53,54,55,
			61,62,63,64,65,66,67,68,69,70,
			76,77,78,79,80,81,82,83,84,85,
			91,92,93,94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[2] = {
		["TinyTallClosetL_TinySquareR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
					 34,35,36,37,38,39,40,41,42,43,
					 49,50,51,52,53,54,55,
					 64,65,66,67,68,69,70,
					 79,80,81,82,83,84,85,
					 94,95,96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["TinySquareL_TinyTallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,39,40,
					 49,50,51,52,53,54,55,
					 64,65,66,67,68,69,70,
					 79,80,81,82,83,84,85,
			91,92,93,94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[3] = {
		["TinyTallClosetL_TinyClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
					 34,35,36,37,38,39,40,41,42,43,
					 49,50,51,52,53,
					 64,65,66,67,68,
					 79,80,81,82,83,
					 94,95,96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["TinyClosetL_TinyTallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,39,40,
						   51,52,53,54,55,
						   66,67,68,69,70,
						   81,82,83,84,85,
			91,92,93,94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[4] = {
		["TinyTallClosetL_TinyTallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
					 34,35,36,37,38,39,40,
					 49,50,51,52,53,54,55,
					 64,65,66,67,68,69,70,
					 79,80,81,82,83,84,85,
					 94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[5] = {
		["SquareL"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
						   36,37,38,39,40,41,42,43,
						   51,52,53,54,55,56,57,58,
						   66,67,68,69,70,71,72,73,
						   81,82,83,84,85,86,87,88,
						   96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["SquareR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,
			46,47,48,49,50,51,52,53,
			61,62,63,64,65,66,67,68,
			76,77,78,79,80,81,82,83,
			91,92,93,94,95,96,97,98,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[6] = {
		["SquareL_TinySquareR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
						   36,37,38,39,40,41,42,43,
						   51,52,53,54,55,
						   66,67,68,69,70,
						   81,82,83,84,85,
						   96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["TinySquareL_SquareR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,
					 49,50,51,52,53,
					 64,65,66,67,68,
					 79,80,81,82,83,
			91,92,93,94,95,96,97,98,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[7] = {
		["SquareL_TinyTallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
						   36,37,38,39,40,
						   51,52,53,54,55,
						   66,67,68,69,70,
						   81,82,83,84,85,
						   96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["TinyTallClosetL_SquareR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
					 34,35,36,37,38,
					 49,50,51,52,53,
					 64,65,66,67,68,
					 79,80,81,82,83,
					 94,95,96,97,98,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[8] = {
		["WideClosetL"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
								 38,39,40,41,42,43,
								 53,54,55,56,57,58,
								 68,69,70,71,72,73,
								 83,84,85,86,87,88,
								 98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["WideClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,
			46,47,48,49,50,51,
			61,62,63,64,65,66,
			76,77,78,79,80,81,
			91,92,93,94,95,96,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[9] = {
		["BigClosetL"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
									   40,41,42,43,
									   55,56,57,58,
									   70,71,72,73,
									   85,86,87,88,
									   100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["BigClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,
			46,47,48,49,
			61,62,63,64,
			76,77,78,79,
			91,92,93,94,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	},
	[10] = {
		["TallClosetL"] = {
			19,20,21,22,23,24,25,26,27,28,
			34,35,36,37,38,39,40,41,42,43,
			49,50,51,52,53,54,55,56,57,58,
			64,65,66,67,68,69,70,71,72,73,
			79,80,81,82,83,84,85,86,87,88,
			94,95,96,97,98,99,100,101,102,103,
			109,110,111,112,113,114,115,116,117,118
		},
		["TallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,
			31,32,33,34,35,36,37,38,39,40,
			46,47,48,49,50,51,52,53,54,55,
			61,62,63,64,65,66,67,68,69,70,
			76,77,78,79,80,81,82,83,84,85,
			91,92,93,94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115
		}
	},
	[11] = {
		["TallClosetL_TinySquareR"] = {
			19,20,21,22,23,24,25,26,27,28,
			34,35,36,37,38,39,40,41,42,43,
			49,50,51,52,53,54,55,
			64,65,66,67,68,69,70,
			79,80,81,82,83,84,85,
			94,95,96,97,98,99,100,101,102,103,
			109,110,111,112,113,114,115,116,117,118
		},
		["TinySquareL_TallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,
			31,32,33,34,35,36,37,38,39,40,
					 49,50,51,52,53,54,55,
					 64,65,66,67,68,69,70,
					 79,80,81,82,83,84,85,
			91,92,93,94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115
		}
	},
	[12] = {
		["TallClosetL_TinyClosetR"] = {
			19,20,21,22,23,24,25,26,27,28,
			34,35,36,37,38,39,40,41,42,43,
			49,50,51,52,53,
			64,65,66,67,68,
			79,80,81,82,83,
			94,95,96,97,98,99,100,101,102,103,
			109,110,111,112,113,114,115,116,117,118
		},
		["TinyClosetL_TallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,
			31,32,33,34,35,36,37,38,39,40,
						   51,52,53,54,55,
						   66,67,68,69,70,
						   81,82,83,84,85,
			91,92,93,94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115
		}
	},
	[13] = {
		["TallClosetL_TinyTallClosetR"] = {
			19,20,21,22,23,24,25,26,27,28,
			34,35,36,37,38,39,40,
			49,50,51,52,53,54,55,
			64,65,66,67,68,69,70,
			79,80,81,82,83,84,85,
			94,95,96,97,98,99,100,
			109,110,111,112,113,114,115,116,117,118
		},
		["TinyTallClosetL_TallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,
					 34,35,36,37,38,39,40,
					 49,50,51,52,53,54,55,
					 64,65,66,67,68,69,70,
					 79,80,81,82,83,84,85,
					 94,95,96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115
		}
	},
	[14] = {
		["TallClosetL_SquareR"] = {
			19,20,21,22,23,24,25,26,27,28,
			34,35,36,37,38,
			49,50,51,52,53,
			64,65,66,67,68,
			79,80,81,82,83,
			94,95,96,97,98,
			109,110,111,112,113,114,115,116,117,118
		},
		["SquareL_TallClosetR"] = {
			16,17,18,19,20,21,22,23,24,25,
						   36,37,38,39,40,
						   51,52,53,54,55,
						   66,67,68,69,70,
						   81,82,83,84,85,
						   96,97,98,99,100,
			106,107,108,109,110,111,112,113,114,115
		}
	},
	[15] = {
		["TallClosetL_TallClosetR"] = {
			19,20,21,22,23,24,25,
			34,35,36,37,38,39,40,
			49,50,51,52,53,54,55,
			64,65,66,67,68,69,70,
			79,80,81,82,83,84,85,
			94,95,96,97,98,99,100,
			109,110,111,112,113,114,115
		}
	},
	[16] = {
		["WideTallClosetL"] = {
			21,22,23,24,25,26,27,28,
			36,37,38,39,40,41,42,43,
			51,52,53,54,55,56,57,58,
			66,67,68,69,70,71,72,73,
			81,82,83,84,85,86,87,88,
			96,97,98,99,100,101,102,103,
			111,112,113,114,115,116,117,118
		},
		["WideTallClosetR"] = {
			16,17,18,19,20,21,22,23,
			31,32,33,34,35,36,37,38,
			46,47,48,49,50,51,52,53,
			61,62,63,64,65,66,67,68,
			76,77,78,79,80,81,82,83,
			91,92,93,94,95,96,97,98,
			106,107,108,109,110,111,112,113
		}
	},
	[17] = {
		["WideTallClosetL_TinySquareR"] = {
			21,22,23,24,25,26,27,28,
			36,37,38,39,40,41,42,43,
			51,52,53,54,55,
			66,67,68,69,70,
			81,82,83,84,85,
			96,97,98,99,100,101,102,103,
			111,112,113,114,115,116,117,118
		},
		["TinySquareL_WideTallClosetR"] = {
			16,17,18,19,20,21,22,23,
			31,32,33,34,35,36,37,38,
					 49,50,51,52,53,
					 64,65,66,67,68,
					 79,80,81,82,83,
			91,92,93,94,95,96,97,98,
			106,107,108,109,110,111,112,113
		}
	},
	[18] = {
		["WideTallClosetL_TinyClosetR"] = {
			21,22,23,24,25,26,27,28,
			36,37,38,39,40,
			51,52,53,54,55,
			66,67,68,69,70,
			81,82,83,84,85,
			96,97,98,99,100,
			111,112,113,114,115,116,117,118
		},
		["TinyClosetL_WideTallClosetR"] = {
			16,17,18,19,20,21,22,23,
					 34,35,36,37,38,
					 49,50,51,52,53,
					 64,65,66,67,68,
					 79,80,81,82,83,
					 94,95,96,97,98,
			106,107,108,109,110,111,112,113
		}
	},
	[19] = {
		["WideTallClosetL_TinyTallClosetR"] = {
			21,22,23,24,25,
			36,37,38,39,40,
			51,52,53,54,55,
			66,67,68,69,70,
			81,82,83,84,85,
			96,97,98,99,100,
			111,112,113,114,115
		},
		["TinyTallClosetL_WideTallClosetR"] = {
			19,20,21,22,23,
			34,35,36,37,38,
			49,50,51,52,53,
			64,65,66,67,68,
			79,80,81,82,83,
			94,95,96,97,98,
			109,110,111,112,113
		}
	},
	[20] = {
		["ClosetU"] = {
			16,17,18,					  26,27,28,
			31,32,33,					  41,42,43,
			46,47,48,					  56,57,58,
			61,62,63,64,65,66,67,68,69,70,71,72,73,
			76,77,78,79,80,81,82,83,84,85,86,87,88,
			91,92,93,94,95,96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["ClosetD"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,39,40,41,42,43,
			46,47,48,49,50,51,52,53,54,55,56,57,58,
			61,62,63,64,65,66,67,68,69,70,71,72,73,
			76,77,78,					  86,87,88,
			91,92,93,					  101,102,103,
			106,107,108,				  116,117,118
		}
	},
	[21] = {
		["WideClosetU"] = {
			16,17,18,					  26,27,28,
			31,32,33,					  41,42,43,
			46,47,48,					  56,57,58,
			61,62,63,					  71,72,73,
			76,77,78,					  86,87,88,
			91,92,93,94,95,96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["WideClosetD"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,39,40,41,42,43,
			46,47,48,					  56,57,58,
			61,62,63,					  71,72,73,
			76,77,78,					  86,87,88,
			91,92,93,					  101,102,103,
			106,107,108,				  116,117,118
		}
	},
	[22] = {
		["BigClosetU"] = {
			16,17,							 27,28,
			31,32,							 42,43,
			46,47,							 57,58,
			61,62,							 72,73,
			76,77,							 87,88,
			91,92,93,94,95,96,97,98,99,100,101,102,103,
			106,107,108,109,110,111,112,113,114,115,116,117,118
		},
		["BigClosetD"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,
			31,32,33,34,35,36,37,38,39,40,41,42,43,
			46,47,							 57,58,
			61,62,							 72,73,
			76,77,							 87,88,
			91,92,							 102,103,
			106,107,						 117,118
		}
	},
	[23] = {
		["BigSquareL"] = {
			23,24,25,26,27,28,
			38,39,40,41,42,43,
			53,54,55,56,57,58,
			68,69,70,71,72,73,
			83,84,85,86,87,88,
			98,99,100,101,102,103,
			113,114,115,116,117,118
		},
		["BigSquareR"] = {
			16,17,18,19,20,21,
			31,32,33,34,35,36,
			46,47,48,49,50,51,
			61,62,63,64,65,66,
			76,77,78,79,80,81,
			91,92,93,94,95,96,
			106,107,108,109,110,111,
		},
		["BigSquare"] = {
			16,17,18,					  26,27,28,
			31,32,33,					  41,42,43,
			46,47,48,					  56,57,58,
			61,62,63,					  71,72,73,
			76,77,78,					  86,87,88,
			91,92,93,					  101,102,103,
			106,107,108,				  116,117,118
		}
	},
	[24] = {
		["WideHallway"] = {
			16,17,18,19,20,21,22,23,24,25,26,27,28,





			106,107,108,109,110,111,112,113,114,115,116,117,118
		}
	}
}

mod.ShadingBg.ClosetL		  = mod.CreateWallShadingSprites("Closet",		   nil,				"shading_closet_l.png")
mod.ShadingBg.ClosetR		  = mod.CreateWallShadingSprites("Closet",		   Vector(300,140), "shading_closet_r.png", false)
mod.ShadingBg.ClosetU		  = mod.CreateWallShadingSprites("Closet",		   Vector(180,60),	"shading_closet_l.png", true, true)
mod.ShadingBg.ClosetD		  = mod.CreateWallShadingSprites("Closet",		   Vector(180,216),	"shading_closet_l.png", true, true)
mod.ShadingBg.TallClosetL	  = mod.CreateWallShadingSprites("SkinnyHallway",  Vector(60,60),	"shading_iv.png",		true, true)
mod.ShadingBg.TallClosetR	  = mod.CreateWallShadingSprites("SkinnyHallway",  Vector(458,60),	"shading_iv.png",		true, true)
mod.ShadingBg.TallClosetU	  = mod.CreateWallShadingSprites("SkinnyHallway",  Vector(260,60),	"shading_iv.png",		true, true)
mod.ShadingBg.TallClosetD	  = mod.CreateWallShadingSprites("SkinnyHallway",  Vector(260,140),	"shading_iv.png",		true, true)
mod.ShadingBg.WideClosetL	  = mod.CreateWallShadingSprites("WideCloset",	   Vector(60,98),	"shading.png",			true, true)
mod.ShadingBg.WideClosetR	  = mod.CreateWallShadingSprites("WideCloset",	   Vector(300,98),	"shading.png",			true, true)
mod.ShadingBg.WideClosetU	  = mod.CreateWallShadingSprites("WideCloset",	   Vector(180,60),	"shading.png",			true, true)
mod.ShadingBg.WideClosetD	  = mod.CreateWallShadingSprites("WideCloset",	   Vector(180,140),	"shading.png",			true, true)
mod.ShadingBg.WideTallClosetL = mod.CreateWallShadingSprites("WideTallCloset", Vector(60,60),	"shading_iv.png",		true, true, Vector(380,60))
mod.ShadingBg.WideTallClosetR = mod.CreateWallShadingSprites("WideTallCloset", Vector(380,60),	"shading_iv.png",		true, true, Vector(-60,60))
mod.ShadingBg.BigClosetL	  = mod.CreateWallShadingSprites("BigCloset",	   Vector(60,98),	"shading.png",			true, true)
mod.ShadingBg.BigClosetR	  = mod.CreateWallShadingSprites("BigCloset",	   Vector(220,98),	"shading.png",			true, true)
mod.ShadingBg.BigClosetU	  = mod.CreateWallShadingSprites("BigCloset",	   Vector(140,60),	"shading.png",			true, true)
mod.ShadingBg.BigClosetD	  = mod.CreateWallShadingSprites("BigCloset",	   Vector(140,140),	"shading.png",			true, true)
mod.ShadingBg.TinyClosetL	  = mod.CreateWallShadingSprites("TinyCloset",	   nil,				"shading_closet_l.png", true, true, Vector(380,60))
mod.ShadingBg.TinyClosetR	  = mod.CreateWallShadingSprites("TinyCloset",	   Vector(380,140), "shading_closet_l.png", true, true, Vector(-60,60))
mod.ShadingBg.TinyClosetU	  = mod.CreateWallShadingSprites("TinyCloset",	   Vector(220,60),	"shading_closet_l.png", true, true)
mod.ShadingBg.TinyClosetD	  = mod.CreateWallShadingSprites("TinyCloset",	   Vector(220,216), "shading_closet_l.png", true, true)
mod.ShadingBg.TinyTallClosetL = mod.CreateWallShadingSprites("TinyTallCloset", Vector(60,98),	"shading_iv.png",		true, true, Vector(380,60))
mod.ShadingBg.TinyTallClosetR = mod.CreateWallShadingSprites("TinyTallCloset", Vector(458,98),	"shading_iv.png",		true, true, Vector(-60,60))
mod.ShadingBg.TinyTallClosetU = mod.CreateWallShadingSprites("TinyTallCloset", Vector(260,60),	"shading_iv.png",		true, true)
mod.ShadingBg.TinyTallClosetD = mod.CreateWallShadingSprites("TinyTallCloset", Vector(260,140), "shading_iv.png",		true, true)
mod.ShadingBg.TinySquareL	  = mod.CreateWallShadingSprites("TinySquare",	   nil,				"shading_closet_l.png", true, true, Vector(380,60))
mod.ShadingBg.TinySquareR	  = mod.CreateWallShadingSprites("TinySquare",	   Vector(458,140), "shading_closet_l.png", true, true, Vector(-60,60))
mod.ShadingBg.TinySquareU	  = mod.CreateWallShadingSprites("TinySquare",	   Vector(260,60),	"shading_closet_l.png", true, true)
mod.ShadingBg.TinySquareD	  = mod.CreateWallShadingSprites("TinySquare",	   Vector(260,216), "shading_closet_l.png", true, true)
mod.ShadingBg.SquareL		  = mod.CreateWallShadingSprites("Square",		   Vector(60,98),	"shading_iv.png",		true, true, Vector(380,60))
mod.ShadingBg.SquareR		  = mod.CreateWallShadingSprites("Square",		   Vector(380,98),	"shading_iv.png",		true, true, Vector(-60,60))
mod.ShadingBg.SquareU		  = mod.CreateWallShadingSprites("Square",		   Vector(220,60),	"shading_iv.png",		true, true)
mod.ShadingBg.SquareD		  = mod.CreateWallShadingSprites("Square",		   Vector(220,140), "shading_iv.png",		true, true)
mod.ShadingBg.BigSquare		  = mod.CreateWallShadingSprites("BigSquare",	   Vector(180,60),	"shading.png",			true, true)
mod.ShadingBg.BigSquareL	  = mod.CreateWallShadingSprites("BigSquare",	   Vector(60,60),	"shading.png",			true, true)
mod.ShadingBg.BigSquareR	  = mod.CreateWallShadingSprites("BigSquare",	   Vector(300,60),	"shading.png",			true, true)
mod.ShadingBg.SkinnyHallway	  = mod.CreateWallShadingSprites("SkinnyHallway",  Vector(260,60),	"shading_iv.png",		true, true)
mod.ShadingBg.WideHallway	  = mod.CreateWallShadingSprites("WideHallway",	   Vector(60,98),	"shading.png",			true, true)

mod.ShadingBg.Cover = {}
mod.ShadingBg.Cover.Wall = Sprite("gfx/backdrop/shading/shading.anm2", true)
mod.ShadingBg.Cover.Wall:Play("Cover")

mod.ShadingBg.DefaultRenderPos = Vector(60,140)
mod.ShadingBg.Current = nil
mod.ShadingBg.CurrentExtra = nil
mod.ShadingBg.ShouldRender = false
mod.ShadingBg.CurrentBackdrop = BackdropType.BASEMENT

function mod.BackdropHasWalls(backdrop)
	return backdrop ~= BackdropType.DARKROOM and backdrop ~= BackdropType.MEGA_SATAN and backdrop ~= BackdropType.ERROR_ROOM and backdrop ~= BackdropType.DUNGEON and backdrop ~= BackdropType.PLANETARIUM and backdrop ~= BackdropType.DOGMA and backdrop ~= BackdropType.DUNGEON_GIDEON and backdrop ~= BackdropType.DUNGEON_ROTGUT and backdrop ~= BackdropType.DUNGEON_BEAST
end

function mod.PreRenderWallsShading(color)
	local game = Game()
	local room = game:GetRoom()
	local backdrop = room:GetBackdropType()
	local roomShape = room:GetRoomShape()
	mod.ShadingBg.ShouldRender = false

	if mod.ShadingBg[roomShape] and mod.BackdropHasWalls(backdrop) then
		mod.ShadingBg.ShouldRender = true
		mod.ShadingBg.Current = roomShape
		mod.ShadingBg.CurrentExtra = nil

		if mod.ShadingBg[mod.ShadingBg.Current].AltWalls then
			for priority,gridmaps in ipairs(mod.ShadingBg[mod.ShadingBg.Current].AltWalls) do
				local shapegood = false
				for shape,gridmap in pairs(gridmaps) do
					shapegood = true
					for _,grid in ipairs(gridmap) do
						if room:GetGridCollision(grid) ~= GridCollisionClass.COLLISION_WALL then
							shapegood = false
							break
						end
					end
					if shapegood then
						if mod.ShadingBg[shape] then
							mod.ShadingBg.Current = shape
							if mod.ShadingBg[shape].CoverPos then
								mod.ShadingBg.CurrentExtra = "Cover"
							end
							break
						else
							local underscoreStart, underscoreEnd = string.find(shape, "_")
							if underscoreStart and underscoreEnd then
								local shape1 = string.sub(shape, 1, underscoreStart-1)
								local shape2 = string.sub(shape, underscoreEnd+1)
								print(shape1, shape2)
								if mod.ShadingBg[shape1] then
									mod.ShadingBg.Current = shape1
									if mod.ShadingBg[shape2] then
										mod.ShadingBg.CurrentExtra = shape2
									end
								elseif mod.ShadingBg[shape2] then
									mod.ShadingBg.Current = shape2
								else
									shapegood = false
								end
							else
								shapegood = false
							end
						end
					end
				end
				if shapegood then
					break
				end
			end
		end
	end

	if mod.ShadingBg.ShouldRender then
		if mod.ShadingBg.CurrentBackdrop ~= backdrop then
			mod.ShadingBg.CurrentBackdrop = backdrop
			local backdropData = XMLData.GetEntryById(XMLNode.BACKDROP, backdrop)
			if backdropData.gfx then
				for _,data in pairs(mod.ShadingBg) do
					if type(data) == "table" then
						if data.Wall then
							mod.ReplaceShadingBackdropSheet(data.Wall, backdropData.gfx)
						end
						if data.Floor then
							mod.ReplaceShadingBackdropSheet(data.Floor, backdropData.gfx)
						end
					end
				end
			end
		end
		if Isaac.CountEntities(nil, EntityType.ENTITY_EFFECT, EffectVariant.DESECRATION, mod.Effects.FAKE_WALL_HANDLER) == 0 then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DESECRATION, mod.Effects.FAKE_WALL_HANDLER, Vector(0,-1500), Vector.Zero, nil).SortingLayer = SortingLayer.SORTING_DOOR
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DESECRATION, mod.Effects.FAKE_WALL_HANDLER, Vector(0,-1500), Vector.Zero, nil).SortingLayer = SortingLayer.SORTING_BACKGROUND
		end
	end
end
mod.AddCallback(ModCallbacks.MC_PRE_BACKDROP_RENDER_WALLS, mod.PreRenderWallsShading)

mod.ModEffectRenderFuncs[mod.Effects.FAKE_WALL_HANDLER] = function(effect,sprite,data)
	if mod.ShadingBg.ShouldRender and mod.ShadingBg.Current and mod.ShadingBg[mod.ShadingBg.Current] then
		local rendermode = Game():GetRoom():GetRenderMode()
		if rendermode == RenderMode.RENDER_NORMAL or rendermode == RenderMode.RENDER_WATER_ABOVE then
			if effect.SortingLayer == SortingLayer.SORTING_DOOR then
				if mod.ShadingBg[mod.ShadingBg.Current].Wall then
					mod.ShadingBg[mod.ShadingBg.Current].Wall:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.Current].RenderPos or mod.ShadingBg.DefaultRenderPos))
				end
				if mod.ShadingBg[mod.ShadingBg.Current].Shading then
					mod.ShadingBg[mod.ShadingBg.Current].Shading:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.Current].ShadingPos or mod.ShadingBg.DefaultRenderPos))
				end
				if mod.ShadingBg.CurrentExtra and mod.ShadingBg[mod.ShadingBg.CurrentExtra] then
					if mod.ShadingBg.CurrentExtra == "Cover" then
						mod.ShadingBg.Cover.Wall:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.Current].CoverPos or mod.ShadingBg.DefaultRenderPos))
					else
						if mod.ShadingBg[mod.ShadingBg.CurrentExtra].Wall then
							mod.ShadingBg[mod.ShadingBg.CurrentExtra].Wall:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.CurrentExtra].RenderPos or mod.ShadingBg.DefaultRenderPos))
						end
						if mod.ShadingBg[mod.ShadingBg.CurrentExtra].Shading then
							mod.ShadingBg[mod.ShadingBg.CurrentExtra].Shading:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.CurrentExtra].ShadingPos or mod.ShadingBg.DefaultRenderPos))
						end
					end
				end
			end
			if effect.SortingLayer == SortingLayer.SORTING_BACKGROUND then
				if mod.ShadingBg[mod.ShadingBg.Current].Floor then
					mod.ShadingBg[mod.ShadingBg.Current].Floor:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.Current].RenderPos or mod.ShadingBg.DefaultRenderPos))
				end
				if mod.ShadingBg.CurrentExtra and mod.ShadingBg[mod.ShadingBg.CurrentExtra] and mod.ShadingBg[mod.ShadingBg.CurrentExtra].Floor then
					mod.ShadingBg[mod.ShadingBg.CurrentExtra].Floor:Render(Isaac.WorldToScreen(mod.ShadingBg[mod.ShadingBg.CurrentExtra].RenderPos or mod.ShadingBg.DefaultRenderPos))
				end
			end
		end
	end
end
