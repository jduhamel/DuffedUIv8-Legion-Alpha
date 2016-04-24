--[[local D, C, L = unpack(select(2, ...))
if not C["misc"].artifact then return end

local barHeight, barWidth = 5, C["misc"].artifactwidth
local barTex, flatTex = C["media"].normTex
local color = RAID_CLASS_COLORS[D.Class]
local move = D["move"]

artifactMover = CreateFrame("Frame", "artifactBarMover", UIParent)
artifactMover:SetSize(barWidth, barHeight)
artifactMover:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 7, 188)
artifactMover:SetFrameLevel(6)
move:RegisterFrame(artifactMover)

local backdrop = CreateFrame("Frame", "Artifact_Backdrop", UIParent)
backdrop:SetAllPoints(artifactMover)
backdrop:SetBackdropColor(C["general"].backdropcolor)
backdrop:SetBackdropBorderColor(C["general"].backdropcolor)
backdrop:CreateBackdrop("Transparent")

local artifactBar = CreateFrame("StatusBar",  "Experience_artifactBar", backdrop, "TextStatusBar")
artifactBar:SetWidth(barWidth)
artifactBar:SetHeight(GetWatchedFactionInfo() and (barHeight) or barHeight)
artifactBar:SetPoint("TOP", backdrop,"TOP", 0, 0)
artifactBar:SetStatusBarTexture(barTex)
if C["general"].classcolor then artifactBar:SetStatusBarColor(color.r, color.g, color.b) else artifactBar:SetStatusBarColor(31/255, 41/255, 130/255) end

local mouseFrame = CreateFrame("Frame", "Experience_mouseFrame", backdrop)
mouseFrame:SetAllPoints(backdrop)
mouseFrame:EnableMouse(true)

backdrop:SetFrameLevel(0)
artifactBar:SetFrameLevel(2)
mouseFrame:SetFrameLevel(3)

local function updateStatus()
	local XP, maxXP, restXP = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion()
	if not maxXP or maxXP == 0 then return end
	local percXP = math.floor((XP / maxXP) * 100)

	if IsMaxLevel() then
		artifactBar:Hide()
	else
		artifactBar:SetMinMaxValues(min(0, XP), maxXP)
		artifactBar:SetValue(XP)
	end

	mouseFrame:SetScript("OnEnter", function()
		GameTooltip:SetOwner(mouseFrame, "ANCHOR_TOPLEFT", -2, 5)
		GameTooltip:ClearLines()
		if not IsMaxLevel() then
			GameTooltip:AddLine(L["artifactBar"]["xptitle"])
			GameTooltip:AddLine(string.format(L["artifactBar"]["xp"], D.CommaValue(XP), D.CommaValue(maxXP), (XP / maxXP) * 100))
			GameTooltip:AddLine(string.format(L["artifactBar"]["xpremaining"], D.CommaValue(maxXP - XP)))
			if restXP then GameTooltip:AddLine(string.format(L["artifactBar"]["xprested"], D.CommaValue(restXP), restXP / maxXP * 100)) end
		end
		GameTooltip:Show()
	end)
	mouseFrame:SetScript("OnLeave", function() GameTooltip:Hide() end)
end

local frame = CreateFrame("Frame",nil,UIParent)
frame:RegisterEvent("ARTIFACT_XP_UPDATE")
--frame:RegisterEvent("PLAYER_LEVEL_UP")
--frame:RegisterEvent("PLAYER_XP_UPDATE")
--frame:RegisterEvent("UPDATE_EXHAUSTION")
--frame:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE")
--frame:RegisterEvent("UPDATE_FACTION")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", updateStatus)]]--
