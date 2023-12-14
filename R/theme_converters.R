#' Given a ggplot2 theme
#' Convert that to a list, preserving class information
#' @noRd
theme_to_list <- function(theme){
  lapply(
    theme,
    function(t){
      list(
        class = class(t),
        attributes = unclass(as.list(t))
      )
    }
  )
}

#' Given a list with classes and attributes
#' Convert this to a ggplot2 theme
#' @noRd
list_to_theme <- function(l){
  out_list <-
    lapply(l,function(x){
    out <- structure(x$attributes,class = x$class)
    if (length(out)==1) {out <- out[[1]]}
    return(out)
  })
  return(out_list)
}
