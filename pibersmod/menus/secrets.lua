local mod = PibersMod

mod.StatViewPos = Vector(444.5,-1365)
mod.SecretViewPos = Vector(-1000,-1365)
mod.SecretPos = Vector(-1000,-1365)
mod.SecretSprite = Sprite("gfx/ui/main menu/todo.anm2", true)
mod.SecretSprite:Play("Icon1Unlocked")
mod.SecretSpriteLocked = Sprite("gfx/ui/main menu/todo.anm2", true)
mod.SecretSpriteLocked:Play("Icon1Locked")

mod.CurrentlySelectedSecret = 1
mod.LastSecretPageFrame = -1
mod.LastSecretPageAnim = "Idle"

local loopvar = 0
mod.SecretBases = {}
mod.SecretBases[4] = "womb"
mod.SecretBases[5] = "mom"
mod.SecretBases[6] = "mom"
mod.SecretBases[8] = "womb"
mod.SecretBases[9] = "bossrush"
mod.SecretBases[10] = "womb"
mod.SecretBases[11] = "womb"
mod.SecretBases[12] = "depths"
mod.SecretBases[13] = "basement"
mod.SecretBases[14] = "caves"
mod.SecretBases[15] = "womb"
mod.SecretBases[20] = "cathedral"
mod.SecretBases[21] = "cathedral"
mod.SecretBases[23] = "depths"
mod.SecretBases[24] = "basement"
mod.SecretBases[25] = "caves"
mod.SecretBases[26] = "character"
mod.SecretBases[27] = "mom"
mod.SecretBases[28] = "depths"
mod.SecretBases[29] = "cathedral"
mod.SecretBases[33] = "womb"
mod.SecretBases[34] = "womb"
mod.SecretBases[35] = "mom"
mod.SecretBases[43] = "sheol"
mod.SecretBases[44] = "sheol"
mod.SecretBases[45] = "sheol"
mod.SecretBases[46] = "sheol"
mod.SecretBases[47] = "darkroom"
mod.SecretBases[48] = "sheol"
mod.SecretBases[49] = "chest"
mod.SecretBases[50] = "chest"
mod.SecretBases[51] = "darkroom"
mod.SecretBases[52] = "darkroom"
mod.SecretBases[53] = "chest"
mod.SecretBases[54] = "cathedral"
mod.SecretBases[55] = "chest"
mod.SecretBases[56] = "sheol"
mod.SecretBases[57] = "cathedral"
mod.SecretBases[58] = "cathedral"
mod.SecretBases[59] = "donation"
mod.SecretBases[60] = "challenge"
mod.SecretBases[61] = "donation"
mod.SecretBases[62] = "cathedral"
mod.SecretBases[63] = "cathedral"
mod.SecretBases[64] = "donation"
mod.SecretBases[65] = "depths"
mod.SecretBases[66] = "cathedral"
mod.SecretBases[66] = "cathedral"
mod.SecretBases[68] = "womb"
mod.SecretBases[70] = "bossrush"
mod.SecretBases[71] = "darkroom"
mod.SecretBases[72] = "sheol"
mod.SecretBases[73] = "darkroom"
mod.SecretBases[74] = "darkroom"
mod.SecretBases[75] = "chest"
mod.SecretBases[76] = "cathedral"
mod.SecretBases[77] = "chest"
mod.SecretBases[78] = "sheol"
mod.SecretBases[85] = "depths"
mod.SecretBases[86] = "basement"
mod.SecretBases[87] = "caves"
mod.SecretBases[88] = "depths"
mod.SecretBases[89] = "challenge"
mod.SecretBases[90] = "challenge"
mod.SecretBases[91] = "challenge"
mod.SecretBases[92] = "challenge"
mod.SecretBases[93] = "challenge"
mod.SecretBases[94] = "challenge"
mod.SecretBases[95] = "challenge"
mod.SecretBases[96] = "challenge"
mod.SecretBases[97] = "challenge"
mod.SecretBases[98] = "challenge"
mod.SecretBases[99] = "challenge"
mod.SecretBases[100] = "challenge"
mod.SecretBases[101] = "challenge"
mod.SecretBases[102] = "challenge"
mod.SecretBases[103] = "challenge"
mod.SecretBases[104] = "challenge"
mod.SecretBases[105] = "challenge"
mod.SecretBases[106] = "cathedral"
mod.SecretBases[107] = "cathedral"
mod.SecretBases[108] = "bossrush"
mod.SecretBases[109] = "bossrush"
mod.SecretBases[110] = "bossrush"
mod.SecretBases[111] = "darkroom"
mod.SecretBases[112] = "bossrush"
mod.SecretBases[113] = "chest"
mod.SecretBases[114] = "bossrush"
mod.SecretBases[115] = "bossrush"
mod.SecretBases[116] = "cathedral"
mod.SecretBases[117] = "sheol"
mod.SecretBases[118] = "chest"
mod.SecretBases[119] = "darkroom"
mod.SecretBases[120] = "challenge"
mod.SecretBases[121] = "cathedral"
mod.SecretBases[122] = "sheol"
mod.SecretBases[123] = "chest"
mod.SecretBases[124] = "darkroom"
mod.SecretBases[125] = "bossrush"
mod.SecretBases[126] = "cathedral"
mod.SecretBases[127] = "sheol"
mod.SecretBases[128] = "chest"
mod.SecretBases[129] = "cathedral"
mod.SecretBases[130] = "sheol"
mod.SecretBases[131] = "chest"
mod.SecretBases[132] = "darkroom"
mod.SecretBases[133] = "bossrush"
mod.SecretBases[134] = "donation"
mod.SecretBases[135] = "donation"
mod.SecretBases[136] = "donation"
mod.SecretBases[137] = "donation"
mod.SecretBases[138] = "donation"
mod.SecretBases[139] = "womb"
mod.SecretBases[140] = "womb"
mod.SecretBases[141] = "womb"
mod.SecretBases[142] = "sheol"
mod.SecretBases[143] = "sheol"
mod.SecretBases[144] = "womb"
mod.SecretBases[145] = "caves"
mod.SecretBases[148] = "donation"
mod.SecretBases[149] = "darkroom"
mod.SecretBases[150] = "womb"
mod.SecretBases[155] = "cathedral"
mod.SecretBases[156] = "god"
mod.SecretBases[167] = "womb"
mod.SecretBases[168] = "womb"
mod.SecretBases[169] = "womb"
mod.SecretBases[170] = "womb"
mod.SecretBases[171] = "womb"
mod.SecretBases[172] = "womb"
mod.SecretBases[173] = "womb"
mod.SecretBases[174] = "womb"
mod.SecretBases[175] = "womb"
mod.SecretBases[176] = "womb"
mod.SecretBases[177] = "womb"
mod.SecretBases[179] = "bluewomb"
mod.SecretBases[180] = "bluewomb"
mod.SecretBases[181] = "bluewomb"
mod.SecretBases[182] = "bluewomb"
mod.SecretBases[183] = "bluewomb"
mod.SecretBases[184] = "bluewomb"
mod.SecretBases[185] = "bluewomb"
mod.SecretBases[186] = "bluewomb"
mod.SecretBases[187] = "bluewomb"
mod.SecretBases[188] = "bluewomb"
mod.SecretBases[189] = "bluewomb"
mod.SecretBases[190] = "bluewomb"
mod.SecretBases[191] = "bluewomb"
mod.SecretBases[192] = "greed"
mod.SecretBases[193] = "greed"
mod.SecretBases[194] = "greed"
mod.SecretBases[195] = "greed"
mod.SecretBases[196] = "greed"
mod.SecretBases[197] = "greed"
mod.SecretBases[198] = "greed"
mod.SecretBases[200] = "greed"
mod.SecretBases[201] = "greed"
mod.SecretBases[202] = "greed"
mod.SecretBases[203] = "greed"
mod.SecretBases[204] = "greed"
mod.SecretBases[205] = "megasatan"
mod.SecretBases[206] = "megasatan"
mod.SecretBases[207] = "megasatan"
mod.SecretBases[208] = "megasatan"
mod.SecretBases[209] = "megasatan"
mod.SecretBases[210] = "megasatan"
mod.SecretBases[211] = "megasatan"
mod.SecretBases[212] = "megasatan"
mod.SecretBases[213] = "megasatan"
mod.SecretBases[214] = "megasatan"
mod.SecretBases[215] = "megasatan"
mod.SecretBases[216] = "megasatan"
mod.SecretBases[217] = "megasatan"
mod.SecretBases[218] = "cathedral"
mod.SecretBases[219] = "chest"
mod.SecretBases[220] = "sheol"
mod.SecretBases[221] = "darkroom"
mod.SecretBases[222] = "bossrush"
mod.SecretBases[223] = "womb"
mod.SecretBases[224] = "challenge"
mod.SecretBases[225] = "challenge"
mod.SecretBases[226] = "challenge"
mod.SecretBases[227] = "challenge"
mod.SecretBases[228] = "challenge"
mod.SecretBases[229] = "challenge"
mod.SecretBases[230] = "challenge"
mod.SecretBases[231] = "challenge"
mod.SecretBases[232] = "challenge"
mod.SecretBases[233] = "challenge"
mod.SecretBases[234] = "bluewomb"
mod.SecretBases[235] = "god"
mod.SecretBases[236] = "cathedral"
mod.SecretBases[237] = "sheol"
mod.SecretBases[238] = "chest"
mod.SecretBases[239] = "darkroom"
mod.SecretBases[240] = "bossrush"
mod.SecretBases[241] = "womb"
mod.SecretBases[242] = "greeddonation"
mod.SecretBases[243] = "greeddonation"
mod.SecretBases[244] = "greeddonation"
mod.SecretBases[245] = "greeddonation"
mod.SecretBases[246] = "greeddonation"
mod.SecretBases[247] = "greeddonation"
mod.SecretBases[248] = "greeddonation"
mod.SecretBases[249] = "greeddonation"
mod.SecretBases[250] = "greeddonation"
mod.SecretBases[252] = "god"
mod.SecretBases[253] = "god"
mod.SecretBases[254] = "god"
mod.SecretBases[255] = "god"
mod.SecretBases[256] = "god"
mod.SecretBases[257] = "god"
mod.SecretBases[258] = "god"
mod.SecretBases[259] = "god"
mod.SecretBases[260] = "god"
mod.SecretBases[261] = "god"
mod.SecretBases[262] = "god"
mod.SecretBases[263] = "god"
mod.SecretBases[264] = "god"
mod.SecretBases[276] = "megasatan"
mod.SecretBases[282] = "void"
mod.SecretBases[283] = "void"
mod.SecretBases[284] = "void"
mod.SecretBases[285] = "void"
mod.SecretBases[286] = "void"
mod.SecretBases[287] = "void"
mod.SecretBases[288] = "void"
mod.SecretBases[289] = "void"
mod.SecretBases[290] = "void"
mod.SecretBases[291] = "void"
mod.SecretBases[292] = "void"
mod.SecretBases[293] = "void"
mod.SecretBases[294] = "void"
mod.SecretBases[295] = "void"
loopvar = 296
while loopvar <= 309 do
	mod.SecretBases[loopvar] = "greed"
	loopvar = loopvar+1
