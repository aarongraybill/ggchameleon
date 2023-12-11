#' Given a ggplot2 theme
#' Convert that to a list, preserving class information
#' @noRd
theme_to_list <- function(theme){
  lapply(
    theme,
    function(t){
      list(
        class = class(t),
        attributes = as.list(t)
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
    out <- x$attributes
    class(out) <- x$class
    return(out)
  })
  return(out_list)
}
