local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

D["ConstructUFBoss"] = function(self)
	--[[Initial Elements]]--
	self.colors = D.UnitColor

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self.menu = D.SpawnMenu
	self:SetAttribute("type2", "togglemenu")

	--[[Health]]--
	local health = CreateFrame("StatusBar", nil, self)
	health:Height(22)
	health:SetPoint("TOPLEFT")
	health:SetPoint("TOPRIGHT")
	health:SetStatusBarTexture(texture)

	local HealthBorder = CreateFrame("Frame", nil, health)
	HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:SetFrameLevel(2)

	local healthBG = health:CreateTexture(nil, "BORDER")
	healthBG:SetAllPoints()
	healthBG:SetTexture(0, 0, 0)

	health.value = health:CreateFontString(nil, "OVERLAY")
	health.value:SetFontObject(font)
	health.value:Point("LEFT", 2, .5)
	health.PostUpdate = D.PostUpdateHealth

	health.frequentUpdates = true
	if C["unitframes"]["showsmooth"] then health.Smooth = true end
	if C["unitframes"]["unicolor"] then
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(unpack(C["unitframes"]["healthbarcolor"]))
		healthBG:SetVertexColor(unpack(C["unitframes"]["deficitcolor"]))
		healthBG:SetTexture(.6, .6, .6)
		if C["unitframes"]["ColorGradient"] then
			health.colorSmooth = true
			healthBG:SetTexture(0, 0, 0)
		end
	else
		health.colorDisconnected = true
		health.colorClass = true
		health.colorReaction = true	
	end

	self.Health = health
	self.HealthBorder = HealthBorder
	self.Health.bg = healthBG

	--[[Power]]--
	local power = CreateFrame("StatusBar", nil, self)
	power:Height(3)
	power:Point("TOPLEFT", health, "BOTTOMLEFT", 85, 0)
	power:Point("TOPRIGHT", health, "BOTTOMRIGHT", -9, -3)
	power:SetStatusBarTexture(texture)
	power:SetFrameLevel(self.Health:GetFrameLevel() + 2)

	local PowerBorder = CreateFrame("Frame", nil, power)
	PowerBorder:SetPoint("TOPLEFT", power, "TOPLEFT", D.Scale(-2), D.Scale(2))
	PowerBorder:SetPoint("BOTTOMRIGHT", power, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	PowerBorder:SetTemplate("Default")
	PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
	self.PowerBorder = PowerBorder

	local powerBG = power:CreateTexture(nil, "BORDER")
	powerBG:SetAllPoints(power)
	powerBG:SetTexture(texture)
	powerBG.multiplier = .3

	power.value = power:CreateFontString(nil, "OVERLAY")
	power.value:SetFontObject(font)
	power.value:Point("RIGHT", health, -2, .5)
	power.PostUpdate = D.PostUpdatePower

	power.frequentUpdates = true
	power.colorPower = true
	if C["unitframes"]["showsmooth"] then power.Smooth = true end

	self.Power = power
	self.Power.bg = powerBG

	--[[Elements]]--
	local Name = health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", health, "CENTER", 0, 1)
	Name:SetJustifyH("CENTER")
	Name:SetFontObject(font)
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)
	Name.frequentUpdates = .2
	self:Tag(Name, "[DuffedUI:getnamecolor][DuffedUI:nameshort]")
	self.Name = Name

	local AltPowerBar = CreateFrame("StatusBar", nil, self.Health)
	AltPowerBar:SetFrameLevel(self.Health:GetFrameLevel() + 1)
	AltPowerBar:Height(4)
	AltPowerBar:SetStatusBarTexture(texture)
	AltPowerBar:GetStatusBarTexture():SetHorizTile(false)
	AltPowerBar:SetStatusBarColor(1, 0, 0)

	AltPowerBar:SetPoint("LEFT")
	AltPowerBar:SetPoint("RIGHT")
	AltPowerBar:SetPoint("TOP", self.Health, "TOP")
	AltPowerBar:SetBackdrop(backdrop)
	AltPowerBar:SetBackdropColor(0, 0, 0)
	self.AltPowerBar = AltPowerBar

	--[[Buffs & Debuffs]]--
	local buffs = CreateFrame("Frame", nil, self)
	buffs:SetHeight(26)
	buffs:SetWidth(252)
	buffs:Point("TOPRIGHT", self, "TOPLEFT", -5, 2)
	buffs.size = 26
	buffs.num = 3
	buffs.spacing = 3
	buffs.initialAnchor = "RIGHT"
	buffs["growth-x"] = "LEFT"
	buffs.PostCreateIcon = D.PostCreateAura
	buffs.PostUpdateIcon = D.PostUpdateAura
	self.Buffs = buffs
	self:HookScript("OnShow", D.updateAllElements)

	local debuffs = CreateFrame("Frame", nil, self)
	debuffs:SetHeight(26)
	debuffs:SetWidth(200)
	debuffs:SetPoint("TOPLEFT", self, "TOPRIGHT", D.Scale(5), 2)
	debuffs.size = 26
	debuffs.num = 4
	debuffs.spacing = 3
	debuffs.initialAnchor = "LEFT"
	debuffs["growth-x"] = "RIGHT"
	debuffs.PostCreateIcon = D.PostCreateAura
	debuffs.PostUpdateIcon = D.PostUpdateAura
	debuffs.onlyShowPlayer = true
	self.Debuffs = debuffs

	--[[Castbar]]--
	local castbar = CreateFrame("StatusBar", self:GetName().."CastBar", self)
	castbar:SetHeight(12)
	castbar:SetStatusBarTexture(texture)
	castbar:SetFrameLevel(10)
	castbar:SetPoint("LEFT", 23, -1)
	castbar:SetPoint("RIGHT", 0, -1)
	castbar:SetPoint("BOTTOM", 0, -21)
	castbar:CreateBackdrop()

	castbar.Text = castbar:CreateFontString(nil, "OVERLAY")
	castbar.Text:SetFontObject(font)
	castbar.Text:Point("LEFT", castbar, "LEFT", 4, 0)
	castbar.Text:SetTextColor(.84, .75, .65)

	castbar.time = castbar:CreateFontString(nil, "OVERLAY")
	castbar.time:SetFontObject(font)
	castbar.time:Point("RIGHT", castbar, "RIGHT", -4, 0)
	castbar.time:SetTextColor(.84, .75, .65)
	castbar.time:SetJustifyH("RIGHT")
	castbar.CustomTimeText = D.CustomTimeText

	castbar.CustomDelayText = D.CustomDelayText
	castbar.PostCastStart = D.CastBar
	castbar.PostChannelStart = D.CastBar

	castbar.button = CreateFrame("Frame", nil, castbar)
	castbar.button:SetTemplate("Default")
	castbar.button:Size(16, 16)
	castbar.button:Point("BOTTOMRIGHT", castbar, "BOTTOMLEFT",-5,-2)

	castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
	castbar.icon:Point("TOPLEFT", castbar.button, 2, -2)
	castbar.icon:Point("BOTTOMRIGHT", castbar.button, -2, 2)
	castbar.icon:SetTexCoord(.08, .92, .08, .92)

	self.Castbar = castbar
	self.Castbar.Icon = castbar.icon
	self.Castbar.Time = castbar.time
end