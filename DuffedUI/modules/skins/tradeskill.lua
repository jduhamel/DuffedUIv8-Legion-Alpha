local D, C, L = unpack(select(2, ...))
if IsAddOnLoaded("AddOnSkins") then return end

local function LoadSkin()
	--[[Main]]--
	TradeSkillFrame:StripTextures(true)
	TradeSkillFrame:SetTemplate("Transparent")
	TradeSkillFrame:Height(TradeSkillFrame:GetHeight() + 12)
	TradeSkillFrameCloseButton:SkinCloseButton()
	TradeSkillFrame.RankFrame:StripTextures()
	TradeSkillFrame.RankFrame:SetStatusBarTexture(C["media"].normTex)
	TradeSkillFrame.RankFrame:CreateBackdrop()
	TradeSkillFrame.FilterButton:StripTextures()
	TradeSkillFrame.FilterButton:SkinButton()
	TradeSkillFrame.SearchBox:SkinEditBox()
	TradeSkillFrame.SearchBox:SetHeight(15)
	
	--[[Recipelist]]--
	TradeSkillFrame.RecipeList:StripTextures()
	TradeSkillFrame.RecipeInset:StripTextures()
	--TradeSkillFrame.RecipeList.scrollBar:SkinScrollBar()
	--TradeSkillFrame.RecipeList.LearnedTab:SkinTab()
	--TradeSkillFrame.RecipeList.UnlearnedTab:SkinTab()
	
	--[[Detailsframe]]--
	TradeSkillFrame.DetailsFrame:StripTextures()
	TradeSkillFrame.DetailsInset:StripTextures()
	TradeSkillFrame.DetailsFrame.Background:Hide()
	TradeSkillFrame.DetailsFrame.CreateAllButton:StripTextures()
	TradeSkillFrame.DetailsFrame.CreateAllButton:SkinButton()
	TradeSkillFrame.DetailsFrame.CreateButton:StripTextures()
	TradeSkillFrame.DetailsFrame.CreateButton:SkinButton()
	TradeSkillFrame.DetailsFrame.ExitButton:StripTextures()
	TradeSkillFrame.DetailsFrame.ExitButton:SkinButton()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:StripTextures()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox:SkinEditBox()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.DecrementButton:SkinNextPrevButton()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SkinNextPrevButton()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:ClearAllPoints()
	TradeSkillFrame.DetailsFrame.CreateMultipleInputBox.IncrementButton:SetPoint("LEFT", TradeSkillFrame.DetailsFrame.CreateMultipleInputBox, "RIGHT", 5, 0)
	--TradeSkillFrame.DetailsFrame.Contents.ResultIcon:SetTexCoord(.08, .92, .08, .92)
	--TradeSkillFrame.DetailsFrame.ScrollBar:SkinScrollBar()
end

D.SkinFuncs["Blizzard_TradeSkillUI"] = LoadSkin