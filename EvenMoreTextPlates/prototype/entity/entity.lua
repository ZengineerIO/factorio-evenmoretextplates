-- EVEN MORE TEXT PLATES
-- Based on the classic Factorio mod by Earendel, y.petremann and gheift

local function text_sprite(size, material, symbol)
  if symbol == "blank" then symbol = "square" end

  local graphicspath = "__EvenMoreTextPlates__/graphics"
  if material == "plastic" and settings.startup["evenmoretextplates-legacy-plastic"].value == true then
    graphicspath = graphicspath.."/legacy"
  end

  local layers = {
    {
      filename = graphicspath.."/entity/"..material.."/"..symbol..".png",
      priority = "extra-high",
      width = 128,
      height = 128,
      frame_count = 1,
      scale = size == "large" and 0.5 or 0.25,
      shift = {1/32, -1/32},
    },
    {
      draw_as_shadow = true,
      filename = graphicspath.."/entity/shadow/"..symbol..".png",
      priority = "extra-high",
      width = 128,
      height = 128,
      frame_count = 1,
      scale = size == "large" and 0.5 or 0.25,
      shift = {2/32, 0},
    },
  }
  
  if material == "plastic" and settings.startup["evenmoretextplates-legacy-plastic"].value == true then
    layers = {
      {
        filename = graphicspath.."/entity/"..material.."/"..symbol..".png",
        priority = "extra-high",
        width = 128,
        height = 128,
        frame_count = 1,
        scale = size == "large" and 0.5 or 0.25,
        -- shift = {1/32, -1/32},
      },
      {
        draw_as_shadow = true,
        filename = graphicspath.."/entity/shadow/"..symbol..".png",
        priority = "extra-high",
        width = 128 * 1.25,
        height = 128,
        frame_count = 1,
        scale = size == "large" and 0.5 or 0.25,
        shift = size == "large" and {0.125*(128/64), 0} or {0.125*(64/64), 0},
      },
    }
  end
  return {
    layers = layers
  }
end

for _, type in pairs(evenmoretextplates.new_types) do
  local size = type.size
  local material = type.material
  local materialtype = (material == "plasticcoloured") and "plastic" or type.material

  local graphicspath = "__EvenMoreTextPlates__/graphics"
  if materialtype == "plastic" and settings.startup["evenmoretextplates-legacy-plastic"].value == true then
    graphicspath = graphicspath.."/legacy"
  end
  local icon = graphicspath.."/icon/"..materialtype.."/blank.png"
  if size == "large" then
    icon = graphicspath.."/icon/"..materialtype.."/square.png"
  end
  local entity = {
    name = type.name,
    type = "simple-entity-with-force",
    icon = icon,
    icon_size = 64,
    localised_name = { "entity-name.textplate", { "textplates."..size }, {"textplates.".. material } },
    flags = {"placeable-neutral", "player-creation"},
    minable = {
        count=1,
        hardness = 0,
        mining_time = 0.1,
        result = type.name,
    },
    render_layer = "lower-object-above-shadow",
    collision_mask = {"floor-layer", "water-tile"}, -- this does not work ... yet
    resistances = {
        {type = "fire", percent = 80},
    },
    pictures = {},

    max_health = 25,
    collision_box = { {-0.45, -0.45}, {0.45, 0.45} },
    selection_box = { {-0.5, -0.5}, {0.5, 0.5} },
    corpse = "small-remnants",
  }

  for id, symbol in ipairs(type.symbols) do
    local picture = text_sprite(size, materialtype, symbol)
    if material == "plasticcoloured" then
      local newlayer = table.deepcopy(picture.layers[1])
      newlayer.apply_runtime_tint = true
      table.insert(picture.layers, newlayer)
      picture.layers[1].tint = {0.5,0.5,0.5,1}
    end
    entity.pictures[id] = picture
  end

  if size == "large" then
    entity.corpse = "medium-remnants"
    entity.max_health = 100
    entity.collision_box = {{-0.9, -0.9}, {0.9, 0.9}}
    entity.selection_box = {{-1, -1}, {1, 1}}
    entity.minable.mining_time = 0.2
  end

  data:extend({entity})
end