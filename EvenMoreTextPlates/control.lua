local textplates = require("globals")
local new_types = {}

for material,ingredient in pairs(textplates.new_materials) do
	for size,_ in pairs(textplates.resolutions) do
		table.insert(new_types, {
			name = string.format("textplate-%s-%s", size, material),
			material = material,
			ingredient = ingredient,
			size = size,
			symbols = textplates.symbols,
		})
	end
end

remote.add_interface("EvenMoreTextPlates", {
	textplates_add_types = function() return new_types end,
	textplates_add_characters_for_symbols = function() return textplates.symbol_by_char end,
})