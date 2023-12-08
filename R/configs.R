#' Current configurations for ggplot2 styling
#'
#' `the` is an object that contains the fonts, colors, theme customizations
#' implemented by the ggchameleon package. `the` should not be edited directly,
#' and is updated automatically when one of the following is run:
#' * [edit_the_main_palette()],
#' * [edit_the_accent_palette()],
#' * [edit_the_fonts()]
#' * [edit_the_theme()]
#'
#' `the` is named as such because it's intended to be used in the way that the
#' English word "the" is used. For example, if you would like the main color
#' used in your ggchameleon configurations, you can write
#' `the$main_palette$main`. This idea comes from  the suggestion
#' [here](https://r-pkgs.org/data.html#sec-data-state)
#'
#' `the` is useful if you need to reference the elements of your configurations
#' in other parts of your code. For example if you wanted to change the color of
#' a base R chart, you could get the color selections from `the`
#'
#' @examples
#' # Using Default base R colors
#' plot(cars)
#' # Using the current secondary color
#' plot(cars,col=the$main_palette$secondary)
#' # Editing the secondary color to pink
#' edit_the_main_palette(secondary="#FF00FF")
#' # New plot automatically updates `the` to pink
#' plot(cars,col=the$main_palette$secondary)
#'
#' @export
the <- new.env(parent = emptyenv())

the$main_palette <-
  list(
    "main" = "#000D4D", # A main distinctive color for your configuration
    "secondary" = "#55CE58", # A secondary color that goes well with the main
    "white" = "#ffffff", # Make this white unless you wanna change all page backgrounds
    "off_white" = "#E7E7E7", # dark enough to be visible on white w/o standing out
    "black" = "#000000",  # the darkest color. Used extensively for outlining geometries
    "contrast" = "#FFF200", # a color that is a difference luminance to the main color for nice gradients
    "intermediate" = "#FC7E00" # a color somewhere between the main color and the contrast color
  )

the$accent_palette <-
  # stick as many colors as you can visually distinguished.
  # Should gel with all of main palette
  # Deliberately unordered as later functions pick best options
  list(
    "#ff4b48",
    "#00a2f1",
    "#14559f",
    "#CF309F",
    "#9C72E8",
    "#EBCE3F"
  )
names(the$accent_palette) <- paste0("accent_",1:length(the$accent_palette))

the$fonts <- # Must be spelled exactly as appears in google fonts
  list(sans = "Atkinson Hyperlegible",
       serif = "Bitter",
       display = "Kumbh Sans",
       mono = "Source Code Pro"
  )

the$theme <- ggplot2::theme()
#' Modify the primary colors used in your charts
#'
#' `edit_the_main_palette()` allows you to change the colors that automatically
#' appear in your ggplots. When you edit a color, ggchameleon will figure out
#' where those new colors should appear in your charts. ggchameleon will not
#' only update the text colors, but also the default colors of the geometries
#' (the shapes that appear in the chart) when applicable. You can edit one or
#' more parameters at a time. After editing parameters, the updated values are
#' stored in [the].
#'
#' @param main The primary color used for title text and appearing whenever
#'   possible in charts
#' @param secondary A color that should notably contrast the `main` color
#' @param white The whitest color that will appear in your charts
#' @param off_white The color used for grid lines, subtly differentiable from
#'   `white`
#' @param black The darkest color that will appear in your plots
#' @param contrast A color that is **very** differentiable from `main`. Used
#'   whenever there is a continuous color gradient
#' @param intermediate A color to appear between `main` and `contrast` in
#'   continuous gradients
#'
#' @examples
#' # Editing one parameter at a time
#' # converts the main color to magenta (pink)
#' edit_the_main_palette(main="magenta")
#' # Editing multiple elements
#' # continuous gradients now go from green to gray to magenta
#' edit_the_main_palette(contrast="darkolivegreen",intermediate="gray50")
#'
#' # our changes are also reflected in `the`
#' the$main_palette
#'
#' @export
edit_the_main_palette <- function(...) {
  args <- list(...)
  found = intersect(names(args), names(the$main_palette))
  missing = setdiff(names(args), names(the$main_palette))
  if (length(missing) > 0) {
    message(paste0(
      "Arguments: (",
      paste0(missing, collapse = ", "),
      ") are not in the main palette and will be ignored."
    ))
  }
  for (found_name in found) {
    the$main_palette[[found_name]] <- args[[found_name]]
  }
  refresh_theming()
}

