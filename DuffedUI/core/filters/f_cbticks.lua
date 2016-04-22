local D, C, L = unpack(select(2, ...))

if C["castbar"].cbticks ~= true then return end

local function SpellName(id)
	local Name = GetSpellInfo(id)
	return Name
end

D.ChannelTicks = {
	[SpellName(689)] = 6,
	[SpellName(755)] = 6,
	[SpellName(5143)] = 5,
	[SpellName(5740)] = 4,
	[SpellName(12051)] = 4,
	[SpellName(15407)] = 3,
	[SpellName(16914)] = 10,
	[SpellName(47540)] = 2,
	[SpellName(48045)] = 5,
	[SpellName(64843)] = 4,
	[SpellName(115175)] = 9,
}

D.HasteTicks = {
	[SpellName(64843)] = true,
}