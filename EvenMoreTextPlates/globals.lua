local textplates = {}
local original_textplates = require("__textplates__.textplates")

textplates.symbols = original_textplates.symbols
textplates.symbol_by_char = original_textplates.symbol_by_char
textplates.types = original_textplates.types

textplates.new_types = {}

textplates.new_materials = {
	["plastic"] = "plastic-bar",
	["plasticcoloured"] = "plastic-bar",
}

-- For future additions
--[[ if settings.startup["evenmoretextplates-even-more"].value then
	textplates.new_materials["creep"] = "raw-fish"
end ]]

for material, ingredient in pairs(textplates.new_materials) do
	table.insert(textplates.new_types, {
		size = "small",
		material = material,
		ingredient = ingredient,
		name = "textplate-small-"..material,
		symbols = textplates.symbols
	})
	table.insert(textplates.new_types, {
		size = "large",
		material = material,
		ingredient = ingredient,
		name = "textplate-large-"..material,
		symbols = textplates.symbols
	})
end

return textplates