end
mod.SecretBases[311] = "sheol"
mod.SecretBases[312] = "chest"
mod.SecretBases[313] = "darkroom"
mod.SecretBases[314] = "bossrush"
mod.SecretBases[315] = "bluewomb"
mod.SecretBases[316] = "greed"
mod.SecretBases[317] = "megasatan"
mod.SecretBases[318] = "womb"
mod.SecretBases[319] = "god"
mod.SecretBases[320] = "void"
mod.SecretBases[321] = "darkroom"
mod.SecretBases[322] = "god"
mod.SecretBases[323] = "god"
mod.SecretBases[324] = "god"
mod.SecretBases[325] = "online"
mod.SecretBases[326] = "darkroom"
mod.SecretBases[327] = "darkroom"
mod.SecretBases[329] = "god"
mod.SecretBases[330] = "god"
loopvar = 331
while loopvar <= 335 do
	mod.SecretBases[loopvar] = "challenge"
	loopvar = loopvar+1
end
mod.SecretBases[336] = "online"
mod.SecretBases[337] = "darkroom"
mod.SecretBases[339] = "god"
mod.SecretBases[341] = "greeddonation"
mod.SecretBases[342] = "basement"
mod.SecretBases[343] = "bluewomb"
mod.SecretBases[344] = "depths"
mod.SecretBases[345] = "womb"
mod.SecretBases[346] = "chest"
mod.SecretBases[347] = "chest"
mod.SecretBases[348] = "darkroom"
mod.SecretBases[349] = "darkroom"
mod.SecretBases[350] = "depths"
mod.SecretBases[351] = "basement"
mod.SecretBases[353] = "caves"
mod.SecretBases[354] = "online"
mod.SecretBases[356] = "basement"
mod.SecretBases[357] = "void"
mod.SecretBases[360] = "darkroom"
mod.SecretBases[364] = "donation"
mod.SecretBases[365] = "caves"
mod.SecretBases[366] = "darkroom"
mod.SecretBases[368] = "depths"
mod.SecretBases[370] = "cathedral"
mod.SecretBases[373] = "cathedral"
mod.SecretBases[374] = "womb"
mod.SecretBases[375] = "depths"
mod.SecretBases[376] = "sheol"
mod.SecretBases[379] = "donation"
mod.SecretBases[380] = "cathedral"
mod.SecretBases[383] = "sheol"
mod.SecretBases[391] = "darkroom"
mod.SecretBases[392] = "womb"
mod.SecretBases[393] = "cathedral"
mod.SecretBases[394] = "sheol"
mod.SecretBases[395] = "chest"
mod.SecretBases[396] = "darkroom"
mod.SecretBases[397] = "bossrush"
mod.SecretBases[398] = "bluewomb"
mod.SecretBases[399] = "greed"
mod.SecretBases[400] = "greed"
mod.SecretBases[401] = "void"
mod.SecretBases[402] = "god"
mod.SecretBases[403] = "megasatan"
mod.SecretBases[407] = "bluewomb"
mod.SecretBases[408] = "depths"
mod.SecretBases[409] = "basement"
mod.SecretBases[410] = "basement"
mod.SecretBases[411] = "corpse"
mod.SecretBases[412] = "bluewomb"
mod.SecretBases[413] = "depths"
mod.SecretBases[414] = "darkroom"
mod.SecretBases[423] = "bluewomb"
mod.SecretBases[435] = "bluewomb"
loopvar = 474
while loopvar <= 490 do
	mod.SecretBases[loopvar] = "tainted"
	loopvar = loopvar+1
