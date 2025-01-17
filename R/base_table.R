#' Create a Summary Table with Grouping and Custom Formatting
#'
#' This function generates a summary table from a data frame with specified 
#' grouping and variable types. It uses the `gtsummary` package to create 
#' descriptive statistics for categorical and continuous variables, with 
#' options for customizing the rounding and labels.
#'
#' @param data1 A data frame containing the data to summarize.
#' @param var_group A string or NULL, the variable to group by (optional). 
#'        If NULL, no grouping will be applied.
#' @param group_title A string, the title for the grouping variable. 
#'        If an empty string is provided, the `var_group` will be used as the title.
#' @param quali A character vector, the names of categorical variables to 
#'        treat as categorical in the summary table.
#' @param quanti A character vector, the names of continuous variables to 
#'        treat as continuous in the summary table.
#' @param round_quanti An integer, the number of decimal places to round 
#'        continuous variables (quantitative) in the summary table.
#' @param round_quali An integer, the number of decimal places to round 
#'        categorical variables (qualitative) in the summary table.
#'
#' @return A `gtsummary` table summarizing the specified variables, 
#'         grouped by `var_group` if provided, with customizable statistics 
#'         and rounding options.
#'
#' @examples
#' # Example usage with the iris dataset
#' base_table(iris, var_group = "Species", group_title = "The Species")
#'
#' @import gtsummary
#' @import dplyr
#' @import rlang
#' @export
base_table <- function(data1,
                       var_group,
                       group_title,
                       quali = NULL,
                       quanti = NULL,
                       round_quanti = 1,
                       round_quali = 1){
  
  if(is.null(var_group)){
    col_1 <- NULL
  } else {
    col_1 <- rlang::ensym(var_group)
    
    if(group_title == ""){
      group_title <- var_group
    }
    
  }
  
  base_table <- data1 %>%
    gtsummary::tbl_summary(
      type = list(
        where(is.factor) ~ "categorical",
        ## type des var (qualitatives)
        gtsummary::all_continuous() ~ "continuous2",
        ## type des var (continus)
        quali ~ "categorical",
        quanti ~ "continuous2"
      ),
      by = !!col_1,
      ## Pour degrouper les tables
      missing = "no",
      ## Ne pas afficher les NA
      statistic = list(
        gtsummary::all_continuous2() ~ c("{mean} ({sd})", "{median} ({p25} ; {p75})","{min} ; {max}"),
        ## Stat à afficher pour les VAR (quantitatives)
        gtsummary::all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (categorielles)
      ),
      digits = list(gtsummary::all_continuous() ~ round_quanti, gtsummary::all_categorical() ~ round_quali) ## le nbre de décimale pour les variables.
    ) %>%
    gtsummary::bold_labels()  ## Variables en gras.
  
  return(base_table)
}