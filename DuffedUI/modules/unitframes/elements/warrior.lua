local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass("player"))
local texture = C["media"]["normTex"]
--local font = D.Font(C["font"]["unitframes"])

if class ~= "WARRIOR" then return end

D["ClassRessource"]["WARRIOR"] = function(self)
	
end