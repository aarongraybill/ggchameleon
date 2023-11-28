font_check <- function(){
    if (!all(c(the$fonts)%in%sysfonts::font_families())){
      message("Installing Fonts")
      load_fonts()
      }
  }
