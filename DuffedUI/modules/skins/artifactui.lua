local D, C, L = unpack(select(2, ...))

local function ArtifactSkin()
	ArtifactFrame:StripTextures()
	ArtifactFrame:SetTemplate("Transparent")
	ArtifactFrame.CloseButton:SkinCloseButton()

	for i = 1, 2 do
		_G["ArtifactFrameTab" .. i]:SkinTab()
	end
end

D.SkinFuncs["Blizzard_ArtifactUI"] = ArtifactSkin