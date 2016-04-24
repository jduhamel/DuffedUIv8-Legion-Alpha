﻿local D, C, L = unpack(select(2, ...))

C["general"] = {
	["autoscale"] = true,
	["uiscale"] = 0.71,
	["backdropcolor"] = {.05, .05, .05},
	["bordercolor"] = {.125, .125, .125},
	["classcolor"] = true,
	["autoaccept"] = true,
	["blizzardreskin"] = true,
	["calendarevent"] = false,
}

C["unitframes"] = {
	["enable"] = true,
	["layout"] = 1,
	["percent"] = true,
	["showsmooth"] = true,
	["unicolor"] = true,
	["healthbarcolor"] = {.125, .125, .125, 1},
	["deficitcolor"] = {0, 0, 0},
	["ColorGradient"] = true,
	["charportrait"] = true,
	["weakenedsoulbar"] = true,
	["classbar"] = true,
	["runeofpower"] = true,
	["targetauras"] = true,
	["onlyselfdebuffs"] = false,
	["combatfeedback"] = true,
	["healcomm"] = true,
	["playeraggro"] = true,
	["totdebuffs"] = false,
	["totdbsize"] = 20,
	["focusdebuffs"] = true,
	["focusbutton"] = true,
	["attached"] = false,
	["oocHide"] = true,
	["playermodel"] = "Model",
	["buffsize"] = 20,
	["debuffsize"] = 20,
	["DruidMana"] = true,
	["AnticipationBar"] = true,
}

C["chat"] = {
	["enable"] = true,
	["whispersound"] = true,
	["lbackground"] = true,
	["rbackground"] = true,
	["textright"] = true,
	["fading"] = true,
}

C["castbar"] = {
	["enable"] = true,
	["petenable"] = true,
	["cblatency"] = true,
	["cbicons"] = true,
	["spark"] = true,
	["classcolor"] = false,
	["color"] = {.31, .45, .63, .5},
	["cbticks"] = true,
	["playerwidth"] = 376,
}

C["nameplate"] = {
 	["active"] = true,
 	["auraswidth"] = 20,
 	["aurasheight"] = 15,
 	["debuffs"] = true,
 	["platewidth"] = 110,
 	["plateheight"] = 7,
 	["threat_goodcolor"] = {.29,  .69, .3},
 	["threat_badcolor"] = {.78, .25, .25},
 	["threat_transitioncolor"] = {.86, .77, .36},
 	["Percent"] = false,
 	["MaxDebuffs"] = 5,
	["NTA"] = .35,
 }

C["actionbar"] = {
	["enable"] = true,
	["rightbarvertical"] = false,
	["rightbarsmouseover"] = false,
	["petbarhorizontal"] = false,
	["petbaralwaysvisible"] = true,
	["verticalshapeshift"] = true,
	["hotkey"] = true,
	["macro"] = false,
	["buttonsize"] = 27,
	["SidebarButtonsize"] = 23,
	["petbuttonsize"] = 29,
	["buttonspacing"] = 4,
	["shapeshiftborder"] = true,
	["shapeshiftmouseover"] = false,
	["borderhighlight"] = false,
	["Leftsidebars"] = false,
	["Rightsidebars"] = false,
}

C["raid"] = {
	["enable"] = true,
	["showboss"] = true,
	["arena"] = true,
	["maintank"] = true,
	["mainassist"] = false,
	["showrange"] = true,
	["raidalphaoor"] = 0.3,
	["showsymbols"] = true,
	["aggro"] = true,
	["raidunitdebuffwatch"] = true,
	["showraidpets"] = false,
	["showplayerinparty"] = true,
	["framewidth"] = 68,
	["frameheight"] = 45,
	["layout"] = "heal",
}

