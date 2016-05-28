local D, C, L = unpack(select(2, ...))
if C["general"].blizzardreskin ~= true then return end
--[[
	Taken from DejaStats, adjusted for DuffedUI
	Credits for the mainparts of the script goes to Dejablue!
]]--

CharacterStatsPane.ItemLevelCategory:Hide()
CharacterStatsPane.ItemLevelCategory.Title:Hide()
CharacterStatsPane.ItemLevelCategory.Background:Hide()

CharacterStatsPane.ItemLevelFrame:ClearAllPoints()
CharacterStatsPane.ItemLevelFrame:SetWidth(186)
CharacterStatsPane.ItemLevelFrame:SetHeight(28)
CharacterStatsPane.ItemLevelFrame:SetPoint("TOP", CharacterStatsPane, "TOP", 0, -8)

CharacterStatsPane.ItemLevelFrame.Background:ClearAllPoints()
CharacterStatsPane.ItemLevelFrame.Background:SetWidth(186)
CharacterStatsPane.ItemLevelFrame.Background:SetHeight(28)
CharacterStatsPane.ItemLevelFrame.Background:SetPoint("CENTER", CharacterStatsPane.ItemLevelFrame, "CENTER", 0, 0)

CharacterStatsPane.ItemLevelFrame.Value:SetFont(C["media"].font, 16, "THINOUTLINE")

hooksecurefunc(CharacterStatsPane.AttributesCategory, "SetPoint", function(self,_,_,_,_,_,flag)
	if flag ~= "CharacterStatsPane" then
		self:ClearAllPoints()
		--self:SetWidth(186)
		--self:SetHeight(28)
		self:SetPoint("TOP", CharacterStatsPane.ItemLevelFrame, "BOTTOM", 0, -10, "CharacterStatsPane")
	end
end)

hooksecurefunc(CharacterStatsPane.AttributesCategory.Background, "SetPoint", function(self,_,_,_,_,_,flag)
	if flag ~= "CharacterStatsPane" then
		self:ClearAllPoints()
		self:SetPoint("CENTER", CharacterStatsPane.AttributesCategory, "CENTER", 0, 2, "CharacterStatsPane")
	end
end)
	
-- primary: only show the 1 for the player's current spec
-- roles: only show if the player's current spec is one of the roles
-- hideAt: only show if it's not this value

PAPERDOLL_STATCATEGORIES= {
	[1] = {
		categoryFrame = "AttributesCategory",
		stats = {
			[1] = { stat = "ARMOR" },
			[2] = { stat = "STRENGTH", primary = LE_UNIT_STAT_STRENGTH },
			[3] = { stat = "AGILITY", primary = LE_UNIT_STAT_AGILITY },
			[4] = { stat = "INTELLECT", primary = LE_UNIT_STAT_INTELLECT },
			[5] = { stat = "STAMINA" },
			[6] = { stat = "ATTACK_DAMAGE", primary = LE_UNIT_STAT_STRENGTH, roles =  { "TANK", "DAMAGER" } },
			[7] = { stat = "ATTACK_AP", hideAt = 0, primary = LE_UNIT_STAT_STRENGTH, roles =  { "TANK", "DAMAGER" } },
			[8] = { stat = "ATTACK_ATTACKSPEED", primary = LE_UNIT_STAT_STRENGTH, roles =  { "TANK", "DAMAGER" } },
			[9] = { stat = "ATTACK_DAMAGE", primary = LE_UNIT_STAT_AGILITY, roles =  { "TANK", "DAMAGER" } },
			[10] = { stat = "ATTACK_AP", hideAt = 0, primary = LE_UNIT_STAT_AGILITY, roles =  { "TANK", "DAMAGER" } },
			[11] = { stat = "ATTACK_ATTACKSPEED", primary = LE_UNIT_STAT_AGILITY, roles =  { "TANK", "DAMAGER" } },
			[12] = { stat = "SPELLPOWER", hideAt = 0, primary = LE_UNIT_STAT_INTELLECT },
			[13] = { stat = "MANAREGEN", hideAt = 0, primary = LE_UNIT_STAT_INTELLECT },
			[14] = { stat = "ENERGY_REGEN", hideAt = 0, primary = LE_UNIT_STAT_AGILITY },
			[15] = { stat = "RUNE_REGEN", hideAt = 0 },
			[16] = { stat = "FOCUS_REGEN", hideAt = 0 },
			[17] = { stat = "MOVESPEED" },
		},
	},
	[2] = {
		categoryFrame = "EnhancementsCategory",
		stats = {
			[1] = { stat = "CRITCHANCE", hideAt = 0 },
			[2] = { stat = "HASTE", hideAt = 0 },
			[3] = { stat = "VERSATILITY", hideAt = 0 },
			[4] = { stat = "MASTERY", hideAt = 0 },
			[5] = { stat = "LIFESTEAL", hideAt = 0 },
			[6] = { stat = "AVOIDANCE", hideAt = 0 },
			[7] = { stat = "DODGE", hideAt = 0, roles =  { "TANK" } },
			[8] = { stat = "PARRY", hideAt = 0, roles =  { "TANK" } },
			[9] = { stat = "BLOCK", hideAt = 0, roles =  { "TANK" } },
--			[10] = { stat = "HEALTH", },
--			[11] = { stat = "POWER", },
		},
	},
};

