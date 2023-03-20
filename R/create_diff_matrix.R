create_diff_matrix <- function(palette){
  ls <-  farver::decode_colour(palette)
  ls <-  farver::convert_colour(ls, 'rgb', 'lab')
  diffs = matrix(nrow = length(palette), ncol = length(palette))
  for (i in 1:nrow(ls)) {
    diffs[i, ] = spacesXYZ::DeltaE(ls[i, ], ls,metric = "2000")
  }
  colnames(diffs) <- palette
  rownames(diffs) <- palette
  diffs
}
