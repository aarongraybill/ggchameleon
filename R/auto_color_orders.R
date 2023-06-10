#' Generate Maximally Differentiable Set of Palette Colors:
#'
gen_palette <- function(n) {
  palette <- c(the$main_palette[c("main", "secondary","intermediate")], the$accent_palette)

  if (length(palette) < n) {
    warning("There will repeated colors")
    return(rep_len(palette |> unlist() |>  as.vector(), n))
  }
  if (n > 5) {
    warning("These colors won't be super differentiable beware")
  }
  if (length(palette) == n) {
    return(unname(unlist(palette)))
  }
  if (n==1){
    return(the$main_palette$main)
  }
  else{
    ls <-  farver::decode_colour(palette)
    ls <-  farver::convert_colour(ls, 'rgb', 'lab')
    diffs = matrix(nrow = length(palette), ncol = length(palette))
    for (i in 1:nrow(ls)) {
      diffs[i, ] = spacesXYZ::DeltaE(ls[i, ], ls,metric = "2000")
    }
    colnames(diffs) <- names(palette)
    rownames(diffs) <- names(palette)

    colors <- c('main', 'secondary')
    new_vec = colMeans(diffs[colors, setdiff(names(palette), colors)])
    while (length(colors) < n) {
      new_col = names(new_vec)[which.max(new_vec)]
      colors = c(colors, new_col)
      new_vec =
        colMeans(as.matrix(diffs[colors, setdiff(names(palette), colors)]))
    }
    return(palette[colors] |> unlist() |> unname())
  }
}

#' Luminance Linear Color Gradient
custom_viridis_palette <-
  function(){
    inputs <-  c(the$main_palette$main,
                 the$main_palette$intermediate,
                 the$main_palette$contrast)
    ls <-  farver::decode_colour(inputs, to = 'lab')[,1]
    inputs <-  inputs[order(ls)]
    ls <-  ls[order(ls)]
    min_l <- min(ls)
    max_l <- max(ls)
    cs  <- 1/(max_l-min_l)*(ls-min_l)

    return(scales::gradient_n_pal(
      inputs,
      values = cs
    )
    )
}

smart_interpolate <- function(inputs = c(the$main_palette$main,
                                         the$main_palette$intermediate,
                                         the$main_palette$contrast)){

  lab <- farver::decode_colour(inputs, to = 'lab')
  inputs <- inputs[order(lab[,1])]
  lab <- lab[order(lab[,1]),]
  midpoint = (lab[1,1]+lab[3,1])/2

  d1 <- lab[2,1]-lab[1,1]
  d2 <- lab[3,1]-lab[2,1]
  closer_index = ifelse(d1<d2,1,3)

  slope_a = (lab[closer_index,2]-lab[2,2])/(lab[closer_index,1]-lab[2,1])
  int_a = lab[2,2]-lab[2,1]*slope_a
  out_a = slope_a*midpoint + int_a

  slope_b = (lab[closer_index,3]-lab[2,3])/(lab[closer_index,1]-lab[2,1])
  int_b = lab[2,3]-lab[2,1]*slope_b
  out_b = slope_b*midpoint + int_b

  target_color_lab = matrix(c(midpoint,out_a,out_b),nrow = 1)
  target_color_hex = farver::encode_colour(target_color_lab, from = 'lab')

  inputs[2] <- target_color_hex
  lab[2,] <- target_color_lab

  fl = approxfun(c(0,.5,1),lab[,1])
  fa = approxfun(c(0,.5,1),lab[,2])
  fb = approxfun(c(0,.5,1),lab[,3])

  function(x){
    m <- cbind(fl(x),fa(x),fb(x))
    return(farver::encode_colour(m,from = 'lab'))
  }

}

#' Discretized Luminance Linear Color Gradient
custom_discrete_viridis_palette <- function(n){
  c <- smart_interpolate()(1:n/n)
  c[1] <- smart_interpolate()(0)
  c[n] <- smart_interpolate()(1)
  c
}

#' Generate new colors that are maximally visibly distinct from existing colors in discrete palette

pad_accent_palette <- function(length.out=10,starting_colors=c(the$main_palette[c("main", "secondary","intermediate")], the$accent_palette)){
  # Make all colors of the form #X0X0X0 (essentialy) colors in 3-digit hex
  hex_dig <- sprintf("%X0",0:15)
  all_hex <- expand.grid(hex_dig,hex_dig,hex_dig)
  all_hex <- paste0("#",all_hex$Var1,all_hex$Var2,all_hex$Var3)
  gamut <- farver::decode_colour(all_hex,to='lab')

  from_lab <- farver::decode_colour(c('#000000','#FFFFFF',starting_colors),to='lab')

  dists <- farver::compare_colour(from = gamut,to=from_lab,from_space = 'lab',to_space = 'lab',method='cie2000')


  colors_needed <- length.out-length(starting_colors)

  while (nrow(from_lab)<length.out+2){
    score <- apply(dists,1,function(x){mean(1/x)})
    new_color <- gamut[which.min(score),]
    new_dist <- farver::compare_colour(from = gamut,to=matrix(new_color,ncol = 3),from_space = 'lab',to_space = 'lab',method='cie2000')

    from_lab <- rbind(from_lab,new_color)
    dists <- cbind(dists,new_dist)

  }
  last_old_row <- length(starting_colors)+2
  return(farver::encode_colour(from_lab[-1:-last_old_row,],from='lab') |> unname())
}


