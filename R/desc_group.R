#' Description of summary tables with data management
#'
#' This function generates a statistical summary table for both categorical
#' and continuous variables using the `gtsummary` package. It formats and displays
#' statistics for the given variables, allowing for customized rounding and other
#' formatting options.
#'
#' @param data1 Dataframe. The input data to generate the summary table.
#' @param table_title Character. Title of the table (default: "").
#' @param quali Character vector. A vector containing the names of the qualitative
#'   variables to describe (default: NULL).
#' @param quanti Character vector. A vector containing the names of the quantitative
#'   variables to describe (default: NULL).
#' @param round_quanti Numeric vector. Number of decimal places for quantitative
#'   variables (default: 1).
#' @param round_quali Numeric vector. Number of decimal places for qualitative variables
#'   (default: c(0, 1)).
#' @param var_title Character. Title of the variable column in the table (default: "Variable").
#'
#' @return A `gtsummary` object representing the summary table.
#'
#' @details
#' - Categorical variables are displayed with statistics such as `{n} ({p}%)`.
#' - Continuous variables are displayed with statistics such as `{mean} ({sd})`,
#'   `{min} ; {max}`, and `{median} ({p25}; {p75})`.
#' - The table is formatted with bold labels for variables and italicized levels for
#'   the categories.
#' - Missing data is excluded from the summary (`missing = "no"`).
#' - The total column is labeled as "**TOTAL** (n={N})".
#' - The footnotes are removed from the table using `modify_footnote`.
#'
#' @examples
#' # Example usage:
#' data <- data.frame(
#'   group = c("A", "B", "A", "B"),
#'   gender = factor(c("Male", "Female", "Female", "Male")),
#'   age = c(34, 29, 45, 36)
#' )
#' desc_group(
#'   data1 = data,
#'   table_title = "Descriptive Table",
#'   quali = c("gender"),
#'   quanti = c("age"),
#'   var_title = "Variable"
#' )
#'
#' @import dplyr
#' @import gtsummary
#' @importFrom rlang ensym
#' @export



desc_group <- function(data1,
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






