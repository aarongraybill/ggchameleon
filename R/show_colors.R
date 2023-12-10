#' Show a list of colors and their names
#'
#' `show_colors()` is a modified version of [scales::show_col()] that
#' incorporates the names of colors into a tile grid of colors. This is useful
#' to quickly see if a set of colors works well together. When called with no
#' arguments, `show_colors` will create a plot containing with all of the colors
#' stored in the ggchameleon current configuration, stored in [the].
#' Alternately, if the `colours` argument is specified, an arbitrary vector of
#' colors can be shown.
#'
#' @param colours A named or unnamed vector of colors. Defaults to the colors
#'   currently stored in [the].
#' @param labels A boolean. Include color names (when named) or color codes
#'   (when unnamed)? Defaults to `TRUE`.
#' @param borders The color of the border around each color tile. Defaults to
#'   the value of `par("fg")` (likely `"black"`).
#' @param cex_label Size of printed labels, as multiplier of default size.
#' @param ncol Number of columns. If not supplied, tries to be as square as
#'   possible.
#'
#' @examples
#' # Show the colors currently stored in `the`.
#' show_colors()
#'
#' # Show a custom vector of colors, some named, some unnamed.
#' # Only named colored are labeled.
#' show_colors(c("my_black"="#000000","#FF00FF","maroon"))
#'
#' # If no names are specified, then the
#' # strings representing the colors are shown.
#' show_colors(c("black","#888888","white"))
#'
#' @export

show_colors <-
  function (colours=c(the$main_palette,the$accent_palette), labels = TRUE, borders = NULL, cex_label = 1,
          ncol = NULL){
    colours <- unlist(colours)
    if (is.null(names(colours))){
      scales::show_col(colours=colours,labels=labels,borders=borders,cex_label = cex_label,ncol=ncol)
      invisible()
      } else{
    n <- length(colours)
    ncol <- ceiling(sqrt(length(colours)))
    nrow <- ceiling(n/ncol)
    color_names=names(colours)
    nas=(ncol*nrow)-length(colours)
    color_names=c(color_names,rep(NA,nas))
    if (is.list(colours)){colours <- unlist(colours)}
    colours <- c(colours, rep(NA, nas))
    colours <- matrix(colours, ncol = ncol, byrow = TRUE)
    old <- graphics::par(pty = "s", mar = c(0, 0, 0, 0))
    on.exit(graphics::par(old))
    size <- max(dim(colours))
    plot(c(0, size), c(0, -size), type = "n", xlab = "", ylab = "",
         axes = FALSE)
    graphics::rect(col(colours) - 1, -row(colours) + 1, col(colours),
         -row(colours), col = colours, border = borders)
    if (labels) {
      if (is.null(color_names)){
      print("I don't think you have names")
      hcl <- farver::decode_colour(colours, "rgb", "hcl")
      label_col <- ifelse(hcl[, "l"] > 50, "black", "white")
      graphics::text(col(colours) - 0.5, -row(colours) + 0.5, colours,
           cex = cex_label, col = label_col)
      }
      else {
        hcl <- farver::decode_colour(colours, "rgb", "hcl")
        label_col <- ifelse(hcl[, "l"] > 50, "black", "white")
        graphics::text(col(colours) - 0.5, -row(colours) + 0.5, labels={matrix(color_names,nrow=nrow,byrow = T)},
             cex = cex_label, col = label_col)
        }
      }
    }
  }
