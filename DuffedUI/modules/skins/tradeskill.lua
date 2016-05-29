local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	TradeSkillFrame:StripTextures(true)
	TradeSkillFrame:SetTemplate("Transparent")
	TradeSkillFrame:Height(TradeSkillFrame:GetHeight() + 12)
	TradeSkillFrameCloseButton:SkinCloseButton()

	TradeSkillFrame.RankFrame:StripTextures()
	TradeSkillFrame.RankFrame:SetStatusBarTexture(C["media"].normTex)
	TradeSkillFrame.RankFrame:CreateBackdrop()

	TradeSkillFrame.FilterButton:StripTextures()
	TradeSkillFrame.FilterButton:SkinButton()
	local function skin(self)
		self:StripTextures()
		self:SkinButton()
	end
	TradeSkillFrame.FilterButton:SetScript("OnEnter", self.skin)
	TradeSkillFrame.FilterButton:SetScript("OnLeave", self.skin)
end

D.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin