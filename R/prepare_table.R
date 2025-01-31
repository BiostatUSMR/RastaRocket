#' Prepare a Data Frame for Summarization with Custom Missing Data Handling and Factor Ordering
#'
#' This function prepares a data frame for summarization by handling missing data 
#' based on the `show_missing_data` argument and applying the specified data manipulation 
#' (DM) option to factor variables. It provides flexibility for data cleaning and ordering 
#' before summarizing with functions like `gtsummary`.
#'
#' @param data1 A data frame containing the data to be prepared.
#' @param show_missing_data A boolean indicating whether missing data should be shown in the table. 
#'        If `NULL`, it will be automatically determined based on the presence of missing data in `data1`.
#'        Defaults to `TRUE` if any missing values are detected.
#' @param drop_levels Boolean (default = TRUE). Drop unused levels.
#' @param freq_relevel Boolean  (default = FALSE). Reorder factors by frequency.
#' @param var_group The group variable (used to correctly update the label if needed).
#' @return A data frame that has been prepared based on the `show_missing_data` and `DM` arguments. 
#'         The function modifies the input data frame by applying labels, ordering factor variables, 
#'         and potentially dropping unused levels.
#'
#' @details
#' - If `show_missing_data` is set to `TRUE` or `NULL` (default behavior), the function will apply labels 
#'   for missing data to the variables in the data.
#' - If `show_missing_data` is set to `FALSE`, the function will display a warning if missing data is present.
#' - The `DM` option defines the data manipulation to be applied to factor variables:
#'   - `"tout"`: Both order factor levels and drop unused levels.
#'   - `"tri"`: Only order factor levels.
#'   - `"remove"`: Drop unused factor levels without ordering.
#'
#' @examples
#' # Example usage with the iris dataset
#' prepare_table(iris, show_missing_data = TRUE)
#'
#' @import dplyr
#' @import Descusmr
#' @import forcats
#' @export
prepare_table <- function(data1,
                          show_missing_data,
                          var_group = NULL,
                          drop_levels = TRUE,
                          freq_relevel = FALSE){
  if(show_missing_data){
    data1 <- data1 %>% Descusmr::ajouter_label_ndm(col_to_skip = var_group)
  } else {
    if(anyNA(data1)){
      warning("You ask not to show missing data but some are present in data1, be careful")
    }
  }
  
  ### Apply DM option
  if(freq_relevel){
    data1 <- ordonner_variables_qualitatives(data1)
  }
  
  if(drop_levels){
    data1 <- data1 %>%
      dplyr::mutate(across(where(is.factor),~ forcats::fct_drop(.)))
  }
  
  return(data1)
}