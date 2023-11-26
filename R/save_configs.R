#' Save stylistic configurations to a file for later use
#'
#' If you are happy with your current chart style, and you wish to use it again
#' in the future, you can save the current state of the ggchameleon
#' configurations to a file on your machine using `save_configs()`. By default,
#' this creates a file called `chameleon.yml` which stores the fonts, colors,
#' and [ggplot2::theme()] modifications you have made. After you end your R
#' session, you can reload these stylings using the [load_configs()] function.
#'
#' By default, `save_configs()` creates a file named `chameleon.yml` in your current working directory.
#' If you are using an R project (ie if you have a `.Rproj` file), then your working directory is
#' likely wherever the `.Rproj` located. When ggchameleon is loaded, it automatically looks for
#' this `chameleon.yml` file, and if it finds it, it will automatically apply those
#' configurations. This is convenient because whenever you re-run any code with
#' ggplot2, it will automatically start using whatever you have saved.
#'
#' @param file A file path ending in `".yml"`. Defaults to `"chameleon.yml"`.
#'
#' @examples
#'
#' # Save the configs file to the default location
#' save_configs()
#'
#' # save the configs to a different file name
#' save_configs("my_different_configs.yml")
#'
#' @export
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
