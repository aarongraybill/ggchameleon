#' Show the philly color pallete, or basically any color pallette
#' Stolen from scales::show_col with the modification to allow for named color lists
#' @export

show_colors <-
  function (colours=c(the$main_palette,the$accent_palette), labels = TRUE, borders = NULL, cex_label = 1,
          ncol = NULL){
    if (is.null(names(colours))){scales::show_col(colours=colours,labels=labels,borders=borders,cex_label = cex_label,ncol=ncol)}
  n <- length(colours)
  ncol <- ceiling(sqrt(length(colours)))
  nrow <- ceiling(n/ncol)
  color_names=names(colours)
  nas=(ncol*nrow)-length(colours)
  color_names=c(color_names,rep(NA,nas))
  if (is.list(colours)){colours <- unlist(colours)}
  colours <- c(colours, rep(NA, nas))
  colours <- matrix(colours, ncol = ncol, byrow = TRUE)
  old <- par(pty = "s", mar = c(0, 0, 0, 0))
  on.exit(par(old))
  size <- max(dim(colours))
  plot(c(0, size), c(0, -size), type = "n", xlab = "", ylab = "",
       axes = FALSE)
  rect(col(colours) - 1, -row(colours) + 1, col(colours),
       -row(colours), col = colours, border = borders)
  if (labels) {
    if (is.null(color_names)){
    print("I don't think you have names")
    hcl <- farver::decode_colour(colours, "rgb", "hcl")
    label_col <- ifelse(hcl[, "l"] > 50, "black", "white")
    text(col(colours) - 0.5, -row(colours) + 0.5, colours,
         cex = cex_label, col = label_col)
    }
    else {
      hcl <- farver::decode_colour(colours, "rgb", "hcl")
      label_col <- ifelse(hcl[, "l"] > 50, "black", "white")
      text(col(colours) - 0.5, -row(colours) + 0.5, labels={matrix(color_names,nrow=nrow,byrow = T)},
           cex = cex_label, col = label_col)
      }
    }
  }
