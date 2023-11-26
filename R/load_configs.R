#' Load stylistic configurations from a file
#'
#' If you have saved a configurations file using [save_configs()], you may
#' wish to load those configurations at a later date. `load_configs` parses
#' these configuration files and automatically updates your current ggchameleon
#' instance so that future charts will have these new configurations applied.
#' When `library(ggchameleon)` is called for the first time, `load_configs`
#' looks for a file called `chameleon.yml` and loads the configurations stored
#' there (the default location of [save_configs()]). If you have a
#' different configuration file that you would like to load, then you can
#' specify that with the `file` argument.
#'
#' When loading a configuration file, `load_configs` edits the contents of [the]
#' using functions like [edit_the_fonts()]. The `chameleon.yml` file is intended
#' to be placed at the same level as your working .Rproj file. This way, all of
#' the charts in this project will have a cohesive style without you having to
#' specify this style across the multiple files in your project.
#'
#' @param config Within `file`, which configuration to use. Defaults to
#'   `"default"`. Useful if multiple versions of the same theme are stored in
#'   one configuration file.
#' @param file A .yml file. The configuration file to load. Should be created by
#'   [save_configs()]. Defaults to `chameleon.yml`.
#'
#' @export
load_configs <- function(config = "default",file="chameleon.yml") {
  if (file.exists(file)){
    configs <- config::get(config = config,file=file)
    rlang::exec("edit_the_main_palette",!!!configs$main_palette)
    rlang::exec("edit_the_accent_palette",!!!configs$accent_palette)
    rlang::exec("edit_the_fonts",!!!configs$fonts)
    rlang::exec("edit_the_theme",!!!configs$theme)
  } else if (file!="chameleon.yml"){
    message(paste0("File \"",file,"\" not found. Resorting to existing. configs."))
  } else{
    # Default config file and not found, must not be using configs
    # Do nothing
  }
}
