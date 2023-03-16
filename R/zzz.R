.onLoad <- function(libname, pkgname) {
  font_check()
  ggplot2::theme_set(theme_custom())
  custom_geom_update()
  custom_scale_update()

}
