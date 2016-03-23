local D, C, L = unpack(select(2, ...)) 

local Kill = CreateFrame("Frame")
Kill:RegisterEvent("ADDON_LOADED")
Kill:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_AchievementUI" then
		if C["tooltip"].enable then hooksecurefunc("AchievementFrameCategories_DisplayButton", function(button) button.showTooltipFunc = nil end) end
	end

	if addon ~= "DuffedUI" then return end
	if C["raid"]["enable"] or C["raid"]["PartyEnable"] then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)

		CompactRaidFrameManager:SetParent(DuffedUIUIHider)
		CompactUnitFrameProfiles:UnregisterAllEvents()

		for i = 1, MAX_PARTY_MEMBERS do
			local member = "PartyMemberFrame"..i

			_G[member]:UnregisterAllEvents()
			_G[member]:SetParent(DuffedUIUIHider)
			_G[member]:Hide()
			_G[member.."HealthBar"]:UnregisterAllEvents()
			_G[member.."ManaBar"]:UnregisterAllEvents()

			local pet = member.."PetFrame"

			_G[pet]:UnregisterAllEvents()
			_G[pet]:SetParent(DuffedUIUIHider)
			_G[pet.."HealthBar"]:UnregisterAllEvents()

			HidePartyFrame()
			ShowPartyFrame = function() return end
			HidePartyFrame = function() return end
		end
	end

	StreamingIcon:Kill()
	Advanced_UseUIScale:Kill()
	Advanced_UIScaleSlider:Kill()
	PartyMemberBackground:Kill()
	TutorialFrameAlertButton:Kill()
	GuildChallengeAlertFrame:Kill()

	if C["auras"].player then
		BuffFrame:Kill()
		TemporaryEnchantFrame:Kill()
		ConsolidatedBuffs:Kill()
		InterfaceOptionsFrameCategoriesButton12:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton12:SetAlpha(0)	
	end

	SetCVar("showArenaEnemyFrames", 0)
	if C["raid"].arena then
		InterfaceOptionsFrameCategoriesButton10:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton10:SetAlpha(0) 
		InterfaceOptionsUnitFramePanelArenaEnemyFrames:Kill()
		InterfaceOptionsUnitFramePanelArenaEnemyCastBar:Kill()
		InterfaceOptionsUnitFramePanelArenaEnemyPets:Kill()
	end

	if C["chat"].enable then
		SetCVar("WholeChatWindowClickable", 0)
		InterfaceOptionsSocialPanelWholeChatWindowClickable:Kill()
	end

	if C["unitframes"].enable then
		PlayerFrame:SetParent(DuffedUIUIHider)
		InterfaceOptionsFrameCategoriesButton9:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton9:SetAlpha(0)
	end

	if C["actionbar"].enable then
		InterfaceOptionsActionBarsPanelBottomLeft:Kill()
		InterfaceOptionsActionBarsPanelBottomRight:Kill()
		InterfaceOptionsActionBarsPanelRight:Kill()
		InterfaceOptionsActionBarsPanelRightTwo:Kill()
		InterfaceOptionsActionBarsPanelAlwaysShowActionBars:Kill()
	end

	if IsAddOnLoaded("KUI Nameplates") then InterfaceOptionsNamesPanelUnitNameplatesNameplateClassColors:Kill() end

	local TaintFix = CreateFrame("Frame")
	TaintFix:SetScript("OnUpdate", function(self, elapsed)
		if LFRBrowseFrame.timeToClear then LFRBrowseFrame.timeToClear = nil end 
	end)
end)