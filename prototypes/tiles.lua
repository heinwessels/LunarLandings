local noise = require("noise")
local tne = noise.to_noise_expression
local tile_trigger_effects = require("__base__.prototypes.tile.tile-trigger-effects")
local sounds = require("__base__.prototypes.entity.sounds")
local transitions = require("__alien-biomes__/prototypes/tile/tile-transitions-static")

local elevation = noise.var("elevation")

local moon_autoplace = {
  default_enabled = false,
  probability_expression = (elevation) * math.huge
}
local rough_moon_autoplace = {
  default_enabled = false,
  probability_expression = (-elevation) * math.huge
}
local mountain_moon_autoplace = {
  default_enabled = false,
  probability_expression = (elevation - 20) * 100 * math.huge
}


data:extend{
  {
    name = "ll-luna-plain",
    type = "tile",
    order = "e[moon]-a",
    collision_mask = {"ground-tile"},
    --autoplace = autoplace_settings("dirt-1", "dirt", {{0, 0.25}, {0.45, 0.3}}, {{0.4, 0}, {0.45, 0.25}}),
    layer = 10,  -- Will be overwritten by Alien Biomes in data-final-fixes, then in Lunar Landings
    variants = tile_variations_template(
      "__space-exploration-graphics__/graphics/terrain/asteroid/asteroid.png", "__base__/graphics/terrain/masks/transition-1.png",
      "__space-exploration-graphics__/graphics/terrain/asteroid/hr-asteroid.png", "__base__/graphics/terrain/masks/hr-transition-1.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 } },
        [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      }
    ),

    transitions = transitions.cliff_transitions(),  -- to_tiles is set later
    transitions_between_transitions = transitions.cliff_transitions_between_transitions(),

    walking_sound = table.deepcopy(data.raw.tile["dirt-1"].walking_sound),
    map_color={r=150, g=150, b=150},
    --scorch_mark_color = {r = 0.541, g = 0.407, b = 0.248, a = 1.000},
    pollution_absorption_per_second = 0.0000066,
    vehicle_friction_modifier = 1.5,
    can_be_part_of_blueprint = false,

    --trigger_effect = tile_trigger_effects.dirt_1_trigger_effect()
    autoplace = moon_autoplace,
  },
  {
    name = "ll-luna-lowland",
    type = "tile",
    order = "e[moon]-b",
    collision_mask = {"ground-tile"},
    autoplace = rough_moon_autoplace,
    layer = 22,
    variants = tile_variations_template(
      "__alien-biomes__/graphics/terrain/sr/mineral-grey-dirt-2.png", "__base__/graphics/terrain/masks/transition-1.png",
      "__alien-biomes-hr-terrain__/graphics/terrain/hr/mineral-grey-dirt-2.png", "__base__/graphics/terrain/masks/hr-transition-1.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 } },
        [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      }
    ),

    transitions = dark_dirt_transitions,
    transitions_between_transitions = dark_dirt_transitions_between_transitions,

    walking_sound = dirt_sounds,
    map_color={r=50, g=50, b=50},
    scorch_mark_color = {r = 0.420, g = 0.304, b = 0.191, a = 1.000},
    pollution_absorption_per_second = dirt_pollution_absorption,
    vehicle_friction_modifier = dirt_vehicle_speed_modifier,

    trigger_effect = tile_trigger_effects.dirt_4_trigger_effect()
  },
  {
    name = "ll-luna-mountain",
    type = "tile",
    order = "e[moon]-c",
    collision_mask = {"ground-tile"},
    autoplace = mountain_moon_autoplace,
    layer = 22,
    variants = tile_variations_template(
      "__alien-biomes__/graphics/terrain/sr/mineral-white-dirt-4.png", "__base__/graphics/terrain/masks/transition-1.png",
      "__alien-biomes-hr-terrain__/graphics/terrain/hr/mineral-white-dirt-4.png", "__base__/graphics/terrain/masks/hr-transition-1.png",
      {
        max_size = 4,
        [1] = { weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045 } },
        [2] = { probability = 1, weights = {0.070, 0.070, 0.025, 0.070, 0.070, 0.070, 0.007, 0.025, 0.070, 0.050, 0.015, 0.026, 0.030, 0.005, 0.070, 0.027 } },
        [4] = { probability = 1.00, weights = {0.070, 0.070, 0.070, 0.070, 0.070, 0.070, 0.015, 0.070, 0.070, 0.070, 0.015, 0.050, 0.070, 0.070, 0.065, 0.070 }, },
        --[8] = { probability = 1.00, weights = {0.090, 0.125, 0.125, 0.125, 0.125, 0.125, 0.125, 0.025, 0.125, 0.005, 0.010, 0.100, 0.100, 0.010, 0.020, 0.020} }
      }
    ),

    transitions = transitions.cliff_transitions(),  -- to_tiles is set later
    transitions_between_transitions = transitions.cliff_transitions_between_transitions(),

    walking_sound = dirt_sounds,
    map_color={r=200, g=200, b=200},
    scorch_mark_color = {r = 0.420, g = 0.304, b = 0.191, a = 1.000},
    pollution_absorption_per_second = dirt_pollution_absorption,
    vehicle_friction_modifier = dirt_vehicle_speed_modifier,

    trigger_effect = tile_trigger_effects.dirt_4_trigger_effect()
  },

  {
    type = "tile",
    name = "ll-lunar-foundation",
    order = "e[moon]-d[foundation]",
    needs_correction = false,
    minable = {mining_time = 0.1, result = "ll-lunar-foundation"},
    mined_sound = sounds.deconstruct_bricks(0.8),
    collision_mask = {"ground-tile"},
    walking_speed_modifier = 1.5,
    layer = 64,
    transition_overlay_layer_offset = 2, -- need to render border overlay on top of hazard-concrete
    decorative_removal_probability = 0.25,
    variants =
    {
      main = {
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile1.png",
        count = 12,
        size = 1,
        hr_version =
        {
          picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/hr-tile1.png",
          count = 12,
          size = 1,
          scale = 0.5
        }
      },},

      inner_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-inner-corner.png",
        count = 1,
        hr_version =
        {
          picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/hr-tile-inner-corner.png",
          count = 1,
          scale = 0.5
        }
      },
      inner_corner_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-inner-corner-mask.png",
        count = 16,
        hr_version =
        {
          picture = "__base__/graphics/terrain/concrete/hr-concrete-inner-corner-mask.png",
          count = 16,
          scale = 0.5
        }
      },

      outer_corner =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-outer-corner.png",
        count = 1,
        hr_version =
        {
          picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/hr-tile-outer-corner.png",
          count = 1,
          scale = 0.5
        }
      },
      outer_corner_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-outer-corner-mask.png",
        count = 8,
        hr_version =
        {
          picture = "__base__/graphics/terrain/concrete/hr-concrete-outer-corner-mask.png",
          count = 8,
          scale = 0.5
        }
      },

      side =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-side.png",
        count = 16,
        hr_version =
        {
          picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/hr-tile-side.png",
          count = 16,
          scale = 0.5
        }
      },
      side_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-side-mask.png",
        count = 16,
        hr_version =
        {
          picture = "__base__/graphics/terrain/concrete/hr-concrete-side-mask.png",
          count = 16,
          scale = 0.5
        }
      },

      u_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-u.png",
        count = 1,
        hr_version =
        {
          picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/hr-tile-u.png",
          count = 1,
          scale = 0.5
        }
      },
      u_transition_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-u-mask.png",
        count = 8,
        hr_version =
        {
          picture = "__base__/graphics/terrain/concrete/hr-concrete-u-mask.png",
          count = 8,
          scale = 0.5
        }
      },

      o_transition =
      {
        picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/tile-o.png",
        count = 1,
        hr_version =
        {
          picture = "__space-exploration-graphics__/graphics/terrain/space-platform-plating/hr-tile-o.png",
          count = 1,
          scale = 0.5
        }
      },
      o_transition_mask =
      {
        picture = "__base__/graphics/terrain/concrete/concrete-o-mask.png",
        count = 4,
        hr_version =
        {
          picture = "__base__/graphics/terrain/concrete/hr-concrete-o-mask.png",
          count = 4,
          scale = 0.5
        }
      },
    },

    transitions = concrete_transitions,
    transitions_between_transitions = concrete_transitions_between_transitions,

    --walking_sound = refined_concrete_sounds,
    --build_sound = concrete_tile_build_sounds,

    map_color={r=49, g=48, b=45},
    scorch_mark_color = {r = 0.373, g = 0.307, b = 0.243, a = 1.000},
    pollution_absorption_per_second = 0,
    --vehicle_friction_modifier = concrete_vehicle_speed_modifier,

    trigger_effect = tile_trigger_effects.concrete_trigger_effect()
  },
  {
    type = "item",
    name = "ll-lunar-foundation",
    icon = "__space-exploration-graphics__/graphics/icons/space-platform-plating.png",
    icon_size = 64,
    subgroup = "terrain",
    order = "e[moon]-a[foundation]",
    stack_size = 100,
    place_as_tile =
    {
      result = "ll-lunar-foundation",
      condition_size = 1,
      condition = { "water-tile" }  -- Will be overwritten in data-final-fixes
    }
  },
  {
    type = "recipe",
    name = "ll-lunar-foundation",
    energy_required = 15,
    enabled = false,
    category = "crafting-with-fluid",
    ingredients =
    {
      {"stone-brick", 10},
      {"steel-plate", 1},
      {type="fluid", name="water", amount=20}
    },
    result= "ll-lunar-foundation",
    result_count = 20
  },
}

data.raw.tile["ll-luna-plain"].transitions[1].to_tiles = {"ll-luna-lowland"}
data.raw.tile["ll-luna-mountain"].transitions[1].to_tiles = {"ll-luna-lowland"}

-- Add craters to tile
local crater_names = {
  "crater3-huge", "crater1-large-rare", "crater1-large", "crater2-medium", "crater4-small"
}

for _, crater_name in pairs(crater_names) do
  local crater = data.raw["optimized-decorative"][crater_name]
  table.insert(crater.autoplace.tile_restriction, "ll-luna-plain")
  --crater.autoplace = nil
end

data.raw["straight-rail"]["straight-rail"].surface_conditions = {nauvis = true, luna = false}
data.raw["curved-rail"]["curved-rail"].surface_conditions = {nauvis = true, luna = false}
data.raw["assembling-machine"]["assembling-machine-1"].surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
data.raw["assembling-machine"]["assembling-machine-2"].surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
data.raw["assembling-machine"]["assembling-machine-3"].surface_conditions = {nauvis = true, luna = {plain = false, lowland = false, mountain = false, foundation = true}}
