
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggchameleon <img src="man/figures/logo.svg" align="right" height="139"/>

<!-- badges: start -->
<!-- badges: end -->

ggchameleon allows you to write standard
[ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)
syntax while automatically theming your plots with user-specified or
algorithmically determined colors and fonts. ggchameleon balances
unobtrusiveness with reproducibility, allowing the user to save a
`chameleon.yml` file which stores customized ggplot theming without
requiring the user to write extra code to fetch this theming.

## Installation

You can install the development version of ggchameleon from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("aarongraybill/ggchameleon")
```

## Design Principle

ggchameleon gets its name from two key design principles:

1.  The chameleon’s ability to change colors at will
2.  The chameleon’s ability to blend into the background of its
    environment.

On the color changing side, ggcchameleon allows the user to flexibly
change theme elements (color, font, size of lines, etc.). ggchameleon is
written to make these changes reproducible and easy to access with the
`save_current_theme` function.

However, much a like a real chameleon in dense rain forest foliage,
ggchameleon is very hard to spot in your code! ggchameleon both reduces
boilerplate and maintains compatability with standard `ggplot2`. In
fact, when used as intended, the only place ggchameleon appears in your
scripts is `library(ggchameleon)`. All of the theming is loaded on
startup from your configurations or the package defaults. If you were to
remove the `library(ggchameleon)` at the beginning of your code, you
would produce plots with exactly the same information, now in the
default ggplot theme.

## Basic Usage

First, here’s the look of a standard ggplot:

``` r
library(ggplot2)
library(dplyr)

d <- diamonds |> slice_sample(n = 100)
p <- ggplot(d) +
  geom_point(aes(x = carat, y = price, color = price)) +
  ggtitle("My Cool & Informative Plot",
          subtitle = "With an even cooler subtitle!")
p
```

<img src="man/figures/README-example-1.png" width="100%" />

Now, if we load the ggchameleon package we can immediately see a change
in how the plot looks:

``` r
library(ggchameleon)
p
```

<img src="man/figures/README-add_ggchameleon-1.png" width="100%" />

But the real magic of ggchameleon comes when we wish to alter the
default ggchameleon parameters:

``` r
edit_the_main_palette(intermediate = "darkgreen")
p
```

<img src="man/figures/README-altering_ggchameleon-1.png" width="100%" />

Notice that without having to specify a different
`scale_color_continuous`, we were able to drastically change the colors
of the legend. This is where ggchameleon does the heavy lifting. It
finds the parts of your theme that use the `intermediate` color and
updates all such instances to use the new color.

``` r
edit_the_fonts(sans="Creepster")
p
```

<img src="man/figures/README-editing fonts-1.png" width="100%" />

We can also edit elements of the theme that we apply to each plot by
default, for example:

``` r
edit_the_theme(legend.position = "bottom",
                             legend.direction = "horizontal")

p
```

<img src="man/figures/README-editing_theme-1.png" width="100%" />

As you can see, it does not take very much work to make a very
customized, but very ugly theme! If we wish to burn our current theme to
the ground and start anew, ggchameleon provides two useful functions:

``` r
huemint_randomize(auto_accept = TRUE)
#> Palette ovweritten.
```

<img src="man/figures/README-huemint_and_font_shuffle-1.png" width="100%" />

``` r

p
```

<img src="man/figures/README-huemint_and_font_shuffle-2.png" width="100%" />

## Wrapping Up For Next Time

Now that we’ve edited the theming to our heart’s content, we can save
these modifications for next time we use this project. If we run the
following, we will save a file, `chameleon.yml` which will be
automatically applied the next time we load this project and use
`library(ggchameleon)`.

``` r
save_configs()
```
