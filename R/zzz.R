.onLoad <- function(libname, pkgname) {
  showtext::showtext_auto()
  refresh_theming()
  parse_configs()
}
