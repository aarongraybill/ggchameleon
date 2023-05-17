.onLoad <- function(libname, pkgname) {
  the$old_theme <- ggplot2::theme_get()
  showtext::showtext_auto()
  parse_configs()
  refresh_theming()
}

.onUnload <- function(libname,pkgname) {
  theme_set <- theme_set(the$old_theme)
}