function PaperDollFrame_SetItemLevel(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end

	local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel();
	avgItemLevel = floor(avgItemLevel);
	avgItemLevelEquipped = floor(avgItemLevelEquipped);
	PaperDollFrame_SetLabelAndText(statFrame, STAT_AVERAGE_ITEM_LEVEL, ((avgItemLevelEquipped).."/"..avgItemLevel), false, avgItemLevelEquipped);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_AVERAGE_ITEM_LEVEL).." "..avgItemLevel;
	if ( avgItemLevelEquipped ~= avgItemLevel ) then
		statFrame.tooltip = statFrame.tooltip .. "  " .. format(STAT_AVERAGE_ITEM_LEVEL_EQUIPPED, avgItemLevelEquipped);
	end
	statFrame.tooltip = statFrame.tooltip .. FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_AVERAGE_ITEM_LEVEL_TOOLTIP;
end

function PaperDollFrame_SetAttackSpeed(statFrame, unit)
	local meleeHaste = GetMeleeHaste();
	local speed, offhandSpeed = UnitAttackSpeed(unit);

	local displaySpeed = format("%.2f", speed);
	if ( offhandSpeed ) then
		offhandSpeed = format("%.2f", offhandSpeed);
	end
	if ( offhandSpeed ) then
		displaySpeedxt =  displaySpeed .." / ".. offhandSpeed;
	else
		displaySpeedxt =  displaySpeed;
	end
	PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, displaySpeed, false, speed);

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..displaySpeed..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = format(STAT_ATTACK_SPEED_BASE_TOOLTIP, BreakUpLargeNumbers(meleeHaste));
	
	statFrame:Show();
end

function PaperDollFrame_SetMovementSpeed(statFrame, unit)
	statFrame.wasSwimming = nil;
	statFrame.unit = unit;
	MovementSpeed_OnUpdate(statFrame);
	
	statFrame.onEnterFunc = MovementSpeed_OnEnter;
	-- TODO: Fix if we decide to show movement speed
	-- statFrame:SetScript("OnUpdate", MovementSpeed_OnUpdate);

	statFrame:Show();
end

function PaperDollFrame_SetEnergyRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken ~= "ENERGY") then
		PaperDollFrame_SetLabelAndText(statFrame, STAT_ENERGY_REGEN, NOT_APPLICABLE, false, 0);
		statFrame.tooltip = nil;
		statFrame:Hide();
		return;
	end
	
	local regenRate = GetPowerRegen();
	local regenRateText = BreakUpLargeNumbers(regenRate);
	PaperDollFrame_SetLabelAndText(statFrame, STAT_ENERGY_REGEN, regenRateText, false, regenRate);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_ENERGY_REGEN).." "..regenRateText..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_ENERGY_REGEN_TOOLTIP;
	statFrame:Show();
end

function PaperDollFrame_SetFocusRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local powerType, powerToken = UnitPowerType(unit);
	if (powerToken ~= "FOCUS") then
		PaperDollFrame_SetLabelAndText(statFrame, STAT_FOCUS_REGEN, NOT_APPLICABLE, false, 0);
		statFrame.tooltip = nil;
		statFrame:Hide();
		return;
	end
	
	local regenRate = GetPowerRegen();
	local regenRateText = BreakUpLargeNumbers(regenRate);
	PaperDollFrame_SetLabelAndText(statFrame, STAT_FOCUS_REGEN, regenRateText, false, regenRate);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_FOCUS_REGEN).." "..regenRateText..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_FOCUS_REGEN_TOOLTIP;
	statFrame:Show();
end

