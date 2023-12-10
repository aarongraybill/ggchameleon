# Given a vector or list of colors
# return a vector of which colors are valid
validate_colors <- function(cols){
  lapply(cols,function(x){
    out <- tryCatch(
      farver::decode_colour(x),
      error = function(e){e}
    )
    all(class(out) != "error")
  }) |>
    unlist()
}
