local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "PALADIN" then return end

D["ClassRessource"]["PALADIN"] = function(self)
	local HolyPower = CreateFrame("Frame", "HolyPowerBar", UIParent)
	HolyPower:Size(216, 5)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			HolyPower:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			HolyPower:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			HolyPower:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			HolyPower:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		HolyPower:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Mana", 216, 5)
	end
	HolyPower:SetBackdrop(backdrop)
	HolyPower:SetBackdropColor(0, 0, 0)
	HolyPower:SetBackdropBorderColor(0, 0, 0, 0)

	for i = 1, 5 do
		HolyPower[i]=CreateFrame("StatusBar", "HolyPowerBar" .. i, HolyPower)
		HolyPower[i]:Height(5)
		HolyPower[i]:SetStatusBarTexture(texture)
		HolyPower[i]:GetStatusBarTexture():SetHorizTile(false)
		HolyPower[i]:SetStatusBarColor(228/255, 225/255, 16/255)
		HolyPower[i].bg = HolyPower[i]:CreateTexture(nil, "BORDER")
		HolyPower[i].bg:SetTexture(228/255, 225/255, 16/255)
		if i == 1 then
			HolyPower[i]:Width((216 / 5) - 3)
			HolyPower[i]:SetPoint("LEFT", HolyPower)
			HolyPower[i].bg:SetAllPoints(HolyPower[i])
		else
			HolyPower[i]:Width(216 / 5)
			HolyPower[i]:Point("LEFT", HolyPower[i - 1], "RIGHT", 1, 0)
			HolyPower[i].bg:SetAllPoints(HolyPower[i])
		end
		HolyPower[i].bg:SetTexture(texture)
		HolyPower[i].bg:SetAlpha(.15)
	end
	HolyPower:CreateBackdrop()
	self.HolyPower = HolyPower

	if C["unitframes"]["oocHide"] then D["oocHide"](HolyPower) end
end