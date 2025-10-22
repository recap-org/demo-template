#' Save a figure to file
#' 
#' Saves figures to the assets/figures directory as a pdf, with sensible defaults
#' 
#' @param name The desired filename, without the .pdf extension
#' @param width Output width; defaults to 6.2 inches, the textwidth of ./tex/article; passed on to ggplot2::ggsave
#' @param height Output height; passed on to ggplot2::ggsave
#' @param units The unit in which width and height are to be provided; passed on to ggplot2::ggsave

save_figure <- function(name, width = 6.2, height = 4, units = "in") {
  ggsave(
      paste0("./assets/figures/", name, ".pdf"),
      width = width,
      height = height,
      units = units
  )
}

#' Save a table to file
#' 
#' Saves tinytable objects to the assets/tables directory as a .tex
#' 
#' @param x A tinytable object
#' @param name The desired filename, without the .tex extension
#' @param table Should the output be wrapped within the LaTeX table environment (default is FALSE) 

save_table <- function(x, name, table = FALSE) {
    tex <- tinytable::save_tt(x, output = "latex")
    if(!table) {
        tex <- sub("\\begin{table}\n\\centering\n", "", tex, fixed = TRUE)
        tex <- sub("\n\\end{table}", "", tex, fixed = T)
    }
    writeLines(
        tex, 
        paste0("./assets/tables/", name, ".tex")
    )
}