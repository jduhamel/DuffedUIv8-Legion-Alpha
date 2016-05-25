local D, C, L = unpack(select(2, ...))

--[[Variables]]--
local nameplates = CreateFrame("Frame", nil, WorldFrame)
local _G = _G
local unpack = unpack
local select = select
local colors = D["UnitColor"]

--[[Functions]]--
local function IsPlayerEffectivelyTank()
	local assignedRole = UnitGroupRolesAssigned("player")
	
	if assignedRole == "NONE" then
		local spec GetSpecialization()
		return spec and GetSpecializationRole(spec) == "TANK"
	end
	return assignedRole == "TANK"
end

function nameplates:customSize()
	C_NamePlate.SetNamePlateOtherSize(C["nameplate"].platewidth, C["nameplate"].plateheight)
end

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
			r, g, b = .78, .25, .25 -- hostile
			self.isFriendly = false
		elseif r + b == 0 then
			r, g, b = .31, .45, .63 -- player
			self.isFriendly = true
		elseif r + g > 1.95 then
			r, g, b = .86, .77, .36 -- neutral
			self.isFriendly = false
		elseif r + g == 0 then
			r, g, b = .29,  .69, .3 -- good
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

function nameplates:UpdateAggroPlates()
	local isTanking, threatStatus = UnitDetailedThreatSituation("player", self.displayedUnit)
	-- (3 = securely tanking, 2 = insecurely tanking, 1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank)
	
	if IsPlayerEffectivelyTank() then
		if not isTanking then
			nameplates:colorHealth()
		else
			if (threatStatus == 3) then
				self.healthBar.barTexture:SetVertexColor(.29,  .69, .3) -- good
			elseif (threatStatus == 2) then
				self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
			else
				self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
			end
		end
	else
		if isTanking then
			self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
			self:GetParent().playerHasAggro = true
		else
			if (threatStatus == 3) then
				self.healthBar.barTexture:SetVertexColor(.78, .25, .25) -- bad
				self:GetParent().playerHasAggro = true
			elseif (threatStatus == 2) then
				self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
				self:GetParent().playerHasAggro = true
			elseif (threatStatus == 1) then
				self.healthBar.barTexture:SetVertexColor(.86, .77, .36) -- transition
				self:GetParent().playerHasAggro = false
			elseif (threatStatus == 0) then
				self.healthBar.barTexture:SetVertexColor(.29,  .69, .3) -- good
				self:GetParent().playerHasAggro = false
			else
				nameplates:colorHealth()
			end
		end
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
	castbar.Text:SetFont(C["media"].font, 8)
	castbar.Text:SetShadowOffset(1.25, -1.25)

	cicon:SetTexCoord(unpack(D["IconCoord"]))
	cicon:Size(health:GetHeight() + castbar:GetHeight() + 3)
	cicon:ClearAllPoints()
	cicon:SetPoint("TOPRIGHT", health, "TOPLEFT", -3, 0)

	buffframe:ClearAllPoints()
	buffframe:SetPoint("TOPLEFT", health, "TOPLEFT", 0, 30)

	name:SetFont(C["media"].font, 8)
	name:SetSize(C["nameplate"]["platewidth"], C["nameplate"]["plateheight"])
	name:SetShadowOffset(1.25, -1.25)
	hooksecurefunc(name, "Show", nameplates.SetName)
	if self.unit == "target" then name:SetTextColor(1, 1, 0) else name:SetTextColor(1, 1, 1) end
	highlight:SetAlpha(0)
	--aggro:Hide()
end

--[[Enable & Running]]--
function nameplates:enable()
	if C["nameplate"]["active"] ~= true then return end
	
    self:customSize()
    self:SetScript("OnEvent", self.onEvent)
	
	hooksecurefunc("DefaultCompactNamePlateFrameSetup", self.visualStyle)
	if C["nameplate"]["ethreat"] then
		hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.UpdateAggroPlates)
	else
		hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.colorHealth)
	end
end

nameplates:RegisterEvent("ADDON_LOADED")
nameplates:RegisterEvent("PLAYER_ENTERING_WORLD")
nameplates:RegisterEvent("UNIT_TARGET")
nameplates:RegisterEvent("PLAYER_TARGET_CHANGED")
nameplates:RegisterEvent("NAME_PLATE_CREATED")
nameplates:RegisterEvent("NAME_PLATE_UNIT_ADDED")
nameplates:SetScript("OnEvent", function(self, event, ...)
	nameplates:enable()
end)