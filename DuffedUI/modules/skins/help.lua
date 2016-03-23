local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	local frames = {
		"HelpFrameLeftInset",
		"HelpFrameMainInset",
		"HelpFrameKnowledgebase",
		"HelpFrameHeader",
		"HelpFrameKnowledgebaseErrorFrame",
	}

	local buttons = {
		"HelpFrameAccountSecurityOpenTicket",
		"HelpFrameOpenTicketHelpOpenTicket",
		"HelpFrameKnowledgebaseSearchButton",
		"HelpFrameKnowledgebaseNavBarHomeButton",
		"HelpFrameCharacterStuckStuck",
		"GMChatOpenLog",
		"HelpFrameTicketSubmit",
		"HelpFrameTicketCancel",
	}

	-- skin main frames
	for i = 1, #frames do
		_G[frames[i]]:StripTextures(true)
		_G[frames[i]]:CreateBackdrop("Default")
	end

	HelpFrameHeader:SetFrameLevel(HelpFrameHeader:GetFrameLevel() + 2)
	HelpFrameKnowledgebaseErrorFrame:SetFrameLevel(HelpFrameKnowledgebaseErrorFrame:GetFrameLevel() + 2)
	HelpFrameKnowledgebaseScrollFrame2ScrollBar:SkinScrollBar()

	-- skin main buttons
	for i = 1, 6 do
		local b = _G["HelpFrameButton"..i]
		b:SkinButton(true)
		b.text:ClearAllPoints()
		b.text:SetPoint("CENTER")
		b.text:SetJustifyH("CENTER")
	end
	
	local b = _G["HelpFrameButton16"]
	b:StripTextures(true)
	b:SkinButton(true)
	b.text:ClearAllPoints()
	b.text:SetPoint("CENTER")
	b.text:SetJustifyH("CENTER")

	local b2 = _G["HelpFrameSubmitSuggestionSubmit"]
	b2:StripTextures(true)
	b2:SkinButton(true)
	
	local b3 = _G["HelpFrameButton6"]
	b3:ClearAllPoints()
	b3:Point("TOP", b, "BOTTOM", 0, -4)

	-- skin table options
	for i = 1, HelpFrameKnowledgebaseScrollFrameScrollChild:GetNumChildren() do
		local b = _G["HelpFrameKnowledgebaseScrollFrameButton"..i]
		b:StripTextures(true)
		b:SkinButton(true)
	end

	-- skin misc items
	HelpFrameKnowledgebaseSearchBox:ClearAllPoints()
	HelpFrameKnowledgebaseSearchBox:Point("TOPLEFT", HelpFrameMainInset, "TOPLEFT", 13, -10)
	HelpFrameKnowledgebaseNavBarOverlay:Kill()

	HelpFrameKnowledgebaseNavBar:StripTextures()

	HelpFrame:StripTextures(true)
	HelpFrame:CreateBackdrop("Transparent")
	HelpFrameKnowledgebaseSearchBox:SkinEditBox()
	HelpFrameKnowledgebaseScrollFrameScrollBar:SkinScrollBar()
	HelpFrameCloseButton:SkinCloseButton(HelpFrame.backdrop)	
	HelpFrameKnowledgebaseErrorFrameCloseButton:SkinCloseButton(HelpFrameKnowledgebaseErrorFrame.backdrop)

	-- Help Browser
	HelpBrowserNavHome:SkinButton()
	HelpBrowserNavBack:SkinNextPrevButton()
	HelpBrowserNavForward:SkinNextPrevButton()
	HelpBrowserNavReload:SkinButton()
	HelpBrowserNavStop:SkinButton()
	HelpBrowserBrowserSettings:SkinButton()
	BrowserSettingsTooltip:StripTextures()
	BrowserSettingsTooltip:SetTemplate()
	BrowserSettingsTooltip.CookiesButton:StripTextures()
	BrowserSettingsTooltip.CookiesButton:SkinButton()
	BrowserSettingsTooltip.CacheButton:StripTextures()
	BrowserSettingsTooltip.CacheButton:SkinButton()

	--Hearth Stone Button
	HelpFrameCharacterStuckHearthstone:StyleButton()
	HelpFrameCharacterStuckHearthstone:SetTemplate("Default", true)
	HelpFrameCharacterStuckHearthstone.IconTexture:ClearAllPoints()
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("TOPLEFT", 2, -2)
	HelpFrameCharacterStuckHearthstone.IconTexture:Point("BOTTOMRIGHT", -2, 2)
	HelpFrameCharacterStuckHearthstone.IconTexture:SetTexCoord(.08, .92, .08, .92)

	HelpFrameGM_ResponseScrollFrame2ScrollBar:SkinScrollBar()
	HelpFrameGM_ResponseScrollFrame1ScrollBar:SkinScrollBar()
	HelpFrameGM_ResponseNeedMoreHelp:SkinButton()
	HelpFrameGM_ResponseCancel:SkinButton()
	for i=1, HelpFrameGM_Response:GetNumChildren() do
		local child = select(i, HelpFrameGM_Response:GetChildren())
		if child and child:GetObjectType() == "Frame" and not child:GetName() then
			child:SetTemplate("Default")
		end
	end
	
	for i=1, HelpFrameReportBug:GetNumChildren() do
		local child = select(i, HelpFrameReportBug:GetChildren())
		if child and not child:GetName() then
			child:StripTextures()
			child:SetTemplate()
		end
	end
	
	for i=1, HelpFrameSubmitSuggestion:GetNumChildren() do
		local child = select(i, HelpFrameSubmitSuggestion:GetChildren())
		if child and not child:GetName() then
			child:StripTextures()
			child:SetTemplate()
		end
	end
	
	HelpFrameReportBugSubmit:SkinButton()
	HelpFrameSubmitSuggestionScrollFrameScrollBar:SkinScrollBar()
	HelpFrameReportBugScrollFrameScrollBar:SkinScrollBar()
	HelpFrameGM_ResponseScrollFrame1ScrollBar:SkinScrollBar()
	HelpFrameGM_ResponseScrollFrame2ScrollBar:SkinScrollBar()
end

tinsert(D.SkinFuncs["DuffedUI"], LoadSkin)