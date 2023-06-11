#' @export
#'
the <- new.env(parent = emptyenv())

the$main_palette <-
  list(
    "main" = "#000D4D", # A main distinctive color for your brand
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

edit_the_theme <- function(...){
  args <- list(...)
  bundled_args <- lapply(args,rebundle_element)

  the$theme <-
    the$theme +
    rlang::exec(ggplot2::theme,!!!bundled_args)

  refresh_theming()
}

