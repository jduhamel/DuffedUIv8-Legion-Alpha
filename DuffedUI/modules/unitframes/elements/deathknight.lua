local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
--local font = D.Font(C["font"]["unitframes"])
local layout = C["unitframes"]["layout"]

if class ~= "DEATHKNIGHT" then return end

D["ClassRessource"]["DEATHKNIGHT"] = function(self)
	
end