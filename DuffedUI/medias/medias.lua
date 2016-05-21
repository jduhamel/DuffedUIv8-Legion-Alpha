local D, C, L = unpack(select(2, ...))

C["media"] = {
	["font"] = [[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]],
	["dmgfont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat.ttf]],

	["fr_font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["fr_dmgfont"] = [=[Interface\AddOns\DuffedUI\medias\fonts\combat.ttf]=],

	["ru_font"] = [=[Interface\Addons\DuffedUI\medias\fonts\normal_font.ttf]=],
	["ru_dmgfont"] = [[Interface\AddOns\DuffedUI\medias\fonts\combat_rus.ttf]],

	["tw_font"] = [=[Fonts\bLEI00D.ttf]=],
	["tw_dmgfont"] = [[Fonts\bLEI00D.ttf]],

	["kr_font"] = [=[Fonts\2002.TTF]=],
	["kr_dmgfont"] = [[Fonts\2002.TTF]],

	["cn_font"] = [=[Fonts\ARKai_T.TTF]=],
	["cn_dmgfont"] = [[Fonts\ARKai_C.TTF]],

	["normTex"] = [[Interface\AddOns\DuffedUI\medias\textures\normTex.tga]],
	["glowTex"] = [[Interface\AddOns\DuffedUI\medias\textures\glowTex.tga]],
	["copyicon"] = [[Interface\AddOns\DuffedUI\medias\textures\copy.tga]],
	["blank"] = [[Interface\AddOns\DuffedUI\medias\textures\blank.tga]],
	["duffed"] = [[Interface\AddOns\DuffedUI\medias\textures\duffed.tga]],
	["duffed_logo"] = [[Interface\AddOns\DuffedUI\medias\textures\logo.tga]],
	["alliance"] = [[Interface\AddOns\DuffedUI\medias\textures\alliance.tga]],
	["d3"] = [[Interface\AddOns\DuffedUI\medias\textures\d3.tga]],
	["horde"] = [[Interface\AddOns\DuffedUI\medias\textures\horde.tga]],
	["neutral"] = [[Interface\AddOns\DuffedUI\medias\textures\neutral.tga]],
	["sc2"] = [[Interface\AddOns\DuffedUI\medias\textures\sc2.tga]],
	["RaidIcons"] = [[Interface\AddOns\DuffedUI\medias\textures\raidicons.tga]],

	["bordercolor"] = C["general"].bordercolor or { .125, .125, .125 },
	["backdropcolor"] = C["general"].backdropcolor or { .05, .05, .05 },
	["datatextcolor1"] = { .4, .4, .4 }, -- color of datatext title
	["datatextcolor2"] = { 1, 1, 1 }, -- color of datatext result

	["whisper"] = [[Interface\AddOns\DuffedUI\medias\sounds\whisper.ogg]],
}