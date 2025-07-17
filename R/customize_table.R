#' Customize a Summary Table with Grouping, Missing Data, and Custom Titles
#'
#' This function customizes a `gtsummary` summary table by adding an overall column, 
#' handling missing data, applying group-specific statistics, and updating headers 
#' and captions. It provides flexible options for grouping, displaying missing data, 
#' and customizing table titles.
#'
#' @param base_table A `gtsummary` table object, typically generated using functions 
#'        like `gtsummary::tbl_summary`.
#' @param var_group A string or NULL, specifying the variable used for grouping in the 
#'        table. If `NULL`, no group-specific modifications are applied.
#' @param add_total A boolean to add total column or not when var_group is specified.
#' @param show_missing_data A boolean indicating whether to display missing data counts 
#'        and percentages in the table. If `TRUE`, columns for missing data will be added.
#' @param show_n_per_group A boolean indicating whether to display group sizes (n) for 
#'        each level of the grouping variable.
#' @param group_title A string specifying the title for the group column in the table.
#' @param table_title A string specifying the title of the entire table.
#' @param var_title A string specifying the title for the variable column in the table.
#' @param var_tot A string specifying the name of total column.
#'
#' @return A customized `gtsummary` table object with added columns, headers, captions, 
#'         and modifications based on the provided arguments.
#'
#' @details
#' - The `show_missing_data` parameter determines whether missing data counts and 
#'   percentages are displayed:
#'   - If `TRUE`, missing data columns are added.
#'   - If `FALSE`, only non-missing data counts are displayed.
#' - Headers for columns and spanning headers are customized using the `group_title`, 
#'   `table_title`, and `var_title` arguments.
#' - An external function `modify_table_body_func` is called to further modify 
#'   the table body.
#'
#' @examples
#' # Example usage with a sample gtsummary table
#' library(gtsummary)
#' base_table <- trial %>%
#'   tbl_summary(by = "trt", missing = "no")
#' 
#' customize_table(
#'   base_table,
#'   var_group = "trt",
#'   add_total = TRUE,
#'   show_missing_data = TRUE,
#'   show_n_per_group = FALSE,
#'   group_title = "Treatment Group",
#'   table_title = "Summary Statistics",
#'   var_title = "Variables",
#'   var_tot = "Total"
#' )
#'
#' @import gtsummary
#' @import dplyr
#' @export
customize_table <- function(base_table,
                            var_group,
                            add_total,
                            show_missing_data,
                            show_n_per_group,
                            group_title,
                            table_title,
                            var_title, 
                            var_tot){
  ### Add Overall column if specified
  if(!is.null(var_group) & add_total){
    base_table <- base_table %>%
      gtsummary::add_overall(col_label = var_tot)
  }
  
  ### Add missing values
  if(show_missing_data){
    base_table_missing <- base_table %>%
      gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)")
  } else {
    base_table_missing <- base_table %>%
      gtsummary::add_n("{N_nonmiss}", col_label = "**N**")
  }
  
  if(!is.null(var_group)){
    if(show_missing_data){
      base_table_missing <- base_table_missing %>%
        gtsummary::add_stat(fns = everything() ~ add_by_n) ## Stat en colonnes (Total et données manquantes)
    } else {
      base_table_missing <- base_table_missing %>%
        gtsummary::add_stat(fns = everything() ~ add_by_n_noNA) ## Stat en colonnes (Total et données manquantes)
    }
  }
  
  base_table_missing_2 <- base_table_missing %>%
    gtsummary::modify_table_body(~ modify_table_body_func(.)) %>%  ## Appel de la fonction externe pour modifier le corps du tableau
    gtsummary::modify_footnote(everything() ~ NA) ## Note de page.

  ### header
  if(show_missing_data){
    base_table_missing_3 <- base_table_missing_2 |> 
      gtsummary::modify_header(all_stat_cols() ~ "**{level}** <br> n (dm ; %dm)",
                               label = "**Variable**" )
  } else {
    base_table_missing_3 <- base_table_missing_2 |> 
      gtsummary::modify_header(all_stat_cols() ~ "**{level}**",
                               label = "**Variable**" )
  }
  
  ### spanning header
  if(!is.null(var_group)){
    
    if(is.null(group_title)){
      group_title <- labelled::get_variable_labels(base_table$inputs$data)[[var_group]]
      
      if(is.null(group_title)){
        group_title <- var_group
      }
    }
    
    base_table_missing_3 <- base_table_missing_3 %>%
      gtsummary::modify_spanning_header(c(gtsummary::all_stat_cols(F) ~ paste0("**",group_title,"**")))
  }
  
  res <- base_table_missing_3 %>%
    gtsummary::modify_caption(paste0("**",table_title,"**")) %>%
    gtsummary::bold_labels() ## Titre pour la table.
  
  return(res)
}