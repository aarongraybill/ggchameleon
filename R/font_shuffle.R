font_shuffle <- function(){
  font_info = sysfonts::font_info_google()
  font_info = font_info[grep("latin",font_info$subsets),]
  font_info = font_info[grep("regular",font_info$variants),]

  sans <- font_info[font_info$category=="sans-serif",]
  sans <- sans$family[sample(1:nrow(sans),1)]

  display <- font_info[font_info$category=="display",]
  display <- display$family[sample(1:nrow(display),1)]


  edit_the_fonts(sans=sans,display=display)
}


