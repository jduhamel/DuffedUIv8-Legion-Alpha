local D, C, L = unpack(select(2, ...))

local function LoadSkin()
	TalkingHeadFrame:StripTextures()
	TalkingHeadFrame:SetTemplate("Transparent")
	TalkingHeadFrame:ClearAllPoints()
	TalkingHeadFrame:SetPoint("BOTTOM", UIParent, 0, 450)
	TalkingHeadFrame:SetSize(550, 150)
	TalkingHeadFrame.MainFrame.CloseButton:SkinCloseButton()

	TalkingHeadFrame.MainFrame:StripTextures()

	TalkingHeadFrame.PortraitFrame:StripTextures()
end

D.SkinFuncs["Blizzard_TalkingHeadUI"] = LoadSkin