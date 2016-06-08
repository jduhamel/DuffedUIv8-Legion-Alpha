local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]
local backdrop = {
	bgFile = C["media"]["blank"],
	insets = {top = -D["mult"], left = -D["mult"], bottom = -D["mult"], right = -D["mult"]},
}

if class ~= "DRUID" then return end

D["ClassRessource"]["DRUID"] = function(self)
	--[[Druid Mana]]--
	if C["unitframes"]["DruidMana"] then
		local DruidMana = CreateFrame("StatusBar", nil, self.Health)
		DruidMana:Size(216, 3)
		if C["unitframes"]["attached"] then
			if layout == 1 then
				DruidMana:Point("TOP", self.Power, "BOTTOM", 0, -10)
			elseif layout == 2 then
				DruidMana:Point("BOTTOM", self.Health, "TOP", 0, -5)
				DruidMana:SetFrameLevel(self.Health:GetFrameLevel() + 2)
			elseif layout == 3 then
				DruidMana:Point("CENTER", self.panel, "CENTER", 0, -3)
			elseif layout == 4 then
				DruidMana:Point("TOP", self.Health, "BOTTOM", 0, -10)
			end
		else
			DruidMana:Point("TOP", RessourceMover, "BOTTOM", 0, -5)
		end
		DruidMana:SetStatusBarTexture(texture)
		DruidMana:SetStatusBarColor(.30, .52, .90)
		DruidMana:SetFrameLevel(self.Health:GetFrameLevel() + 3)
		DruidMana:CreateBackdrop()

		DruidMana:SetBackdrop(backdrop)
		DruidMana:SetBackdropColor(0, 0, 0)
		DruidMana:SetBackdropBorderColor(0, 0, 0)

		DruidMana.bg = DruidMana:CreateTexture(nil, "BORDER")
		DruidMana.bg:SetAllPoints(DruidMana)
		DruidMana.bg:SetTexture(.30, .52, .90, .2)

		self.DruidMana = DruidMana
		self.DruidMana.bg = DruidMana.bg
		--if C["unitframes"]["oocHide"] then D["oocHide"](DruidMana) end
	end
end