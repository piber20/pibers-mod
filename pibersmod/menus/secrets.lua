PibersMod.StatViewPos = Vector(444.5,-1365)
PibersMod.SecretViewPos = Vector(-1000,-1365)
PibersMod.SecretPos = Vector(-1000,-1365)
PibersMod.SecretSprite = Sprite("gfx/ui/main menu/todo.anm2", true)
PibersMod.SecretSprite:Play("Icon1Unlocked")
PibersMod.SecretSpriteLocked = Sprite("gfx/ui/main menu/todo.anm2", true)
PibersMod.SecretSpriteLocked:Play("Icon1Locked")

PibersMod.CurrentlySelectedSecret = 1
PibersMod.LastSecretPageFrame = -1
PibersMod.LastSecretPageAnim = "Idle"

local loopvar = 0
PibersMod.SecretBases = {}
PibersMod.SecretBases[4] = "womb"
PibersMod.SecretBases[5] = "mom"
PibersMod.SecretBases[6] = "mom"
PibersMod.SecretBases[8] = "womb"
PibersMod.SecretBases[9] = "bossrush"
PibersMod.SecretBases[10] = "womb"
PibersMod.SecretBases[11] = "womb"
PibersMod.SecretBases[12] = "depths"
PibersMod.SecretBases[13] = "basement"
PibersMod.SecretBases[14] = "caves"
PibersMod.SecretBases[15] = "womb"
PibersMod.SecretBases[20] = "cathedral"
PibersMod.SecretBases[21] = "cathedral"
PibersMod.SecretBases[23] = "depths"
PibersMod.SecretBases[24] = "basement"
PibersMod.SecretBases[25] = "caves"
PibersMod.SecretBases[26] = "character"
PibersMod.SecretBases[27] = "mom"
PibersMod.SecretBases[28] = "depths"
PibersMod.SecretBases[29] = "cathedral"
PibersMod.SecretBases[33] = "womb"
PibersMod.SecretBases[34] = "womb"
PibersMod.SecretBases[35] = "mom"
PibersMod.SecretBases[43] = "sheol"
PibersMod.SecretBases[44] = "sheol"
PibersMod.SecretBases[45] = "sheol"
PibersMod.SecretBases[46] = "sheol"
PibersMod.SecretBases[47] = "darkroom"
PibersMod.SecretBases[48] = "sheol"
PibersMod.SecretBases[49] = "chest"
PibersMod.SecretBases[50] = "chest"
PibersMod.SecretBases[51] = "darkroom"
PibersMod.SecretBases[52] = "darkroom"
PibersMod.SecretBases[53] = "chest"
PibersMod.SecretBases[54] = "cathedral"
PibersMod.SecretBases[55] = "chest"
PibersMod.SecretBases[56] = "sheol"
PibersMod.SecretBases[57] = "cathedral"
PibersMod.SecretBases[58] = "cathedral"
PibersMod.SecretBases[59] = "donation"
PibersMod.SecretBases[60] = "challenge"
PibersMod.SecretBases[61] = "donation"
PibersMod.SecretBases[62] = "cathedral"
PibersMod.SecretBases[63] = "cathedral"
PibersMod.SecretBases[64] = "donation"
PibersMod.SecretBases[65] = "depths"
PibersMod.SecretBases[66] = "cathedral"
PibersMod.SecretBases[66] = "cathedral"
PibersMod.SecretBases[68] = "womb"
PibersMod.SecretBases[70] = "bossrush"
PibersMod.SecretBases[71] = "darkroom"
PibersMod.SecretBases[72] = "sheol"
PibersMod.SecretBases[73] = "darkroom"
PibersMod.SecretBases[74] = "darkroom"
PibersMod.SecretBases[75] = "chest"
PibersMod.SecretBases[76] = "cathedral"
PibersMod.SecretBases[77] = "chest"
PibersMod.SecretBases[78] = "sheol"
PibersMod.SecretBases[85] = "depths"
PibersMod.SecretBases[86] = "basement"
PibersMod.SecretBases[87] = "caves"
PibersMod.SecretBases[88] = "depths"
PibersMod.SecretBases[89] = "challenge"
PibersMod.SecretBases[90] = "challenge"
PibersMod.SecretBases[91] = "challenge"
PibersMod.SecretBases[92] = "challenge"
PibersMod.SecretBases[93] = "challenge"
PibersMod.SecretBases[94] = "challenge"
PibersMod.SecretBases[95] = "challenge"
PibersMod.SecretBases[96] = "challenge"
PibersMod.SecretBases[97] = "challenge"
PibersMod.SecretBases[98] = "challenge"
PibersMod.SecretBases[99] = "challenge"
PibersMod.SecretBases[100] = "challenge"
PibersMod.SecretBases[101] = "challenge"
PibersMod.SecretBases[102] = "challenge"
PibersMod.SecretBases[103] = "challenge"
PibersMod.SecretBases[104] = "challenge"
PibersMod.SecretBases[105] = "challenge"
PibersMod.SecretBases[106] = "cathedral"
PibersMod.SecretBases[107] = "cathedral"
PibersMod.SecretBases[108] = "bossrush"
PibersMod.SecretBases[109] = "bossrush"
PibersMod.SecretBases[110] = "bossrush"
PibersMod.SecretBases[111] = "darkroom"
PibersMod.SecretBases[112] = "bossrush"
PibersMod.SecretBases[113] = "chest"
PibersMod.SecretBases[114] = "bossrush"
PibersMod.SecretBases[115] = "bossrush"
PibersMod.SecretBases[116] = "cathedral"
PibersMod.SecretBases[117] = "sheol"
PibersMod.SecretBases[118] = "chest"
PibersMod.SecretBases[119] = "darkroom"
PibersMod.SecretBases[120] = "challenge"
PibersMod.SecretBases[121] = "cathedral"
PibersMod.SecretBases[122] = "sheol"
PibersMod.SecretBases[123] = "chest"
PibersMod.SecretBases[124] = "darkroom"
PibersMod.SecretBases[125] = "bossrush"
PibersMod.SecretBases[126] = "cathedral"
PibersMod.SecretBases[127] = "sheol"
PibersMod.SecretBases[128] = "chest"
PibersMod.SecretBases[129] = "cathedral"
PibersMod.SecretBases[130] = "sheol"
PibersMod.SecretBases[131] = "chest"
PibersMod.SecretBases[132] = "darkroom"
PibersMod.SecretBases[133] = "bossrush"
PibersMod.SecretBases[134] = "donation"
PibersMod.SecretBases[135] = "donation"
PibersMod.SecretBases[136] = "donation"
PibersMod.SecretBases[137] = "donation"
PibersMod.SecretBases[138] = "donation"
PibersMod.SecretBases[139] = "womb"
PibersMod.SecretBases[140] = "womb"
PibersMod.SecretBases[141] = "womb"
PibersMod.SecretBases[142] = "sheol"
PibersMod.SecretBases[143] = "sheol"
PibersMod.SecretBases[144] = "womb"
PibersMod.SecretBases[145] = "caves"
PibersMod.SecretBases[148] = "donation"
PibersMod.SecretBases[149] = "darkroom"
PibersMod.SecretBases[150] = "womb"
PibersMod.SecretBases[155] = "cathedral"
PibersMod.SecretBases[156] = "god"
PibersMod.SecretBases[167] = "womb"
PibersMod.SecretBases[168] = "womb"
PibersMod.SecretBases[169] = "womb"
PibersMod.SecretBases[170] = "womb"
PibersMod.SecretBases[171] = "womb"
PibersMod.SecretBases[172] = "womb"
PibersMod.SecretBases[173] = "womb"
PibersMod.SecretBases[174] = "womb"
PibersMod.SecretBases[175] = "womb"
PibersMod.SecretBases[176] = "womb"
PibersMod.SecretBases[177] = "womb"
PibersMod.SecretBases[179] = "bluewomb"
PibersMod.SecretBases[180] = "bluewomb"
PibersMod.SecretBases[181] = "bluewomb"
PibersMod.SecretBases[182] = "bluewomb"
PibersMod.SecretBases[183] = "bluewomb"
PibersMod.SecretBases[184] = "bluewomb"
PibersMod.SecretBases[185] = "bluewomb"
PibersMod.SecretBases[186] = "bluewomb"
PibersMod.SecretBases[187] = "bluewomb"
PibersMod.SecretBases[188] = "bluewomb"
PibersMod.SecretBases[189] = "bluewomb"
PibersMod.SecretBases[190] = "bluewomb"
PibersMod.SecretBases[191] = "bluewomb"
PibersMod.SecretBases[192] = "greed"
PibersMod.SecretBases[193] = "greed"
PibersMod.SecretBases[194] = "greed"
PibersMod.SecretBases[195] = "greed"
PibersMod.SecretBases[196] = "greed"
PibersMod.SecretBases[197] = "greed"
PibersMod.SecretBases[198] = "greed"
PibersMod.SecretBases[200] = "greed"
PibersMod.SecretBases[201] = "greed"
PibersMod.SecretBases[202] = "greed"
PibersMod.SecretBases[203] = "greed"
PibersMod.SecretBases[204] = "greed"
PibersMod.SecretBases[205] = "megasatan"
PibersMod.SecretBases[206] = "megasatan"
PibersMod.SecretBases[207] = "megasatan"
PibersMod.SecretBases[208] = "megasatan"
PibersMod.SecretBases[209] = "megasatan"
PibersMod.SecretBases[210] = "megasatan"
PibersMod.SecretBases[211] = "megasatan"
PibersMod.SecretBases[212] = "megasatan"
PibersMod.SecretBases[213] = "megasatan"
PibersMod.SecretBases[214] = "megasatan"
PibersMod.SecretBases[215] = "megasatan"
PibersMod.SecretBases[216] = "megasatan"
PibersMod.SecretBases[217] = "megasatan"
PibersMod.SecretBases[218] = "cathedral"
PibersMod.SecretBases[219] = "chest"
PibersMod.SecretBases[220] = "sheol"
PibersMod.SecretBases[221] = "darkroom"
PibersMod.SecretBases[222] = "bossrush"
PibersMod.SecretBases[223] = "womb"
PibersMod.SecretBases[224] = "challenge"
PibersMod.SecretBases[225] = "challenge"
PibersMod.SecretBases[226] = "challenge"
PibersMod.SecretBases[227] = "challenge"
PibersMod.SecretBases[228] = "challenge"
PibersMod.SecretBases[229] = "challenge"
PibersMod.SecretBases[230] = "challenge"
PibersMod.SecretBases[231] = "challenge"
PibersMod.SecretBases[232] = "challenge"
PibersMod.SecretBases[233] = "challenge"
PibersMod.SecretBases[234] = "bluewomb"
PibersMod.SecretBases[235] = "god"
PibersMod.SecretBases[236] = "cathedral"
PibersMod.SecretBases[237] = "sheol"
PibersMod.SecretBases[238] = "chest"
PibersMod.SecretBases[239] = "darkroom"
PibersMod.SecretBases[240] = "bossrush"
PibersMod.SecretBases[241] = "womb"
PibersMod.SecretBases[242] = "greeddonation"
PibersMod.SecretBases[243] = "greeddonation"
PibersMod.SecretBases[244] = "greeddonation"
PibersMod.SecretBases[245] = "greeddonation"
PibersMod.SecretBases[246] = "greeddonation"
PibersMod.SecretBases[247] = "greeddonation"
PibersMod.SecretBases[248] = "greeddonation"
PibersMod.SecretBases[249] = "greeddonation"
PibersMod.SecretBases[250] = "greeddonation"
PibersMod.SecretBases[252] = "god"
PibersMod.SecretBases[253] = "god"
PibersMod.SecretBases[254] = "god"
PibersMod.SecretBases[255] = "god"
PibersMod.SecretBases[256] = "god"
PibersMod.SecretBases[257] = "god"
PibersMod.SecretBases[258] = "god"
PibersMod.SecretBases[259] = "god"
PibersMod.SecretBases[260] = "god"
PibersMod.SecretBases[261] = "god"
PibersMod.SecretBases[262] = "god"
PibersMod.SecretBases[263] = "god"
PibersMod.SecretBases[264] = "god"
PibersMod.SecretBases[276] = "megasatan"
PibersMod.SecretBases[282] = "void"
PibersMod.SecretBases[283] = "void"
PibersMod.SecretBases[284] = "void"
PibersMod.SecretBases[285] = "void"
PibersMod.SecretBases[286] = "void"
PibersMod.SecretBases[287] = "void"
PibersMod.SecretBases[288] = "void"
PibersMod.SecretBases[289] = "void"
PibersMod.SecretBases[290] = "void"
PibersMod.SecretBases[291] = "void"
PibersMod.SecretBases[292] = "void"
PibersMod.SecretBases[293] = "void"
PibersMod.SecretBases[294] = "void"
PibersMod.SecretBases[295] = "void"
loopvar = 296
while loopvar <= 309 do
	PibersMod.SecretBases[loopvar] = "greed"
	loopvar = loopvar+1
