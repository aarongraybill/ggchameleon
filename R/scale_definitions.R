# Discrete Unordered----
scale_color_custom_d <-
  function (..., alpha = 1, begin = 0, end = 1, direction = 1,
            option = "D", aesthetics = "colour"){
    discrete_scale(aesthetics="colour", "custom_d", gen_palette, ...)
  }

scale_fill_custom_d <-
  function (..., alpha = 1, begin = 0, end = 1, direction = 1,
            option = "D", aesthetics = "fill"){
    discrete_scale(aesthetics, "custom_d", gen_palette, ...)
  }

# Discrete Ordered ----
scale_color_custom_o <-
  function (..., alpha = 1, begin = 0, end = 1, direction = 1,
            option = "D", aesthetics = "colour"){
    discrete_scale(aesthetics="colour", "custom_o", custom_discrete_viridis_palette, ...)
  }

scale_fill_custom_o <-
  function (..., alpha = 1, begin = 0, end = 1, direction = 1,
            option = "D", aesthetics = "fill"){
    discrete_scale(aesthetics, "custom_o", custom_discrete_viridis_palette, ...)
  }

# Continuous ----
scale_color_custom_c <-
  function (...,
            alpha = 1,
            begin = 0,
            end = 1,
            direction = 1,
            option = "D",
            values = NULL,
            space = "Lab",
            na.value = "grey50",
            guide = "colourbar",
            aesthetics = "colour") {
    continuous_scale(
      aesthetics,
      "custom_c",
      custom_viridis_palette(),
      na.value = na.value,
      guide = guide,
      ...
    )
  }

scale_fill_custom_c <-
  function (...,
            alpha = 1,
            begin = 0,
            end = 1,
            direction = 1,
            option = "D",
            values = NULL,
            space = "Lab",
            na.value = "grey50",
            guide = "colourbar",
            aesthetics = "fill") {
    continuous_scale(
      aesthetics = "fill",
      "custom_c",
      custom_viridis_palette(),
      na.value = na.value,
      guide = guide,
      ...
    )
  }

# Binned ----

scale_color_custom_b <-
  function (...,
            alpha = 1,
            begin = 0,
            end = 1,
            direction = 1,
            option = "D",
            values = NULL,
            space = "Lab",
            na.value = "grey50",
            guide = "colourbar",
            aesthetics = "colour") {
    continuous_scale(
      aesthetics = "colour",
      "custom_b",
      custom_viridis_palette(),
      na.value = na.value,
      guide = guide,
      ...
    )
  }

scale_fill_custom_b <-
  function (...,
            alpha = 1,
            begin = 0,
            end = 1,
            direction = 1,
            option = "D",
            values = NULL,
            space = "Lab",
            na.value = "grey50",
            guide = "colourbar",
            aesthetics = "fill") {
    continuous_scale(
      aesthetics = "fill",
      "custom_b",
      custom_viridis_palette(),
      na.value = na.value,
      guide = guide,
      ...
    )
  }