function PaperDollFrame_SetRuneRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide();
		return;
	end
	
	local _, class = UnitClass(unit);
	if (class ~= "DEATHKNIGHT") then
		PaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, NOT_APPLICABLE, false, 0);
		statFrame.tooltip = nil;
		statFrame:Hide();
		return;
	end
	
	local _, regenRate = GetRuneCooldown(1); -- Assuming they are all the same for now
	local regenRateText = (format(STAT_RUNE_REGEN_FORMAT, regenRate));
	PaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, regenRateText, false, regenRate);
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RUNE_REGEN).." "..regenRateText..FONT_COLOR_CODE_CLOSE;
	statFrame.tooltip2 = STAT_RUNE_REGEN_TOOLTIP;
	statFrame:Show();
end
--[[CharacterStatsPane.ItemLevelCategory:Kill() -- removed the header
-- moving the value and hide the background
CharacterStatsPane.ItemLevelFrame.Value:ClearAllPoints()
CharacterStatsPane.ItemLevelFrame.Value:SetPoint("RIGHT",  PaperDollSidebarTab1, "LEFT", -15, -3)
CharacterStatsPane.ItemLevelFrame.Value:SetFont(C["media"].font, 16)
CharacterStatsPane.ItemLevelFrame.Background:Hide()

-- set the characterleveltext to center of charactermodelframe, looks a way better
CharacterLevelText:ClearAllPoints()
CharacterLevelText:SetPoint("TOP", CharacterModelFrame, 0, 30)

-- move the attributescategory 10px down, looks better in combination with the paperdollsidebartab
CharacterStatsPane.AttributesCategory:ClearAllPoints()	
CharacterStatsPane.AttributesCategory:SetPoint("TOP", CharacterStatsPane, "TOP", 0, -10)

-- primary: only show the 1 for the player's current spec
-- roles: only show if the player's current spec is one of the roles
-- hideAt: only show if it's not this value

PAPERDOLL_STATCATEGORIES= {
	[1] = {
		categoryFrame = "AttributesCategory",
		stats = {
			[1] = { stat = "HEALTH" },
			[2] = { stat = "POWER" },
			[3] = { stat = "STRENGTH", primary = LE_UNIT_STAT_STRENGTH },
			[4] = { stat = "AGILITY", primary = LE_UNIT_STAT_AGILITY },
			[5] = { stat = "INTELLECT", primary = LE_UNIT_STAT_INTELLECT },
			[6] = { stat = "STAMINA" },
			[7] = { stat = "ATTACK_DAMAGE", primary = LE_UNIT_STAT_STRENGTH, roles =  { "TANK", "DAMAGER" } },
			[8] = { stat = "ATTACK_AP", hideAt = 0, primary = LE_UNIT_STAT_STRENGTH, roles =  { "TANK", "DAMAGER" } },
			[9] = { stat = "ATTACK_ATTACKSPEED", primary = LE_UNIT_STAT_STRENGTH, roles =  { "TANK", "DAMAGER" } },
			[10] = { stat = "ATTACK_DAMAGE", primary = LE_UNIT_STAT_AGILITY, roles =  { "TANK", "DAMAGER" } },
			[11] = { stat = "ATTACK_AP", hideAt = 0, primary = LE_UNIT_STAT_AGILITY, roles =  { "TANK", "DAMAGER" } },
			[12] = { stat = "ATTACK_ATTACKSPEED", primary = LE_UNIT_STAT_AGILITY, roles =  { "TANK", "DAMAGER" } },
			[13] = { stat = "SPELLPOWER", hideAt = 0, primary = LE_UNIT_STAT_INTELLECT },
			[14] = { stat = "MANAREGEN", hideAt = 0, primary = LE_UNIT_STAT_INTELLECT },
			[15] = { stat = "ENERGY_REGEN", hideAt = 0, primary = LE_UNIT_STAT_AGILITY },
			[16] = { stat = "RUNE_REGEN", hideAt = 0 },
			[17] = { stat = "FOCUS_REGEN", hideAt = 0 },
		},
	},
	[2] = {
		categoryFrame = "EnhancementsCategory",
		stats = {
			[1] = { stat = "CRITCHANCE", hideAt = 0 },
			[2] = { stat = "HASTE", hideAt = 0 },
			[3] = { stat = "MASTERY", hideAt = 0 },
			[4] = { stat = "VERSATILITY", hideAt = 0 },
			[5] = { stat = "LIFESTEAL", hideAt = 0 },
			[6] = { stat = "AVOIDANCE", hideAt = 0 },
			[7] = { stat = "ARMOR" },
			[8] = { stat = "DODGE", hideAt = 0, roles =  { "TANK" } },
			[9] = { stat = "PARRY", hideAt = 0, roles =  { "TANK" } },
			[10] = { stat = "BLOCK", hideAt = 0, roles =  { "TANK" } },
			[11] = { stat = "MOVESPEED" },
		},
	},
}

function PaperDollFrame_SetAttackSpeed(statFrame, unit)
	local meleeHaste = GetMeleeHaste()
	local speed, offhandSpeed = UnitAttackSpeed(unit)

	local displaySpeed = format("%.2F", speed)
	if ( offhandSpeed ) then
		offhandSpeed = format("%.2F", offhandSpeed)
	end
	if ( offhandSpeed ) then
		displaySpeedxt = displaySpeed.." / ".. offhandSpeed
	else
		displaySpeedxt = displaySpeed
	end
	PaperDollFrame_SetLabelAndText(statFrame, WEAPON_SPEED, displaySpeed, false, speed)

	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, ATTACK_SPEED).." "..displaySpeed..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = format(STAT_ATTACK_SPEED_BASE_TOOLTIP, BreakUpLargeNumbers(meleeHaste))
	
	statFrame:Show()
end

function PaperDollFrame_SetMovementSpeed(statFrame, unit)
	statFrame.wasSwimming = nil
	statFrame.unit = unit
	MovementSpeed_OnUpdate(statFrame)
	
	statFrame.onEnterFunc = MovementSpeed_OnEnter
	-- TODO: Fix if we decide to show movement speed
	-- statFrame:SetScript("OnUpdate", MovementSpeed_OnUpdate)

	statFrame:Show()
end

function PaperDollFrame_SetEnergyRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide()
		return
	end
	
	local powerType, powerToken = UnitPowerType(unit)
	if (powerToken ~= "ENERGY") then
		PaperDollFrame_SetLabelAndText(statFrame, STAT_ENERGY_REGEN, NOT_APPLICABLE, false, 0)
		statFrame.tooltip = nil
		statFrame:Hide()
		return
	end
	
	local regenRate = GetPowerRegen()
	local regenRateText = BreakUpLargeNumbers(regenRate)
	PaperDollFrame_SetLabelAndText(statFrame, STAT_ENERGY_REGEN, regenRateText, false, regenRate)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_ENERGY_REGEN).." "..regenRateText..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = STAT_ENERGY_REGEN_TOOLTIP
	statFrame:Show()
