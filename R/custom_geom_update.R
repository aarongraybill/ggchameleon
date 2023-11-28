custom_geom_update <- function(){
  line_size = 1
  ggplot2::update_geom_defaults(
    "point", list(color=the$main_palette$black)
  )
  ggplot2::update_geom_defaults(
    "line", list(color=the$main_palette$black,size=line_size)
  )
  ggplot2::update_geom_defaults(
    "bar", list(color=the$main_palette$black,fill=alpha_gradient(.5),size=line_size)
  )
  ggplot2::update_geom_defaults(
    "smooth",list(color = alpha_gradient(.5),fill=the$main_palette$off_white) # transparent
  )
  ggplot2::update_geom_defaults(
    "abline",list(color = the$main_palette$black,size=line_size)
  )
  ggplot2::update_geom_defaults(
    "density2d", list(color=the$main_palette$main,size=.75*line_size)
  )
}


custom_scale_update <- function(){
  # 4 scale options: continuous, binned, discrete, binned * 2 aes: fill &  colour. 8 alterations
 options("ggplot2.discrete.colour"=scale_color_custom_d)
  options("ggplot2.continuous.colour"=scale_color_custom_c)
  options("ggplot2.binned.colour"=scale_color_custom_b)
  options("ggplot2.discrete.fill"=scale_fill_custom_d)
  options("ggplot2.continuous.fill"=scale_fill_custom_c)
  options("ggplot2.binned.fill"=scale_fill_custom_b)
  options("ggplot2.ordinal.colour"=scale_color_custom_o)
  options("ggplot2.ordinal.fill"=scale_fill_custom_o)

}