end
PibersMod.SecretBases[311] = "sheol"
PibersMod.SecretBases[312] = "chest"
PibersMod.SecretBases[313] = "darkroom"
PibersMod.SecretBases[314] = "bossrush"
PibersMod.SecretBases[315] = "bluewomb"
PibersMod.SecretBases[316] = "greed"
PibersMod.SecretBases[317] = "megasatan"
PibersMod.SecretBases[318] = "womb"
PibersMod.SecretBases[319] = "god"
PibersMod.SecretBases[320] = "void"
PibersMod.SecretBases[321] = "darkroom"
PibersMod.SecretBases[322] = "god"
PibersMod.SecretBases[323] = "god"
PibersMod.SecretBases[324] = "god"
PibersMod.SecretBases[325] = "online"
PibersMod.SecretBases[326] = "darkroom"
PibersMod.SecretBases[327] = "darkroom"
PibersMod.SecretBases[329] = "god"
PibersMod.SecretBases[330] = "god"
loopvar = 331
while loopvar <= 335 do
	PibersMod.SecretBases[loopvar] = "challenge"
	loopvar = loopvar+1
end
PibersMod.SecretBases[336] = "online"
PibersMod.SecretBases[337] = "darkroom"
PibersMod.SecretBases[339] = "god"
PibersMod.SecretBases[341] = "greeddonation"
PibersMod.SecretBases[342] = "basement"
PibersMod.SecretBases[343] = "bluewomb"
PibersMod.SecretBases[344] = "depths"
PibersMod.SecretBases[345] = "womb"
PibersMod.SecretBases[346] = "chest"
PibersMod.SecretBases[347] = "chest"
PibersMod.SecretBases[348] = "darkroom"
PibersMod.SecretBases[349] = "darkroom"
PibersMod.SecretBases[350] = "depths"
PibersMod.SecretBases[351] = "basement"
PibersMod.SecretBases[353] = "caves"
PibersMod.SecretBases[354] = "online"
PibersMod.SecretBases[356] = "basement"
PibersMod.SecretBases[357] = "void"
PibersMod.SecretBases[360] = "darkroom"
PibersMod.SecretBases[364] = "donation"
PibersMod.SecretBases[365] = "caves"
PibersMod.SecretBases[366] = "darkroom"
PibersMod.SecretBases[368] = "depths"
PibersMod.SecretBases[370] = "cathedral"
PibersMod.SecretBases[373] = "cathedral"
PibersMod.SecretBases[374] = "womb"
PibersMod.SecretBases[375] = "depths"
PibersMod.SecretBases[376] = "sheol"
PibersMod.SecretBases[379] = "donation"
PibersMod.SecretBases[380] = "cathedral"
PibersMod.SecretBases[383] = "sheol"
PibersMod.SecretBases[391] = "darkroom"
PibersMod.SecretBases[392] = "womb"
PibersMod.SecretBases[393] = "cathedral"
PibersMod.SecretBases[394] = "sheol"
PibersMod.SecretBases[395] = "chest"
PibersMod.SecretBases[396] = "darkroom"
PibersMod.SecretBases[397] = "bossrush"
PibersMod.SecretBases[398] = "bluewomb"
PibersMod.SecretBases[399] = "greed"
PibersMod.SecretBases[400] = "greed"
PibersMod.SecretBases[401] = "void"
PibersMod.SecretBases[402] = "god"
PibersMod.SecretBases[403] = "megasatan"
PibersMod.SecretBases[407] = "bluewomb"
PibersMod.SecretBases[408] = "depths"
PibersMod.SecretBases[409] = "basement"
PibersMod.SecretBases[410] = "basement"
PibersMod.SecretBases[411] = "corpse"
PibersMod.SecretBases[412] = "bluewomb"
PibersMod.SecretBases[413] = "depths"
PibersMod.SecretBases[414] = "darkroom"
PibersMod.SecretBases[423] = "bluewomb"
PibersMod.SecretBases[435] = "bluewomb"
loopvar = 474
while loopvar <= 490 do
	PibersMod.SecretBases[loopvar] = "tainted"
	loopvar = loopvar+1
