# Helpers ----
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

custom_viridis_palette <-
  function(){
    inputs <-  c(the$main_palette$main,
                 the$main_palette$intermediate,
                 the$main_palette$contrast)
    ls <-  farver::decode_colour(inputs)
    ls <-  farver::convert_colour(ls, 'rgb', 'lab')[,1]
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
