local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local level = UnitLevel("player")
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "WARLOCK" then return end

D["ClassRessource"]["WARLOCK"] = function(self)
	local WarlockBar = CreateFrame("Frame", "WarlockBar", UIParent)
	WarlockBar:Size(216, 5)
	if C["unitframes"]["attached"] then
		if layout == 1 then
			WarlockBar:Point("TOP", self.Power, "BOTTOM", 0, 0)
		elseif layout == 2 then
			WarlockBar:Point("CENTER", self.panel, "CENTER", 0, 0)
		elseif layout == 3 then
			WarlockBar:Point("CENTER", self.panel, "CENTER", 0, 5)
		elseif layout == 4 then
			WarlockBar:Point("TOP", self.Health, "BOTTOM", 0, -5)
		end
	else
		WarlockBar:Point("BOTTOM", RessourceMover, "TOP", 0, -5)
		D["ConstructEnergy"]("Mana", 216, 5)
	end
	WarlockBar:CreateBackdrop()

	for i = 1, 4 do
		WarlockBar[i] = CreateFrame("StatusBar", "WarlockBar" .. i, WarlockBar)
		WarlockBar[i]:Height(5)
		WarlockBar[i]:SetStatusBarTexture(texture)
		if i == 1 then
			WarlockBar[i]:Width(54)
			WarlockBar[i]:SetPoint("LEFT", WarlockBar, "LEFT", 0, 0)
		else
			WarlockBar[i]:Width(53)
			WarlockBar[i]:SetPoint("LEFT", WarlockBar[i - 1], "RIGHT", 1, 0)
		end
		WarlockBar[i].bg = WarlockBar[i]:CreateTexture(nil, "ARTWORK")
	end
	WarlockBar:CreateBackdrop()
	self.WarlockSpecBars = WarlockBar

	if C["unitframes"]["oocHide"] then D["oocHide"](WarlockBar) end
end