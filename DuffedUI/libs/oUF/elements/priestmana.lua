--[[ Element: Druid Mana Bar
 Handles updating and visibility of a status bar displaying the druid's mana
 while outside of caster form.

 Widget

 PriestMana - A StatusBar to represent current caster mana.

 Sub-Widgets

 .bg - A Texture which functions as a background. It will inherit the color of
       the main StatusBar.

 Notes

 The default StatusBar texture will be applied if the UI widget doesn't have a
 status bar texture or color defined.

 Options

 .colorClass  - Use `self.colors.class[class]` to color the bar. This will
                always use DRUID as class.
 .colorSmooth - Use `self.colors.smooth` to color the bar with a smooth
                gradient based on the players current mana percentage.
 .colorPower  - Use `self.colors.power[token]` to color the bar. This will
                always use MANA as token.

 Sub-Widget Options

 .multiplier - Defines a multiplier, which is used to tint the background based
               on the main widgets R, G and B values. Defaults to 1 if not
               present.

 Examples

   -- Position and size
   local PriestMana = CreateFrame("StatusBar", nil, self)
   PriestMana:SetSize(20, 20)
   PriestMana:SetPoint('TOP')
   PriestMana:SetPoint('LEFT')
   PriestMana:SetPoint('RIGHT')
   
   -- Add a background
   local Background = PriestMana:CreateTexture(nil, 'BACKGROUND')
   Background:SetAllPoints(PriestMana)
   Background:SetColorTexture(1, 1, 1, .5)
   
   -- Register it with oUF
   self.PriestMana = PriestMana
   self.PriestMana.bg = Background

 Hooks

 Override(self) - Used to completely override the internal update function.
                  Removing the table key entry will make the element fall-back
                  to its internal function again.

]]

if(select(2, UnitClass('player')) ~= 'DRUID') then return end

local _, ns = ...
local oUF = ns.oUF

local function Update(self, event, unit, powertype)
	if(unit ~= 'player' or (powertype and powertype ~= 'MANA')) then return end

	local priestmana = self.PriestMana
	if(priestmana.PreUpdate) then priestmana:PreUpdate(unit) end

	-- Hide the bar if the active power type is mana.
	if(UnitPowerType('player') == SPELL_POWER_MANA) then
		return priestmana:Hide()
	else
		priestmana:Show()
	end

	local min, max = UnitPower('player', SPELL_POWER_MANA), UnitPowerMax('player', SPELL_POWER_MANA)
	priestmana:SetMinMaxValues(0, max)
	priestmana:SetValue(min)

	local r, g, b, t
	if(priestmana.colorClass) then
		t = self.colors.class['DRUID']
	elseif(priestmana.colorSmooth) then
		r, g, b = self.ColorGradient(min, max, unpack(priestmana.smoothGradient or self.colors.smooth))
	elseif(priestmana.colorPower) then
		t = self.colors.power['MANA']
	end

	if(t) then
		r, g, b = t[1], t[2], t[3]
	end

	if(b) then
		priestmana:SetStatusBarColor(r, g, b)

		local bg = priestmana.bg
		if(bg) then
			local mu = bg.multiplier or 1
			bg:SetVertexColor(r * mu, g * mu, b * mu)
		end
	end

	if(priestmana.PostUpdate) then
		return priestmana:PostUpdate(unit, min, max)
	end
end

local function Path(self, ...)
	return (self.PriestMana.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local OnPriestManaUpdate
do
	local UnitPower = UnitPower
	OnPriestManaUpdate = function(self)
		local unit = self.__owner.unit
		local mana = UnitPower(unit, SPELL_POWER_MANA)

		if(mana ~= self.min) then
			self.min = mana
			return Path(self.__owner, 'OnPriestManaUpdate', unit)
		end
	end
end

local Enable = function(self, unit)
	local priestmana = self.PriestMana
	if(priestmana and unit == 'player') then
		priestmana.__owner = self
		priestmana.ForceUpdate = ForceUpdate

		if(priestmana.frequentUpdates) then
			priestmana:SetScript('OnUpdate', OnPriestManaUpdate)
		else
			self:RegisterEvent('UNIT_POWER', Path)
		end

		self:RegisterEvent('UNIT_DISPLAYPOWER', Path)
		self:RegisterEvent('UNIT_MAXPOWER', Path)

		if(priestmana:IsObjectType'StatusBar' and not priestmana:GetStatusBarTexture()) then
			priestmana:SetStatusBarTexture[[Interface\TargetingFrame\UI-StatusBar]]
		end

		return true
	end
end

local Disable = function(self)
	local priestmana = self.PriestMana
	if(priestmana) then
		if(priestmana:GetScript'OnUpdate') then
			priestmana:SetScript("OnUpdate", nil)
		else
			self:UnregisterEvent('UNIT_POWER', Path)
		end

		self:UnregisterEvent('UNIT_DISPLAYPOWER', Path)
		self:UnregisterEvent('UNIT_MAXPOWER', Path)
	end
end

oUF:AddElement('PriestMana', Path, Enable, Disable)
