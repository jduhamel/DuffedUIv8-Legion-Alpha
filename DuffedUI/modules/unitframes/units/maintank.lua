local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, "DuffedUI was unable to locate oUF install.")

ns._Objects = {}
ns._Headers = {}

local texture = C["media"]["normTex"]
local f, fs, ff = C["media"].font, 11, "THINOUTLINE"
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

D["ConstructUFMaintank"] = function(self)
	--[[Initial Elements]]--
	self.colors = D.UnitColor

	self:RegisterForClicks("AnyUp")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)
	self.menu = D.SpawnMenu

	self:SetAttribute("type2", "focus")

	--[[Health]]--
	local health = CreateFrame("StatusBar", nil, self)
	health:Height(20)
	health:SetPoint("TOPLEFT")
	health:SetPoint("TOPRIGHT")
	health:SetStatusBarTexture(texture)

	local healthBG = health:CreateTexture(nil, "BORDER")
	healthBG:SetAllPoints()
	healthBG:SetColorTexture(0, 0, 0)

	local HealthBorder = CreateFrame("Frame", nil, health)
	HealthBorder:SetPoint("TOPLEFT", health, "TOPLEFT", D.Scale(-2), D.Scale(2))
	HealthBorder:SetPoint("BOTTOMRIGHT", health, "BOTTOMRIGHT", D.Scale(2), D.Scale(-2))
	HealthBorder:SetTemplate("Default")
	HealthBorder:SetFrameLevel(2)
	self.HealthBorder = HealthBorder

	health.PostUpdate = D.PostUpdatePetColor
	health.frequentUpdates = true
	if C["unitframes"]["showsmooth"] then health.Smooth = true end
	if C["unitframes"]["unicolor"] then
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(unpack(C["unitframes"]["healthbarcolor"]))
		healthBG:SetVertexColor(unpack(C["unitframes"]["deficitcolor"]))
		healthBG:SetColorTexture(.6, .6, .6)
		if C["unitframes"]["ColorGradient"] then
			health.colorSmooth = true
			healthBG:SetColorTexture(0, 0, 0)
		end
	else
		health.colorDisconnected = true
		health.colorClass = true
		health.colorReaction = true	
	end

	self.Health = health
	self.Health.bg = healthBG

	--[[Elements]]--
	local Name = health:CreateFontString(nil, "OVERLAY")
	Name:SetPoint("CENTER", health, "CENTER", 0, 1)
	Name:SetJustifyH("CENTER")
	Name:SetFont(f, fs, ff)
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)

	self:Tag(Name, "[DuffedUI:getnamecolor][DuffedUI:nameshort]")
	self.Name = Name

	local RaidIcon = health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetTexture(C["media"]["RaidIcons"])
	RaidIcon:Size(28, 28)
	RaidIcon:Point("TOP", health, "TOP", 0, 11)
	self.RaidIcon = RaidIcon
end