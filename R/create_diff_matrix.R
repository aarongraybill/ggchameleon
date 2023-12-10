create_diff_matrix <- function(palette){
  ls <-  farver::decode_colour(palette,to = "lab")
  diffs <- farver::compare_colour(ls,ls,from_space = "lab",method = 'cie2000')
  diffs
}
