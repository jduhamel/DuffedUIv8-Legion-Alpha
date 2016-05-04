local D, C, L = unpack(select(2, ...))
if C["cooldown"]["scdenable"] ~= true then return end

local f, fs, ff = C["media"].font, 11, "THINOUTLINE"
local texture = C["media"]["normTex"]
local size = D.Scale(C["cooldown"]["scdsize"])
local spacing = D.Scale(C["cooldown"]["scdspacing"])
local color = {1, 1, 0, 1}
local fade = C["cooldown"]["scdfade"]
local mode = "HIDE"

if D["Class"] == "WARRIOR" or D["Class"] == "HUNTER" or D["Class"] == "DEATHKNIGHT" or D["Class"] == "ROGUE" then mode = "HIDE" end

spellCooldowns = {
	["DEATHKNIGHT"] = {
		-- Global
		47528, -- Mind Freeze
		48707, -- Anti Magic Shell
		49576, -- Death Grip
		50977, -- Death Gate
		61999, -- Raise Ally
		212552, -- Wraith Walk
		-- Shared
		43265, -- Death & Decay
		48792, -- Icebound Fortitude
		-- Blood
		49028, -- Dancing Rune Weapon
		55233, -- Vampiric Blood
		108199, -- Gorefiend's Grasp
		194679, -- Rune Tap
		194844, -- Bonestorm
		206931, -- Exsanguinate
		206977, -- Blood Mirror
		219809, -- Tombstone
		221562, -- Asphyxiate
		221699, -- Blood Tap
		-- Frost
		47568, -- Empower Rune Weapon
		51271, -- Pillar of Frost
		57330, -- Horn of Winter
		152279, -- Breath of Sindragosa
		194913, -- Glacial Advance
		196770, -- Remorseless Winter
		207127, -- Hungering Rune Weapon
		207167, -- Blinding Sleet
		207256, -- Obliteration
		-- Unholy
		42650, -- Army of the Dead
		46584, -- Raise Dead
		49206, -- Summon Gargoyle
		63560, -- Dark Transformation
		108194, -- Asphyxiate
		130736, -- Soul Reaper
		152280, -- Defile
		194918, -- Blighted Rune Weapon
		207317, -- Epidemic
		207319, -- Corpse Shield
		207349, -- Dark Arbiter
		-- PvP
		47476, -- Strangulate
		51052, -- Anti-Magic-Zone
		77606, -- Dark Simulacrum
		203173, -- Death Chain
		204143, -- Killing Machine
		204160, -- Chill Streak
		208683, -- Gladiators Medallion
	},
	["DEMONHUNTER"] = {
		-- Global
		183752, -- Consume Magic
		188501, -- Spectral Sight
		191427, -- Metamorphosis
		196718, -- Darkness
		211881, -- Fel Eruption
		213241, -- Felblade
		217832, -- Imprison
		-- Havoc
		179057, -- Chaos Nova
		185123, -- Throw Glaive
		188409, -- Blade Dance
		195072, -- Fel Rush
		196555, -- Netherwalk
		198013, -- Eye Beam
		198589, -- Blur
		198793, -- Vengeful Retreat
		201467, -- Fury of the Illidary (Artifact)
		206491, -- Nemesis
		211048, -- Chaos Blades
		211053, -- Fel Barrage
		-- Vengeance
		178740, -- Immolation Aura
		189110, -- Infernal Strike
		202137, -- Sigil of Silence
		202138, -- Sigil of Chains
		203720, -- Demon Spikes
		204021, -- Fiery Brand
		204596, -- Sigil of Flame
		207684, -- Sigil of Misery
		207810, -- Nether Bond
		212084, -- Fel Devastation
		218256, -- Empower Wards
		218640, -- Brand of the Hunt
		-- PvP
		203704, -- Mana Break
		205604, -- Reverse Magic
		205629, -- Demonic Trample
		205630, -- Illidan's Grasp
		206649, -- Eye of Leotheras
		206803, -- Rain from Above
		208683, -- Gladiators Medallion
	},
	["DRUID"] = {
		-- Global
		-- Shared
		-- Balance
		-- Guardian
		-- Feral
		-- Restoration
	},
	["HUNTER"] = {
		-- Global
		1543, -- Flare
		5384, -- Feign Death
		109304, -- Exhilaration
		131894, -- A Murder of Crows
		186257, -- Aspect of the Cheetah
		186265, -- Aspect of the Turtle
		-- Shared
		781, -- Disengage
		19386, -- Wyvern Sting
		34477, -- Misdirection
		109248, -- Binding Shot
		120360, -- Barrage
		147362, -- Counter Shot
		198783, -- Camouflage
		-- Beastmaster
		19574, -- Bestial Wrath
		19577, -- Intimidation	
		120679, -- Dire Beast
		193530, -- Aspect of the Wild
		201430, -- Stampede
		217200, -- Dire Frenzy
		-- Marksmanship
		193526, -- Trueshot
		194599, -- Black Arrow
		198760, -- Headshot
		206817, -- Heightend Vulnerability
		212431, -- Explosive Shot
		214579, -- Sidewinders
		-- Survival
		162488, -- Lacerate
		185855, -- Lacerate
		186289, -- Aspect of the Eagle
		187650, -- Freezing Trap
		187698, -- Tar Trap
		187707, -- Muzzle
		190925, -- Harpoon
		191241, -- Sticky Bomb
		191433, -- Explosive Trap
		194277, -- Caltrops
		194407, -- Spitting Cobra
		194855, -- Dragonsfire Grenade
		200163, -- Throwing Axes
		201078, -- Snake Hunter
		212436, -- Butchery
		-- PvP
		53271, -- Master's Call
		202914, -- Spider Sting
		205691, -- Dire Beast: Basilisk
		208652, -- Dire Beast: Hawk
		208683, -- Gladiators Medallion
		209789, -- Freezing Armor
		212638, -- Tracker's Net
		212640, -- Mending Bandage
		213691, -- Scatter Shot
	},
	["MAGE"] = {
		-- Global
		122, -- Frost Nova
		1953, -- Blink
		2139, -- Counterspell
		11246, -- Ice Barrier
		45438, -- Ice Block
		55342, -- Mirror Image
		80353, -- Time Warp
		108839, -- Ice Floes
		113724, -- Ring of Frost
		116011, -- Rune of Power
		212653, -- Shimmer
		-- Shared
		66, -- Invisibility
		-- Arcane
		12042, -- Arcane Power
		12051, -- Evocation
		110959, -- Greater Invisibility
		114923, -- Nether Tempest
		153626, -- Arcane Orb
		157980, -- Supernova
		195676, -- Displacement
		205022, -- Arcane Familiar
		205025, -- Presence of Mind
		205032, -- Charged Up
		-- Fire
		31661, -- Dragon's Breath
		44457, -- Living Bomb
		108853, -- Inferno Blast
		153561, -- Meteor
		157981, -- Blast Wave
		190319, -- Combustion
		205029, -- Flame On
		-- Frost
		120, -- Cone of Cold
		12472, -- Icy Veins
		31687, -- Summon Water Elemental
		84714, -- Frozen Orb
		112948, -- Frost Bomb
		153595, -- Comet Storm
		157997, -- Ice Nova
		205021, -- Ray of Frost
		205030, -- Frozen Touch
		-- PvP
		30449, -- Spellsteal
		198111, -- Temporal Shield
		198144, -- Ice Form
		198158, -- Mass Invisibility
		208683, -- Gladiators Medallion
	},
	["MONK"] = {
		-- Global
		101643, -- Transcendence
		109132, -- Roll
		115078, -- Paralysis
		116841, -- Tiger's Lust
		116844, -- Ring of Peace
		119381, -- Leg Sweep
		119996, -- Transcendence: Transfer
		122278, -- Dampen Harm
		122281, -- Healing Elixir
		122783, -- Diffuse Magic
		123986, -- Chi Burst
		-- Shared
		115098, -- Chi Wave
		116705, -- Spear Hand Strike
		-- Brewmaster
		115176, -- Zen Meditation
		115181, -- Breath of Fire
		115203, -- Fortifying Brew
		115308, -- Ironskin Brew
		115315, -- Summon Black Ox Statue
		115399, -- Black Ox Brew
		119582, -- Purifying Brew
		132758, -- Niuzao
		-- Mistweaver
		115310, -- Revival
		115313, -- Summon Jade Serpent Statue
		116680, -- Thunder Focus Tea
		116849, -- Life Cocoon
		124081, -- Zen Pulse
		197908, -- Mana Tea
		197945, -- Zen Walk
		198664, -- Chi-ji
		198898, -- Song of Chi-ji
		-- Windwalker
		101545, -- Flying Serpent Kick
		113656, -- Fists of Fury
		115080, -- Touch of Death
		115288, -- Energizing Elixir
		122470, -- Touch of Karma
		123904, -- Xuen
		137639, -- Storm, Earth and Fire
		152173, -- Serenity
		152175, -- Whirling Dragon Punch
		-- PvP
		201318, -- Fortifying Elixir
		201325, -- Zen Meditation
		202162, -- Guard
		202272, -- Incendiary Brew
		202335, -- Double Barrel
		202370, -- Mighty Ox Kick
		208683, -- Gladiators Medallion
		213658, -- Craft: Nimble Brew
		216113, -- Way of the Crane
	},
	["PALADIN"] = {
		-- Global
		498, -- Devine Protection
		633, -- Lay on Hands
		642, -- Divine Shield
		853, -- Hammer of Justice
		1022, -- Blessing of Protection
		1044, -- Blessing of Freedom
		6940, -- Blessing of Scrifice
		20066, -- Repentance
		20271, -- Judgement
		31821, -- Aura Mastery
		115750, -- Blinding Light
		-- Shared
		31884, -- Avenging Wrath
		96231, -- Rebuke
		190784, -- Devine Steed
		-- Holy
		31842, -- Avenging Wrath (Holy)
		105809, -- Holy Avenger
		114158, -- Light's Hammer
		114165, -- Holy Prism
		183415, -- Aura of Mercy
		197446, -- Beacon of Lightbringer
		214202, -- Rule of Law
		223306, -- Bestow Faith
		-- Protection
		31850, -- Ardent Defender
		31935, -- Avenger's Shield
		53600, -- Shield of Righteous
		86659, -- Guardian of Acient Kings
		184092, -- Light of the Protector
		204013, -- Blessing of Salvation
		204018, -- Blessing of Spellwarding
		204035, -- Bastion of Light
		204150, -- Aegis of Light
		213652, -- Hand of Protector
		-- Retribution
		183218, -- Hand of Hindrance
		184575, -- Blade of Justice
		184662, -- Shield of Vengeance
		205191, -- Eye for an Eye
		205656, -- Devine Steed (Retribution)
		210191, -- Word of Glory
		213757, -- Execution Sentence
		215647, -- Holy Wrath
		210220, -- Equality
		-- PvP
		204939, -- Hammer of Reckoning
		208683, -- Gladiators Medallion
		210256, -- Blessing of Sanctuary
		215652, -- Shield of Virtue
		216331, -- Avenging Crusader
	},
	["PRIEST"] = {
		-- Global
		-- Shared
		-- Discipline
		-- Holy
		-- Shadow
	},
	["ROGUE"] = {
		-- Global
		-- Shared
		-- Assassination
		-- Combat
		-- Subtlety
	},
	["SHAMAN"] = {
		-- Global
		-- Shared
		-- Elemental
		-- Enhancement
		-- Restoration
	},
	["WARLOCK"] = {
		-- Global
		-- Shared
		-- Affliction
		-- Demonology
		-- Destruction
	},
	["WARRIOR"] = {
		-- Global
		1719, -- Battle Cry
		6552, -- Pummel
		6544, -- Heroic Leap
		18499, -- Berserker Rage
		46968, -- Shockwave
		107570, -- Storm Bolt
		107574, -- Avatar
		-- Shared
		5246, -- Intimidating Shout
		46924, -- Bladestorm
		97462, -- Commanding Shout
		152277, -- Ravager
		-- Arms
		118038, -- Die by the Sword
		167105, -- Colossus Smash
		-- Fury
		100, -- Charge
		118000, -- Dragon Roar
		184364, -- Frenzied Regeneration
		-- Protection
		871, -- Shield Wall
		1160, -- Demoralizing Shout
		2565, -- Shield Block
		13975, -- Last Stand
		23920, -- Spell Reflection
		198304, -- Intercept
		202168, -- Impending Victory
		-- PvP
		198758, -- Intercept
		198817, -- Sharpen Blade
		198912, -- Shield Bash
		206572, -- Dragon Charge
		208683, -- Gladiators Medallion
		213871, -- Bodyguard
		213915, -- Mass Spell Reflection
		216890, -- Spell Reflection
	},
	["RACE"] = {
		["Orc"] = {
			33697, -- Orc Blood Fury Shaman
			33702, -- Orc Blood Fury Warlock
			20572, -- Orc Blood Fury AP
		},
		["BloodElf"] = {
			25046, -- Blood Elf Arcane Torrent Rogue
		},
		["Scourge"] = {		
			20577, -- Cannibalize
			7744,   -- Will of the Forsaken
		},
		["Tauren"] = {
			20549, -- War Stomp
		},
		["Troll"] = {
			26297, -- Berserking
		},
		["Goblin"] = {
			69070, -- Rocket Jump and Rocket Barrage
		},
		["Draenei"] = {
			59545, -- Gift of the Naaru DK
			59543, -- GotN Hunter
			59548, -- GotN Mage
			59542, -- GotN Paladin
			59544, -- GotN Priest
			59547, -- GotN Shaman
			28880, -- GotN Warrior
			121093, -- GotN Monk
		},
		["Dwarf"] = {
			20594, -- Stoneform
		},
		["Gnome"] = {
			20589, -- Escape Artist
		},
		["Human"] = {
			59752, -- Every Man for Himself
		},
		["NightElf"] = {
			58984, -- Shadowmeld
		},		
		["Worgen"] = {
			68992, -- Darkflight
			68996, -- Two Forms
		},
		["Pandaren"] = {
			107079, -- Quaking Palm
		}
	},
	["PET"] = {
		-- Warlock
		6360, -- Succubus Whiplash
		7812, -- Voidwalker Sacrifice
		19647, -- Felhunter Spell Lock
		89766, -- Felguard Axe Toss
		89751, -- Felguard Felstorm
		30151, -- Felguard Pursuit
		115770, -- Shivarra Teufelspeitsche
		115781, -- Beobachter Augenstrahl
		-- Hunter
	},
}

