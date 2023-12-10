test_that("output length is correct", {
  expect_length(
    validate_colors(c("#FF00FF","firebrick")),
    2
  )
})

test_that("colors are correctly detected",{
  cols <-
    c('red',
      'notred',
      '#FF00FF',
      'FF00FF',
      '#0F0',
      'transparent')
  expect_equal(validate_colors(cols),
               c(TRUE,FALSE,TRUE,FALSE,FALSE,TRUE))
})
