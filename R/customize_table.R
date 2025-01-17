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
#' @param group A string specifying the group to display. If `"ALL"`, an overall column 
#'        summarizing all groups will be added.
#' @param show_missing_data A boolean indicating whether to display missing data counts 
#'        and percentages in the table. If `TRUE`, columns for missing data will be added.
#' @param show_n_per_group A boolean indicating whether to display group sizes (n) for 
#'        each level of the grouping variable. If `NULL`, it defaults to `TRUE` when 
#'        `var_group` is `NULL`.
#' @param group_title A string specifying the title for the group column in the table.
#' @param table_title A string specifying the title of the entire table.
#' @param var_title A string specifying the title for the variable column in the table.
#'
#' @return A customized `gtsummary` table object with added columns, headers, captions, 
#'         and modifications based on the provided arguments.
#'
#' @details
#' - If `group` is `"ALL"` and `var_group` is not `NULL`, an additional "Total" column 
#'   summarizing all groups will be added.
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
#'   group = "ALL",
#'   show_missing_data = TRUE,
#'   show_n_per_group = FALSE,
#'   group_title = "Treatment Group",
#'   table_title = "Summary Statistics",
#'   var_title = "Variables"
#' )
#'
#' @import gtsummary
#' @import dplyr
#' @export
customize_table <- function(base_table,
                            var_group,
                            group,
                            show_missing_data,
                            show_n_per_group,
                            group_title,
                            table_title,
                            var_title){
  ### Add Overall column if specified
  if(!is.null(var_group) & group == "ALL"){
    base_table <- base_table %>%
      gtsummary::add_overall(col_label = "**Total**")
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
  
  ls_modify_header <- list(
    label ~ paste0("**",var_title,"**"),
    ## Titre des variables du tableau.
    starts_with("add_n_stat") ~ ""
  )
  
  if(show_missing_data){
    ls_modify_header[[length(ls_modify_header) + 1]] <- n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
  } else {
    ls_modify_header[[length(ls_modify_header) + 1]] <- n ~  "**Total**" ## labels des Stat des NA.
  }
  
  if(is.null(show_n_per_group)){
    show_n_per_group = is.null(var_group)
  }
  
  if(!show_n_per_group){
    ls_modify_header[[length(ls_modify_header) + 1]] <- gtsummary::all_stat_cols() ~ "**{level}**"
    # ls_modify_header[[length(ls_modify_header) + 1]] <- stat_0 ~ ""
  }
  
  base_table_missing <- base_table_missing %>%
    gtsummary::modify_header(ls_modify_header) %>%
    gtsummary::modify_table_body(~ modify_table_body_func(.)) %>%  ## Appel de la fonction externe pour modifier le corps du tableau
    gtsummary::modify_footnote(everything() ~ NA) ## Note de page.
  
  if(!is.null(var_group)){
    base_table_missing <- base_table_missing %>%
      gtsummary::modify_spanning_header(c(gtsummary::all_stat_cols(F) ~ paste0("**",group_title,"**")))
  }
  
  res <- base_table_missing %>%
    gtsummary::modify_caption(paste0("**",table_title,"**")) %>%
    gtsummary::bold_labels() ## Titre pour la table.
  
  return(res)
}