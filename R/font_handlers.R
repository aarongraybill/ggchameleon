get_font <- function(font){

  if (font%in%sysfonts::font_families()){
    # Do nothing, font exists

  } else if (!curl::has_internet()) {
      warning(paste0("No internet connection,",font, "will be replaced with default font"))
      return(NULL)

  } else{
    # We have internet but not the font, try to download it
    tryCatch(
      sysfonts::font_add_google(font, db_cache = T),
      error = function(x) {
        #if we can't find it cached
        tryCatch(
          sysfonts::font_add_google(font, db_cache = F),
          error = function(y){
            if (grep("font not found",y$message)){
              stop(paste0("The font: \"",
                          font,
                          "\" could not be found on Google Fonts. ",
                          "Please ensure that the font is available and is ",
                          "spelled correctly"))

            }

          }
        )
      }
    )
  }
}

load_fonts <- function() {
  for (font in the$fonts) {
    get_font(font)
  }
}

font_check <- function(){
    if (!all(c(the$fonts)%in%sysfonts::font_families())){
      load_fonts()
      }
  }