end
loopvar = 491
while loopvar <= 507 do
	mod.SecretBases[loopvar] = "beast"
	loopvar = loopvar+1
end
loopvar = 524
while loopvar <= 537 do
	mod.SecretBases[loopvar] = "greed"
	loopvar = loopvar+1
end
mod.SecretBases[538] = "challenge"
loopvar = 539
while loopvar <= 544 do
	mod.SecretBases[loopvar] = "greed"
	loopvar = loopvar+1
end
mod.SecretBases[546] = "depths"
mod.SecretBases[548] = "darkroom"
mod.SecretBases[549] = "corpse"
mod.SecretBases[550] = "darkroom"
mod.SecretBases[551] = "corpse"
mod.SecretBases[552] = "darkroom"
mod.SecretBases[553] = "corpse"
mod.SecretBases[554] = "darkroom"
mod.SecretBases[555] = "corpse"
mod.SecretBases[556] = "darkroom"
mod.SecretBases[557] = "corpse"
mod.SecretBases[558] = "darkroom"
mod.SecretBases[559] = "corpse"
mod.SecretBases[560] = "darkroom"
mod.SecretBases[561] = "corpse"
mod.SecretBases[562] = "darkroom"
mod.SecretBases[563] = "corpse"
mod.SecretBases[564] = "darkroom"
mod.SecretBases[565] = "corpse"
mod.SecretBases[566] = "darkroom"
mod.SecretBases[567] = "corpse"
mod.SecretBases[568] = "darkroom"
mod.SecretBases[569] = "corpse"
mod.SecretBases[570] = "darkroom"
mod.SecretBases[571] = "corpse"
mod.SecretBases[572] = "darkroom"
mod.SecretBases[573] = "corpse"
mod.SecretBases[574] = "darkroom"
mod.SecretBases[575] = "corpse"
mod.SecretBases[576] = "darkroom"
mod.SecretBases[577] = "corpse"
mod.SecretBases[578] = "darkroom"
mod.SecretBases[579] = "corpse"
mod.SecretBases[580] = "darkroom"
mod.SecretBases[581] = "corpse"
mod.SecretBases[582] = "donation"
mod.SecretBases[583] = "donation"
loopvar = 584
while loopvar <= 600 do
	mod.SecretBases[loopvar] = "void"
	loopvar = loopvar+1
end
loopvar = 601
while loopvar <= 617 do
	mod.SecretBases[loopvar] = "megasatan"
	loopvar = loopvar+1
end
loopvar = 618
while loopvar <= 634 do
	mod.SecretBases[loopvar] = "bluewomb"
	loopvar = loopvar+1
end
mod.SecretBases[635] = "corpse"
mod.SecretBases[636] = "god"

mod.SecretOverlays = {}
mod.SecretOverlays[30] = "blood"
mod.SecretOverlays[31] = "blood"
mod.SecretOverlays[147] = "blood"
mod.SecretOverlays[155] = "blood"
mod.SecretOverlays[156] = "blood"
loopvar = 167
while loopvar <= 177 do
	mod.SecretOverlays[loopvar] = "blood"
	loopvar = loopvar+1
end
mod.SecretOverlays[223] = "blood"
mod.SecretOverlays[241] = "blood"
loopvar = 252
while loopvar <= 264 do
	mod.SecretOverlays[loopvar] = "blood"
	loopvar = loopvar+1
end
loopvar = 296
while loopvar <= 309 do
	mod.SecretOverlays[loopvar] = "blood"
	loopvar = loopvar+1
end
mod.SecretOverlays[318] = "blood"
mod.SecretOverlays[319] = "blood"
mod.SecretOverlays[328] = "blood"
mod.SecretOverlays[376] = "blood"
mod.SecretOverlays[383] = "blood"
mod.SecretOverlays[384] = "blood"
mod.SecretOverlays[392] = "blood"
mod.SecretOverlays[400] = "blood"
mod.SecretOverlays[402] = "blood"
loopvar = 491
while loopvar <= 507 do
	mod.SecretOverlays[loopvar] = "tainted"
	loopvar = loopvar+1
end
mod.SecretOverlays[516] = "deletethis"
loopvar = 524
while loopvar <= 544 do
	mod.SecretOverlays[loopvar] = "tainted"
	loopvar = loopvar+1
end
mod.SecretOverlays[545] = "blood"
mod.SecretOverlays[546] = "blood"
mod.SecretOverlays[547] = "blood"
loopvar = 548
while loopvar <= 636 do
	mod.SecretOverlays[loopvar] = "tainted"
	loopvar = loopvar+1
end

mod.SecretIconsItems = {}
mod.SecretIconsItems[154] = CollectibleType.COLLECTIBLE_DOLLAR
mod.SecretIconsItems[155] = CollectibleType.BLOODY_FEATHER
mod.SecretIconsItems[157] = CollectibleType.COLLECTIBLE_DARK_MATTER
mod.SecretIconsItems[158] = CollectibleType.COLLECTIBLE_BUCKET_OF_LARD
mod.SecretIconsItems[159] = CollectibleType.COLLECTIBLE_HALO_OF_FLIES
mod.SecretIconsItems[160] = CollectibleType.COLLECTIBLE_MY_REFLECTION
mod.SecretIconsItems[161] = CollectibleType.COLLECTIBLE_GUPPYS_HEAD
mod.SecretIconsItems[162] = CollectibleType.COLLECTIBLE_REMOTE_DETONATOR
mod.SecretIconsItems[165] = CollectibleType.COLLECTIBLE_BROTHER_BOBBY
mod.SecretIconsItems[236] = CollectibleType.COLLECTIBLE_WOODEN_NICKEL
mod.SecretIconsItems[248] = CollectibleType.COLLECTIBLE_RAZOR_BLADE
mod.SecretIconsItems[250] = CollectibleType.COLLECTIBLE_HOLY_MANTLE
mod.SecretIconsItems[269] = CollectibleType.COLLECTIBLE_CHARM_VAMPIRE
mod.SecretIconsItems[270] = CollectibleType.COLLECTIBLE_BOOMERANG
mod.SecretIconsItems[271] = CollectibleType.COLLECTIBLE_BOBS_BRAIN
mod.SecretIconsItems[272] = CollectibleType.COLLECTIBLE_RAINBOW_BABY
mod.SecretIconsItems[279] = CollectibleType.COLLECTIBLE_POKE_GO
mod.SecretIconsItems[508] = CollectibleType.COLLECTIBLE_BLOOD_OATH

