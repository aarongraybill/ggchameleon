color_gradient <- function(x,start = the$main_palette$main,end = the$main_palette$off_white){
  scales::gradient_n_pal(c(start,end))(x)
}

alpha_gradient <- function(x,color = the$main_palette$main){
  scales::alpha(color,alpha=x)
}
