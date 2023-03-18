parse_configs <- function(config = "default",file="gigiConfig.yml") {
  if (!requireNamespace("config", quietly = TRUE)) {
    stop(
      "Package \"config\" must be installed to use this function.",
      call. = FALSE
    )
  }
  if (file.exists(file)){
    configs <- config::get(config = config,file=file)
    rlang::exec("edit_the_main_palette",!!!configs$main_palette)
    rlang::exec("edit_the_accent_palette",!!!configs$accent_palette)
    rlang::exec("edit_the_fonts",!!!configs$fonts)
  } else if (file!="gigiConfig.yml"){
    message(paste0("File \"",file,"\" not found. Resorting to existing. configs."))
  } else{
    # Default config file and not found, must not be using configs
    # Do nothing
  }
}
