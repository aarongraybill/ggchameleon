theme_custom <-
  function (base_size = 11,
            base_family = "",
            base_line_size = base_size / 22,
            base_rect_size = base_size / 22) {

    working_fonts <-
      ifelse(the$fonts%in%sysfonts::font_families(),the$fonts,"") |>
      as.list()
    names(working_fonts) <- names(the$fonts)
    t <-
      ggplot2::theme_bw(base_size, base_family, base_line_size, base_rect_size) +
      ggplot2::theme(
        # geometric elements ----
        line = ggplot2::element_line(color=the$main_palette$black),
        panel.border = ggplot2::element_rect(color = the$main_palette$white),
        axis.line = ggplot2::element_line(color = the$main_palette$black),
        axis.ticks.length = ggplot2::unit(base_size/3, "pt"),
        panel.grid.major.y = ggplot2::element_line(
          linetype = "dashed",
          color = the$main_palette$off_white),
        panel.grid.minor.y = ggplot2::element_line(
          linetype = "dashed",
          linewidth = base_line_size / 2,
          color = the$main_palette$off_white
        ),
        panel.grid.major.x = ggplot2::element_blank(),
        panel.grid.minor.x = ggplot2::element_blank(),
        strip.background = ggplot2::element_rect(fill=the$main_palette$off_white),
        # Begin dealing with text ----
        text = ggplot2::element_text(family=working_fonts$sans,colour = the$main_palette$black),
        plot.title = ggplot2::element_text(color=the$main_palette$main,face="bold",hjust=0,family=working_fonts$display),
        plot.subtitle = ggplot2::element_text(hjust=0,face="bold.italic"),
        plot.caption = ggplot2::element_text(family=working_fonts$sans,face="italic",hjust=0,color=the$main_palette$black),
        axis.text = ggplot2::element_text(colour = the$main_palette$black),
        # Legend Positioning: ----
        legend.position = c(0,1),
        legend.justification = c(0,1),
        legend.background = ggplot2::element_rect(fill = "#FF00FF00",colour = "#FF00FF00"),
        legend.key = ggplot2::element_rect(fill = "#FF00FF00",colour = "#FF00FF00"),
        legend.direction = "vertical",
        legend.box = "horizontal"
      )
    return(t)
  }

