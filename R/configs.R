#' @export
#'
the <- new.env(parent = emptyenv())

the$main_palette <-
  list(
    "main" = "#22311d", # A main distinctive color for your brand
    "secondary" = "#9f503d", # A secondary color that goes well with the brand_color
    "white" = "#ffffff", # Make this white unless you wanna change all page backgrounds
    "off_white" = "#e8e9eb", # dark enough to be visible on white w/o standing out
    "black" = "#060b0b",  # the darkest color. Used extensively for outlining geometries
    "contrast" = "#FFEA46", # a color that is a difference luminance to the main color for nice gradients
    "intermediate" = "#4D58A3" # a color somewhere between the main color and the contrast color
  )

the$accent_palette <-
  # stick as many colors as you can visually distinguished.
  # Should gel with all of main palette
  # Deliberately unordered as later functions pick best options
  list(
    "#522A7A",
    "#82BCE4",
    "#C68965",
    "#522A00"
  )
names(the$accent_palette) <- paste0("accent_",1:length(the$accent_palette))

the$fonts <- # Must be spelled exactly as appears in google fonts
  list(sans = "Chivo Mono",
       serif = "Bitter",
       display = "Public Sans"
  )

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
    if (!is.null(names(args)))
      message("Names in the accent palette are deliberately ignored")
    if (length(args) < 4 &&
        mode == "overwrite")
      warning("Fewer than four accent colors while overwriting is not recommended! Proceeding.")
    if (mode == "overwrite") {
      the$accent_palette <- args
      names(the$accent_palette) <-
        paste0("accent_", 1:length(the$accent_palette))
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

