test_that("themes can be converted to lists", {
  l <-
    theme_to_list(
      ggplot2::theme(
        line = ggplot2::element_blank(),
        legend.position = "none",
        text = ggplot2::element_text(angle = 45)
      )
    )

  expected <-
    list(
      line = list(class = c("element_blank","element"),
                  attributes = list()),
      text = list(class = c("element_text","element"),
                  attributes = list(
                    family = NULL,
                    face = NULL,
                    colour = NULL,
                    size = NULL,
                    hjust = NULL,
                    vjust = NULL,
                    angle = 45,
                    lineheight = NULL,
                    margin = NULL,
                    debug = NULL,
                    inherit.blank = FALSE
                  )),
      legend.position = list(class = "character",
                             attributes = list("none"))
    )

  expect_equal(l,expected)
})

test_that("lists can be converted to themes", {

   t <-
    list(
      line = list(class = c("element_blank","element"),
                  attributes = list()),
      text = list(class = c("element_text","element"),
                  attributes = list(
                    family = NULL,
                    face = NULL,
                    colour = NULL,
                    size = NULL,
                    hjust = NULL,
                    vjust = NULL,
                    angle = 45,
                    lineheight = NULL,
                    margin = NULL,
                    debug = NULL,
                    inherit.blank = FALSE
                  )),
      legend.position = list(class = "character",
                             attributes = list("none"))
    ) |>
    list_to_theme()

   t <- rlang::exec(ggplot2::theme,!!!t)

   expected <-
       ggplot2::theme(line = ggplot2::element_blank(),
                      legend.position = "none",
                      text = ggplot2::element_text(angle = 45))

  expect_equal(t,expected)
})
