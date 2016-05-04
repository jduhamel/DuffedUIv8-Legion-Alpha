local D, C, L = unpack(select(2, ...))
if not C["misc"].artifact then return end

local barHeight, barWidth = 5, C["misc"].artifactwidth
local barTex, flatTex = C["media"].normTex
local color = RAID_CLASS_COLORS[D.Class]
local move = D["move"]
local hAE = HasArtifactEquipped()

if not hAE then return end

local backdrop = CreateFrame("Frame", "Artifact_Backdrop", UIParent)
backdrop:SetSize(barWidth, barHeight)
backdrop:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -7, 178)
backdrop:SetBackdropColor(C["general"].backdropcolor)
backdrop:SetBackdropBorderColor(C["general"].backdropcolor)
backdrop:CreateBackdrop("Transparent")
move:RegisterFrame(backdrop)

local artifactBar = CreateFrame("StatusBar",  "Experience_artifactBar", backdrop, "TextStatusBar")
artifactBar:SetWidth(barWidth)
artifactBar:SetHeight(barHeight)
artifactBar:SetPoint("TOP", backdrop,"TOP", 0, 0)
artifactBar:SetStatusBarTexture(barTex)
artifactBar:SetStatusBarColor(157/255, 138/255, 108/255)

local ArtifactmouseFrame = CreateFrame("Frame", "Artifact_mouseFrame", backdrop)
ArtifactmouseFrame:SetAllPoints(backdrop)
ArtifactmouseFrame:EnableMouse(true)

backdrop:SetFrameLevel(0)
backdrop:SetFrameStrata("LOW")
artifactBar:SetFrameLevel(2)
ArtifactmouseFrame:SetFrameLevel(3)

local function updateStatus()
	local _, _, _, _, xp, pointsSpent, _, _, _, _, _, _ = C_ArtifactUI.GetEquippedArtifactInfo()
	local aPT = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(pointsSpent, xp)

	if (not hAE) then artifactBar:Hide() else artifactBar:SetValue(xp) end

	ArtifactmouseFrame:SetScript("OnEnter", function()
		GameTooltip:SetOwner(ArtifactmouseFrame, "ANCHOR_TOPRIGHT", 2, 5)
		GameTooltip:ClearLines()
		if hAE then
			GameTooltip:AddLine(L["artifactBar"]["xptitle"])
			GameTooltip:AddLine(string.format(L["artifactBar"]["xp"], xp))
			GameTooltip:AddLine(string.format(L["artifactBar"]["traits"], aPT))
		end
		GameTooltip:Show()
	end)
	ArtifactmouseFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

local frame = CreateFrame("Frame",nil,UIParent)
frame:RegisterEvent("ARTIFACT_XP_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", updateStatus)