mod.SecretIconsTrinkets = {}
mod.SecretIconsTrinkets[237] = TrinketType.TRINKET_STORE_KEY
mod.SecretIconsTrinkets[245] = TrinketType.TRINKET_PAPER_CLIP

mod.SecretIconsTrinketOffset = {}
mod.SecretIconsTrinketOffset[55] = true
mod.SecretIconsTrinketOffset[64] = true
mod.SecretIconsTrinketOffset[360] = true
mod.SecretIconsTrinketOffset[388] = true
mod.SecretIconsTrinketOffset[389] = true
mod.SecretIconsTrinketOffset[399] = true
mod.SecretIconsTrinketOffset[454] = true
mod.SecretIconsTrinketOffset[493] = true
mod.SecretIconsTrinketOffset[556] = true
mod.SecretIconsTrinketOffset[562] = true
mod.SecretIconsTrinketOffset[563] = true
mod.SecretIconsTrinketOffset[573] = true

mod.SecretIconsTrinketOffsetSlight = {}
mod.SecretIconsTrinketOffsetSlight[71] = true
mod.SecretIconsTrinketOffsetSlight[72] = true
mod.SecretIconsTrinketOffsetSlight[85] = true
mod.SecretIconsTrinketOffsetSlight[101] = true
mod.SecretIconsTrinketOffsetSlight[108] = true
mod.SecretIconsTrinketOffsetSlight[111] = true
mod.SecretIconsTrinketOffsetSlight[118] = true
mod.SecretIconsTrinketOffsetSlight[196] = true
mod.SecretIconsTrinketOffsetSlight[204] = true
mod.SecretIconsTrinketOffsetSlight[229] = true
mod.SecretIconsTrinketOffsetSlight[232] = true
mod.SecretIconsTrinketOffsetSlight[239] = true
mod.SecretIconsTrinketOffsetSlight[287] = true
mod.SecretIconsTrinketOffsetSlight[301] = true
mod.SecretIconsTrinketOffsetSlight[304] = true
mod.SecretIconsTrinketOffsetSlight[336] = true
mod.SecretIconsTrinketOffsetSlight[375] = true
mod.SecretIconsTrinketOffsetSlight[381] = true
mod.SecretIconsTrinketOffsetSlight[408] = true
mod.SecretIconsTrinketOffsetSlight[419] = true
mod.SecretIconsTrinketOffsetSlight[421] = true
mod.SecretIconsTrinketOffsetSlight[518] = true
mod.SecretIconsTrinketOffsetSlight[521] = true
mod.SecretIconsTrinketOffsetSlight[522] = true
mod.SecretIconsTrinketOffsetSlight[523] = true
mod.SecretIconsTrinketOffsetSlight[548] = true
mod.SecretIconsTrinketOffsetSlight[549] = true
mod.SecretIconsTrinketOffsetSlight[550] = true
mod.SecretIconsTrinketOffsetSlight[551] = true
mod.SecretIconsTrinketOffsetSlight[552] = true
mod.SecretIconsTrinketOffsetSlight[553] = true
mod.SecretIconsTrinketOffsetSlight[554] = true
mod.SecretIconsTrinketOffsetSlight[555] = true
mod.SecretIconsTrinketOffsetSlight[557] = true
mod.SecretIconsTrinketOffsetSlight[558] = true
mod.SecretIconsTrinketOffsetSlight[559] = true
mod.SecretIconsTrinketOffsetSlight[560] = true
mod.SecretIconsTrinketOffsetSlight[561] = true
mod.SecretIconsTrinketOffsetSlight[564] = true
mod.SecretIconsTrinketOffsetSlight[565] = true
mod.SecretIconsTrinketOffsetSlight[566] = true
mod.SecretIconsTrinketOffsetSlight[567] = true
mod.SecretIconsTrinketOffsetSlight[568] = true
mod.SecretIconsTrinketOffsetSlight[569] = true
mod.SecretIconsTrinketOffsetSlight[570] = true
mod.SecretIconsTrinketOffsetSlight[572] = true
mod.SecretIconsTrinketOffsetSlight[574] = true
mod.SecretIconsTrinketOffsetSlight[577] = true
mod.SecretIconsTrinketOffsetSlight[578] = true
mod.SecretIconsTrinketOffsetSlight[579] = true
mod.SecretIconsTrinketOffsetSlight[581] = true

mod.SecretIconsCoins = {}
mod.SecretIconsCoins[151] = "pickup_002_coin"
mod.SecretIconsCoins[152] = "pickup_002_coinblack"
mod.SecretIconsCoins[153] = "pickup_002_coinsilver"
mod.SecretIconsCoins[242] = "pickup_002_lucky_penny"

