.onLoad <- function(libname, pkgname) {
  the$old_theme <- ggplot2::theme_get()
  showtext::showtext_auto()
  parse_configs()
  refresh_theming()
  if (length(the$accent_palette)<10){
    edit_the_accent_palette(pad_accent_palette(10),mode = 'append')
  }
}

.onUnload <- function(libname,pkgname) {
  theme_set <- theme_set(the$old_theme)
}
