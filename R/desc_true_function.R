
#' Create a Summary Table for Descriptive Statistics
#'
#' This function generates a summary table of descriptive statistics for the given dataset,
#' tailored for both categorical and continuous variables. It allows grouping and provides
#' options to customize table titles, variable labels, and grouping headers.
#'
#' @param data1 A data frame containing the dataset to summarize.
#' @param table_title A character string specifying the title of the table (default: `""`).
#' @param quali A vector of qualitative variables to include in the summary. These should be poorly described variables to prioritize for better description (default: `NULL`).
#' @param quanti A vector of quantitative variables to include in the summary (default: `NULL`).
#' @param var_title A character string specifying the column header for variables in the table (default: `"Variable"`).
#' @param var_group A grouping variable to segment the table by. It must be a column in `data1` (default: `NULL`).
#' @param group_title A character string specifying the header for the group variable in the table (default: `""`).
#'
#' @details
#' The function uses the `gtsummary` package to generate descriptive statistics.
#' - Categorical variables are summarized using counts and percentages.
#' - Continuous variables are summarized with the mean, standard deviation, minimum, maximum, median, and interquartile range.
#' - Missing data statistics are added as a separate column, and formatting is applied to emphasize key elements (e.g., bold variable labels, italicized levels).
#'
#' It supports additional customization options such as hiding NA values, controlling the number of decimal places, and adding headers or captions.
#'
#' @return A `gtsummary` object representing the formatted summary table.
#'
#' @examples
#' # Example usage:
#' library(gtsummary)
#' data(mtcars)
#' desc_table <- desc_true(
#'   data1 = mtcars,
#'   table_title = "Descriptive Statistics of mtcars Dataset",
#'   quali = c("cyl", "gear"),
#'   quanti = c("mpg", "disp", "hp"),
#'   var_title = "Variable Name",
#'   var_group = "cyl",
#'   group_title = "Cylinders"
#' )
#'
#' desc_table
#'
#' @import dplyr
#' @importFrom gtsummary tbl_summary bold_labels italicize_levels add_n modify_header modify_caption
#' @export



desc_true <- function (data1,
                       table_title = "",
                       ## Titre de la table
                       quali = NULL,
                       ## Vecteur des variables quali ~tatives mal decrites
                       quanti = NULL,
                       round_quanti = c(1),
                       round_quali = c(0,1),
                       var_title = "Variable",
                       var_group = NULL,
                       group_title = "") {

  col_1 <- rlang::ensym(var_group)




  desc_degrou <-
    data1 %>%
    gtsummary::tbl_summary(
      type = list(
        where(is.factor) ~ "categorical",
        ## type des var (qualitatives)
        all_continuous() ~ "continuous2",
        ## type des var (continus)
        quali ~ "categorical",
        quanti ~ "continuous2"
      ),
      by = !!col_1,
      ## Pour degrouper les tables
      missing = "no",
      ## Ne pas afficher les NA
      statistic = list(
        all_continuous2() ~ c("{mean} ({sd})", "{min} ; {max}", "{median} ({p25};{p75})"),
        ## Stat à afficher pour les VAR (quantitatives)
        all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (categorielles)
      ),
      digits = list(all_continuous() ~ round_quanti, all_categorical() ~ round_quali)  ## le nbre de décimale pour les variables.
    ) %>%
    gtsummary::bold_labels() %>%  ## Variables en gras.
    gtsummary::italicize_levels() %>%  ## Variables en labels.
    # add_overall(col_label = "") %>%
    gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
    gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
    gtsummary::modify_header(
      list(
        label ~ paste0("**", var_title, "**"),
        ## Titre des variables du tableau.
        starts_with("add_n_stat") ~ "",
        all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
        ## labels Stat des colonnes.
        n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
      )
    )  %>%
    gtsummary::modify_table_body(~ modify_table_body_func(.)) %>%
    gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
    gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0("**", group_title, "**"))) %>% ## Titre pour la variable de groupe.
    gtsummary::modify_caption(paste0("**", table_title, "**")) %>% bold_labels()

}
