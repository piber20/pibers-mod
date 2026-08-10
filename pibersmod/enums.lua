Music.MUSIC_DEATHMATCH = 119
Music.NUM_MUSIC = 120

BossColors = BossColors or {}
BossColors.GEMINI_STEVEN = Isaac.GetBossColorIdxByName("fakestevengemini")
BossColors.GEMINI_STEVEN_BABY = Isaac.GetBossColorIdxByName("fakestevenbaby")
BossColors.GEMINI_STEVEN_CORD = Isaac.GetBossColorIdxByName("fakestevencord")
BossColors.DUKE_ETERNAL = Isaac.GetBossColorIdxByName("eternalduke")
BossColors.SCOLEX_BLACK = Isaac.GetBossColorIdxByName("blackscolex")

GeminiVariant = GeminiVariant or {}
GeminiVariant.CONTUSION = 0
GeminiVariant.STEVEN = 1
GeminiVariant.CONTUSION_OVUM = 2
GeminiVariant.SUTURE = 10
GeminiVariant.STEVEN_BABY = 11
GeminiVariant.SUTURE_GHOST = 12
GeminiVariant.CORD = 20

BackdropType.RUNEROOM_SECRET = Isaac.GetBackdropIdByName("Rune Room Secret")
BackdropType.BASEMENT_BOSS = Isaac.GetBackdropIdByName("Basement Boss")
BackdropType.TEST = Isaac.GetBackdropIdByName("Test")
BackdropType.BABY_SHOP = Isaac.GetBackdropIdByName("Baby Shop")
BackdropType.ARCADE_BETA = Isaac.GetBackdropIdByName("Arcade Beta")

HeartSubType.BLESSING = Isaac.GetEntitySubTypeByName("Blessing")

EffectVariant.PIBERSMOD = Isaac.GetEntityVariantByName("Sticky Nickel Puddle")
PibersMod.Effects = {}
PibersMod.Effects.STICKY_NICKEL_PUDDLE = Isaac.GetEntitySubTypeByName("Sticky Nickel Puddle")
PibersMod.Effects.FAKE_WALL_HANDLER = Isaac.GetEntitySubTypeByName("Fake Wall Handler")

EffectVariant.PIBERSMOD_FORCEBACKDROP = Isaac.GetEntityVariantByName("Force Backdrop Handler")

EntityType.EFFECT_PROXY = Isaac.GetEntityTypeByName("Effect Proxy")

CollectibleType.MIXED_VEGGIES = Isaac.GetItemIdByName("Mixed Veggies")
CollectibleType.BLOODY_FEATHER = Isaac.GetItemIdByName("Bloody Feather")
CollectibleType.KEY_PIECE_COMPLETE = Isaac.GetItemIdByName("The Key")
CollectibleType.KNIFE_PIECE_COMPLETE = Isaac.GetItemIdByName("The Knife")
CollectibleType.COUNTERFEIT_DOLLAR = Isaac.GetItemIdByName("Counterfeit Dollar")

TrinketType.ORTHODOX_CROSS = Isaac.GetTrinketIdByName("Orthodox Cross")

ItemPoolType.ISAACS_ROOM = Isaac.GetPoolIdByName("isaacsroom")
ItemPoolType.BARREN_ROOM = Isaac.GetPoolIdByName("barrenroom")
ItemPoolType.DICE_ROOM = Isaac.GetPoolIdByName("diceroom")
ItemPoolType.CRAWLSPACE = Isaac.GetPoolIdByName("crawlspace")
ItemPoolType.DUNGEON = ItemPoolType.CRAWLSPACE
ItemPoolType.POOL_DUNGEON = ItemPoolType.CRAWLSPACE
ItemPoolType.SACRIFICE_ROOM = Isaac.GetPoolIdByName("sacrificeroom")
ItemPoolType.KRAMPUS = Isaac.GetPoolIdByName("krampus")
ItemPoolType.PLANETARIUM_BLOATED = Isaac.GetPoolIdByName("planetariumBloated")

NullItemID.MAGGYS_HAIR_HAT = Isaac.GetNullItemIdByName("maggys hair for hats")

Card.RUNE_ISAZ = Isaac.GetCardIdByName("Isaz")
Card.RUNE_WUNJO = Isaac.GetCardIdByName("Wunjo")

BedSubType.BED_MOM = 10

GridRooms.ROOM_FIRST_IDX = 0
GridRooms.ROOM_LAST_IDX = 168
GridRooms.WIDTH = 13

GridRooms.ROOM_STARTING_IDX = 84

