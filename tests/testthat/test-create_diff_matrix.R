test_that("column names are handled",{
  pal <- c("black","gray","white")
  pal_names <- c("a","b","c")
  names(pal) <- pal_names

  m <- create_diff_matrix(pal)

  expect_equal(pal_names,colnames(m))
})

test_that("row names are handled",{
  pal <- c("black","gray","white")
  pal_names <- c("a","b","c")
  names(pal) <- pal_names

  m <- create_diff_matrix(pal)

  expect_equal(pal_names,rownames(m))
})

test_that("values are sensible",{
  pal <- c("black","white","red","#FF00FF")

  m <- create_diff_matrix(pal)
  m <- round(m,0)

  expected <-
    matrix(
    c(0,100,50,57,
      100,0,46,42,
      50,46,0,43,
      57,42,43,0),
    nrow = 4
  )

  expect_equal(m,expected)
})

