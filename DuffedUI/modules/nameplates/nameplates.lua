local D, C, L = unpack(select(2, ...))

--[[Variables]]--
local nameplates = CreateFrame("Frame", nil, WorldFrame)
local _G = _G
local unpack = unpack
local select = select
local colors = D["UnitColor"]

--[[Functions]]--
function nameplates:customSize()
	C_NamePlate.SetNamePlateOtherSize(C["nameplate"].platewidth, C["nameplate"].plateheight)
end

--[[function nameplates:colorHealth()
    if (self:GetName() and string.find(self:GetName(), "NamePlate")) then
        local r, g, b

        if not UnitIsConnected(self.unit) then
            r, g, b = unpack(colors.disconnected)
        else
            if UnitIsPlayer(self.unit) then
                local Class = select(2, UnitClass(self.unit))
                r, g, b = unpack(colors.class[Class])
            else
                if (UnitIsFriend("player", self.unit)) then r, g, b = unpack(colors.reaction[5]) else r, g, b = unpack(colors.reaction[1]) end
            end
        end
        self.healthBar:SetStatusBarColor(r, g, b)
    end
end]]--

--[[function nameplates:visualStyle(setupOptions, frameOptions)
	local highlight = self.selectionHighlight
	local health = self.healthBar
	local name = self.name
	
	health:SetHeight(C["nameplate"].plateheight)
	health:SetTexture(C["media"].normTex)
	--health:SetTemplate()

	name:SetFont(C["media"].font, 9, "THINOUTLINE")
	highlight:Kill()
end]]--

--[[Events]]--
function nameplates:registerEvents()
	--self:RegisterEvent("NAME_PLATE_CREATED")
    --self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    --self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
    --self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("DISPLAY_SIZE_CHANGED")
    --self:RegisterEvent("UNIT_AURA")
    --self:RegisterEvent("VARIABLES_LOADED")
    --self:RegisterEvent("CVAR_UPDATE") 
end

function nameplates:onEvent(event, ...)
    if event == "DISPLAY_SIZE_CHANGED" then
        self:customSize()
    end
end

--[[Enable & Running]]--
function nameplates:enable()
	if C["nameplate"]["active"] ~= true then return end
	
	self:registerEvents()
    self:customSize()
    self:SetScript("OnEvent", self.onEvent)
	
	--hooksecurefunc("DefaultCompactNamePlateFrameSetup", self.visualStyle)
	--hooksecurefunc("CompactUnitFrame_UpdateHealthColor", self.colorHealth)
end

nameplates:RegisterEvent("ADDON_LOADED")
nameplates:RegisterEvent("PLAYER_ENTERING_WORLD")
nameplates:SetScript("OnEvent", function(self, event, ...)
	nameplates:enable()
end)