GridRooms.ROOM_GREEDMODE_STARTING_IDX = 84
GridRooms.ROOM_GREEDMODE_STARTING_OTHER_IDX = 97
GridRooms.ROOM_GREEDMODE_STARTING_TOP_IDX = 84
GridRooms.ROOM_GREEDMODE_STARTING_BOTTOM_IDX = 97
GridRooms.ROOM_GREEDMODE_SHOP_IDX = 70
GridRooms.ROOM_GREEDMODE_SHOP_OTHER_IDX = 71
GridRooms.ROOM_GREEDMODE_SHOP_LEFT_IDX = 70
GridRooms.ROOM_GREEDMODE_SHOP_RIGHT_IDX = 71
GridRooms.ROOM_GREEDMODE_SHOP_DESC_IDX = 70
GridRooms.ROOM_GREEDMODE_SHOP_DESC_SAFE_IDX = 70
GridRooms.ROOM_GREEDMODE_CURSE_IDX = 83
GridRooms.ROOM_GREEDMODE_TREASURE_IDX = 85
GridRooms.ROOM_GREEDMODE_TREASURE_GOLD_IDX = 85
GridRooms.ROOM_GREEDMODE_TREASURE_YELLOW_IDX = 85
GridRooms.ROOM_GREEDMODE_TREASURE_LOCKED_IDX = 85
GridRooms.ROOM_GREEDMODE_TREASURE_SILVER_IDX = 98
GridRooms.ROOM_GREEDMODE_TREASURE_WHITE_IDX = 98
GridRooms.ROOM_GREEDMODE_TREASURE_BOSS_IDX = 98
GridRooms.ROOM_GREEDMODE_TREASURE_UNLOCKED_IDX = 98
GridRooms.ROOM_GREEDMODE_TREASURE_OTHER_IDX = 98
GridRooms.ROOM_GREEDMODE_EXIT_IDX = 110

GridRooms.ROOM_ULTRAGREED_STARTING_IDX = 84
GridRooms.ROOM_ULTRAGREED_PRE_IDX = 71
GridRooms.ROOM_ULTRAGREED_PREBOSS_IDX = 71
GridRooms.ROOM_ULTRAGREED_FIRSTBOSS_IDX = 71
GridRooms.ROOM_ULTRAGREED_BOSS1_IDX = 71
GridRooms.ROOM_ULTRAGREED_IDX = 58
GridRooms.ROOM_ULTRAGREED_DESC_IDX = 45
GridRooms.ROOM_ULTRAGREED_DESC_SAFE_IDX = 45
GridRooms.ROOM_ULTRAGREED_TOP_IDX = 45
GridRooms.ROOM_ULTRAGREED_BOTTOM_IDX = 58
GridRooms.ROOM_ULTRAGREED_BOSS_IDX = 58
GridRooms.ROOM_ULTRAGREED_BOSS_TOP_IDX = 45
GridRooms.ROOM_ULTRAGREED_BOSS_BOTTOM_IDX = 58
GridRooms.ROOM_ULTRAGREED_LASTBOSS_IDX = 58
GridRooms.ROOM_ULTRAGREED_BOSS2_IDX = 58

GridRooms.ROOM_BLUEWOMB_BOSS_IDX = 71
GridRooms.ROOM_BLUEWOMB_BOSS_ENTRANCE_IDX = 71
GridRooms.ROOM_BLUEWOMB_BOSS_DESC_IDX = 58
GridRooms.ROOM_BLUEWOMB_BOSS_DESC_SAFE_IDX = 58
GridRooms.ROOM_BLUEWOMB_BOSS_TOPLEFT_IDX = 58
GridRooms.ROOM_BLUEWOMB_BOSS_TOPRIGHT_IDX = 59
GridRooms.ROOM_BLUEWOMB_BOSS_BOTTOMLEFT_IDX = 71
GridRooms.ROOM_BLUEWOMB_BOSS_BOTTOMRIGHT_IDX = 72
GridRooms.ROOM_BLUEWOMB_STARTING_IDX = 84
GridRooms.ROOM_BLUEWOMB_STARTING_OTHER_IDX = 97
GridRooms.ROOM_BLUEWOMB_STARTING_TOP_IDX = 84
GridRooms.ROOM_BLUEWOMB_STARTING_BOTTOM_IDX = 97
GridRooms.ROOM_BLUEWOMB_TREASURE_LEFT_IDX = 96
GridRooms.ROOM_BLUEWOMB_TREASURE_RIGHT_IDX = 98
GridRooms.ROOM_BLUEWOMB_SHOP_IDX = 110