end
loopvar = 491
while loopvar <= 507 do
	PibersMod.SecretBases[loopvar] = "beast"
	loopvar = loopvar+1
end
loopvar = 524
while loopvar <= 537 do
	PibersMod.SecretBases[loopvar] = "greed"
	loopvar = loopvar+1
end
PibersMod.SecretBases[538] = "challenge"
loopvar = 539
while loopvar <= 544 do
	PibersMod.SecretBases[loopvar] = "greed"
	loopvar = loopvar+1
end
PibersMod.SecretBases[546] = "depths"
PibersMod.SecretBases[548] = "darkroom"
PibersMod.SecretBases[549] = "corpse"
PibersMod.SecretBases[550] = "darkroom"
PibersMod.SecretBases[551] = "corpse"
PibersMod.SecretBases[552] = "darkroom"
PibersMod.SecretBases[553] = "corpse"
PibersMod.SecretBases[554] = "darkroom"
PibersMod.SecretBases[555] = "corpse"
PibersMod.SecretBases[556] = "darkroom"
PibersMod.SecretBases[557] = "corpse"
PibersMod.SecretBases[558] = "darkroom"
PibersMod.SecretBases[559] = "corpse"
PibersMod.SecretBases[560] = "darkroom"
PibersMod.SecretBases[561] = "corpse"
PibersMod.SecretBases[562] = "darkroom"
PibersMod.SecretBases[563] = "corpse"
PibersMod.SecretBases[564] = "darkroom"
PibersMod.SecretBases[565] = "corpse"
PibersMod.SecretBases[566] = "darkroom"
PibersMod.SecretBases[567] = "corpse"
PibersMod.SecretBases[568] = "darkroom"
PibersMod.SecretBases[569] = "corpse"
PibersMod.SecretBases[570] = "darkroom"
PibersMod.SecretBases[571] = "corpse"
PibersMod.SecretBases[572] = "darkroom"
PibersMod.SecretBases[573] = "corpse"
PibersMod.SecretBases[574] = "darkroom"
PibersMod.SecretBases[575] = "corpse"
PibersMod.SecretBases[576] = "darkroom"
PibersMod.SecretBases[577] = "corpse"
PibersMod.SecretBases[578] = "darkroom"
PibersMod.SecretBases[579] = "corpse"
PibersMod.SecretBases[580] = "darkroom"
PibersMod.SecretBases[581] = "corpse"
PibersMod.SecretBases[582] = "donation"
PibersMod.SecretBases[583] = "donation"
loopvar = 584
while loopvar <= 600 do
	PibersMod.SecretBases[loopvar] = "void"
	loopvar = loopvar+1
end
loopvar = 601
while loopvar <= 617 do
	PibersMod.SecretBases[loopvar] = "megasatan"
	loopvar = loopvar+1
end
loopvar = 618
while loopvar <= 634 do
	PibersMod.SecretBases[loopvar] = "bluewomb"
	loopvar = loopvar+1
end
PibersMod.SecretBases[635] = "corpse"
PibersMod.SecretBases[636] = "god"

PibersMod.SecretOverlays = {}
PibersMod.SecretOverlays[30] = "blood"
PibersMod.SecretOverlays[31] = "blood"
PibersMod.SecretOverlays[147] = "blood"
PibersMod.SecretOverlays[155] = "blood"
PibersMod.SecretOverlays[156] = "blood"
loopvar = 167
while loopvar <= 177 do
	PibersMod.SecretOverlays[loopvar] = "blood"
	loopvar = loopvar+1
end
PibersMod.SecretOverlays[223] = "blood"
PibersMod.SecretOverlays[241] = "blood"
loopvar = 252
while loopvar <= 264 do
	PibersMod.SecretOverlays[loopvar] = "blood"
	loopvar = loopvar+1
end
loopvar = 296
while loopvar <= 309 do
	PibersMod.SecretOverlays[loopvar] = "blood"
	loopvar = loopvar+1
end
PibersMod.SecretOverlays[318] = "blood"
PibersMod.SecretOverlays[319] = "blood"
PibersMod.SecretOverlays[328] = "blood"
PibersMod.SecretOverlays[376] = "blood"
PibersMod.SecretOverlays[383] = "blood"
PibersMod.SecretOverlays[384] = "blood"
PibersMod.SecretOverlays[392] = "blood"
PibersMod.SecretOverlays[400] = "blood"
PibersMod.SecretOverlays[402] = "blood"
loopvar = 491
while loopvar <= 507 do
	PibersMod.SecretOverlays[loopvar] = "tainted"
	loopvar = loopvar+1
end
PibersMod.SecretOverlays[516] = "deletethis"
loopvar = 524
while loopvar <= 544 do
	PibersMod.SecretOverlays[loopvar] = "tainted"
	loopvar = loopvar+1
end
PibersMod.SecretOverlays[545] = "blood"
PibersMod.SecretOverlays[546] = "blood"
PibersMod.SecretOverlays[547] = "blood"
loopvar = 548
while loopvar <= 636 do
	PibersMod.SecretOverlays[loopvar] = "tainted"
	loopvar = loopvar+1
end

