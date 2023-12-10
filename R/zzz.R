.onLoad <- function(libname, pkgname) {
  the$old_theme <- ggplot2::theme_get()
  showtext::showtext_auto()
  load_configs()
  refresh_theming()
  #pad_accent_palette(10)
  # if (length(the$accent_palette)<10){
  #   edit_the_accent_palette(pad_accent_palette(10),mode = 'append')
  # }
}

.onUnload <- function(libname,pkgname) {
  ggplot2::theme_set(the$old_theme)
}
