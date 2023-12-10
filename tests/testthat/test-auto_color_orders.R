test_that("Discrete Colors are Different", {
  expect_false(any(duplicated(gen_palette(15))))
})

test_that("Discrete Colors Return expected first colors",{
  expect_equal(
    gen_palette(2),
    c(the$main_palette$main,the$main_palette$secondary)
  )
})

test_that("Discrete Colors Have the correct length",{
  n=10
  expect_length(
    gen_palette(n),
    n
  )
})

# Continuous Color Gradient
test_that("Luminance is Linear",{
  n = 100
  cols <- custom_viridis_palette()(0:n/n)
  luminance <- farver::decode_colour(cols,to='lab')[,'l']
  diffs = luminance[2:(n+1)]-luminance[1:(n)]

  # The gradient has a linear change in luminance
  # if the difference between each successive
  # luminance is the same. As such, we see how close
  # each entry is to the first entry. If it's approximately
  # close, we say it's linear.
  expect_equal(diffs,rep(diffs[1],n),tolerance = .5)
})

test_that("Gradient edges match default colors",{
  n = 100
  cols <- custom_viridis_palette()(0:n/n)

  # The order of the colors might be different (depending on which is darker)
  # So we should really test for set equality
  expect_setequal(
    cols[c(1,n+1)],
    c(the$main_palette$main,the$main_palette$contrast)
    )
})

test_that("Gradient gets close to intermediate",{
  n=100
  cols <- custom_viridis_palette()(0:n/n) |> farver::decode_colour()
  target <- the$main_palette$intermediate |> farver::decode_colour()

  dists <- farver::compare_colour(from = cols,
                                 to = target,
                                 from_space = "rgb",
                                 to_space = "rgb",
                                 method = "cie2000")

  # The minimal distance should be less than 1
  expect_lt(min(dists),1)
})

# Now test the smart_interpolate version of the same things
# Continuous Color Gradient
test_that("Luminance is Linear",{
  n = 100
  cols <- smart_interpolate()(0:n/n)
  luminance <- farver::decode_colour(cols,to='lab')[,'l']
  diffs = luminance[2:(n+1)]-luminance[1:(n)]

  # The gradient has a linear change in luminance
  # if the difference between each successive
  # luminance is the same. As such, we see how close
  # each entry is to the first entry. If it's approximately
  # close, we say it's linear.
  expect_equal(diffs,rep(diffs[1],n),tolerance = .5)
})

test_that("Gradient edges match default colors",{
  n = 100
  cols <- smart_interpolate()(0:n/n)

  # The order of the colors might be different (depending on which is darker)
  # So we should really test for set equality
  expect_setequal(
    cols[c(1,n+1)],
    c(the$main_palette$main,the$main_palette$contrast)
  )
})

test_that("Gradient gets close to intermediate",{
  n=100
  cols <- smart_interpolate()(0:n/n) |> farver::decode_colour()
  target <- the$main_palette$intermediate |> farver::decode_colour()

  dists <- farver::compare_colour(from = cols,
                                  to = target,
                                  from_space = "rgb",
                                  to_space = "rgb",
                                  method = "cie2000")

  # The minimal distance should be less than 1
  expect_lt(min(dists),1)
})

test_that("Discrete Gradient is expected length",{
  n=5
  expect_length(custom_discrete_viridis_palette(n),n)
})

test_that("Discrete Gradient has expected edges",{
  n=5
  cols <- custom_discrete_viridis_palette(5)
  expect_setequal(
    cols[c(1,n)],
    c(the$main_palette$main,the$main_palette$contrast)
  )
})
