local D, C, L = unpack(select(2, ...))

--[[Variables]]--
local nameplates = CreateFrame("Frame", nil, WorldFrame)
local _G = _G
local unpack = unpack
local select = select
local colors = D["UnitColor"]

--[[Functions]]--
function nameplates:customSize() C_NamePlate.SetNamePlateOtherSize(C["nameplate"].platewidth, C["nameplate"].plateheight) end

function nameplates:colorHealth()
    if (self:GetName() and string.find(self:GetName(), "NamePlate")) then
        local r, g, b = self.healthBar:GetStatusBarColor()

        for class, color in pairs(RAID_CLASS_COLORS) do
			local r, g, b = floor(r * 100 + .5) / 100, floor(g * 100 + .5) / 100, floor(b * 100 + .5) / 100
			if RAID_CLASS_COLORS[class].r == r and RAID_CLASS_COLORS[class].g == g and RAID_CLASS_COLORS[class].b == b then
				self.hasClass = true
				self.isFriendly = false
				self.healthBar:SetStatusBarColor(unpack(oUFDuffedUI.colors.class[class]))
				return
			end
		end

		if g + b == 0 then
			r, g, b = .87, .37, .37
			self.isFriendly = false
		elseif r + b == 0 then
			r, g, b = .31, .45, .63
			self.isFriendly = true
		elseif r + g > 1.95 then
			r, g, b = .86, .77, .36
			self.isFriendly = false
		elseif r + g == 0 then
			r, g, b = .29,  .69, .3
			self.isFriendly = true
		else
			self.isFriendly = false
		end

		if UnitIsPlayer(self.unit) then
			local Class = select(2, UnitClass(self.unit))
			r, g, b = unpack(colors.class[Class])
		end
        self.healthBar:SetStatusBarColor(r, g, b)
    end
end

function nameplates:SetName()
    local text = self:GetText()

    if text then
        local class = select(2, UnitClass(self:GetParent().unit))
		if self.unit == "target" then
			self:SetText("|cffffff00".. text .."|r")
		else
			self:SetText("|cffffffff".. text .."|r")
		end
    end
end

function nameplates:visualStyle(setupOptions, frameOptions)
	local highlight = self.selectionHighlight
	local health = self.healthBar
	local aggro = self.aggroHighlight
	local name = self.name
	local castbar = self.castBar
	local cicon = self.castBar.Icon
	local buffframe = self.BuffFrame

	health:SetHeight(C["nameplate"].plateheight)
	health:SetStatusBarTexture(C["media"].normTex)

	ClassNameplateManaBarFrame:SetStatusBarTexture(C["media"].normTex)

	castbar:SetSize(C["nameplate"].platewidth, 5)
	castbar:SetStatusBarTexture(C["media"].normTex)
	castbar:GetStatusBarTexture():SetHorizTile(true)
	castbar.background:ClearAllPoints()
	castbar.background:SetOutside()
	castbar.Text:SetFont(C["media"].font, 9, "THINOUTLINE")

	cicon:SetTexCoord(unpack(D["IconCoord"]))
	cicon:Size(health:GetHeight() + castbar:GetHeight() + 3)
	cicon:ClearAllPoints()
	cicon:SetPoint("TOPRIGHT", health, "TOPLEFT", -3, 0)

	buffframe:ClearAllPoints()
	buffframe:SetPoint("TOPLEFT", health, "TOPLEFT", 0, 30)

	name:SetFont(C["media"].font, 9, "THINOUTLINE")
	hooksecurefunc(name, "Show", nameplates.SetName)
	if self.unit == "target" then name:SetTextColor(1, 1, 0) else name:SetTextColor(1, 1, 1) end
	highlight:Kill()
	aggro:Kill()
end

--[[Enable & Running]]--
function nameplates:enable()
	if C["nameplate"]["active"] ~= true then return end
	
    self:customSize()
    self:SetScript("OnEvent", self.onEvent)
	
	hooksecurefunc("DefaultCompactNamePlateFrameSetup", self.visualStyle)
	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.colorHealth)
end

nameplates:RegisterEvent("ADDON_LOADED")
nameplates:RegisterEvent("PLAYER_ENTERING_WORLD")
nameplates:SetScript("OnEvent", function(self, event, ...)
	nameplates:enable()
end)