mod.SecretIcons32x = {}
mod.SecretIcons32x[89] = "ui/main menu/secrets/rune_of_hagalaz"
mod.SecretIcons32x[90] = "ui/main menu/secrets/rune_of_jera"
mod.SecretIcons32x[91] = "ui/main menu/secrets/rune_of_ehwaz"
mod.SecretIcons32x[92] = "ui/main menu/secrets/rune_of_dagaz"
mod.SecretIcons32x[93] = "ui/main menu/secrets/rune_of_ansuz"
mod.SecretIcons32x[94] = "ui/main menu/secrets/rune_of_perthro"
mod.SecretIcons32x[95] = "ui/main menu/secrets/rune_of_berkano"
mod.SecretIcons32x[96] = "ui/main menu/secrets/rune_of_algiz"
mod.SecretIcons32x[97] = "ui/main menu/secrets/chaos_card"
mod.SecretIcons32x[98] = "ui/main menu/secrets/credit_card"
mod.SecretIcons32x[99] = "ui/main menu/secrets/rules_card"
mod.SecretIcons32x[100] = "ui/main menu/secrets/card_against_humanity"
mod.SecretIcons32x[120] = "ui/main menu/secrets/suicide_king"
mod.SecretIcons32x[144] = "familiar/familiar_other_04_cubeofmeatlevel4"
mod.SecretIcons32x[164] = "ui/main menu/secrets/glass_cannon"
mod.SecretIcons32x[176] = "ui/main menu/secrets/glitch_baby"
mod.SecretIcons32x[191] = "ui/main menu/secrets/keeper_now_holds_a_penny"
mod.SecretIcons32x[224] = "ui/main menu/secrets/gold_heart"
mod.SecretIcons32x[225] = "ui/main menu/secrets/get_out_of_jail_free_card"
mod.SecretIcons32x[226] = "ui/main menu/secrets/gold_bomb"
mod.SecretIcons32x[227] = "ui/main menu/secrets/pay_to_play_pills"
mod.SecretIcons32x[228] = "ui/main menu/secrets/have_a_heart_pills"
mod.SecretIcons32x[233] = "ui/main menu/secrets/blank_rune"
mod.SecretIcons32x[235] = "ui/main menu/secrets/1001"
mod.SecretIcons32x[240] = "ui/main menu/secrets/sticky_nickels"
mod.SecretIcons32x[266] = "ui/main menu/secrets/turbo"
mod.SecretIcons32x[267] = "ui/main menu/secrets/blue_bomber"
mod.SecretIcons32x[273] = "ui/main menu/secrets/onans_streak"
mod.SecretIcons32x[293] = "ui/main menu/secrets/holy_card"
mod.SecretIcons32x[309] = "ui/main menu/secrets/black_rune"
mod.SecretIcons32x[321] = "ui/main menu/secrets/once_more_with_feeling"
mod.SecretIcons32x[322] = "ui/main menu/secrets/hat_trick"
mod.SecretIcons32x[324] = "ui/main menu/secrets/sin_collector"
mod.SecretIcons32x[325] = "ui/main menu/secrets/dedication"
mod.SecretIcons32x[326] = "ui/main menu/secrets/zip"
mod.SecretIcons32x[327] = "ui/main menu/secrets/its_the_key"
mod.SecretIcons32x[328] = "ui/main menu/secrets/mr_resetter"
mod.SecretIcons32x[329] = "ui/main menu/secrets/living_on_the_edge"
mod.SecretIcons32x[330] = "ui/main menu/secrets/u_broke_it"
mod.SecretIcons32x[333] = "ui/main menu/secrets/charged_key"
mod.SecretIcons32x[337] = "ui/main menu/secrets/rerun"
mod.SecretIcons32x[338] = "ui/main menu/secrets/delirious"
mod.SecretIcons32x[361] = "ui/main menu/secrets/huge_growth"
mod.SecretIcons32x[362] = "ui/main menu/secrets/ancient_recall"
mod.SecretIcons32x[363] = "ui/main menu/secrets/era_walk"
mod.SecretIcons32x[391] = "ui/main menu/secrets/bone_heart"
mod.SecretIcons32x[403] = "ui/main menu/secrets/bound_baby"
mod.SecretIcons32x[406] = "ui/main menu/secrets/planetarium"
mod.SecretIcons32x[411] = "items/pick ups/pickup_001_heart2"
mod.SecretIcons32x[416] = "ui/main menu/secrets/wisp_baby"
mod.SecretIcons32x[426] = "ui/main menu/secrets/hope_baby"
mod.SecretIcons32x[427] = "ui/main menu/secrets/glowing_baby"
mod.SecretIcons32x[438] = "ui/main menu/secrets/solomons_baby"
--mod.SecretIcons32x[474] = "ui/main menu/secrets/the_broken"
mod.SecretIcons32x[509] = "ui/main menu/secrets/baptism_by_fire"
mod.SecretIcons32x[510] = "ui/main menu/secrets/isaacs_awakening"
mod.SecretIcons32x[511] = "ui/main menu/secrets/seeing_double"
mod.SecretIcons32x[524] = "ui/main menu/secrets/the_fool"
mod.SecretIcons32x[525] = "ui/main menu/secrets/the_magician"
mod.SecretIcons32x[526] = "ui/main menu/secrets/the_high_prestess"
mod.SecretIcons32x[527] = "ui/main menu/secrets/the_empress"
mod.SecretIcons32x[528] = "ui/main menu/secrets/the_emporer"
mod.SecretIcons32x[529] = "ui/main menu/secrets/the_hierophant"
mod.SecretIcons32x[530] = "ui/main menu/secrets/the_lovers"
mod.SecretIcons32x[531] = "ui/main menu/secrets/the_chariot"
mod.SecretIcons32x[532] = "ui/main menu/secrets/justice"
mod.SecretIcons32x[533] = "ui/main menu/secrets/the_hermit"
mod.SecretIcons32x[534] = "ui/main menu/secrets/wheel_of_fortune"
mod.SecretIcons32x[535] = "ui/main menu/secrets/strength"
mod.SecretIcons32x[536] = "ui/main menu/secrets/the_hanged_man"
mod.SecretIcons32x[537] = "ui/main menu/secrets/death"
mod.SecretIcons32x[538] = "ui/main menu/secrets/temperance"
mod.SecretIcons32x[539] = "ui/main menu/secrets/the_devil"
mod.SecretIcons32x[540] = "ui/main menu/secrets/the_tower"
mod.SecretIcons32x[541] = "ui/main menu/secrets/the_stars"
mod.SecretIcons32x[542] = "ui/main menu/secrets/the_sun_and_the_moon"
mod.SecretIcons32x[543] = "ui/main menu/secrets/judgement"
mod.SecretIcons32x[544] = "ui/main menu/secrets/the_world"

mod.SecretIcons48x = {}
mod.SecretIcons48x[5] = "ui/main menu/secrets/harbingers"
mod.SecretIcons48x[38] = "ui/main menu/secrets/spelunker_boy"
mod.SecretIcons48x[39] = "ui/main menu/secrets/dark_boy"
mod.SecretIcons48x[40] = "ui/main menu/secrets/mamas_boy"
mod.SecretIcons48x[41] = "ui/main menu/secrets/golden_god"
mod.SecretIcons48x[66] = "ui/main menu/secrets/a_forgotten_horseman"
mod.SecretIcons48x[69] = "ui/main menu/secrets/platinum_god"
mod.SecretIcons48x[86] = "ui/main menu/secrets/cellar"
mod.SecretIcons48x[87] = "ui/main menu/secrets/catacombs"
mod.SecretIcons48x[88] = "ui/main menu/secrets/necropolis"
mod.SecretIcons48x[178] = "ui/main menu/secrets/lord_of_the_flies"
mod.SecretIcons48x[243] = "ui/main menu/secrets/special_hangingguys"
mod.SecretIcons48x[247] = "ui/main menu/secrets/special_shopkeepers"
mod.SecretIcons48x[274] = "ui/main menu/secrets/the_guardian"
mod.SecretIcons48x[275] = "ui/main menu/secrets/generosity"
mod.SecretIcons48x[277] = "ui/main menu/secrets/backasswards"
mod.SecretIcons48x[280] = "ui/main menu/secrets/ultra_hard"
mod.SecretIcons48x[323] = "ui/main menu/secrets/5_nights_at_moms"
mod.SecretIcons48x[331] = "ui/main menu/secrets/laz_bleeds_more"
mod.SecretIcons48x[332] = "ui/main menu/secrets/maggy_now_holds_a_pill"
mod.SecretIcons48x[342] = "ui/main menu/secrets/burning_basement"
mod.SecretIcons48x[343] = "ui/main menu/secrets/flooded_caves"
mod.SecretIcons48x[344] = "ui/main menu/secrets/dank_depths"
mod.SecretIcons48x[345] = "ui/main menu/secrets/scarred_womb"
mod.SecretIcons48x[405] = "ui/main menu/secrets/jacob_and_esau"
mod.SecretIcons48x[412] = "ui/main menu/secrets/dross"
mod.SecretIcons48x[413] = "ui/main menu/secrets/ashpit"
mod.SecretIcons48x[414] = "ui/main menu/secrets/gehenna"
mod.SecretIcons48x[513] = "ui/main menu/secrets/hot_potato"

