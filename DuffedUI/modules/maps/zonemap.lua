local D, C, L = unpack(select(2, ...)) 
if IsAddOnLoaded("Capping") then return end

local tinymap = CreateFrame("Frame", "DuffedUIZoneMap", UIParent)
tinymap:SetPoint("CENTER")
tinymap:SetSize(223, 150)
tinymap:EnableMouse(true)
tinymap:SetMovable(true)
tinymap:RegisterEvent("ADDON_LOADED")
tinymap:SetPoint("CENTER", UIParent, 0, 0)
tinymap:SetFrameLevel(7)
tinymap:Hide()

local tinymapbg = CreateFrame("Frame", nil, tinymap)
tinymapbg:SetAllPoints()
tinymapbg:SetFrameLevel(0)
tinymapbg:SetTemplate("Default")

tinymap:SetScript("OnEvent", function(self, event, addon)
	if addon ~= "Blizzard_BattlefieldMinimap" then return end

	BattlefieldMinimap:SetScript("OnShow", function(self)
		tinymap:Show()
		BattlefieldMinimapCorner:Kill()
		BattlefieldMinimapBackground:Kill()
		BattlefieldMinimapTab:Kill()
		BattlefieldMinimapTabLeft:Kill()
		BattlefieldMinimapTabMiddle:Kill()
		BattlefieldMinimapTabRight:Kill()
		self:SetParent(tinymap)
		self:SetPoint("TOPLEFT", tinymap, "TOPLEFT", 2, -2)
		self:SetFrameStrata(tinymap:GetFrameStrata())
		BattlefieldMinimapCloseButton:ClearAllPoints()
		BattlefieldMinimapCloseButton:SetPoint("TOPRIGHT", -4, 0)
		BattlefieldMinimap:SetFrameLevel(6)
		BattlefieldMinimapCloseButton:SetFrameLevel(8)
		tinymap:SetScale(1)
		tinymap:SetAlpha(1)
		BattlefieldMinimapCloseButton:SkinCloseButton()
		BattlefieldMinimap_Update()
	end)

	BattlefieldMinimap:SetScript("OnHide", function(self)
		tinymap:SetScale(0.00001)
		tinymap:SetAlpha(0)
	end)

	self:SetScript("OnMouseUp", function(self, btn)
		if btn == "LeftButton" then
			self:StopMovingOrSizing()
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end
		elseif btn == "RightButton" then
			ToggleDropDownMenu(nil, nil, BattlefieldMinimapTabDropDown, self:GetName(), 0, -4)
			if OpacityFrame:IsShown() then OpacityFrame:Hide() end
		end
	end)

	self:SetScript("OnMouseDown", function(self, btn)
		if btn == "LeftButton" then
			if BattlefieldMinimapOptions and BattlefieldMinimapOptions.locked then return else self:StartMoving() end
		end
	end)
end)