local evenmoretextplates = {}
local original_textplates = require("__textplates__.textplates")

evenmoretextplates.symbols = original_textplates.symbols
evenmoretextplates.symbol_by_char = original_textplates.symbol_by_char
evenmoretextplates.types = original_textplates.types

evenmoretextplates.new_types = {}

evenmoretextplates.new_materials = {
	["plastic"] = "plastic-bar",
	["plasticcoloured"] = "plastic-bar",
}

-- For future additions
--[[ if settings.startup["evenmoretextplates-even-more"].value then
	evenmoretextplates.new_materials["creep"] = "raw-fish"
end ]]

if settings.startup["evenmoretextplates-even-more"].value then
	evenmoretextplates.new_materials["wood"] = "wood"
end

for material, ingredient in pairs(evenmoretextplates.new_materials) do
	table.insert(evenmoretextplates.new_types, {
		size = "small",
		material = material,
		ingredient = ingredient,
		name = "textplate-small-"..material,
		symbols = evenmoretextplates.symbols
	})
	table.insert(evenmoretextplates.new_types, {
		size = "large",
		material = material,
		ingredient = ingredient,
		name = "textplate-large-"..material,
		symbols = evenmoretextplates.symbols
	})
end

return evenmoretextplates