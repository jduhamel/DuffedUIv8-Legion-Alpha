local function LoadOrderHallSkin()
	--[[OrderHall CommandBar]]--
	OrderHallCommandBar:StripTextures()
	OrderHallCommandBar:SetTemplate("Transparent")
	OrderHallCommandBar:ClearAllPoints()
	OrderHallCommandBar:SetPoint("TOP", UIParent, 0, 0)
	OrderHallCommandBar:SetWidth(480)
	OrderHallCommandBar.ClassIcon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
	OrderHallCommandBar.ClassIcon:SetSize(46, 20)
	OrderHallCommandBar.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)
	OrderHallCommandBar.AreaName:ClearAllPoints()
	OrderHallCommandBar.AreaName:SetPoint("LEFT", OrderHallCommandBar.CurrencyIcon, "RIGHT", 10, 0)
	OrderHallCommandBar.WorldMapButton:ClearAllPoints()
	OrderHallCommandBar.WorldMapButton:SetPoint("RIGHT", OrderHallCommandBar, -5, -2)
	OrderHallCommandBar.WorldMapButton:SetSize(23, 22)
	
	--[[MissionFrame]]--
	OrderHallMissionFrame:StripTextures()
	OrderHallMissionFrame:SetTemplate("Transparent")
	OrderHallMissionFrame.CloseButton:SkinCloseButton()
	for i = 1, 3 do _G["OrderHallMissionFrameTab" .. i]:SkinTab() end
	OrderHallMissionFrame.GarrCorners:StripTextures()
	OrderHallMissionFrameMissions:StripTextures()
	OrderHallMissionFrameMissionsListScrollFrame:StripTextures()
	OrderHallMissionFrameMissionsListScrollFrameScrollBar:SkinScrollBar()
	OrderHallMissionFrameMissions.CombatAllyUI:StripTextures()
	OrderHallMissionFrameMissions.MaterialFrame:StripTextures()

	for i = 1, 2 do
		_G["OrderHallMissionFrameMissionsTab" .. i]:StripTextures()
		_G["OrderHallMissionFrameMissionsTab" .. i]:SkinButton()
		_G["OrderHallMissionFrameMissionsTab" .. i]:Height(_G["GarrisonMissionFrameMissionsTab" .. i]:GetHeight() - 10)
	end

	for i, v in ipairs(OrderHallMissionFrame.MissionTab.MissionList.listScroll.buttons) do
		local Button = _G["OrderHallMissionFrameMissionsListScrollFrameButton" .. i]
		if Button and not Button.skinned then
			Button:StripTextures()
			Button:SetTemplate()
			Button:SkinButton()
			Button:SetBackdropBorderColor(0, 0, 0, 0)
			Button:HideInsets()
			Button.LocBG:Hide()
			for i = 1, #Button.Rewards do
				local Texture = Button.Rewards[i].Icon:GetTexture()

				Button.Rewards[i]:StripTextures()
				Button.Rewards[i]:StyleButton()
				Button.Rewards[i]:CreateBackdrop()
				Button.Rewards[i].Icon:SetTexture(Texture)
				Button.Rewards[i].backdrop:ClearAllPoints()
				Button.Rewards[i].backdrop:SetOutside(Button.Rewards[i].Icon)
				Button.Rewards[i].Icon:SetTexCoord(unpack(D.IconCoord))
			end
			Button.isSkinned = true
		end
	end
	
	--[[MissionTab]]--
	
	
	--[[MissionStage]]--
	local Mission = OrderHallMissionFrameMissions
	Mission.CompleteDialog:StripTextures()
	Mission.CompleteDialog:SetTemplate("Transparent")
	Mission.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	OrderHallMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	--[[TalentFrame]]--
	OrderHallTalentFrame:StripTextures()
	OrderHallTalentFrame:SetTemplate("Transparent")
	OrderHallTalentFrameCloseButton:SkinCloseButton()
	ClassHallTalentInset:StripTextures()
	OrderHallTalentFrame.Currency:SetFont(C["media"].font, 16)
	OrderHallTalentFrame.CurrencyIcon:SetAtlas("legionmission-icon-currency", false)
end

D.SkinFuncs["Blizzard_OrderHallUI"] = LoadOrderHallSkin