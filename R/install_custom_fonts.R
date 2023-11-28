load_fonts <- function() {

  if (!curl::has_internet()) {
    warning("No internet connection, resorting to default fonts")
    return(NULL)
  }

  get_font <- function(font){
    tryCatch(
      sysfonts::font_add_google(font, db_cache = T),
      error = function(x) {
        sysfonts::font_add_google(font, db_cache = F) #if we can't find it cached
      }
    )
  }
  for (font in the$fonts) {
    get_font(font)
  }
}
