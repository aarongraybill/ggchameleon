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

test_that("Nonexistent fonts give an error",{
  expect_error(edit_the_fonts(sans="MrTambourineMan"),
               "The font: \"MrTambourineMan\" could not be found")
})

test_that("Nonexistent fonts don't change any fonts",{
  old_fonts <- the$fonts
  tryCatch(edit_the_fonts(display='Lobster',sans="MrTambourineMan"),
           error = function(x){NULL})
  expect_equal(the$fonts,old_fonts)
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

test_that("invalid main colors are errored",{
  expect_error(
    edit_the_main_palette(main="not a real color"),
    "not a real color"
  )
})

test_that("invalid main colors do not take effect",{

  old_main <- the$main_palette
  tryCatch(
    edit_the_main_palette(main="red",secondary="not a real color"),
    error = function(e){NULL}
  )

  expect_equal(old_main,the$main_palette)
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

test_that("invalid accent colors are errored",{
  expect_error(
    edit_the_accent_palette("not a real color"),
    "not a real color"
  )
})

test_that("invalid accent colors do not take effect",{

  old_accent <- the$accent_palette
  tryCatch(
    edit_the_accent_palette("red","not a real color"),
    error = function(e){NULL}
  )

  expect_equal(old_accent,the$accent_palette)
})


test_that("the fonts can be swapped locally",{
  in_font <- the$fonts$display

  edit_the_fonts(display="Atkinson Hyperlegible")
  expect_equal(the$fonts$display,"Atkinson Hyperlegible")

  edit_the_fonts(display = in_font)

})

test_that("the fonts can be added from remote",{
  in_font <- the$fonts$display

  edit_the_fonts(display="Lobster")
  expect_equal(the$fonts$display,"Lobster")

  edit_the_fonts(display = in_font)
})

test_that("bad theme arguments message",{
  expect_message(edit_the_theme(not_an_argument="doesn't matter"),"are not valid")
})

test_that("theme arguments with strings can be edited",{
  old_theme <- ggplot2::theme_get()

  edit_the_theme(legend.position='bottom')

  expect_equal(theme_get()$legend.position,'bottom')

  edit_the_theme(legend.position = old_theme$legend.position)
})

test_that("theme arguments with elements can be edited",{
  old_theme <- ggplot2::theme_get()

  edit_the_theme(text = element_text(angle = 45))

  expect_equal(theme_get()$text$angle,45)

  edit_the_theme(text = old_theme$text)
})
