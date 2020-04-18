-- DEADLOCK'S TEXT PLATES EXTENDED
-- Based on the classic Factorio mod by Earendel, y.petremann and gheift

local textplates = require("globals")

local function create_text_plate(materialtype, ingredient_item)
	local material = (materialtype == "plasticcoloured") and "plastic" or materialtype
	if data.raw.item[ingredient_item] then
		for size,resolution in pairs(textplates.resolutions) do
			local source_entity_name = string.format("textplate-%s-%s", size, textplates.source_material)
			local source_entity = data.raw["simple-entity-with-force"][source_entity_name]
			if source_entity then
				-- entity
				local new_entity = table.deepcopy(source_entity)
				new_entity.name = string.format("textplate-%s-%s", size, materialtype)
				new_entity.icon = string.format("%s/%s/%s_%s.png", textplates.graphics_path, size, materialtype, "blank")
				new_entity.minable.result = new_entity.name
				new_entity.localised_name = { "entity-name.textplate", { "textplates."..size }, {"textplates.".. materialtype } }
				new_entity.fast_replaceable_group = "textplate-"..size
				new_entity.render_layer = "lower-object-above-shadow"
				for id,picture in pairs(new_entity.pictures) do
					picture = {
						layers = {
							{
								filename = string.format("%s/%s/%s_%s.png", textplates.graphics_path, size, material, textplates.symbols[id]),
								width = resolution,
								height = resolution,
								scale = 0.5
							},
							{
								filename = string.format("%s/%s/%s_%s.png", textplates.graphics_path, size, "shadow", textplates.symbols[id]),
								draw_as_shadow = true,
								width = resolution * 1.25,
								height = resolution,
								scale = 0.5,
								shift = {0.125*(resolution/64), 0}
							}
						}
					}
					if materialtype == "plasticcoloured" then
						local newlayer = table.deepcopy(picture.layers[1])
						newlayer.apply_runtime_tint = true
						table.insert(picture.layers, newlayer)
						picture.layers[1].tint = {0.5,0.5,0.5,1}
					end
					new_entity.pictures[id] = picture
				end
				data:extend({new_entity})
				-- variant items
				for id,symbol in pairs(textplates.symbols) do
					local source_item_name = string.format("textplate-%s-%s-%s", size, textplates.source_material, symbol)
					local source_item = data.raw.item[source_item_name]
					if source_item then
						local new_item = table.deepcopy(source_item)
						new_item.name = string.format("textplate-%s-%s-%s", size, materialtype, symbol)
						new_item.icon = string.format("%s/%s/%s_%s.png", textplates.graphics_path, "small", material, (symbol == "blank" and size == "small") and "blank_small" or symbol)
						new_item.icon_size = 64
						new_item.place_result = string.format("textplate-%s-%s", size, materialtype)
						new_item.order = string.format("%s-%s", materialtype, size)
						new_item.localised_name = { "item-name.textplate", { "textplates."..size }, {"textplates.".. materialtype } }
						data:extend({new_item})
					end
				end
				-- base item
				local source_item_name = string.format("textplate-%s-%s", size, textplates.source_material)
				local source_item = data.raw.item[source_item_name]
				if source_item then
					local new_item = table.deepcopy(source_item)
					new_item.name = string.format("textplate-%s-%s", size, materialtype)
					new_item.icon = string.format("%s/%s/%s_%s.png", textplates.graphics_path, "small", materialtype, size == "small" and "blank_small" or "blank")
					new_item.icon_size = 64
					new_item.place_result = string.format("textplate-%s-%s", size, materialtype)
					new_item.order = string.format("%s-%s", materialtype, size)
					new_item.localised_name = { "item-name.textplate", { "textplates."..size }, {"textplates.".. materialtype } }
					data:extend({new_item})
				end
				-- recipe
				local source_recipe_name = string.format("textplate-%s-%s", size, textplates.source_material)
				local source_recipe = data.raw.recipe[source_recipe_name]
				if source_recipe then
					local new_recipe = table.deepcopy(source_recipe)
					new_recipe.name = string.format("textplate-%s-%s", size, materialtype)
					new_recipe.icon = string.format("%s/%s/%s_%s.png", textplates.graphics_path, "small", materialtype, (size == "small") and "blank_small" or "blank")
					new_recipe.icon_size = 64
					new_recipe.ingredients = {{ type = "item", name = ingredient_item, amount = (size == "large") and 4 or 1 }}
					new_recipe.results = {{ type = "item", name = string.format("textplate-%s-%s", size, materialtype), amount = 1}}
					data:extend({new_recipe})
				end
			end
		end
	end
end

for materialtype,ingredient_item in pairs(textplates.new_materials) do
	create_text_plate(materialtype, ingredient_item)
end