GridRooms.ROOM_HOME_MOMSROOM_IDX = 82
GridRooms.ROOM_HOME_ISAACSROOM_IDX = 84
GridRooms.ROOM_HOME_LEFTHALL_IDX = 95
GridRooms.ROOM_HOME_LEFTHALL_OTHER_IDX = 108
GridRooms.ROOM_HOME_LEFTHALL_TOP_IDX = 95
GridRooms.ROOM_HOME_LEFTHALL_BOTTOM_IDX = 108
GridRooms.ROOM_HOME_LEFTHALL_CLOSET_IDX = 95
GridRooms.ROOM_HOME_LEFTCLOSET_IDX = 95
GridRooms.ROOM_HOME_TAINTED_IDX = 95
GridRooms.ROOM_HOME_TAINTED_CLOSET_IDX = 95
GridRooms.ROOM_HOME_CLOSET_TAINTED_IDX = 95
GridRooms.ROOM_HOME_RIGHTHALL_IDX = 97
GridRooms.ROOM_HOME_RIGHTHALL_OTHER_IDX = 110
GridRooms.ROOM_HOME_RIGHTHALL_TOP_IDX = 97
GridRooms.ROOM_HOME_RIGHTHALL_BOTTOM_IDX = 110
GridRooms.ROOM_HOME_RIGHTHALL_CLOSET_IDX = 98
GridRooms.ROOM_HOME_CLOSET_IDX = 98
GridRooms.ROOM_HOME_RIGHTCLOSET_IDX = 98
GridRooms.ROOM_HOME_LIVINGROOM_IDX = 109
GridRooms.ROOM_HOME_LIVINGROOM_ENTRANCE_IDX = 109
GridRooms.ROOM_HOME_LIVINGROOM_OTHER_IDX = 122
GridRooms.ROOM_HOME_LIVINGROOM_TOP_IDX = 109
GridRooms.ROOM_HOME_LIVINGROOM_BOTTOM_IDX = 122

FireplaceVariant = FireplaceVariant or {}
FireplaceVariant.NORMAL = 0
FireplaceVariant.RED = 1
FireplaceVariant.BLUE = 2
FireplaceVariant.PURPLE = 3
FireplaceVariant.WHITE = 4

PoopVariant = PoopVariant or {}
PoopVariant.NORMAL = 0
PoopVariant.RED = 1
PoopVariant.CORNY = 2
PoopVariant.GOLDEN = 3
PoopVariant.RAINBOW = 4
PoopVariant.BLACK = 5
PoopVariant.WHITE = 6
PoopVariant.GIANT = 10
PoopVariant.CHARMING = 11

Poof02Subtype = Poof02Subtype or {}
Poof02Subtype.LARGE_RED = 0
Poof02Subtype.GROUND = 1
Poof02Subtype.GROUND_FOREGROUND = 2
Poof02Subtype.BLOOD = 3
Poof02Subtype.BLOOD_FOREGROUND = 4
Poof02Subtype.BLOOD_CLOUD = 5
Poof02Subtype.FORGOTTEN_SOUL = 10
Poof02Subtype.HOLY_MANTLE = 11
Poof02Subtype.LAVA_SPLASH = 66
Poof02Subtype.LAVA_SPLASH_LARGE = 67
Poof02Subtype.BLOOD_FOREGROUND_WHITE = 97
Poof02Subtype.LARGE = 98
Poof02Subtype.SMALL = 99

PickupSubType = PickupSubType or {}
PickupSubType.NULL = 0
PickupSubType.CARD_TAROT = 1
PickupSubType.CARD_SUIT = 2
PickupSubType.RUNE_1 = 3
PickupSubType.RUNE_2 = 4
PickupSubType.EMERGENCY_CONTACT = 5
PickupSubType.DICE_SHARD = 6
PickupSubType.RUNE_BLACK = 7
PickupSubType.CARD_MAGIC = 8
PickupSubType.CARD_HUMANITY = 9
PickupSubType.CARD_CREDIT = 10
PickupSubType.CARD_HOLY = 11
PickupSubType.CARD_CHANCE = 12
PickupSubType.RUNE_SHARD= 13
PickupSubType.CARD_TAROT_REVERSE = 14
PickupSubType.KEY_CRACKED = 15
PickupSubType.CARD_TREASURE = 16
PickupSubType.CARD_UNUS = 17
PickupSubType.SOUL_ISAAC = 18
PickupSubType.SOUL_MAGDALENE = 19
PickupSubType.SOUL_CAIN = 20
PickupSubType.SOUL_JUDAS = 21
PickupSubType.SOUL_BLUEBABY = 22
PickupSubType.SOUL_EVE = 23
PickupSubType.SOUL_SAMSON = 24
PickupSubType.SOUL_AZAZEL = 25
PickupSubType.SOUL_LAZARUS = 26
PickupSubType.SOUL_EDEN = 27
PickupSubType.SOUL_LOST = 28
PickupSubType.SOUL_LILITH = 29
PickupSubType.SOUL_KEEPER = 30
PickupSubType.SOUL_APOLLYON = 31
PickupSubType.SOUL_FORGOTTEN = 32
PickupSubType.SOUL_BETHANY = 33
PickupSubType.SOUL_JACOB = 34
PickupSubType.NUM_PICKUPS = 35
PickupSubType.CARD_SUIT_BLOODY = Isaac.GetEntitySubTypeByName("Bloody Suit Card")
PickupSubType.CARD_CARD_QUESTION = Isaac.GetEntitySubTypeByName("Question Card")
PickupSubType.CARD_RUNE_BLANK = Isaac.GetEntitySubTypeByName("Blank Rune")