mod.SecretIcons64x = {}
mod.SecretIcons64x[4] = "grid/door_11_wombhole"
mod.SecretIcons64x[16] = "ui/main menu/secrets/steven"
mod.SecretIcons64x[17] = "ui/main menu/secrets/chad"
mod.SecretIcons64x[84] = "ui/main menu/secrets/real_platinum_god"
mod.SecretIcons64x[142] = "ui/main menu/secrets/krampus"
mod.SecretIcons64x[163] = "ui/main menu/secrets/cursed"
mod.SecretIcons64x[234] = "grid/door_11_wombhole_blue"
mod.SecretIcons64x[265] = "ui/main menu/secrets/xl"
mod.SecretIcons64x[268] = "ui/main menu/secrets/pay_to_play"
mod.SecretIcons64x[278] = "ui/main menu/secrets/aprils_fool"
mod.SecretIcons64x[281] = "ui/main menu/secrets/pong"
mod.SecretIcons64x[320] = "ui/main menu/secrets/portal"
mod.SecretIcons64x[339] = "ui/main menu/secrets/1000000"
mod.SecretIcons64x[341] = "ui/main menu/secrets/greedier"
mod.SecretIcons64x[346] = "ui/main menu/secrets/something_wicked_this_way_comes"
mod.SecretIcons64x[348] = "ui/main menu/secrets/portal"
mod.SecretIcons64x[407] = "ui/main menu/secrets/a_secret_exit"
--mod.SecretIcons64x[475] = "ui/main menu/secrets/the_dauntless" --temp
--mod.SecretIcons64x[476] = "ui/main menu/secrets/the_hoarder" --temp
--mod.SecretIcons64x[477] = "ui/main menu/secrets/the_deceiver" --temp
--mod.SecretIcons64x[478] = "ui/main menu/secrets/the_soiled" --temp
--mod.SecretIcons64x[479] = "ui/main menu/secrets/the_curdled" --temp
--mod.SecretIcons64x[480] = "ui/main menu/secrets/the_savage" --temp
--mod.SecretIcons64x[481] = "ui/main menu/secrets/the_benighted" --temp
--mod.SecretIcons64x[482] = "ui/main menu/secrets/the_enigma" --temp
--mod.SecretIcons64x[483] = "ui/main menu/secrets/the_capricious" --temp
--mod.SecretIcons64x[484] = "ui/main menu/secrets/the_baleful" --temp
--mod.SecretIcons64x[485] = "ui/main menu/secrets/the_harlot" --temp
--mod.SecretIcons64x[486] = "ui/main menu/secrets/the_miser" --temp
--mod.SecretIcons64x[487] = "ui/main menu/secrets/the_empty" --temp
--mod.SecretIcons64x[488] = "ui/main menu/secrets/the_fettered" --temp
--mod.SecretIcons64x[489] = "ui/main menu/secrets/the_zealot" --temp
--mod.SecretIcons64x[490] = "ui/main menu/secrets/the_deserter" --temp
mod.SecretIcons64x[512] = "ui/main menu/secrets/pica_run"
mod.SecretIcons64x[514] = "ui/main menu/secrets/cantripped"
mod.SecretIcons64x[515] = "ui/main menu/secrets/red_redemption"
mod.SecretIcons64x[593] = "ui/main menu/secrets/corrupted_data" --temp

mod.SecretIcons80x = {}
mod.SecretIcons80x[18] = "ui/main menu/secrets/gish"
mod.SecretIcons80x[34] = "ui/main menu/secrets/itlives"
mod.SecretIcons80x[68] = "ui/main menu/secrets/something_icky"
mod.SecretIcons80x[246] = "ui/main menu/secrets/everything_is_terrible_2"

mod.SecretIcons128x = {}
mod.SecretIcons128x[347] = "ui/main menu/secrets/something_wicked_this_way_comes_plus"

mod.SecretIconsCharacters = {}

mod.SecretIconsCharactersScream = {}
mod.SecretIconsCharactersScream[33] = PlayerType.PLAYER_ISAAC

mod.SecretIconsCharactersThumb = {}
mod.SecretIconsCharactersThumb[37] = PlayerType.PLAYER_ISAAC
mod.SecretIconsCharactersThumb[83] = PlayerType.PLAYER_THEFORGOTTEN
mod.SecretIconsCharactersThumb[334] = PlayerType.PLAYER_SAMSON

mod.SecretIconsCharactersDeath = {}
mod.SecretIconsCharactersDeath[166] = PlayerType.PLAYER_ISAAC

mod.SecretIconsBabies = {}

