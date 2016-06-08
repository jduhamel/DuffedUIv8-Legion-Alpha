local D, C, L = unpack(select(2, ...))

local texture = C["media"].normTex
local font, fontsize, fontflag = C["media"].font, 11, "THINOUTLINE"
local Color = RAID_CLASS_COLORS[D.Class]
local move = D["move"]
D["ClassRessource"] = {}

--[[Mover for ressources]]--
if not C["unitframes"]["attached"] then
	local cba = CreateFrame("Frame", "RessourceMover", UIParent)
	cba:Size(250, 15)
	cba:Point("BOTTOM", UIParent, "BOTTOM", 0, 325)
	move:RegisterFrame(cba)
end