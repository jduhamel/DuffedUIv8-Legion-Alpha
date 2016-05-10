--[[NEEDS ATTENTION]]--
local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	PVPUIFrame:StripTextures()
	PVPUIFrame:SetTemplate("Transparent")

	for i = 1, 4 do
		local button = _G["PVPQueueFrameCategoryButton" .. i]
		button:SetTemplate()
		button.Background:Kill()
		button.Ring:Kill()
		button.Icon:Size(45)
		button.Icon:SetTexCoord(.15, .85, .15, .85)
		button:CreateBackdrop()
		button.backdrop:SetOutside(button.Icon)
		button.backdrop:SetFrameLevel(button:GetFrameLevel())
		button.Icon:SetParent(button.backdrop)
		button:StyleButton()
	end

	-- HONOR FRAME
	HonorFrameTypeDropDown:SkinDropDownBox()
	HonorFrame.Inset:StripTextures()
	HonorFrameSpecificFrameScrollBar:SkinScrollBar()
	HonorFrameQueueButton:SkinButton(true)
	HonorFrame.BonusFrame:StripTextures()
	HonorFrame.BonusFrame:SetFrameLevel(5)
	HonorFrame.BonusFrame:SetFrameStrata("HIGH")
	HonorFrame.BonusFrame.ShadowOverlay:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:StripTextures()
	HonorFrame.BonusFrame.RandomBGButton:SkinButton()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.RandomBGButton.SelectedTexture:SetTexture(0, 1, 0, .1)
	HonorFrame.BonusFrame.Arena1Button:StripTextures()
	HonorFrame.BonusFrame.Arena1Button:SkinButton()
	HonorFrame.BonusFrame.Arena1Button.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.Arena1Button.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.Arena1Button.SelectedTexture:SetTexture(0, 1, 0, .1)
	HonorFrame.BonusFrame.AshranButton:StripTextures()
	HonorFrame.BonusFrame.AshranButton:SkinButton()
	HonorFrame.BonusFrame.AshranButton.SelectedTexture:ClearAllPoints()
	HonorFrame.BonusFrame.AshranButton.SelectedTexture:SetAllPoints()
	HonorFrame.BonusFrame.AshranButton.SelectedTexture:SetTexture(0, 1, 0, .1)
	HonorFrame.BonusFrame.DiceButton:SkinButton()

	HonorFrame.RoleInset:StripTextures()
	HonorFrame.RoleInset.DPSIcon.checkButton:SkinCheckBox()
	HonorFrame.RoleInset.DPSIcon.checkButton:SetFrameLevel(HonorFrame.RoleInset.DPSIcon:GetFrameLevel() + 2)
	HonorFrame.RoleInset.TankIcon.checkButton:SkinCheckBox()
	HonorFrame.RoleInset.TankIcon.checkButton:SetFrameLevel(HonorFrame.RoleInset.TankIcon:GetFrameLevel() + 2)
	HonorFrame.RoleInset.HealerIcon.checkButton:SkinCheckBox()
	HonorFrame.RoleInset.HealerIcon.checkButton:SetFrameLevel(HonorFrame.RoleInset.HealerIcon:GetFrameLevel() + 2)

	-- CONQUEST FRAME
	ConquestFrame.Inset:StripTextures()
	ConquestFrame:StripTextures()
	ConquestFrame:SetFrameLevel(5)
	ConquestFrame:SetFrameStrata("HIGH")
	ConquestFrame.ShadowOverlay:StripTextures()

	local function SkinRated(button)
		button:StripTextures()
		button:SkinButton()
		button.SelectedTexture:ClearAllPoints()
		button.SelectedTexture:SetAllPoints()
		button.SelectedTexture:SetTexture(0, 1, 0, .1)
	end
	SkinRated(ConquestFrame.RatedBG)
	SkinRated(ConquestFrame.Arena2v2)
	SkinRated(ConquestFrame.Arena3v3)
	ConquestJoinButton:SkinButton(true)

	-- PvP Ready Dialog
	PVPReadyDialog:StripTextures()
	PVPReadyDialog:SetTemplate("Transparent")
	PVPReadyDialog.SetBackdrop = D.Dummy
	PVPReadyDialog.filigree:SetAlpha(0)
	PVPReadyDialog.bottomArt:SetAlpha(0)
	PVPReadyDialogEnterBattleButton:SkinButton()
	PVPReadyDialogLeaveQueueButton:SkinButton()
	PVPReadyDialogCloseButton:SkinCloseButton()
	PVPReadyDialogCloseButton.t:SetText("_")

	-- WARGRAMES FRAME
	WarGamesFrame:StripTextures()
	WarGamesFrame.RightInset:StripTextures()
	WarGameStartButton:SkinButton(true)
	WarGamesFrameScrollFrameScrollBar:SkinScrollBar()
	WarGamesFrame.HorizontalBar:StripTextures()
	WarGameStartButton:StripTextures()
	WarGameStartButton:SkinButton()
	WarGameTournamentModeCheckButton:SkinCheckBox()
end

D.SkinFuncs["Blizzard_PVPUI"] = LoadSkin