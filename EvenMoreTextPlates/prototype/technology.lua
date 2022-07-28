for material, tech_data in pairs(evenmoretextplates.technologies) do
    local prerequisite
    for _, potential_prerequisite in pairs(tech_data.prerequisite) do
      if data.raw.technology[potential_prerequisite] then
        prerequisite = potential_prerequisite
        break
      end
    end
    if prerequisite then
      local prerequisite_tech = data.raw.technology[prerequisite]
      local icon_material = (material == "plasticcoloured") and "plastic" or material
      data:extend({{
          type = "technology",
          name = "textplates-"..material,
          effects = {
          },
          icon = "__EvenMoreTextPlates__/graphics/entity/"..icon_material.."/t.png",
          icon_size = 128,
          order = "a",
          prerequisites = {prerequisite},
          unit = {
              count = 10,
              ingredients = table.deepcopy(prerequisite_tech.unit.ingredients),
              time = prerequisite_tech.unit.time
          },
          localised_name = { "technology-name.textplate", {"textplates.".. material.."-C"} }
      }})
    end
  end