-- Timer update throttle (in seconds). The lower, the more precise. Set it to a really low value and don't blame me for low fps
local throttle = 0.3
local spells = {}
local frames = {}

local GetTime = GetTime
local pairs = pairs
local xSpacing, ySpacing = spacing, 0
local width, height = size, size
local anchorPoint = "TOPRIGHT"
local onUpdate
local move = D["move"]

local scfa = CreateFrame("Frame", "SpellCooldownsMover", UIParent)
scfa:Size(120, 17)
scfa:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 335)
move:RegisterFrame(scfa)

local SpellCooldownFrame = CreateFrame("Frame", "DuffedUISpellCooldowns", UIParent)
SpellCooldownFrame:SetFrameStrata("BACKGROUND")
SpellCooldownFrame:SetHeight(height)
SpellCooldownFrame:SetWidth(width)
SpellCooldownFrame:SetPoint("CENTER", scfa, 0, 0)

local function enableCooldown(self)
	self.enabled = true
	if self.StatusBar then
		self.StatusBar:Show()
		self.DurationText:Show()
	end
	if self.Cooldown then self.Cooldown:Show() end
	self:SetScript("OnUpdate", onUpdate)
	onUpdate(self, 1)
	if mode == "HIDE" then
		self:Show()
	else
		self.Icon:SetVertexColor(1, 1, 1, 1)
		self:SetAlpha(1)
	end
