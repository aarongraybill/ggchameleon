font_shuffle <- function(exclude=c("Noto Sans ")){
  font_info = font_popularity
  font_info = font_info[grep("latin",font_info$subsets),]
  font_info = font_info[grep("regular",font_info$variants),]
  if (!is.null(exclude)){
    font_info = font_info[!grepl(paste0(exclude,collapse="|"),font_info$family),]
  }

  sans <- font_info[font_info$category%in%c("sans-serif","monospace"),]
  sans <- sample(sans$family,1,prob = log(sans$weekly))

  display <- font_info[font_info$category=="display",]
  display <- sample(display$family,1,prob = log(display$weekly))


  edit_the_fonts(sans=sans,display=display)
}