function mod.GenerateSecretsMenuData()
	for index=0, XMLData.GetNumEntries(XMLNode.ACHIEVEMENT) do
		local data = XMLData.GetEntryByOrder(XMLNode.ACHIEVEMENT, index)
		if data and data.id then
			if data.text then
				if string.find(data.text, "You unlocked ") then
					mod.SecretBases[tonumber(data.id)] = "character"
				end
				if string.find(data.text, " in the basement") and not string.find(data.text, " appeared in the basement") then
					mod.SecretBases[tonumber(data.id)] = "basement"
				end
				if string.find(data.text, " in the caves") then
					mod.SecretBases[tonumber(data.id)] = "caves"
				end
				if string.find(data.text, " in the depths") then
					mod.SecretBases[tonumber(data.id)] = "depths"
				end
				if string.find(data.text, "Boy\" achieved") or string.find(data.text, " God") then
					mod.SecretBases[tonumber(data.id)] = "god"
				end
				if string.find(data.text, "Store Upgrade") then
					mod.SecretBases[tonumber(data.id)] = "donation"
				end
				if string.find(data.text, "You unlocked Challenge ") then
					mod.SecretBases[tonumber(data.id)] = "challenge"
				end
			end
			if data.steam_name then
				if string.find(data.steam_name, " God") then
					mod.SecretBases[tonumber(data.id)] = "god"
				end
			end
			if data.steam_description then
				if string.find(data.steam_description, "Complete the game") or string.find(data.steam_description, "Beat the game") then
					mod.SecretBases[tonumber(data.id)] = "womb"
				end
				if string.find(data.steam_description, "Complete everything") or string.find(data.steam_description, "Beat everything") then
					mod.SecretBases[tonumber(data.id)] = "god"
				end
				if string.find(data.steam_description, "in Hard mode") then
					mod.SecretOverlays[tonumber(data.id)] = "blood"
				end
				if string.find(data.steam_description, "Complete the Cathedral") or string.find(data.steam_description, "Beat the Cathedral") then
					mod.SecretBases[tonumber(data.id)] = "cathedral"
				end
				if string.find(data.steam_description, "Complete Sheol") or string.find(data.steam_description, "Beat Sheol") then
					mod.SecretBases[tonumber(data.id)] = "sheol"
				end
				if string.find(data.steam_description, "Complete the Chest") or string.find(data.steam_description, "Beat the Chest") then
					mod.SecretBases[tonumber(data.id)] = "chest"
				end
				if string.find(data.steam_description, "Complete the Dark Room") or string.find(data.steam_description, "Beat the Dark Room") then
					mod.SecretBases[tonumber(data.id)] = "darkroom"
				end
				if string.find(data.steam_description, "Complete Boss Rush") or string.find(data.steam_description, "Beat Boss Rush") then
					mod.SecretBases[tonumber(data.id)] = "bossrush"
				end
				if string.find(data.steam_description, "Complete Greed") or string.find(data.steam_description, "Beat Greed") then
					mod.SecretBases[tonumber(data.id)] = "greed"
					if string.find(data.steam_description, "Complete Greedier") or string.find(data.steam_description, "Beat Greedier") then
						mod.SecretOverlays[tonumber(data.id)] = "blood"
					end
				end
				--if string.find(data.steam_description, "Complete ???") or  string.find(data.steam_description, "Beat ???") then
					--mod.SecretBases[tonumber(data.id)] = "bluewomb"
				--end
				if string.find(data.steam_description, "Complete the Void") or string.find(data.steam_description, "Beat the Void") then
					mod.SecretBases[tonumber(data.id)] = "void"
				end
				if string.find(data.steam_description, "Defeat Mega Satan") then
					mod.SecretBases[tonumber(data.id)] = "megasatan"
				end
				if string.find(data.steam_description, "Complete the Corpse") or string.find(data.steam_description, "Beat the Corpse") then
					mod.SecretBases[tonumber(data.id)] = "corpse"
					mod.SecretOverlays[tonumber(data.id)] = "blooddark"
				end
				if string.find(data.steam_description, "Complete the final chapter") or string.find(data.steam_description, "Beat the final chapter") then
					mod.SecretBases[tonumber(data.id)] = "beast"
				end
				if string.find(data.steam_description, "Complete Challenge") or string.find(data.steam_description, "Beat Challenge") then
					mod.SecretBases[tonumber(data.id)] = "challenge"
				end
			end
		end
	end

	for index=0, XMLData.GetNumEntries(XMLNode.ITEM) do
		local data = XMLData.GetEntryByOrder(XMLNode.ITEM, index)
		if data and data.achievement then
			local id = tonumber(data.id) or Isaac.GetItemIdByName(data.name)
			if id then
				if tonumber(data.achievement) and not mod.SecretIconsItems[tonumber(data.achievement)] then
					mod.SecretIconsItems[tonumber(data.achievement)] = id
				elseif string.len(data.achievement) > 0 then
					local achivID = Isaac.GetAchievementIdByName(data.achievement)
					if achivID and not mod.SecretIconsItems[achivID] then
						mod.SecretIconsItems[achivID] = id
					end
				end
			end
		end
	end

	for index=0, XMLData.GetNumEntries(XMLNode.TRINKET) do
		local data = XMLData.GetEntryByOrder(XMLNode.TRINKET, index)
		if data and data.achievement then
			local id = tonumber(data.id) or Isaac.GetTrinketIdByName(data.name)
			if id then
				if tonumber(data.achievement) and not mod.SecretIconsTrinkets[tonumber(data.achievement)] then
					mod.SecretIconsTrinkets[tonumber(data.achievement)] = id
				elseif string.len(data.achievement) > 0 then
					local achivID = Isaac.GetAchievementIdByName(data.achievement)
					if achivID and not mod.SecretIconsTrinkets[achivID] then
						mod.SecretIconsTrinkets[achivID] = id
					end
				end
			end
		end
	end

	for index=0, XMLData.GetNumEntries(XMLNode.PLAYER) do
		local data = XMLData.GetEntryByOrder(XMLNode.PLAYER, index)
		if data and data.achievement then
			local id = tonumber(data.id) or Isaac.GetPlayerTypeByName(data.name)
			if id then
				if tonumber(data.achievement) and not mod.SecretIconsCharacters[tonumber(data.achievement)] and not mod.SecretIconsItems[tonumber(data.achievement)] then
					mod.SecretIconsCharacters[tonumber(data.achievement)] = id
					if not mod.SecretBases[tonumber(data.achievement)] then
						mod.SecretBases[tonumber(data.achievement)] = "character"
					end
				elseif string.len(data.achievement) > 0 then
					local achivID = Isaac.GetAchievementIdByName(data.achievement)
					if achivID and not mod.SecretIconsCharacters[achivID] and not mod.SecretIconsItems[achivID] then
						mod.SecretIconsCharacters[achivID] = id
						if not mod.SecretBases[achivID] then
							mod.SecretBases[achivID] = "character"
						end
					end
				end
			end
		end
	end

	for index=0, EntityConfig.GetMaxBabyID() do
		local data = EntityConfig.GetBaby(index)
		if data and data:GetAchievementID() and not mod.SecretIconsBabies[data:GetAchievementID()] then
			mod.SecretIconsBabies[data:GetAchievementID()] = data:GetID()
		end
	end
end
mod.AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, mod.GenerateSecretsMenuData)

