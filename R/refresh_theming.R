refresh_theming <- function(){
  font_check()
  ggplot2::theme_set(the$theme)
  custom_geom_update()
  custom_scale_update()
}
