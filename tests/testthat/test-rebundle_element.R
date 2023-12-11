test_that("element_blank() is supported", {
  expect_no_error(
    rebundle_element(c('text'=element_blank()))
    )
})
