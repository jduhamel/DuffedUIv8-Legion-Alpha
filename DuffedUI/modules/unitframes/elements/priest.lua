local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "PRIEST" then return end

D["ClassRessource"]["PRIEST"] = function(self)
	local PMB = CreateFrame("StatusBar", "PriestManaBar", self.Health)
	PMB:Size(216, 5)
	if layout == 1 then
		PMB:Point("TOP", self.Power, "BOTTOM", 0, -10)
	elseif layout == 2 then
		PMB:Point("BOTTOM", self.Health, "TOP", 0, -5)
		PMB:SetFrameLevel(self.Health:GetFrameLevel() + 2)
	elseif layout == 3 then
		PMB:Point("CENTER", self.panel, "CENTER", 0, -3)
	elseif layout == 4 then
		PMB:Point("TOP", self.Health, "BOTTOM", 0, -10)
	end
	PMB:SetStatusBarTexture(texture)
	PMB:SetStatusBarColor(.30, .52, .90)
	PMB:SetFrameLevel(self.Health:GetFrameLevel() + 3)
	PMB:CreateBackdrop()

	PMB:SetBackdrop(backdrop)
	PMB:SetBackdropColor(0, 0, 0)
	PMB:SetBackdropBorderColor(0, 0, 0)

	PMB.bg = PMB:CreateTexture(nil, "BORDER")
	PMB.bg:SetAllPoints(PMB)
	PMB.bg:SetTexture(.30, .52, .90, .2)

	self.PriestMana = PMB
	self.PriestMana.bg = PMB.bg
end