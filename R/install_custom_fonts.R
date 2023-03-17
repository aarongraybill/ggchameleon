#' Get fonts that resemble the fonts we use for publication
#'
#' @description Pulls fonts from google then installs them into a file in the package location and then adds them to the list of R-available fonts
#' @return Nothing,
#' @details You cannot directly edit any other theme elements. This function returns a complete theme, and if you wish to further modify you should use the ggplot2::theme() command
#' @examples
#' install_philly_fonts()
#'

load_fonts <- function() {

  for (font in the$fonts) {
    tryCatch(
      sysfonts::font_add_google(font, db_cache = T),
      error = function(x) {
        sysfonts::font_add_google(font, db_cache = F) #if we can't find it cached
      }
    )
  }
}
