#' Generate Maximally Differentiable Set of Palette Colors:
#'
gen_palette <- function(n) {
  palette <- c(the$main_palette[c("main", "secondary","intermediate")], the$accent_palette)
  extra_colors <- c()

  if (n==1){
    return(the$main_palette$main)
  }

  if (length(palette) < n) {
    extra_colors <-
      create_new_colors(length.out = n,
                                    starting_colors = c(
                                      palette,
                                      the$main_palette[
                                        c('black',
                                          'white',
                                          'off_white')]
                                      )) |>
      as.vector()


    names(extra_colors) <- paste0("extra_",1:length(extra_colors))
  }

  # Convert colors to lab space for easier color math
  palette <- c(palette,extra_colors)
  ls <-  farver::decode_colour(palette,to = "lab")

  # Compute distances between all colors
  # creates a symmetric matrix
  diffs <- farver::compare_colour(from = ls,to=ls,from_space = 'lab',to_space = 'lab',method='cie2000')

  # Higher score is a worse match for the colors already included
  scores <- 1/diffs^2

  # The first two colors we always want to include
  colors <- c('main', 'secondary')

  # We subset the scores matrix so that it has only the rows
  # from `colors` and only the columns that *aren't* in `colors`
  # when we take the column means, that gives us the average score of every
  # other color compared to the colors we've already selected
  new_vec = colMeans(scores[colors, setdiff(names(palette), colors)])
  # Continue adding to `colors` until we have enough
  while (length(colors) < n) {
    # Select which of the colmeans has the lowest score
    new_col = names(which.min(new_vec))
    # Add that optimal color to the `colors` list
    colors = c(colors, new_col)

    # New badness scores include the newly found color as a row, not a column
    new_vec =
      colMeans(scores[colors, setdiff(names(palette), colors), drop = FALSE])
  }
  return(palette[colors] |> unlist() |> unname())
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

# Generate new colors that are maximally visibly distinct from existing colors in discrete palette


create_new_colors <-
  function(length.out = 25,
           starting_colors =
             c(the$main_palette[c("main",
                                  "secondary",
                                  "intermediate",
                                  'black',
                                  'white',
                                  'off_white')],
               the$accent_palette)) {
    if (length(starting_colors)-3 >= length.out) {
      return(c())
    } else{
    # Make all colors of the form #X0X0X0 (essentially) colors in 3-digit hex
    hex_dig <- sprintf("%X0",0:15)
    all_hex <- expand.grid(hex_dig,hex_dig,hex_dig)
    all_hex <- paste0("#",all_hex$Var1,all_hex$Var2,all_hex$Var3)
    gamut <- farver::decode_colour(all_hex,to='lab')

    from_lab <- farver::decode_colour(starting_colors,to='lab')

    dists <- farver::compare_colour(from = gamut,to=from_lab,from_space = 'lab',to_space = 'lab',method='cie2000')

    # We add colors to the input colors until there
    # are three more colors than we need (because we don't actually)
    # use white, off_white, or black as marker colors
    while (nrow(from_lab)<length.out+3){
      # The square term here punishes colors that are very near to each other
      # essentially eliminating them from contention
      score <- apply(dists,1,function(x){mean(1/x^2)})

      # The new color for the palette is the one with the lowest score (maximal)
      # average distance
      new_color <- gamut[which.min(score),]
      # compute the distance from the new color to all other colors
      # you might worry that we have to delete this new color from the rows of
      # gamut, but we actually don't have to because the distance between
      # the new color and itself will always be 0, so it will never
      # be re-chosen as the maximially distinct color.
      new_dist <- farver::compare_colour(from = gamut,to=matrix(new_color,ncol = 3),from_space = 'lab',to_space = 'lab',method='cie2000')

      # Add the new color to the list of lab colors
      from_lab <- rbind(from_lab,new_color)

      # Add the distances of the new color to all other colors
      dists <- cbind(dists,new_dist)

    }
    # We only want to output the new colors, ie the colors we didn't start with
    # so we start remove all of the rows corresponding
    # to the colors we already have
    last_old_row <- length(starting_colors)
    return(farver::encode_colour(matrix(from_lab[-1:-last_old_row,],ncol=3),from='lab') |> unname())
    }
}


