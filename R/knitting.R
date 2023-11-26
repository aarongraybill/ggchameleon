# Custom Knit function for RStudio
knit_with_chameleon <- function(input, ...) {
  # Get default parameters specified by rmarkdown::render
  default_args <- formals(rmarkdown::render)

  # Get any parameters we overwrote
  current_args <- list(...)

  # Current args are the defaults when not specified otherwise
  current_args <- modifyList(default_args, current_args)

  input_lines <- rmarkdown:::read_utf8(input)
  output_format <- rmarkdown:::output_format_from_yaml_front_matter(input_lines, current_args$output_options, current_args$output_format, current_args$output_yaml, current_args$output_file)

  if (isFALSE(output_format$options$self_contained)){
    stop("ggchameleon automatic theming is incompatible with non-self-contained output")
  }

  # Here's where we inject ggchameleon custom theming

  # if css isn't defined, that's okay we just concatenate a null
  tf_css <- tempfile()
  make_css(tf_css)
  output_format$options$css <-
    output_format$options$css <- c(output_format$options$css,tf_css)

  # Same thing to ovverwrite html header to get google fonts
  tf_html <- tempfile()
  make_html_header(tf_html)
  output_format$options$includes$in_header <- c(output_format$options$includes$in_header,tf_html)

  # Basically pass control back to rmarkdown
  output_format <- rmarkdown:::create_output_format(output_format$name,
                                        output_format$options)
  do.call(rmarkdown::render,args = c('input'=input,'output_format'=list(output_format),current_args[!grepl('output_format|input',names(current_args))]))
}
