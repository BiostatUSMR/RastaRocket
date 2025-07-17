#' Prepare a Data Frame for Summarization with Custom Missing Data Handling and Factor Ordering
#'
#' This function prepares a data frame for summarization by handling missing data 
#' based on the `show_missing_data` argument and applying the specified data manipulation 
#' (DM) option to factor variables. It provides flexibility for data cleaning and ordering 
#' before summarizing with functions like `gtsummary`.
#'
#' @param data1 A data frame containing the data to be prepared.
#' @param drop_levels Boolean (default = TRUE). Drop unused levels.
#' @param freq_relevel Boolean  (default = FALSE). Reorder factors by frequency.
#' @param var_group The group variable (used to correctly update the label if needed).
#' @return A data frame that has been prepared based on the `show_missing_data` and `DM` arguments. 
#'         The function modifies the input data frame by applying labels, ordering factor variables, 
#'         and potentially dropping unused levels.
#'
#' @details
#' - The `DM` option defines the data manipulation to be applied to factor variables:
#'   - `"tout"`: Both order factor levels and drop unused levels.
#'   - `"tri"`: Only order factor levels.
#'   - `"remove"`: Drop unused factor levels without ordering.
#'
#' @examples
#' # Example usage with the iris dataset
#' prepare_table(iris)
#'
#' @import dplyr
#' @import Descusmr
#' @import forcats
#' @export
prepare_table <- function(data1,
                          var_group = NULL,
                          drop_levels = TRUE,
                          freq_relevel = FALSE){
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