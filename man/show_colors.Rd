% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/show_colors.R
\name{show_colors}
\alias{show_colors}
\title{Show a list of colors and their names}
\usage{
show_colors(
  colours = c(the$main_palette, the$accent_palette),
  labels = TRUE,
  borders = NULL,
  cex_label = 1,
  ncol = NULL
)
}
\arguments{
\item{colours}{A named or unnamed vector of colors. Defaults to the colors
currently stored in \link{the}.}

\item{labels}{A boolean. Include color names (when named) or color codes
(when unnamed)? Defaults to \code{TRUE}.}

\item{borders}{The color of the border around each color tile. Defaults to
the value of \code{par("fg")} (likely \code{"black"}).}

\item{cex_label}{Size of printed labels, as multiplier of default size.}

\item{ncol}{Number of columns. If not supplied, tries to be as square as
possible.}
}
\description{
\code{show_colors()} is a modified version of \code{\link[scales:show_col]{scales::show_col()}} that
incorporates the names of colors into a tile grid of colors. This is useful
to quickly see if a set of colors works well together. When called with no
arguments, \code{show_colors} will create a plot containing with all of the colors
stored in the ggchameleon current configuration, stored in \link{the}.
Alternately, if the \code{colours} argument is specified, an arbitrary vector of
colors can be shown.
}
\examples{
# Show the colors currently stored in `the`.
show_colors()

# Show a custom vector of colors, some named, some unnamed.
# Only named colored are labeled.
show_colors(c("my_black"="#000000","#FF00FF","maroon"))

# If no names are specified, then the
# strings representing the colors are shown.
show_colors(c("black","#888888","white"))

}
