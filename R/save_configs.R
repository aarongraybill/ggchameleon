#' Save stylistic configurations to a file for later use
#'
#' If you are happy with your current chart style, and you wish to use it again
#' in the future, you can save the current state of the ggchameleon
#' configurations to a file on your machine using `save_configs()`. By default,
#' this creates a file called `chameleon.yml` in your working directory which
#' stores the fonts, colors, and [ggplot2::theme()] modifications you have made.
#' After you end your R session, you can reload these stylings using the
#' [load_configs()] function.
#'
#' By default, `save_configs()` creates a file named `chameleon.yml` in your
#' current working directory. If you are using an R project (ie if you have a
#' `.Rproj` file), then your working directory is likely wherever the `.Rproj`
#' located. When ggchameleon is loaded, it automatically looks for this
#' `chameleon.yml` file in your working directory, and if it finds it, it will
#' automatically apply those configurations. This is convenient because whenever
#' you start a new R session and re-run any code with ggplot2, it will
#' automatically start using whatever you have saved.
#'
#' @param file A file path ending in `".yml"`. Defaults to `"chameleon.yml"`.
#' @param overwrite A boolean. Whether or not to overwrite `file` if it exists.
#'   Defaults to `FALSE`. When `FALSE`, `file` will have random characters
#'   appended to the end of the name to disambiguate.
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
save_configs <- function(file="chameleon.yml",overwrite=FALSE){

  yml_exists <- file.exists(file)

  # We don't care about what theme the user had prior
  # to using ggchameleon
  to_write <- as.list(the)[names(the)!='old_theme']

  # Convert gg theme to yaml friendly list
  to_write[['theme']] <- theme_to_list(to_write[['theme']])

  if (!yml_exists){
    yaml::write_yaml(to_write,file)
    message("Configurations saved to \"",file,"\".")
  } else if (!overwrite){
    parent_dir <- dirname(file)
    file_name <- tools::file_path_sans_ext(basename(file)) |> paste0("_")
    new_file <- tempfile(file_name,tmpdir = parent_dir,fileext = '.yml')
    yaml::write_yaml(to_write,new_file)
    message(paste0("The file \"",file,"\" exists, saving as: \"", new_file,
                   "\".\nConsider renaming this to something more relevant."))
  } else {
    yaml::write_yaml(to_write,file)
    message("Configurations overwritten at \"",file,"\".")
  }
}