PibersMod.SecretIconsItems = {}
PibersMod.SecretIconsItems[154] = CollectibleType.COLLECTIBLE_DOLLAR
PibersMod.SecretIconsItems[155] = CollectibleType.BLOODY_FEATHER
PibersMod.SecretIconsItems[157] = CollectibleType.COLLECTIBLE_DARK_MATTER
PibersMod.SecretIconsItems[158] = CollectibleType.COLLECTIBLE_BUCKET_OF_LARD
PibersMod.SecretIconsItems[159] = CollectibleType.COLLECTIBLE_HALO_OF_FLIES
PibersMod.SecretIconsItems[160] = CollectibleType.COLLECTIBLE_MY_REFLECTION
PibersMod.SecretIconsItems[161] = CollectibleType.COLLECTIBLE_GUPPYS_HEAD
PibersMod.SecretIconsItems[162] = CollectibleType.COLLECTIBLE_REMOTE_DETONATOR
PibersMod.SecretIconsItems[165] = CollectibleType.COLLECTIBLE_BROTHER_BOBBY
PibersMod.SecretIconsItems[236] = CollectibleType.COLLECTIBLE_WOODEN_NICKEL
PibersMod.SecretIconsItems[248] = CollectibleType.COLLECTIBLE_RAZOR_BLADE
PibersMod.SecretIconsItems[250] = CollectibleType.COLLECTIBLE_HOLY_MANTLE
PibersMod.SecretIconsItems[269] = CollectibleType.COLLECTIBLE_CHARM_VAMPIRE
PibersMod.SecretIconsItems[270] = CollectibleType.COLLECTIBLE_BOOMERANG
PibersMod.SecretIconsItems[271] = CollectibleType.COLLECTIBLE_BOBS_BRAIN
PibersMod.SecretIconsItems[272] = CollectibleType.COLLECTIBLE_RAINBOW_BABY
PibersMod.SecretIconsItems[279] = CollectibleType.COLLECTIBLE_POKE_GO
PibersMod.SecretIconsItems[508] = CollectibleType.COLLECTIBLE_BLOOD_OATH

PibersMod.SecretIconsTrinkets = {}
PibersMod.SecretIconsTrinkets[237] = TrinketType.TRINKET_STORE_KEY
PibersMod.SecretIconsTrinkets[245] = TrinketType.TRINKET_PAPER_CLIP

PibersMod.SecretIconsTrinketOffset = {}
PibersMod.SecretIconsTrinketOffset[55] = true
PibersMod.SecretIconsTrinketOffset[64] = true
PibersMod.SecretIconsTrinketOffset[360] = true
PibersMod.SecretIconsTrinketOffset[388] = true
PibersMod.SecretIconsTrinketOffset[389] = true
PibersMod.SecretIconsTrinketOffset[399] = true
PibersMod.SecretIconsTrinketOffset[454] = true
PibersMod.SecretIconsTrinketOffset[493] = true
PibersMod.SecretIconsTrinketOffset[556] = true
PibersMod.SecretIconsTrinketOffset[562] = true
PibersMod.SecretIconsTrinketOffset[563] = true
PibersMod.SecretIconsTrinketOffset[573] = true

PibersMod.SecretIconsTrinketOffsetSlight = {}
PibersMod.SecretIconsTrinketOffsetSlight[71] = true
PibersMod.SecretIconsTrinketOffsetSlight[72] = true
PibersMod.SecretIconsTrinketOffsetSlight[85] = true
PibersMod.SecretIconsTrinketOffsetSlight[101] = true
PibersMod.SecretIconsTrinketOffsetSlight[108] = true
PibersMod.SecretIconsTrinketOffsetSlight[111] = true
PibersMod.SecretIconsTrinketOffsetSlight[118] = true
PibersMod.SecretIconsTrinketOffsetSlight[196] = true
PibersMod.SecretIconsTrinketOffsetSlight[204] = true
PibersMod.SecretIconsTrinketOffsetSlight[229] = true
PibersMod.SecretIconsTrinketOffsetSlight[232] = true
PibersMod.SecretIconsTrinketOffsetSlight[239] = true
PibersMod.SecretIconsTrinketOffsetSlight[287] = true
PibersMod.SecretIconsTrinketOffsetSlight[301] = true
PibersMod.SecretIconsTrinketOffsetSlight[304] = true
PibersMod.SecretIconsTrinketOffsetSlight[336] = true
PibersMod.SecretIconsTrinketOffsetSlight[375] = true
PibersMod.SecretIconsTrinketOffsetSlight[381] = true
PibersMod.SecretIconsTrinketOffsetSlight[408] = true
PibersMod.SecretIconsTrinketOffsetSlight[419] = true
PibersMod.SecretIconsTrinketOffsetSlight[421] = true
PibersMod.SecretIconsTrinketOffsetSlight[518] = true
PibersMod.SecretIconsTrinketOffsetSlight[521] = true
PibersMod.SecretIconsTrinketOffsetSlight[522] = true
PibersMod.SecretIconsTrinketOffsetSlight[523] = true
PibersMod.SecretIconsTrinketOffsetSlight[548] = true
PibersMod.SecretIconsTrinketOffsetSlight[549] = true
PibersMod.SecretIconsTrinketOffsetSlight[550] = true
PibersMod.SecretIconsTrinketOffsetSlight[551] = true
PibersMod.SecretIconsTrinketOffsetSlight[552] = true
PibersMod.SecretIconsTrinketOffsetSlight[553] = true
PibersMod.SecretIconsTrinketOffsetSlight[554] = true
PibersMod.SecretIconsTrinketOffsetSlight[555] = true
PibersMod.SecretIconsTrinketOffsetSlight[557] = true
PibersMod.SecretIconsTrinketOffsetSlight[558] = true
PibersMod.SecretIconsTrinketOffsetSlight[559] = true
PibersMod.SecretIconsTrinketOffsetSlight[560] = true
PibersMod.SecretIconsTrinketOffsetSlight[561] = true
PibersMod.SecretIconsTrinketOffsetSlight[564] = true
PibersMod.SecretIconsTrinketOffsetSlight[565] = true
PibersMod.SecretIconsTrinketOffsetSlight[566] = true
PibersMod.SecretIconsTrinketOffsetSlight[567] = true
PibersMod.SecretIconsTrinketOffsetSlight[568] = true
PibersMod.SecretIconsTrinketOffsetSlight[569] = true
PibersMod.SecretIconsTrinketOffsetSlight[570] = true
PibersMod.SecretIconsTrinketOffsetSlight[572] = true
PibersMod.SecretIconsTrinketOffsetSlight[574] = true
PibersMod.SecretIconsTrinketOffsetSlight[577] = true
PibersMod.SecretIconsTrinketOffsetSlight[578] = true
PibersMod.SecretIconsTrinketOffsetSlight[579] = true
PibersMod.SecretIconsTrinketOffsetSlight[581] = true

PibersMod.SecretIconsCoins = {}
PibersMod.SecretIconsCoins[151] = "pickup_002_coin"
PibersMod.SecretIconsCoins[152] = "pickup_002_coinblack"
PibersMod.SecretIconsCoins[153] = "pickup_002_coinsilver"
PibersMod.SecretIconsCoins[242] = "pickup_002_lucky_penny"

