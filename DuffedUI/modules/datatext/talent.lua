local D, C, L = unpack(select(2, ...))
--As long as blizzard doesn't go back to dual spec, this should work forever, even with new classes with no changes.
if C["datatext"].talent and C["datatext"].talent > 0 then

	local LeftClickMenu = { }
	LeftClickMenu[1] = { text = "DuffedUI Specialization Selector", isTitle = true, notCheckable = true}

	local DuffedUISpecSwap = CreateFrame("Frame", "DuffedUISpecSwap", UIParent, "UIDropDownMenuTemplate") --Setting up the menu for later for each spec regardless of class, thanks to Simca for helping out with the function.
	DuffedUISpecSwap:SetTemplate("Transparent")
	DuffedUISpecSwap:RegisterEvent("PLAYER_LOGIN")
	DuffedUISpecSwap:SetScript("OnEvent", function(...)
		local specIndex
		for specIndex = 1, GetNumSpecializations() do
			LeftClickMenu[specIndex + 1] = {
				text = tostring(select(2, GetSpecializationInfo(specIndex))),
				notCheckable = true,
				func = (function()
					local getSpec = GetSpecialization()
					if getSpec and getSpec == specIndex then
						UIErrorsFrame:AddMessage("You're already in that spec!", 1.0, 0.0, 0.0, 53, 5);
						return
					end
					SetSpecialization(specIndex)
				end)
			}
		end
	end)
	

	local Stat = CreateFrame("Frame", "DuffedUIStatTalent") --The datatext
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)
	Stat.Option = C.datatext.talent
	Stat.Color1 = D.RGBToHex(unpack(C["media"].datatextcolor1))
	Stat.Color2 = D.RGBToHex(unpack(C["media"].datatextcolor2))
 
	local f, fs, ff = C["media"]["font"], 11, "THINOUTLINE"
	local Text = Stat:CreateFontString("DuffedUIStatTalentText", "OVERLAY")
	Text:SetFont(f, fs, ff)
	D.DataTextPosition(C["datatext"].talent, Text)
 
	local function Update(self) --The pretty part of the data text, displays the name of the spec.
		if not GetSpecialization() then
			Text:SetText(L["dt"]["talent"]) 
		else
			local tree = GetSpecialization()
			local spec = select(2,GetSpecializationInfo(tree)) or ""
			Text:SetText(Stat.Color1.."S:|r "..Stat.Color2..spec.."|r")
		end
		self:SetAllPoints(Text)
	end
 
	Stat:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	Stat:RegisterEvent("CONFIRM_TALENT_WIPE")
	Stat:RegisterEvent("PLAYER_TALENT_UPDATE")
	Stat:SetScript("OnEvent", Update)
	Stat:SetScript("OnMouseDown", function(self, btn)
		if btn == "LeftButton" then 
		EasyMenu(LeftClickMenu, DuffedUISpecSwap, "cursor", 0, 0, "MENU", 2) --Dropdown/popup menu for spec selection.
		end
    end)
end