make_css <- function(file_name){
  tableHTML::make_css(
    list(
      'p',
      c(
        'color',
        'font-family'
      ),
      c(
        the$main_palette$black,
        the$fonts$sans
      )
    ),
  list(
    'h1,h2,h3,h4,h5,h6',
    c(
      'color',
      'font-family'
    ),
    c(
      the$main_palette$main,
      the$fonts$display
    )
  ),
  list(
    'a',
    c('color'),
    c(the$main_palette$intermediate)
  ),
  list(
    'a:hover',
    c('color'),
    c(the$main_palette$intermediate)
  ),
  list(
    'code',
    c('font-family'),
    c(the$fonts$mono)
  ),
  list(
    'pre',
    c('background-color',
      'border-color'),
    c(smart_interpolate(c(the$main_palette$black,the$main_palette$off_white,the$main_palette$white))(.95),
      #slightly darker than off white for border
      smart_interpolate(c(the$main_palette$black,the$main_palette$off_white,the$main_palette$white))(.7)
      )
  ),
  # Bullets:
  list(
    "ul",
    c("font-family"),
    c(the$fonts$sans)
  ),
  # Numbered List:
  list(
    "ol",
    c("font-family"),
    c(the$fonts$sans)
  ),
  # Catchall other non-specified text:
  list(
    "html, body",
    c("font-family"),
    c(the$fonts$sans)
  ),
  file = file_name
  )
}

make_html_header <- function(file_name){
  l1 <- "<link rel=\"preconnect\" href=\"https://fonts.googleapis.com\">"
  l2 <- "<link rel=\"preconnect\" href=\"https://fonts.gstatic.com\" crossorigin>"
  families <- paste0('family=',gsub(' ','\\+',the$fonts),collapse = "&")
  l3 <- glue::glue("<link href=\"https://fonts.googleapis.com/css2?{families}&display=swap\" rel=\"stylesheet\">")
  htmltools::HTML(paste0(c(l1,l2,l3),collapse = '\n')) |> writeLines(con = file_name)

}
