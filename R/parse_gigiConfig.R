parse_configs <- function(config = "default",file="gigiConfig.yml") {
  if (!requireNamespace("config", quietly = TRUE)) {
    stop(
      "Package \"config\" must be installed to use this function.",
      call. = FALSE
    )
  }
  configs <- config::get(config = config,file=file)
  rlang::exec("edit_the_main_palette",!!!configs$main_palette)
  rlang::exec("edit_the_accent_palette",!!!configs$accent_palette)
  rlang::exec("edit_the_fonts",!!!configs$fonts)
}