end

function PaperDollFrame_SetFocusRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide()
		return
	end
	
	local powerType, powerToken = UnitPowerType(unit)
	if (powerToken ~= "FOCUS") then
		PaperDollFrame_SetLabelAndText(statFrame, STAT_FOCUS_REGEN, NOT_APPLICABLE, false, 0)
		statFrame.tooltip = nil
		statFrame:Hide()
		return
	end
	
	local regenRate = GetPowerRegen()
	local regenRateText = BreakUpLargeNumbers(regenRate)
	PaperDollFrame_SetLabelAndText(statFrame, STAT_FOCUS_REGEN, regenRateText, false, regenRate)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_FOCUS_REGEN).." "..regenRateText..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = STAT_FOCUS_REGEN_TOOLTIP
	statFrame:Show()
end

function PaperDollFrame_SetRuneRegen(statFrame, unit)
	if ( unit ~= "player" ) then
		statFrame:Hide()
		return
	end
	
	local _, class = UnitClass(unit)
	if (class ~= "DEATHKNIGHT") then
		PaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, NOT_APPLICABLE, false, 0)
		statFrame.tooltip = nil
		statFrame:Hide()
		return
	end
	
	local _, regenRate = GetRuneCooldown(1) -- Assuming they are all the same for now
	local regenRateText = (format(STAT_RUNE_REGEN_FORMAT, regenRate))
	PaperDollFrame_SetLabelAndText(statFrame, STAT_RUNE_REGEN, regenRateText, false, regenRate)
	statFrame.tooltip = HIGHLIGHT_FONT_COLOR_CODE..format(PAPERDOLLFRAME_TOOLTIP_FORMAT, STAT_RUNE_REGEN).." "..regenRateText..FONT_COLOR_CODE_CLOSE
	statFrame.tooltip2 = STAT_RUNE_REGEN_TOOLTIP
	statFrame:Show()
end]]--