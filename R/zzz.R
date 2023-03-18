.onLoad <- function(libname, pkgname) {
  showtext::showtext_auto()
  parse_configs()
  refresh_theming()
}
