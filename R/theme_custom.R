#' Add Custom Theme to a ggplot
#'
#' @description This function is used exactly like a regular ggplot2 theme object. It can be added to a ggplot to change the stylistic elements of a plot
#' @param base_size base font size
#' @param base_family base font family, defaults to COMPLETE THIS
#' @param base_line_size bae size for line elements
#' @param base_rect_size base size for rect elements
#' @return A ggplot2 theme object used to update a ggplot2 plot.
#' @details You cannot directly edit any other theme elements. This function returns a complete theme, and if you wish to further modify you should use the ggplot2::theme() command
#' @export
#'
theme_custom <-
  function (base_size = 11,
            base_family = "",
            base_line_size = base_size / 22,
            base_rect_size = base_size / 22) {
    library(ggplot2)
    t <-
      theme_bw(base_size, base_family, base_line_size, base_rect_size) +
      theme(
        # geometric elements ----
        line = element_line(color=the$main_palette$black),
        panel.border = element_rect(color = the$main_palette$white),
        axis.line = element_line(color = the$main_palette$black),
        axis.ticks.length = unit(base_size/3, "pt"),
        panel.grid.major.y = element_line(
          linetype = "dashed",
          color = the$main_palette$off_white),
        panel.grid.minor.y = element_line(
          linetype = "dashed",
          size = base_line_size / 2,
          color = the$main_palette$off_white
        ),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        strip.background = element_rect(fill=the$main_palette$off_white),
        # Begin dealing with text ----
        text = element_text(family=the$fonts$sans),
        plot.title = element_text(color=the$main_palette$main,face="bold",hjust=0),
        plot.subtitle = element_text(hjust=0,family=the$fonts$display,face="bold.italic"),
        plot.caption = element_text(family=the$fonts$sans,face="italic",hjust=0,color=the$main_palette$black),
        # Legend Positioning: ----
        legend.position = c(0,1),
        legend.justification = c(0,1),
        legend.background = element_rect(fill = "#FF00FF00",colour = "#FF00FF00"),
        legend.key = element_rect(fill = "#FF00FF00",colour = "#FF00FF00"),
        legend.direction = "vertical",
        legend.box = "horizontal"
      )
    return(t)
  }

