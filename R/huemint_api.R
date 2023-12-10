#' Randomize colors to a (usually) pleasant palette
#'
#' @description `huemint_randomize` *overwrites* the existing colors in [the]
#' (the environment that stores your current configurations).
#' `huemint_randomize` leverages [https://huemint.com/](https://huemint.com/) to
#' generate the new color palette. Huemint uses machine learning to create color
#' palettes that are novel and appealing. You can read more about that process
#' at [https://huemint.com/about/](https://huemint.com/about/).
#'
#' `huemint_randomize` imposes further restrictions on the generated palette---
#' requiring certain colors to be more and less differentiable. For example the
#' generated black should look very different from the generated white.
#'
#' @param auto_accept A boolean. Whether or not to accept the new colors without
#'   user confirmation. Defaults to `FALSE`.
#'
#' @param show_colors A boolean. Whether or not to preview the new palette.
#'   Defaults to `TRUE`.
#'
#' @export
huemint_randomize <- function(auto_accept = FALSE, show_colors = TRUE){

  # You can't provide consent without seeing the palette
  if (!auto_accept & !show_colors){
    message("The option \u0145auto_accept = FALSE\u0146 requires that you preview",
            " the colors to make your selection.",
            " As such, the option \u0145show_colors = TRUE\u0146 will be enabled.")
    show_colors <- TRUE
  }

  if (!curl::has_internet()) {
    warning("No internet connection, keeping existing colors palettes")
    return(NULL)
  }

  custom_specs <-
    matrix(data = 0,nrow = 7,ncol=7)
  custom_specs[1,2] <- 50 # Main and secondary should be diffable
  custom_specs[1,3] <- 80 # Main should not be white
  custom_specs[1,5] <- 50 # Main should not be black
  custom_specs[1,6] <- 75 # Main should be quite different from contrast
  custom_specs[1,7] <- 50 # Main should be somewhat close to intermediate
  custom_specs[2,3] <- 80 # Secondary should not be white
  custom_specs[2,5] <- 50 # Secondary should not be black
  custom_specs[3,4] <- 5  # Off white should be near white
  custom_specs[3,5] <- 95 # White should not be black
  custom_specs[3,6] <- 20 # White should be close but not too close to contrast
  custom_specs[4,5] <- 95 # Off white should not be black
  custom_specs[6,7] <- 50 # Contrast should be somewhat close to intermediate
  custom_specs <- custom_specs + t(custom_specs)


  main_palette_payload <-
    list(
      mode = "transformer",
      num_colors = 7,
      temperature = "1.5",
      num_results = 10,
      adjacency = custom_specs |> as.character(), #the$main_palette |> create_diff_matrix() |> round() |> as.character(),
      palette = c("-","-","#FFFFFF","-","-","-","-")
    )

  accent_palette_payload <- function(main,secondary){
    list(
      mode = "transformer",
      num_colors = 7,
      temperature = "1.5",
      num_results = 1,
      adjacency = matrix("50",nrow=7,ncol=7) |> as.character(),
      palette = c(main,secondary,"-","-","-","-","-")
    )
  }

  result <- httr::POST("https://api.huemint.com/color",
                 body = main_palette_payload,
                 httr::add_headers(.headers = c("Content-Type"="application/json")),
                 encode = "json")
  out <- httr::content(result)
  custom_specs[custom_specs==0] <- NA
  scores <- lapply(out$results,function(x){mean((create_diff_matrix(x$palette)-custom_specs)^2,na.rm=T)})

  main_palette_edits <- out$results[[which.min(scores)]]$palette
  names(main_palette_edits) <- c("main","secondary","white","off_white","black","contrast","intermediate")

  result <- httr::POST("https://api.huemint.com/color",
                 body = accent_palette_payload(the$main_palette$main,the$main_palette$secondary),
                 httr::add_headers(.headers = c("Content-Type"="application/json")),
                 encode = "json")
  out <- httr::content(result)
  new_accents <- out$results[[1]]$palette[-c(1:2)]
  names(new_accents) <- paste0("accent_",1:length(new_accents))

  if (show_colors) show_colors(c(main_palette_edits,new_accents))

  if (auto_accept){
    message("Palette ovweritten.")
    rlang::exec(edit_the_main_palette,!!!main_palette_edits)
    rlang::exec(edit_the_accent_palette,!!!new_accents)
  } else {

    prompt_text <-
      paste("Accept the preview theme?",
            "This will overwrite your existing theme (which may not be saved).",
            "\nPlease Enter a Number.",
            sep = " ")

    response <- utils::menu(choices = c("Yes","No"),title = prompt_text)

    if (response==0){
      message("Choice aborted, keeping existing palette.")
    } else if(response==1){
      message("Palette ovweritten.")
      rlang::exec(edit_the_main_palette,!!!main_palette_edits)
      rlang::exec(edit_the_accent_palette,!!!new_accents)
    } else {
      message("Keeping existing palette.")
    }

  }



}