PibersMod.SecretIcons32x = {}
PibersMod.SecretIcons32x[89] = "ui/main menu/secrets/rune_of_hagalaz"
PibersMod.SecretIcons32x[90] = "ui/main menu/secrets/rune_of_jera"
PibersMod.SecretIcons32x[91] = "ui/main menu/secrets/rune_of_ehwaz"
PibersMod.SecretIcons32x[92] = "ui/main menu/secrets/rune_of_dagaz"
PibersMod.SecretIcons32x[93] = "ui/main menu/secrets/rune_of_ansuz"
PibersMod.SecretIcons32x[94] = "ui/main menu/secrets/rune_of_perthro"
PibersMod.SecretIcons32x[95] = "ui/main menu/secrets/rune_of_berkano"
PibersMod.SecretIcons32x[96] = "ui/main menu/secrets/rune_of_algiz"
PibersMod.SecretIcons32x[97] = "ui/main menu/secrets/chaos_card"
PibersMod.SecretIcons32x[98] = "ui/main menu/secrets/credit_card"
PibersMod.SecretIcons32x[99] = "ui/main menu/secrets/rules_card"
PibersMod.SecretIcons32x[100] = "ui/main menu/secrets/card_against_humanity"
PibersMod.SecretIcons32x[120] = "ui/main menu/secrets/suicide_king"
PibersMod.SecretIcons32x[144] = "familiar/familiar_other_04_cubeofmeatlevel4"
PibersMod.SecretIcons32x[164] = "ui/main menu/secrets/glass_cannon"
PibersMod.SecretIcons32x[176] = "ui/main menu/secrets/glitch_baby"
PibersMod.SecretIcons32x[191] = "ui/main menu/secrets/keeper_now_holds_a_penny"
PibersMod.SecretIcons32x[224] = "ui/main menu/secrets/gold_heart"
PibersMod.SecretIcons32x[225] = "ui/main menu/secrets/get_out_of_jail_free_card"
PibersMod.SecretIcons32x[226] = "ui/main menu/secrets/gold_bomb"
PibersMod.SecretIcons32x[227] = "ui/main menu/secrets/pay_to_play_pills"
PibersMod.SecretIcons32x[228] = "ui/main menu/secrets/have_a_heart_pills"
PibersMod.SecretIcons32x[233] = "ui/main menu/secrets/blank_rune"
PibersMod.SecretIcons32x[235] = "ui/main menu/secrets/1001"
PibersMod.SecretIcons32x[240] = "ui/main menu/secrets/sticky_nickels"
PibersMod.SecretIcons32x[266] = "ui/main menu/secrets/turbo"
PibersMod.SecretIcons32x[267] = "ui/main menu/secrets/blue_bomber"
PibersMod.SecretIcons32x[273] = "ui/main menu/secrets/onans_streak"
PibersMod.SecretIcons32x[293] = "ui/main menu/secrets/holy_card"
PibersMod.SecretIcons32x[309] = "ui/main menu/secrets/black_rune"
PibersMod.SecretIcons32x[321] = "ui/main menu/secrets/once_more_with_feeling"
PibersMod.SecretIcons32x[322] = "ui/main menu/secrets/hat_trick"
PibersMod.SecretIcons32x[324] = "ui/main menu/secrets/sin_collector"
PibersMod.SecretIcons32x[325] = "ui/main menu/secrets/dedication"
PibersMod.SecretIcons32x[326] = "ui/main menu/secrets/zip"
PibersMod.SecretIcons32x[327] = "ui/main menu/secrets/its_the_key"
PibersMod.SecretIcons32x[328] = "ui/main menu/secrets/mr_resetter"
PibersMod.SecretIcons32x[329] = "ui/main menu/secrets/living_on_the_edge"
PibersMod.SecretIcons32x[330] = "ui/main menu/secrets/u_broke_it"
PibersMod.SecretIcons32x[333] = "ui/main menu/secrets/charged_key"
PibersMod.SecretIcons32x[337] = "ui/main menu/secrets/rerun"
PibersMod.SecretIcons32x[338] = "ui/main menu/secrets/delirious"
PibersMod.SecretIcons32x[361] = "ui/main menu/secrets/huge_growth"
PibersMod.SecretIcons32x[362] = "ui/main menu/secrets/ancient_recall"
PibersMod.SecretIcons32x[363] = "ui/main menu/secrets/era_walk"
PibersMod.SecretIcons32x[391] = "ui/main menu/secrets/bone_heart"
PibersMod.SecretIcons32x[403] = "ui/main menu/secrets/bound_baby"
PibersMod.SecretIcons32x[406] = "ui/main menu/secrets/planetarium"
PibersMod.SecretIcons32x[411] = "items/pick ups/pickup_001_heart2"
PibersMod.SecretIcons32x[416] = "ui/main menu/secrets/wisp_baby"
PibersMod.SecretIcons32x[426] = "ui/main menu/secrets/hope_baby"
PibersMod.SecretIcons32x[427] = "ui/main menu/secrets/glowing_baby"
PibersMod.SecretIcons32x[438] = "ui/main menu/secrets/solomons_baby"
--PibersMod.SecretIcons32x[474] = "ui/main menu/secrets/the_broken"
PibersMod.SecretIcons32x[509] = "ui/main menu/secrets/baptism_by_fire"
PibersMod.SecretIcons32x[510] = "ui/main menu/secrets/isaacs_awakening"
PibersMod.SecretIcons32x[511] = "ui/main menu/secrets/seeing_double"
PibersMod.SecretIcons32x[524] = "ui/main menu/secrets/the_fool"
PibersMod.SecretIcons32x[525] = "ui/main menu/secrets/the_magician"
PibersMod.SecretIcons32x[526] = "ui/main menu/secrets/the_high_prestess"
PibersMod.SecretIcons32x[527] = "ui/main menu/secrets/the_empress"
PibersMod.SecretIcons32x[528] = "ui/main menu/secrets/the_emporer"
PibersMod.SecretIcons32x[529] = "ui/main menu/secrets/the_hierophant"
PibersMod.SecretIcons32x[530] = "ui/main menu/secrets/the_lovers"
PibersMod.SecretIcons32x[531] = "ui/main menu/secrets/the_chariot"
PibersMod.SecretIcons32x[532] = "ui/main menu/secrets/justice"
PibersMod.SecretIcons32x[533] = "ui/main menu/secrets/the_hermit"
PibersMod.SecretIcons32x[534] = "ui/main menu/secrets/wheel_of_fortune"
PibersMod.SecretIcons32x[535] = "ui/main menu/secrets/strength"
PibersMod.SecretIcons32x[536] = "ui/main menu/secrets/the_hanged_man"
PibersMod.SecretIcons32x[537] = "ui/main menu/secrets/death"
PibersMod.SecretIcons32x[538] = "ui/main menu/secrets/temperance"
PibersMod.SecretIcons32x[539] = "ui/main menu/secrets/the_devil"
PibersMod.SecretIcons32x[540] = "ui/main menu/secrets/the_tower"
PibersMod.SecretIcons32x[541] = "ui/main menu/secrets/the_stars"
PibersMod.SecretIcons32x[542] = "ui/main menu/secrets/the_sun_and_the_moon"
PibersMod.SecretIcons32x[543] = "ui/main menu/secrets/judgement"
PibersMod.SecretIcons32x[544] = "ui/main menu/secrets/the_world"

