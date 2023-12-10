test_that("the has expected top level names", {
  expect_setequal(
    names(the),
    c("accent_palette","theme","main_palette","fonts","old_theme")
  )
})

test_that("the main palette has expected names", {
  expect_setequal(
    names(the$main_palette),
    c("main","secondary","white","off_white","black","contrast","intermediate")
  )
})

test_that("the fonts have expected names", {
  expect_setequal(
    names(the$fonts),
    c("mono","sans","serif","display")
  )
})


test_that("Main colors Can be edited by color name",{
  test_color <- "magenta"

  colors_in <- the$main_palette

  edit_the_main_palette(
    main = test_color
  )

  expect_equal(the$main_palette$main,test_color)

  # Reset to original configs
  edit_the_main_palette(main = colors_in$main)
})

test_that("Main colors Can be edited by hex",{
  test_color <- "#FF00FF"

  colors_in <- the$main_palette

  edit_the_main_palette(
    main = test_color
  )

  expect_equal(the$main_palette$main,test_color)

  # Reset to original configs
  edit_the_main_palette(main = colors_in$main)
})

test_that("Accent colors can be replaced",{
  test_colors <- c("black","white","red","blue")

  colors_in <- the$accent_palette

  edit_the_accent_palette(
    test_colors
  )

  expect_setequal(the$accent_palette,test_colors)

  # Reset to original configs
  edit_the_accent_palette(colors_in)
})

test_that("Accent colors can be appended",{
  test_colors <- c("black",'white')

  colors_in <- the$accent_palette

  edit_the_accent_palette(
    test_colors,
    mode = "append"
  )

  expect_true(all(test_colors%in%the$accent_palette))

  # Reset to original configs
  edit_the_accent_palette(colors_in)
})

test_that("Warning given with few accent colors",{
  test_colors <- c("red","blue")

  colors_in <- the$accent_palette

  expect_warning(edit_the_accent_palette(test_colors),'Fewer than four accent')

  # Reset to original configs
  edit_the_accent_palette(colors_in)
})
