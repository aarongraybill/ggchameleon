# Takes yml input and converts it to usable ggplot::theme arguments
rebundle_element <- function(named_list){

  if (length(named_list)==1){return(named_list)}

  # Element Arguments minus the alternate spelling of color
  text_args <- setdiff(methods::formalArgs(ggplot2::element_text),"color")
  rect_args <- setdiff(methods::formalArgs(ggplot2::element_rect),"color")
  line_args <- setdiff(methods::formalArgs(ggplot2::element_line),"color")

  # Test which element arguments the input list matches
  if (setequal(names(named_list),text_args)){
    rlang::exec(ggplot2::element_text,!!!named_list)
  } else if (setequal(names(named_list),rect_args)){
    rlang::exec(ggplot2::element_rect,!!!named_list)
  } else if (setequal(names(named_list),line_args)){
    rlang::exec(ggplot2::element_line,!!!named_list)
  } else{
    stop("Improperly Formatted Element in Configuration File")
  }
}