PibersMod.SecretIcons48x = {}
PibersMod.SecretIcons48x[5] = "ui/main menu/secrets/harbingers"
PibersMod.SecretIcons48x[38] = "ui/main menu/secrets/spelunker_boy"
PibersMod.SecretIcons48x[39] = "ui/main menu/secrets/dark_boy"
PibersMod.SecretIcons48x[40] = "ui/main menu/secrets/mamas_boy"
PibersMod.SecretIcons48x[41] = "ui/main menu/secrets/golden_god"
PibersMod.SecretIcons48x[66] = "ui/main menu/secrets/a_forgotten_horseman"
PibersMod.SecretIcons48x[69] = "ui/main menu/secrets/platinum_god"
PibersMod.SecretIcons48x[86] = "ui/main menu/secrets/cellar"
PibersMod.SecretIcons48x[87] = "ui/main menu/secrets/catacombs"
PibersMod.SecretIcons48x[88] = "ui/main menu/secrets/necropolis"
PibersMod.SecretIcons48x[178] = "ui/main menu/secrets/lord_of_the_flies"
PibersMod.SecretIcons48x[243] = "ui/main menu/secrets/special_hangingguys"
PibersMod.SecretIcons48x[247] = "ui/main menu/secrets/special_shopkeepers"
PibersMod.SecretIcons48x[274] = "ui/main menu/secrets/the_guardian"
PibersMod.SecretIcons48x[275] = "ui/main menu/secrets/generosity"
PibersMod.SecretIcons48x[277] = "ui/main menu/secrets/backasswards"
PibersMod.SecretIcons48x[280] = "ui/main menu/secrets/ultra_hard"
PibersMod.SecretIcons48x[323] = "ui/main menu/secrets/5_nights_at_moms"
PibersMod.SecretIcons48x[331] = "ui/main menu/secrets/laz_bleeds_more"
PibersMod.SecretIcons48x[332] = "ui/main menu/secrets/maggy_now_holds_a_pill"
PibersMod.SecretIcons48x[342] = "ui/main menu/secrets/burning_basement"
PibersMod.SecretIcons48x[343] = "ui/main menu/secrets/flooded_caves"
PibersMod.SecretIcons48x[344] = "ui/main menu/secrets/dank_depths"
PibersMod.SecretIcons48x[345] = "ui/main menu/secrets/scarred_womb"
PibersMod.SecretIcons48x[405] = "ui/main menu/secrets/jacob_and_esau"
PibersMod.SecretIcons48x[412] = "ui/main menu/secrets/dross"
PibersMod.SecretIcons48x[413] = "ui/main menu/secrets/ashpit"
PibersMod.SecretIcons48x[414] = "ui/main menu/secrets/gehenna"
PibersMod.SecretIcons48x[513] = "ui/main menu/secrets/hot_potato"

PibersMod.SecretIcons64x = {}
PibersMod.SecretIcons64x[4] = "grid/door_11_wombhole"
PibersMod.SecretIcons64x[16] = "ui/main menu/secrets/steven"
PibersMod.SecretIcons64x[17] = "ui/main menu/secrets/chad"
PibersMod.SecretIcons64x[84] = "ui/main menu/secrets/real_platinum_god"
PibersMod.SecretIcons64x[142] = "ui/main menu/secrets/krampus"
PibersMod.SecretIcons64x[163] = "ui/main menu/secrets/cursed"
PibersMod.SecretIcons64x[234] = "grid/door_11_wombhole_blue"
PibersMod.SecretIcons64x[265] = "ui/main menu/secrets/xl"
PibersMod.SecretIcons64x[268] = "ui/main menu/secrets/pay_to_play"
PibersMod.SecretIcons64x[278] = "ui/main menu/secrets/aprils_fool"
PibersMod.SecretIcons64x[281] = "ui/main menu/secrets/pong"
PibersMod.SecretIcons64x[320] = "ui/main menu/secrets/portal"
PibersMod.SecretIcons64x[339] = "ui/main menu/secrets/1000000"
PibersMod.SecretIcons64x[341] = "ui/main menu/secrets/greedier"
PibersMod.SecretIcons64x[346] = "ui/main menu/secrets/something_wicked_this_way_comes"
PibersMod.SecretIcons64x[348] = "ui/main menu/secrets/portal"
PibersMod.SecretIcons64x[407] = "ui/main menu/secrets/a_secret_exit"
--PibersMod.SecretIcons64x[475] = "ui/main menu/secrets/the_dauntless" --temp
--PibersMod.SecretIcons64x[476] = "ui/main menu/secrets/the_hoarder" --temp
--PibersMod.SecretIcons64x[477] = "ui/main menu/secrets/the_deceiver" --temp
--PibersMod.SecretIcons64x[478] = "ui/main menu/secrets/the_soiled" --temp
--PibersMod.SecretIcons64x[479] = "ui/main menu/secrets/the_curdled" --temp
--PibersMod.SecretIcons64x[480] = "ui/main menu/secrets/the_savage" --temp
--PibersMod.SecretIcons64x[481] = "ui/main menu/secrets/the_benighted" --temp
--PibersMod.SecretIcons64x[482] = "ui/main menu/secrets/the_enigma" --temp
--PibersMod.SecretIcons64x[483] = "ui/main menu/secrets/the_capricious" --temp
--PibersMod.SecretIcons64x[484] = "ui/main menu/secrets/the_baleful" --temp
--PibersMod.SecretIcons64x[485] = "ui/main menu/secrets/the_harlot" --temp
--PibersMod.SecretIcons64x[486] = "ui/main menu/secrets/the_miser" --temp
--PibersMod.SecretIcons64x[487] = "ui/main menu/secrets/the_empty" --temp
--PibersMod.SecretIcons64x[488] = "ui/main menu/secrets/the_fettered" --temp
--PibersMod.SecretIcons64x[489] = "ui/main menu/secrets/the_zealot" --temp
--PibersMod.SecretIcons64x[490] = "ui/main menu/secrets/the_deserter" --temp
PibersMod.SecretIcons64x[512] = "ui/main menu/secrets/pica_run"
PibersMod.SecretIcons64x[514] = "ui/main menu/secrets/cantripped"
PibersMod.SecretIcons64x[515] = "ui/main menu/secrets/red_redemption"
PibersMod.SecretIcons64x[593] = "ui/main menu/secrets/corrupted_data" --temp

PibersMod.SecretIcons80x = {}
PibersMod.SecretIcons80x[18] = "ui/main menu/secrets/gish"
PibersMod.SecretIcons80x[34] = "ui/main menu/secrets/itlives"
PibersMod.SecretIcons80x[68] = "ui/main menu/secrets/something_icky"
PibersMod.SecretIcons80x[246] = "ui/main menu/secrets/everything_is_terrible_2"

PibersMod.SecretIcons128x = {}
PibersMod.SecretIcons128x[347] = "ui/main menu/secrets/something_wicked_this_way_comes_plus"

PibersMod.SecretIconsCharacters = {}

PibersMod.SecretIconsCharactersScream = {}
PibersMod.SecretIconsCharactersScream[33] = PlayerType.PLAYER_ISAAC

PibersMod.SecretIconsCharactersThumb = {}
PibersMod.SecretIconsCharactersThumb[37] = PlayerType.PLAYER_ISAAC
PibersMod.SecretIconsCharactersThumb[83] = PlayerType.PLAYER_THEFORGOTTEN
PibersMod.SecretIconsCharactersThumb[334] = PlayerType.PLAYER_SAMSON

PibersMod.SecretIconsCharactersDeath = {}
PibersMod.SecretIconsCharactersDeath[166] = PlayerType.PLAYER_ISAAC

PibersMod.SecretIconsBabies = {}

