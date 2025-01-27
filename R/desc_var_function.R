
#' Generate Descriptive Tables for Variables
#'
#' This function creates descriptive tables for variables in a dataset. It can handle qualitative and quantitative variables, grouped or ungrouped, and supports multiple configurations for handling missing data (DM).
#'
#' @param data1 A data frame containing the dataset to be analyzed.
#' @param table_title A character string specifying the title of the table.
#' @param quali A vector of qualitative variables to be described. Defaults to `NULL`.
#' @param quanti A vector of quantitative variables to be described. Defaults to `NULL`.
#' @param group A logical value or character string indicating whether the variables should be grouped. Options:
#'   - `"ALL"`: Grouped by all levels of `var_group`.
#'   - `TRUE`: Grouped by `var_group`.
#'   - `FALSE`: Not grouped.
#' @param var_title A character string for the title of the variable column in the table. Defaults to `"Variable"`.
#' @param var_group A variable used for grouping (if applicable). Defaults to `NULL`.
#' @param group_title A character string specifying the title for the grouping variable.
#' @param round_quanti An integer vector specifying the number of decimal places for quantitative variables. Defaults to `c(1)`.
#' @param round_quali An integer vector specifying the number of decimal places for qualitative variables. Defaults to `c(0, 1)`.
#' @param DM A character string controlling the handling of missing data. Options:
#'   - `"tout"`: Keep all variables and drop unused levels of factors.
#'   - `"tri"`: Retain only variables with at least three levels.
#'   - `"remove"`: Remove missing levels from factors.
#'   - `"NULL"`: No special handling of missing data.
#' @param tests A value in order to add p value. Defaut to `FALSE` OPTION :
#'   - `FALSE`: No p-value add
#'   - `TRUE`: Add p-value made by default by gtsummary. See gtsummary add_p() options.
#'   - `list()`: To force tests. See gtsummary add_p() options.
#' @param show_n_per_group Default to `FALSE`. Should the 'N' appears in the column header of the groups. Can be either :
#'   - `FALSE`: No 'N' is shown
#'   - `TRUE`: 'N' is shown
#' @param show_missing_data Default to `NULL`. Should the missing data be displayed. Can be either :
#'   - `FALSE`: No missing data displayed
#'   - `TRUE`: Missing data displayed
#'   - `NULL` (default): will be switch to `anyNA(data1)` value.
#'
#' @details
#' The function processes the dataset according to the specified parameters and generates descriptive tables.
#' - It first uses the `ajouter_label_ndm()` function to append missing data statistics to variable labels.
#' - Depending on the `group` and `DM` arguments, it adjusts the dataset and creates tables using helper functions like `desc_group`, `desc_degroup`, and `desc_degroup_group`.
#' - Qualitative variables are reordered, and unused levels are dropped when necessary.
#'
#' @return A gtsummary table object containing the descriptive statistics.
#'
#' @examples
#' # Example usage:
#' library(dplyr)
#'
#' # Sample dataset
#' data1 <- data.frame(
#'   group = c("A", "B", "A", "C"),
#'   var1 = c(1, 2, 3, NA),
#'   var2 = c("X", "Y", "X", NA)
#' )
#'
#' # Generate descriptive table
#' table <- desc_var(
#'   data1 = data1,
#'   table_title = "Descriptive Table",
#'   group = FALSE,
#'   group_title = "Group",
#'   DM = "tout"
#' )
#'
#' @importFrom dplyr mutate across where
#' @importFrom forcats fct_drop
#' @importFrom tidyr drop_na
#' @importFrom gtsummary tbl_summary
#' @import cardx
#' @export

# data1 = iris
# table_title = ""
# quali = NULL
# quanti = NULL
# group = "ALL"
# var_title = "Variable"
# var_group = "Species" ## Variable de groupe (dégroupée les tables)
# group_title = "Speciesss"
# round_quanti = c(1)
# round_quali = c(0,1)
# DM = "NULL"
# tests = FALSE
# show_missing_data = FALSE
# show_n_per_group = TRUE

desc_var <- ## Les arugments de la fonction
  function(data1,
           ##  Jeux de données numéro 1.
           table_title = "",
           ## Titre de la table
           quali = NULL,
           ## Vecteur des variables quali ~tatives mal decrites
           quanti = NULL,
           ## Vecteur des variables quantitatives mal decrites
           group,
           var_title = "Variable",
           ## booléen pour préciser s'il faut degroupé ou pas les tables.
           var_group = NULL, ## Variable de groupe (dégroupée les tables)
           group_title = "",
           round_quanti = c(1),
           round_quali = c(0,1),
           DM = "NULL",
           tests = FALSE,
           show_n_per_group = FALSE,
           show_missing_data = NULL) {
    
    ### Add labels
    if(is.null(show_missing_data)){
      show_missing_data <- anyNA(data1)
    }
    
    data1 <- prepare_table(data1 = data1,
                           show_missing_data = show_missing_data,
                           DM = DM)
    
    base_table <- base_table(data1 = data1,
                             var_group = var_group,
                             group_title = group_title,
                             quali = quali,
                             quanti = quanti,
                             round_quanti = round_quanti,
                             round_quali = round_quali)
    
    res <- customize_table(base_table = base_table,
                           var_group = var_group,
                           group = group,
                           show_missing_data = show_missing_data,
                           show_n_per_group = show_n_per_group,
                           group_title = group_title,
                           table_title = table_title,
                           var_title = var_title)
    
    # Add tests tests 
    if (is.list(tests)) {
      res <- res %>%
        gtsummary::add_p(test = tests) %>%
        gtsummary::separate_p_footnotes()
    } else if (isTRUE(tests)) {
      res <- res %>%
        gtsummary::add_p() %>%
        gtsummary::separate_p_footnotes()
    }

    return(res)
    
  }


  
