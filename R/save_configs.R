#' Title
#'
#' @param file
#'
#' @return
#' @export
#'
#' @examples
save_configs <- function(file="chameleon.yml"){
  if (!requireNamespace("config", quietly = TRUE)) {
    stop(
      "Package \"config\" must be installed to use this function.",
      call. = FALSE
    )
  }

  while (file.exists(file)){
    new_file <- tempfile("chameleon_",tmpdir = "",fileext = ".yml")
    new_file <- substr(new_file,2,nchar(new_file))
    message(paste0("\"",file,"\" exists, saving as: \"", new_file,
                   "\"\nConsider Renaming the File to Something More Relevant"))
    file <- new_file
  }
  yaml::write_yaml(list(default = as.list(the)),file)
}
