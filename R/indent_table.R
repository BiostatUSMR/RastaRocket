#' Text indentation for `gtsummary` tables
#'
#' @param g_table A `gt` table object
#' @param indent A numeric value corresponding to value as pixels, specifying text indentation (default = 0). Value can be 0, 1 or 2 (0 ~ px(0); 1 ~ px(30); 2 ~ px(60))
#'
#' @returns A `gt` table object with indentation applied.
#' @export
#'
#' @examples
#' tbl_bis <- RastaRocket::desc_var(
#' iris,
#' table_title = "test",
#' quali = "Species")
#'
#' tbl_bis |> indent_table(indent = 1)
#' tbl_bis |> indent_table(indent = 2)
#'
indent_table <- function(g_table, indent = 0){

  indent = dplyr::case_when(
    indent == 0 ~ px(0),
    indent == 1 ~ px(30),
    indent == 2 ~ px(60),
    .default = as.character(indent)
  )

  # Convert gtsummary table to gt table
  if("gtsummary" %in% class(g_table)){
    g_table <- gtsummary::as_gt(g_table)
  }
  # indent the “label” columns (gtsummary tables))
  g_table <- g_table |>
    tab_style(
      style = cell_text(indent = indent),
      locations = cells_body(columns = label))


  return(g_table)
}
