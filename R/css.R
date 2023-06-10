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
    'h1,h2',
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
