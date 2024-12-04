
#' Create a Summary Table for Ungrouped Descriptive Statistics
#'
#' This function generates a summary table of descriptive statistics for a dataset, focusing on both
#' categorical and continuous variables. Unlike `desc_true`, this function does not include grouping.
#' It provides options to customize the table's title and variable labels.
#'
#' @param data1 A data frame containing the dataset to summarize.
#' @param table_title A character string specifying the title of the table (default: `""`).
#' @param quali A vector of qualitative variables to include in the summary. These are variables that require
#' additional description, often due to poor definition (default: `NULL`).
#' @param quanti A vector of quantitative variables to include in the summary (default: `NULL`).
#' @param var_title A character string specifying the column header for variables in the table (default: `"Variable"`).
#'
#' @details
#' The function uses the `gtsummary` package to compute and format descriptive statistics:
#' - Categorical variables are summarized with counts and percentages.
#' - Continuous variables are summarized with the mean, standard deviation, minimum, maximum, median,
#' and interquartile range.
#' - Missing data statistics are added, and the table includes custom formatting, such as bolded labels
#' for variable names and italicized levels for categorical variables.
#'
#' The table can also include a count of non-missing values and missing value statistics.
#'
#' **Key Customizations:**
#' - Variables are displayed in bold.
#' - NA values are excluded from the summary statistics.
#' - Statistical formatting is applied, with specific decimal precision for both continuous and categorical variables.
#'
#' @return A `gtsummary` object representing the formatted summary table.
#'
#' @examples
#' # Example usage:
#' library(gtsummary)
#' data(mtcars)
#' desc_table <- desc_false(
#'   data1 = mtcars,
#'   table_title = "Descriptive Statistics of mtcars Dataset",
#'   quali = c("cyl", "gear"),
#'   quanti = c("mpg", "disp", "hp"),
#'   var_title = "Variable Name"
#' )
#'
#' desc_table
#'
#' @import dplyr
#' @importFrom gtsummary tbl_summary bold_labels italicize_levels add_n modify_header modify_caption
#' @export



desc_false <- function(data1,
                       table_title = "",
                       ## Titre de la table
                       quali = NULL,
                       ## Vecteur des variables quali ~tatives mal decrites
                       quanti = NULL,
                       round_quanti = c(1),
                       round_quali = c(0,1),
                       var_title = "Variable") {


  desc_degrou <- data1 %>% gtsummary::tbl_summary(
    type = list(
      ## Traitement des variables par type.
      where(is.factor) ~ "categorical",
      ## type des var (qualitatives)
      all_continuous() ~ "continuous2",
      ## type des var (continues)
      quali ~  "categorical",
      quanti ~ "continuous2"
    ),
    missing = "no",
    ## Ne pas afficher les NA
    statistic = list(
      all_continuous2() ~ c("{mean} ({sd})", "{min} ; {max}", "{median} ({p25};{p75})"),
      ## Stat à afficher pour les VAR (quantitatives)
      all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (qualitatives)
    ),
    digits = list(all_continuous() ~ round_quanti, all_categorical() ~  round_quali)## Nbre de décimales pour les variables.
  ) %>%
    gtsummary::bold_labels() %>%  ## Variables en gras
    gtsummary::italicize_levels() %>%  ## modalités en italique
    gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
    gtsummary::modify_header(list(
      label  ~ paste0("**", var_title, "**"),
      ## Titre des variables du tableaux.
      stat_0 ~ "**TOTAL** (n={N})",
      ## label des Totals.
      n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
    )) %>%
    gtsummary::modify_table_body( ~ customize_table_body(.)) %>%
    gtsummary::modify_footnote(everything() ~ NA) %>%
    gtsummary::modify_caption(paste0("**", table_title, "**")) %>%
    gtsummary::bold_labels()


}