end

local function disableCooldown(self)
	self.enabled = false
	if mode == "HIDE" then
		self:Hide()
	else
		self.Icon:SetVertexColor(1, 1, 1, .15)
		self:SetAlpha(.2)
	end
	if self.StatusBar then
		self.StatusBar:Hide()
		self.DurationText:SetText("")
	end
	if self.Cooldown then self.Cooldown:Hide() end
	self:SetScript("OnUpdate", nil)
end

local function positionHide()
	local lastFrame = SpellCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if GetSpellTexture(GetSpellInfo(frame.spell)) or D["Class"] == "PRIEST"then
			local start, duration = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then
				if D["Class"] == "PRIEST" and frame.spell == 88682 or frame.spell == 88684 or frame.spell == 88685 then 
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				frame:ClearAllPoints()
				if index == 0 then frame:SetPoint("TOPLEFT", lastFrame, "TOPLEFT", xSpacing, ySpacing) else frame:SetPoint("TOPLEFT", lastFrame, anchorPoint, xSpacing, ySpacing) end
				if not frame.disabled then enableCooldown(frame) end
				lastFrame = frame
				index = index + 1
			else
				if frame.enabled then disableCooldown(frame) end
			end
		end
	end
	SpellCooldownFrame:SetWidth(width * index + (index + 1) * xSpacing)
