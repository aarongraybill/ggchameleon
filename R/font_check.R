#' Check if all fonts are installed and install if not
#'
#' @description Look for fonts in relevant directory. If none are found, then install those fonts.
#' @return nothing, but messages if no fonts are installed
#' @details You cannot directly edit any other theme elements. This function returns a complete theme, and if you wish to further modify you should use the ggplot2::theme() command
#' @examples
#' font_check()
#'
#'
#'
font_check <- function(){
    if (!all(c(the$fonts)%in%sysfonts::font_families())){
        load_fonts()
      message("Installing Fonts")
      }
  }
