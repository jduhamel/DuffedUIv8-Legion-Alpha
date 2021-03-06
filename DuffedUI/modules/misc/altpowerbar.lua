local D, C, L = unpack(select(2, ...))
if not DuffedUIInfoLeft then return end

local PowerTextures = {
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJASPER_HORIZONTAL_FILL.BLP"] = {r = 1, g = 0.4, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\MAP_HORIZONTAL_FILL.BLP"] = {r = .97, g = .81, b = 0},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDCOBALT_HORIZONTAL_FILL.BLP"] = {r = .1, g = .4, b = .95},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDJADE_HORIZONTAL_FILL.BLP"] = {r = .13, g = .55, b = .13},
	["INTERFACE\\UNITPOWERBARALT\\STONEGUARDAMETHYST_HORIZONTAL_FILL.BLP"] = {r = .67, g = 0, b = 1},
}
local move = D["move"]

PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")

local AltPowerBar = CreateFrame("Frame", "DuffedUIAltPowerBar", DuffedUIInfoLeft)
AltPowerBar:SetPoint("BOTTOM", UIParent, "BOTTOM", -340, 238)
AltPowerBar:SetSize(232, 20)
AltPowerBar:SetTemplate("Transparent")
AltPowerBar:SetFrameStrata("MEDIUM")
AltPowerBar:SetFrameLevel(0)
AltPowerBar:EnableMouse(true)
move:RegisterFrame(AltPowerBar)

local AltPowerBarStatus = CreateFrame("StatusBar", "DuffedUIAltPowerBarStatus", AltPowerBar)
AltPowerBarStatus:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBarStatus:SetStatusBarTexture(C["media"].normTex)
AltPowerBarStatus:SetMinMaxValues(0, 100)
AltPowerBarStatus:Point("TOPLEFT", AltPowerBar, "TOPLEFT", 2, -2)
AltPowerBarStatus:Point("BOTTOMRIGHT", AltPowerBar, "BOTTOMRIGHT", -2, 2)

local AltPowerText = AltPowerBarStatus:CreateFontString("DuffedUIAltPowerBarText", "OVERLAY")
AltPowerText:SetFont(C["media"].font, 11)
AltPowerText:Point("CENTER", AltPowerBar, "CENTER", 0, 0)
AltPowerText:SetShadowColor(0, 0, 0)
AltPowerText:SetShadowOffset(1.25, -1.25)

AltPowerBar:RegisterEvent("UNIT_POWER")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_SHOW")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_HIDE")
AltPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")

local function OnEvent(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if UnitAlternatePowerInfo("player") then self:Show() else self:Hide() end
end
AltPowerBar:SetScript("OnEvent", OnEvent)

local TimeSinceLastUpdate = 1
local function OnUpdate(self, elapsed)
	if not AltPowerBar:IsShown() then return end
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	
	if (TimeSinceLastUpdate >= 1) then
		self:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
		local power = UnitPower("player", ALTERNATE_POWER_INDEX)
		local mpower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
		self:SetValue(power)
		AltPowerText:SetText(power.." / "..mpower)
		local texture, r, g, b = UnitAlternatePowerTextureInfo("player", 2, 0) -- 2 = status bar index, 0 = displayed bar
		if texture and PowerTextures[texture] then r, g, b = PowerTextures[texture].r, PowerTextures[texture].g, PowerTextures[texture].b else r, g, b = oUFDuffedUI.ColorGradient(power,mpower, 0, .8, 0, .8, .8, 0, .8, 0, 0) end
		AltPowerBarStatus:SetStatusBarColor(r, g, b)
		self.TimeSinceLastUpdate = 0
	end
end
AltPowerBarStatus:SetScript("OnUpdate", OnUpdate)