function mod.SetSecretIcon(sprite, id)
	if sprite then
		sprite:ReplaceSpritesheet(1, "gfx/ui/main menu/secrets/base_locked.png", false)
		sprite:ReplaceSpritesheet(3, "blank.png", false)
		sprite:ReplaceSpritesheet(2, "gfx/ui/main menu/secrets/locked.png", false)
		sprite:ReplaceSpritesheet(4, "blank.png", false)
		sprite:ReplaceSpritesheet(5, "blank.png", false)
		sprite:ReplaceSpritesheet(6, "blank.png", false)
		sprite:ReplaceSpritesheet(8, "blank.png", false)
		sprite:ReplaceSpritesheet(9, "blank.png", false)
		sprite:ReplaceSpritesheet(10, "blank.png", false)
		sprite:ReplaceSpritesheet(11, "blank.png", false)
		sprite:ReplaceSpritesheet(12, "blank.png", false)
		sprite:ReplaceSpritesheet(13, "blank.png", false)
		sprite:ReplaceSpritesheet(14, "blank.png", false)
		sprite:ReplaceSpritesheet(15, "blank.png", false)
		if id then
			local numSecrets = XMLData.GetNumEntries(XMLNode.ACHIEVEMENT)
			if id < 1 then
				id = id + numSecrets
			end
			if id > numSecrets then
				id = id - numSecrets
			end

			local gamedata = Isaac.GetPersistentGameData()
			--if gamedata:Unlocked(id) then
				sprite:ReplaceSpritesheet(2, "blank.png", false)
				if mod.SecretBases[id] then
					sprite:ReplaceSpritesheet(1, "gfx/ui/main menu/secrets/base_" .. mod.SecretBases[id] .. ".png", false)
				else
					sprite:ReplaceSpritesheet(1, "gfx/ui/main menu/secrets/base_generic.png", false)
				end
				if mod.SecretOverlays[id] then
					sprite:ReplaceSpritesheet(3, "gfx/ui/main menu/secrets/overlay_" .. mod.SecretOverlays[id] .. ".png", false)
				end
				if mod.SecretIcons32x[id] then
					sprite:ReplaceSpritesheet(2, "gfx/" .. mod.SecretIcons32x[id] .. ".png", false)
				elseif mod.SecretIconsItems[id] then
					local data = XMLData.GetEntryById(XMLNode.ITEM, mod.SecretIconsItems[id])
					if data and data.gfx then
						sprite:ReplaceSpritesheet(2, "gfx/items/collectibles/" .. data.gfx, false)
					end
				elseif mod.SecretIconsTrinkets[id] then
					local data = XMLData.GetEntryById(XMLNode.TRINKET, mod.SecretIconsTrinkets[id])
					if data and data.gfx then
						if mod.SecretIconsTrinketOffset[id] then
							sprite:ReplaceSpritesheet(11, "gfx/items/trinkets/" .. data.gfx, false)
						elseif mod.SecretIconsTrinketOffsetSlight[id] then
							sprite:ReplaceSpritesheet(12, "gfx/items/trinkets/" .. data.gfx, false)
						else
							sprite:ReplaceSpritesheet(2, "gfx/items/trinkets/" .. data.gfx, false)
						end
					end
				elseif mod.SecretIconsCoins[id] then
					sprite:ReplaceSpritesheet(13, "gfx/items/pick ups/" .. mod.SecretIconsCoins[id] .. ".png", false)
				elseif mod.SecretIconsCharactersDeath[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, mod.SecretIconsCharactersDeath[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(14, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif mod.SecretIconsCharactersScream[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, mod.SecretIconsCharactersScream[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(9, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif mod.SecretIconsCharactersThumb[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, mod.SecretIconsCharactersThumb[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(10, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif mod.SecretIconsCharacters[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, mod.SecretIconsCharacters[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(5, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif mod.SecretIconsBabies[id] then
					local data = EntityConfig.GetBaby(mod.SecretIconsBabies[id])
					if data then
						sprite:ReplaceSpritesheet(2, data:GetSpritesheetPath(), false)
					end
				elseif mod.SecretIcons48x[id] then
					sprite:ReplaceSpritesheet(6, "gfx/" .. mod.SecretIcons48x[id] .. ".png", false)
				elseif mod.SecretIcons64x[id] then
					sprite:ReplaceSpritesheet(4, "gfx/" .. mod.SecretIcons64x[id] .. ".png", false)
				elseif mod.SecretIcons80x[id] then
					sprite:ReplaceSpritesheet(8, "gfx/" .. mod.SecretIcons80x[id] .. ".png", false)
				elseif mod.SecretIcons128x[id] then
					sprite:ReplaceSpritesheet(15, "gfx/" .. mod.SecretIcons128x[id] .. ".png", false)
				end
				sprite:LoadGraphics()
				return true
			--end
		end
		sprite:LoadGraphics()
	end
	return false
end

function mod.OnMainMenuRenderSecrets()
	local gamedata = Isaac.GetPersistentGameData()
	if StatsMenu.IsSecretsMenuVisible() then

		--[[
		for id=0, XMLData.GetNumEntries(XMLNode.ACHIEVEMENT) do
			local data = XMLData.GetEntryById(XMLNode.ACHIEVEMENT, id)
			if data and data.id then
				local secretPos = mod.SecretPos + Vector((id%10)*32, math.ceil(id/10)*32)
				if gamedata:Unlocked(id) then
					mod.SecretSprite:Render(Isaac.WorldToMenuPosition(MainMenuType.STATS, secretPos))
				else
					mod.SecretSpriteLocked:Render(Isaac.WorldToMenuPosition(MainMenuType.STATS, secretPos))
				end
			end
		end
		]]

		local numSecrets = XMLData.GetNumEntries(XMLNode.ACHIEVEMENT)
		local secretSprite = StatsMenu.GetSecretsMenuSprite()
		local frame = secretSprite:GetFrame()
		if frame == 0 and mod.LastSecretPageFrame ~= frame then
			if secretSprite:IsPlaying("Appear") then
				mod.LastSecretPageAnim = "Appear"
				local checkSecret = mod.CurrentlySelectedSecret-1
				if checkSecret < 1 then
					checkSecret = checkSecret + numSecrets
				end
				local secretData = XMLData.GetEntryByOrder(XMLNode.ACHIEVEMENT, checkSecret)
				if secretData and secretData.gfx then
					secretSprite:ReplaceSpritesheet(3, "gfx/ui/achievement/" .. secretData.gfx, true)
				end
			elseif secretSprite:IsPlaying("Appear2") then
				mod.LastSecretPageAnim = "Appear2"
				local checkSecret = mod.CurrentlySelectedSecret+1
				if checkSecret > numSecrets then
					checkSecret = checkSecret - numSecrets
				end
				local secretData = XMLData.GetEntryByOrder(XMLNode.ACHIEVEMENT, checkSecret)
				if secretData and secretData.gfx then
					secretSprite:ReplaceSpritesheet(3, "gfx/ui/achievement/" .. secretData.gfx, true)
				end
			end
		end
		if secretSprite:IsPlaying("Idle")
		or ((secretSprite:IsPlaying("Appear") or secretSprite:IsPlaying("Appear2"))
		and (frame == 7 and mod.LastSecretPageFrame == frame)) then
			if mod.LastSecretPageAnim == "Appear" then
				mod.CurrentlySelectedSecret = mod.CurrentlySelectedSecret - 1
				if mod.CurrentlySelectedSecret < 1 then
					mod.CurrentlySelectedSecret = numSecrets
				end
			elseif mod.LastSecretPageAnim == "Appear2" then
				mod.CurrentlySelectedSecret = mod.CurrentlySelectedSecret + 1
				if mod.CurrentlySelectedSecret > numSecrets then
					mod.CurrentlySelectedSecret = 1
				end
			end
			mod.LastSecretPageAnim = "Idle"
		end

		mod.LastSecretPageFrame = frame


		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite1(), mod.CurrentlySelectedSecret-4)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite2(), mod.CurrentlySelectedSecret-3)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite3(), mod.CurrentlySelectedSecret-2)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite4(), mod.CurrentlySelectedSecret-1)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite5(), mod.CurrentlySelectedSecret)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite6(), mod.CurrentlySelectedSecret+1)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite7(), mod.CurrentlySelectedSecret+2)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite8(), mod.CurrentlySelectedSecret+3)
		mod.SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite9(), mod.CurrentlySelectedSecret+4)
	elseif mod.CurrentlySelectedSecret ~= 2 then
		local firstUnlocked = 1
		for id=firstUnlocked, XMLData.GetNumEntries(XMLNode.ACHIEVEMENT) do
			if gamedata:Unlocked(id) then
				firstUnlocked = id
				break
			end
		end
		mod.CurrentlySelectedSecret = firstUnlocked+1
	end
end
mod.AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, mod.OnMainMenuRenderSecrets)
