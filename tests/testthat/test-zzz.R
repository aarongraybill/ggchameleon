test_that(".onAttach captures theme", {
  expect_equal(the$old_theme, ggplot2::theme_gray())
})

test_that(".onAttach captures geoms", {
  expect_equal(the$old_geoms$GeomPoint,
               ggplot2::aes(
                 shape = 19,
                 colour = "black",
                 size = 1.5,
                 fill = NA,
                 alpha = NA,
                 stroke = 0.5
               ))
})

test_that(".onAttach captures scales", {
  expect_null(the$old_scales$ggplot2.discrete.colour)
})

test_that(".onUnload resets theme",{
  cur_theme <- ggplot2::theme_get()
  edit_the_theme(legend.position="bottom")
  .onUnload()
  expect_equal(
    ggplot2::theme_get()$legend.position,
    "right"
  )
  edit_the_theme(cur_theme)
})

test_that(".onUnload resets geoms",{
  .onUnload()
  expect_equal(
    GeomBar$default_aes$fill,
    "grey35"
  )
  refresh_theming()
})

test_that(".onUnload resets scales",{
  .onUnload()
  expect_equal(
    options("ggplot2.continuous.fill"),
    list("ggplot2.continuous.fill"=NULL)
  )
  refresh_theming()
})
