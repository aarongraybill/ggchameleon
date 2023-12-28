.onLoad <- function(libname, pkgname) {
  # Capture Current Options Before Loading:
  the$old_theme <- ggplot2::theme_get()
  scales_to_check <-  c(
    "ggplot2.discrete.colour",
    "ggplot2.continuous.colour",
    "ggplot2.binned.colour",
    "ggplot2.discrete.fill",
    "ggplot2.continuous.fill",
    "ggplot2.binned.fill",
    "ggplot2.ordinal.colour",
    "ggplot2.ordinal.fill"
  )
  the$old_scales <- rlang::exec(options, !!!scales_to_check)
  geom_names <- getNamespaceExports("ggplot2")
  geom_names <- geom_names[grepl("^Geom",geom_names)]
  the$old_geoms <-
    lapply(geom_names,
           function(x) {
             get(x, envir = getNamespace("ggplot2"))$default_aes
           })
  names(the$old_geoms) <- geom_names

  showtext::showtext_auto()
  load_configs()
  refresh_theming()
  #pad_accent_palette(10)
  # if (length(the$accent_palette)<10){
  #   edit_the_accent_palette(pad_accent_palette(10),mode = 'append')
  # }
}

.onUnload <- function(libname,pkgname) {
  ggplot2::theme_set(the$old_theme)
  rlang::exec(options,!!!the$old_scales)
  mapply(function(n,x){
    geom_name <- gsub("^Geom","",n)
    ggplot2::update_geom_defaults(geom_name,x)
  },
  names(the$old_geoms),the$old_geoms)
}
