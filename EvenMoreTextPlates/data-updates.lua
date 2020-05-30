-- update recipes to corrospoding ingredients if they exist

--[[ if data.raw.item["textplate-small-creep"] and data.raw.item["biomass"] then
    data.raw.recipe["textplate-small-creep"].ingredients = {{type = "item", name = "biomass", amount = 1}}
    data.raw.recipe["textplate-large-creep"].ingredients = {{type = "item", name = "biomass", amount = 4}}
end ]]