end

local function positionDim()
	local lastFrame = SpellCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if GetSpellTexture(GetSpellInfo(frame.spell)) or D["Class"] == "PRIEST" then
			local start, duration, enable = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then
				if D["Class"] == "PRIEST" and frame.spell == 88682 or frame.spell == 88684 or frame.spell == 88685 then
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				if not frame.enabled then enableCooldown(frame) end
			else
				if frame.enabled then disableCooldown(frame) end
			end
		end
		if (index == 0) then frame:SetPoint("TOPLEFT", lastFrame, "TOPLEFT", xSpacing, ySpacing) else frame:SetPoint("TOPLEFT", lastFrame, anchorPoint, xSpacing, ySpacing) end
		lastFrame = frame
		index = index + 1
	end
	SpellCooldownFrame:SetWidth(width * index + (index + 1) * xSpacing)
end


local function position()
	if mode == "HIDE" then positionHide() else positionDim() end
end

--[[Frames]]--
local function createCooldownFrame(spell)
	local frame = CreateFrame("Frame", nil, UIParent)
	frame:CreateBackdrop("Transparent")
	frame:SetHeight(width)
	frame:SetWidth(width)
	frame:SetFrameStrata("MEDIUM")

	local icon = frame:CreateTexture()
	local spellInfo = GetSpellInfo(spell)
	if not spellInfo then return nil end
	local texture = GetSpellTexture(spellInfo)
	icon:SetAllPoints(frame)
	if D["Class"] == "PRIEST" and spell == 88682 or spell == 88684 or spell == 88685 then texture = GetSpellTexture(GetSpellInfo(88625)) end
	if not texture then return nil end
	icon:SetTexture(texture)
	icon:SetTexCoord(.08, .92, .08, .92)
	frame.Icon = icon

	local durationText = frame:CreateFontString(nil, "OVERLAY")
	durationText:SetFont(f, fs, ff)
	durationText:SetTextColor(unpack(color))
	durationText:SetText("")
	durationText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 2, 2)
	frame.DurationText = durationText

	local statusBar = CreateFrame("StatusBar", nil, frame, "TextStatusBar")
	statusBar:Size(width, 4)
	statusBar:SetStatusBarTexture(texture)
	statusBar:SetStatusBarColor(.77, .12, .23)
	statusBar:SetPoint("TOP", frame,"TOP", 0, 0)
	statusBar:SetMinMaxValues(0, 1)
	statusBar:SetFrameLevel(frame:GetFrameLevel() + 3)
	frame.StatusBar = statusBar

	frame.lastupdate = 0
	frame.spell = spell
	frame.start = GetTime()
	frame.duration = 0

	disableCooldown(frame)
	return frame
