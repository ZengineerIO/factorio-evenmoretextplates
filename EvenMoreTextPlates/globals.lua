local textplates = {}
local original_textplates = require("__textplates__.textplates")

textplates.graphics_path = "__EvenMoreTextPlates__/graphics"

textplates.symbols = original_textplates.symbols
textplates.symbol_by_char = original_textplates.symbol_by_char
textplates.types = original_textplates.types

textplates.new_materials = {
	["plastic"] = "plastic-bar",
	["plasticcoloured"] = "plastic-bar",
}

textplates.source_material = "copper"

textplates.resolutions = {
	small = 64,
	large = 128,
}

return textplates