#' Modify supplemental colors
#'
#' The accent palette contains an arbitrary number of additional colors for your
#' configurations that can be used when coloring discrete/categorical variables.
#' The accent palette does not have meaningful names or an order. Because of
#' this, by default, `edit_the_accent_palette` overwrites *the entire* existing
#' accent palette. You can append to the existing list by using `mode =
#' 'append'`. Behind the scenes, ggchameleon figures out which colors are most
#' differentiable, and includes those in your chart.
#'
#' If you only include a few colors, or if your chart requires many different
#' colors, ggchameleon will automatically other colors to your chart. It tries
#' to make these additional colors as differentiable as possible from the colors
#' being used.
#'
#' @param ... A vector or comma-separated list of colors
#' @param mode `"overwrite"` (the default), removes all existing accent colors
#'   and replace them with `...`. The `"append"` option leaves all existing
#'   colors and adds every color specified in `...`.
#'
#' @examples
#' # Add additional colors to the accent palette
#' edit_the_accent_palette("tomato","powderblue",mode="append")
#'
#' # Overwrite the existing accent colors and replace with new colors
#' edit_the_accent_palette(c("orchid","lavender","violet","goldenrod"))
#'
#' @export
edit_the_accent_palette <-
  function(..., mode = c("overwrite", "append")) {
    mode <- match.arg(mode)
    args <- list(...)
    args <- unlist(args)
    if (length(args) < 4 && mode == "overwrite" && length(args)>0){
      warning("Fewer than four accent colors while overwriting is not recommended! Proceeding.")
      }
    if (mode == "overwrite") {
      if (length(args)==0||is.null(unlist(args))){
        # Do nothing, no args supplied
      } else{
        the$accent_palette <- args
        names(the$accent_palette) <- paste0("accent_", 1:length(the$accent_palette))
      }
    } else if (mode == "append") {
    the$accent_palette <- c(the$accent_palette, args)
    names(the$accent_palette) <-
      paste0("accent_", 1:length(the$accent_palette))
  }
refresh_theming()
  }

#' Use custom fonts from Google Fonts
#'
#' `edit_the_fonts` allows you specify any fonts available in the [Google
#' Fonts](https://fonts.google.com/) library as fonts for your ggchameleon
#' configurations. You can specify different fonts depending on which part of
#' the chart you are interested in modifying. `edit_the_fonts` defers to
#' [sysfonts::font_add_google()] for finding and installing Google fonts.
#'
#' @param sans The most legible font, used for the smaller elements, axis labels, legend, etc.
#' @param display The most distinctive font. Used for the title.
#' @param serif Used in the subtitle.
#' @param mono A "monospace" font. Used whenever code needs to be displayed.
#'
#' @examples
#' # Changes the title font to the "Lobster" font family
#' edit_the_fonts(display="Lobster")
#'
#' @export
edit_the_fonts <- function(...) {
  args <- list(...)
  found = intersect(names(args), names(the$fonts))
  missing = setdiff(names(args), names(the$fonts))
  if (length(missing) > 0) {
    message(paste0(
      "Arguments: (",
      paste0(missing, collapse = ", "),
      ") are not in the fonts and will be ignored."
    ))
  }
  for (found_name in found) {
    the$fonts[[found_name]] <- args[[found_name]]
  }
  refresh_theming()
}

#' Specify a custom ggplot2 plot layout
#'
#' With `edit_the_theme`, anything that can be modified with [ggplot2::theme()]
#' can be set as a default under the ggchameleon framework. The syntax of
#' `edit_the_theme` mirrors that of [ggplot2::theme()]. You can customize layout
#' parameters by customizing options like `legend.position`, or you can
#' customize options related font size or colors. Importantly, `edit_the_theme`
#' is unable to customize the "geometries" the shapes representing the data.
#'
#' @inheritDotParams ggplot2::theme
#'
#' @examples
#' library(ggplot2)
#' # Places the legend at the bottom by default.
#' edit_the_theme(legend.position='bottom')
#'
#' # Change the title text color to the secondary color
#' edit_the_theme(title = element_text(color = the$main_palette$secondary))
#'
#' @export
edit_the_theme <- function(...){
  args <- list(...)
  bundled_args <- lapply(args,rebundle_element)

  the$theme <-
    the$theme +
    rlang::exec(ggplot2::theme,!!!bundled_args)

  refresh_theming()
}