function PibersMod.GenerateSecretsMenuData()
	for index=0, XMLData.GetNumEntries(XMLNode.ACHIEVEMENT) do
		local data = XMLData.GetEntryByOrder(XMLNode.ACHIEVEMENT, index)
		if data and data.id then
			if data.text then
				if string.find(data.text, "You unlocked ") then
					PibersMod.SecretBases[tonumber(data.id)] = "character"
				end
				if string.find(data.text, " in the basement") and not string.find(data.text, " appeared in the basement") then
					PibersMod.SecretBases[tonumber(data.id)] = "basement"
				end
				if string.find(data.text, " in the caves") then
					PibersMod.SecretBases[tonumber(data.id)] = "caves"
				end
				if string.find(data.text, " in the depths") then
					PibersMod.SecretBases[tonumber(data.id)] = "depths"
				end
				if string.find(data.text, "Boy\" achieved") or string.find(data.text, " God") then
					PibersMod.SecretBases[tonumber(data.id)] = "god"
				end
				if string.find(data.text, "Store Upgrade") then
					PibersMod.SecretBases[tonumber(data.id)] = "donation"
				end
				if string.find(data.text, "You unlocked Challenge ") then
					PibersMod.SecretBases[tonumber(data.id)] = "challenge"
				end
			end
			if data.steam_name then
				if string.find(data.steam_name, " God") then
					PibersMod.SecretBases[tonumber(data.id)] = "god"
				end
			end
			if data.steam_description then
				if string.find(data.steam_description, "Complete the game") or string.find(data.steam_description, "Beat the game") then
					PibersMod.SecretBases[tonumber(data.id)] = "womb"
				end
				if string.find(data.steam_description, "Complete everything") or string.find(data.steam_description, "Beat everything") then
					PibersMod.SecretBases[tonumber(data.id)] = "god"
				end
				if string.find(data.steam_description, "in Hard mode") then
					PibersMod.SecretOverlays[tonumber(data.id)] = "blood"
				end
				if string.find(data.steam_description, "Complete the Cathedral") or string.find(data.steam_description, "Beat the Cathedral") then
					PibersMod.SecretBases[tonumber(data.id)] = "cathedral"
				end
				if string.find(data.steam_description, "Complete Sheol") or string.find(data.steam_description, "Beat Sheol") then
					PibersMod.SecretBases[tonumber(data.id)] = "sheol"
				end
				if string.find(data.steam_description, "Complete the Chest") or string.find(data.steam_description, "Beat the Chest") then
					PibersMod.SecretBases[tonumber(data.id)] = "chest"
				end
				if string.find(data.steam_description, "Complete the Dark Room") or string.find(data.steam_description, "Beat the Dark Room") then
					PibersMod.SecretBases[tonumber(data.id)] = "darkroom"
				end
				if string.find(data.steam_description, "Complete Boss Rush") or string.find(data.steam_description, "Beat Boss Rush") then
					PibersMod.SecretBases[tonumber(data.id)] = "bossrush"
				end
				if string.find(data.steam_description, "Complete Greed") or string.find(data.steam_description, "Beat Greed") then
					PibersMod.SecretBases[tonumber(data.id)] = "greed"
					if string.find(data.steam_description, "Complete Greedier") or string.find(data.steam_description, "Beat Greedier") then
						PibersMod.SecretOverlays[tonumber(data.id)] = "blood"
					end
				end
				--if string.find(data.steam_description, "Complete ???") or  string.find(data.steam_description, "Beat ???") then
					--PibersMod.SecretBases[tonumber(data.id)] = "bluewomb"
				--end
				if string.find(data.steam_description, "Complete the Void") or string.find(data.steam_description, "Beat the Void") then
					PibersMod.SecretBases[tonumber(data.id)] = "void"
				end
				if string.find(data.steam_description, "Defeat Mega Satan") then
					PibersMod.SecretBases[tonumber(data.id)] = "megasatan"
				end
				if string.find(data.steam_description, "Complete the Corpse") or string.find(data.steam_description, "Beat the Corpse") then
					PibersMod.SecretBases[tonumber(data.id)] = "corpse"
					PibersMod.SecretOverlays[tonumber(data.id)] = "blooddark"
				end
				if string.find(data.steam_description, "Complete the final chapter") or string.find(data.steam_description, "Beat the final chapter") then
					PibersMod.SecretBases[tonumber(data.id)] = "beast"
				end
				if string.find(data.steam_description, "Complete Challenge") or string.find(data.steam_description, "Beat Challenge") then
					PibersMod.SecretBases[tonumber(data.id)] = "challenge"
				end
			end
		end
	end

	for index=0, XMLData.GetNumEntries(XMLNode.ITEM) do
		local data = XMLData.GetEntryByOrder(XMLNode.ITEM, index)
		if data and data.achievement then
			local id = tonumber(data.id) or Isaac.GetItemIdByName(data.name)
			if id then
				if tonumber(data.achievement) and not PibersMod.SecretIconsItems[tonumber(data.achievement)] then
					PibersMod.SecretIconsItems[tonumber(data.achievement)] = id
				elseif string.len(data.achievement) > 0 then
					local achivID = Isaac.GetAchievementIdByName(data.achievement)
					if achivID and not PibersMod.SecretIconsItems[achivID] then
						PibersMod.SecretIconsItems[achivID] = id
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
				if tonumber(data.achievement) and not PibersMod.SecretIconsTrinkets[tonumber(data.achievement)] then
					PibersMod.SecretIconsTrinkets[tonumber(data.achievement)] = id
				elseif string.len(data.achievement) > 0 then
					local achivID = Isaac.GetAchievementIdByName(data.achievement)
					if achivID and not PibersMod.SecretIconsTrinkets[achivID] then
						PibersMod.SecretIconsTrinkets[achivID] = id
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
				if tonumber(data.achievement) and not PibersMod.SecretIconsCharacters[tonumber(data.achievement)] and not PibersMod.SecretIconsItems[tonumber(data.achievement)] then
					PibersMod.SecretIconsCharacters[tonumber(data.achievement)] = id
					if not PibersMod.SecretBases[tonumber(data.achievement)] then
						PibersMod.SecretBases[tonumber(data.achievement)] = "character"
					end
				elseif string.len(data.achievement) > 0 then
					local achivID = Isaac.GetAchievementIdByName(data.achievement)
					if achivID and not PibersMod.SecretIconsCharacters[achivID] and not PibersMod.SecretIconsItems[achivID] then
						PibersMod.SecretIconsCharacters[achivID] = id
						if not PibersMod.SecretBases[achivID] then
							PibersMod.SecretBases[achivID] = "character"
						end
					end
				end
			end
		end
	end

	for index=0, EntityConfig.GetMaxBabyID() do
		local data = EntityConfig.GetBaby(index)
		if data and data:GetAchievementID() and not PibersMod.SecretIconsBabies[data:GetAchievementID()] then
			PibersMod.SecretIconsBabies[data:GetAchievementID()] = data:GetID()
		end
	end
end
PibersMod:AddPriorityCallback(ModCallbacks.MC_POST_MODS_LOADED, CallbackPriority.LATE, PibersMod.GenerateSecretsMenuData)