end

local function OnEvent(self, event, arg1)
	if event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_TALENT_UPDATE" then	
		for k, v in pairs(spells) do
			if GetSpellInfo(v) then frames[v] = frames[v] or createCooldownFrame(spells[k]) else frames[v] = createCooldownFrame(spells[k]) end
		end
		position()
	end

	if event == "SPELL_UPDATE_COOLDOWN" then position() end
end

spells = spellCooldowns[select(2, UnitClass("player"))]

local race = spellCooldowns["RACE"]
for i = 1, table.getn(race[select(2, UnitRace("player"))]) do table.insert(spells, race[select(2, UnitRace("player"))][i]) end

local _, pra = UnitRace("player")
if D["Class"] == "WARLOCK" or D["Class"] == "HUNTER" then
	for i = 1, table.getn(spellCooldowns["PET"]) do table.insert(spells, spellCooldowns["PET"][i]) end
end

onUpdate = function (self, elapsed)
	self.lastupdate = self.lastupdate + elapsed
	if self.lastupdate > throttle then
		local start, duration = GetSpellCooldown(self.spell)
		if duration and duration > 1.5 then
			local currentDuration = (start + duration - GetTime())
			local normalized = currentDuration/self.duration
			if self.StatusBar then
				self.StatusBar:SetValue(normalized)
				self.DurationText:SetText(math.floor(currentDuration))
				if fade == 1 then 
					self.StatusBar:GetStatusBarTexture():SetVertexColor(1 - normalized, normalized, 0 / 255)
				elseif fade == 2 then
					self.StatusBar:GetStatusBarTexture():SetVertexColor(normalized, 1 - normalized, 0 / 255)
				end
			end
			if (self.Cooldown) then self.Cooldown:SetCooldown(start, duration) end
		else
			if self.enabled then disableCooldown(self) end
			position()
		end
		self.lastupdate = 0
	end
end

SpellCooldownFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
SpellCooldownFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
SpellCooldownFrame:RegisterEvent("PLAYER_TALENT_UPDATE")
SpellCooldownFrame:SetScript("OnEvent", OnEvent)
