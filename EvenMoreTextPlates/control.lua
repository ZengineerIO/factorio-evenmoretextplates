local textplates = require("globals")

remote.add_interface("EvenMoreTextPlates", {
	textplates_add_types = function() return textplates.new_types end,
	textplates_add_characters_for_symbols = function() return textplates.symbol_by_char end,
})