function PibersMod:SetSecretIcon(sprite, id)
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
				if PibersMod.SecretBases[id] then
					sprite:ReplaceSpritesheet(1, "gfx/ui/main menu/secrets/base_" .. PibersMod.SecretBases[id] .. ".png", false)
				else
					sprite:ReplaceSpritesheet(1, "gfx/ui/main menu/secrets/base_generic.png", false)
				end
				if PibersMod.SecretOverlays[id] then
					sprite:ReplaceSpritesheet(3, "gfx/ui/main menu/secrets/overlay_" .. PibersMod.SecretOverlays[id] .. ".png", false)
				end
				if PibersMod.SecretIcons32x[id] then
					sprite:ReplaceSpritesheet(2, "gfx/" .. PibersMod.SecretIcons32x[id] .. ".png", false)
				elseif PibersMod.SecretIconsItems[id] then
					local data = XMLData.GetEntryById(XMLNode.ITEM, PibersMod.SecretIconsItems[id])
					if data and data.gfx then
						sprite:ReplaceSpritesheet(2, "gfx/items/collectibles/" .. data.gfx, false)
					end
				elseif PibersMod.SecretIconsTrinkets[id] then
					local data = XMLData.GetEntryById(XMLNode.TRINKET, PibersMod.SecretIconsTrinkets[id])
					if data and data.gfx then
						if PibersMod.SecretIconsTrinketOffset[id] then
							sprite:ReplaceSpritesheet(11, "gfx/items/trinkets/" .. data.gfx, false)
						elseif PibersMod.SecretIconsTrinketOffsetSlight[id] then
							sprite:ReplaceSpritesheet(12, "gfx/items/trinkets/" .. data.gfx, false)
						else
							sprite:ReplaceSpritesheet(2, "gfx/items/trinkets/" .. data.gfx, false)
						end
					end
				elseif PibersMod.SecretIconsCoins[id] then
					sprite:ReplaceSpritesheet(13, "gfx/items/pick ups/" .. PibersMod.SecretIconsCoins[id] .. ".png", false)
				elseif PibersMod.SecretIconsCharactersDeath[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, PibersMod.SecretIconsCharactersDeath[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(14, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif PibersMod.SecretIconsCharactersScream[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, PibersMod.SecretIconsCharactersScream[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(9, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif PibersMod.SecretIconsCharactersThumb[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, PibersMod.SecretIconsCharactersThumb[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(10, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif PibersMod.SecretIconsCharacters[id] then
					local data = XMLData.GetEntryById(XMLNode.PLAYER, PibersMod.SecretIconsCharacters[id])
					if data and data.skin then
						sprite:ReplaceSpritesheet(5, "gfx/characters/costumes/" .. data.skin, false)
					end
				elseif PibersMod.SecretIconsBabies[id] then
					local data = EntityConfig.GetBaby(PibersMod.SecretIconsBabies[id])
					if data then
						sprite:ReplaceSpritesheet(2, data:GetSpritesheetPath(), false)
					end
				elseif PibersMod.SecretIcons48x[id] then
					sprite:ReplaceSpritesheet(6, "gfx/" .. PibersMod.SecretIcons48x[id] .. ".png", false)
				elseif PibersMod.SecretIcons64x[id] then
					sprite:ReplaceSpritesheet(4, "gfx/" .. PibersMod.SecretIcons64x[id] .. ".png", false)
				elseif PibersMod.SecretIcons80x[id] then
					sprite:ReplaceSpritesheet(8, "gfx/" .. PibersMod.SecretIcons80x[id] .. ".png", false)
				elseif PibersMod.SecretIcons128x[id] then
					sprite:ReplaceSpritesheet(15, "gfx/" .. PibersMod.SecretIcons128x[id] .. ".png", false)
				end
				sprite:LoadGraphics()
				return true
			--end
		end
		sprite:LoadGraphics()
	end
	return false
end

function PibersMod:OnMainMenuRenderSecrets()
	local gamedata = Isaac.GetPersistentGameData()
	if StatsMenu.IsSecretsMenuVisible() then

		--[[
		for id=0, XMLData.GetNumEntries(XMLNode.ACHIEVEMENT) do
			local data = XMLData.GetEntryById(XMLNode.ACHIEVEMENT, id)
			if data and data.id then
				local secretPos = PibersMod.SecretPos + Vector((id%10)*32, math.ceil(id/10)*32)
				if gamedata:Unlocked(id) then
					PibersMod.SecretSprite:Render(Isaac.WorldToMenuPosition(MainMenuType.STATS, secretPos))
				else
					PibersMod.SecretSpriteLocked:Render(Isaac.WorldToMenuPosition(MainMenuType.STATS, secretPos))
				end
			end
		end
		]]

		local numSecrets = XMLData.GetNumEntries(XMLNode.ACHIEVEMENT)
		local secretSprite = StatsMenu.GetSecretsMenuSprite()
		local frame = secretSprite:GetFrame()
		if frame == 0 and PibersMod.LastSecretPageFrame ~= frame then
			if secretSprite:IsPlaying("Appear") then
				PibersMod.LastSecretPageAnim = "Appear"
				local checkSecret = PibersMod.CurrentlySelectedSecret-1
				if checkSecret < 1 then
					checkSecret = checkSecret + numSecrets
				end
				local secretData = XMLData.GetEntryByOrder(XMLNode.ACHIEVEMENT, checkSecret)
				if secretData and secretData.gfx then
					secretSprite:ReplaceSpritesheet(3, "gfx/ui/achievement/" .. secretData.gfx, true)
				end
			elseif secretSprite:IsPlaying("Appear2") then
				PibersMod.LastSecretPageAnim = "Appear2"
				local checkSecret = PibersMod.CurrentlySelectedSecret+1
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
		and (frame == 7 and PibersMod.LastSecretPageFrame == frame)) then
			if PibersMod.LastSecretPageAnim == "Appear" then
				PibersMod.CurrentlySelectedSecret = PibersMod.CurrentlySelectedSecret - 1
				if PibersMod.CurrentlySelectedSecret < 1 then
					PibersMod.CurrentlySelectedSecret = numSecrets
				end
			elseif PibersMod.LastSecretPageAnim == "Appear2" then
				PibersMod.CurrentlySelectedSecret = PibersMod.CurrentlySelectedSecret + 1
				if PibersMod.CurrentlySelectedSecret > numSecrets then
					PibersMod.CurrentlySelectedSecret = 1
				end
			end
			PibersMod.LastSecretPageAnim = "Idle"
		end

		PibersMod.LastSecretPageFrame = frame


		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite1(), PibersMod.CurrentlySelectedSecret-4)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite2(), PibersMod.CurrentlySelectedSecret-3)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite3(), PibersMod.CurrentlySelectedSecret-2)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite4(), PibersMod.CurrentlySelectedSecret-1)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite5(), PibersMod.CurrentlySelectedSecret)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite6(), PibersMod.CurrentlySelectedSecret+1)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite7(), PibersMod.CurrentlySelectedSecret+2)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite8(), PibersMod.CurrentlySelectedSecret+3)
		PibersMod:SetSecretIcon(StatsMenu.GetSecretsMenuMiniSprite9(), PibersMod.CurrentlySelectedSecret+4)
	elseif PibersMod.CurrentlySelectedSecret ~= 2 then
		local firstUnlocked = 1
		for id=firstUnlocked, XMLData.GetNumEntries(XMLNode.ACHIEVEMENT) do
			if gamedata:Unlocked(id) then
				firstUnlocked = id
				break
			end
		end
		PibersMod.CurrentlySelectedSecret = firstUnlocked+1
	end
end
PibersMod:AddCallback(ModCallbacks.MC_MAIN_MENU_RENDER, PibersMod.OnMainMenuRenderSecrets)
