legend_bottom <-
  function(){
    theme(
      legend.justification = "center",
      legend.direction = "horizontal",
      legend.position = "bottom"
    )
  }

legend_right <-
  function(){
    theme(
      legend.justification = "center",
      legend.direction = "vertical",
      legend.position = "right"
    )
  }

scales_smoosh_continuous <-
  function(){
    scale_x_continuous(expand = c(0,0))+
      scale_y_continuous(expand=c(0,0))
  }

scales_smoosh_discrete <-
  function(){
    scale_x_discrete(expand = c(0,0))+
      scale_y_discrete(expand=c(0,0))
  }
