#' Modify gtsummary table headers and add a spanning header
#'
#' This function customizes the column headers, optional spanning header, and table caption
#' for a `gtsummary` table. It supports adding a feature name, total label, group title, and
#' formats missing data presentation.
#'
#' @param base_table_missing A `gtsummary` table object (typically output from previous steps).
#' @param var_characteristic Optional. A string to label the features column.
#' @param show_missing_data Logical. If `TRUE`, adds missing data info to column headers.
#' @param var_tot Optional. A string to label the total column.
#' @param var_group Optional. Name of a grouping variable for adding a spanning header.
#' @param group_title Optional. Title for the spanning header. If `NULL`, uses the variable label or name.
#' @param table_title Title for the entire table.
#'
#' @return A `gtsummary` table object with updated headers, spanning header, and caption.
#' @export
custom_headers <- function(base_table_missing,
                           var_characteristic = NULL,
                           show_missing_data = TRUE,
                           var_tot = NULL,
                           var_group = NULL,
                           group_title = NULL,
                           table_title) {
  # Set feature column header
  if (!is.null(var_characteristic)) {
    base_table_missing <- base_table_missing |>
      gtsummary::modify_header(label = paste0("**", var_characteristic, "**"))
  }
  
  # Define missing suffix
  if (show_missing_data) {
    missing_suffix <- " <br><span style='font-size:80%'>n (dm ; %dm)</span>"
  } else {
    missing_suffix <- ""
  }
  
  # Set stats columns header
  base_table_missing <- base_table_missing |>
    gtsummary::modify_header(gtsummary::all_stat_cols() ~ paste0("**{level}**", missing_suffix))
  
  # Set total column header
  if (!is.null(var_tot)) {
    base_table_missing <- base_table_missing |>
      gtsummary::modify_header(stat_0 = paste0("**", var_tot, "**", missing_suffix))
  }
  
  # Add spanning header if grouping variable is provided
  if (!is.null(var_group)) {
    if (is.null(group_title)) {
      group_title <- labelled::get_variable_labels(base_table_missing$inputs$data)[[var_group]]
      if (is.null(group_title)) {
        group_title <- var_group
      }
    }
    
    base_table_missing <- base_table_missing %>%
      gtsummary::modify_spanning_header(
        c(gtsummary::all_stat_cols(FALSE) ~ paste0("**", group_title, "**"))
      )
  }
  
  # Finalize table: caption and bold labels
  res <- base_table_missing %>%
    gtsummary::modify_caption(paste0("**", table_title, "**")) %>%
    gtsummary::bold_labels()
  
  return(res)
}