C["datatext"] = {
	["armor"] = 0,
	["avd"] = 0,
	["bags"] = 5,
	["battleground"] = true,
	["block"] = 0,
	["bonusarmor"] = 0,
	["calltoarms"] = 0,
	["crit"] = 0,
	["dodge"] = 0,
	["dur"] = 2,
	["friends"] = 3,
	["gold"] = 6,
	["guild"] = 1,
	["haste"] = 0,
	["honor"] = 0,
	["honorablekills"] = 0,
	["leech"] = 0,
	["mastery"] = 0,
	["micromenu"] = 0,
	["multistrike"] = 0,
	["parry"] = 0,
	["power"] = 7,
	["profession"] = 0,
	["smf"] = 4,
	["talent"] = 0,
	["versatility"] = 0,
	["wowtime"] = 8,
	["garrison"] = 0,

	["time24"] = true,
	["localtime"] = false,
	["ShowInCombat"] = false,
}

C["cooldown"] = {
	["enable"] = true,
	["treshold"] = 8,
	["rcdenable"] = true,
	["rcdraid"] = true,
	["rcdparty"] = false,
	["rcdarena"] = false,
	["scdenable"] = true,
	["scdfsize"] = 12,
	["scdsize"] = 28,
	["scdspacing"] = 10,
	["scdfade"] = 0,
}

C["classtimer"] = {
	["enable"] = true,
	["playercolor"] = {.2, .2, .2, 1 },
	["targetbuffcolor"] = { 70/255, 150/255, 70/255, 1 },
	["targetdebuffcolor"] = { 150/255, 30/255, 30/255, 1 },
	["trinketcolor"] = {75/255, 75/255, 75/255, 1 },
	["height"] = 15,
	["spacing"] = 1,
	["separator"] = true,
	["separatorcolor"] = { 0, 0, 0, .5 },
	["debuffsenable"] = true,
	["targetdebuff"] = false,
}

C["auras"] = {
	["player"] = true,
	["consolidate"] = false,
	["flash"] = false,
	["classictimer"] = true,
	["bufftracker"] = true,
	["buffnotice"] = true,
	["warning"] = true,
	["wrap"] = 18,
}

C["bags"] = {
	["enable"] = true,
	["bpr"] = 10,
	["scale"] = 1,
	["buttonsize"] = 28,
	["spacing"] = 4,
	["Bounce"] = true,
	["SortingButton"] = true,
}

C["misc"] = {
	["gold"] = true,
	["sesenable"] = true,
	["sesenablegear"] = true,
	["sesgearswap"] = true,
	["sesset1"] = 1,
	["sesset2"] = 2,
	["combatanimation"] = true,
	["flightpoint"] = true,
	["ilvlcharacter"] = true,
	["loc"] = true,
	["acm_screen"] = true,
	["AFKCamera"] = true,
	["XPBar"] = true,
	["XPBarWidth"] = 378,
	["magemenu"] = false,
}

C["duffed"] = {
	["dispelannouncement"] = false,
	["drinkannouncement"] = false,
	["sayinterrupt"] = true,
	["announcechannel"] = "SAY",
	["spellannounce"] = true,
	["errorfilter"] = true,
	filter = {
		[INVENTORY_FULL] = true,
		[ERR_PARTY_LFG_BOOT_COOLDOWN_S] = true,
		[ERR_PARTY_LFG_BOOT_LIMIT] = true,
		[ERR_PETBATTLE_NOT_HERE] = true,
		[ERR_PETBATTLE_NOT_WHILE_IN_COMBAT] = true,
		[ERR_CANT_USE_ITEM] = true,
		[CANT_USE_ITEM] = true,
		[SPELL_FAILED_NOT_FISHABLE] = true,
	},
}

C["loot"] = {
	["lootframe"] = true,
	["rolllootframe"] = true,
}

C["tooltip"] = {
	["enable"] = true,
	["hidecombat"] = false,
	["hidebuttons"] = false,
	["hideuf"] = false,
	["ilvl"] = true,
	["ids"] = true,
	["enablecaster"] = true,
	["Mouse"] = false,
}

C["merchant"] = {
	["sellgrays"] = true,
	["autorepair"] = true,
	["sellmisc"] = true,
	["autoguildrepair"] = true,
}
