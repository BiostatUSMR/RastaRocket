#' Description of grouped and ungrouped tables with data management
#'
#' This function generates a statistical summary of grouped and ungrouped data
#' using the `gtsummary` package. It allows displaying customized statistics for
#' categorical and continuous variables, with options to adjust titles, rounding,
#' and other parameters.
#'
#' @param data1 Dataframe. The input data to generate the table.
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
#' @param var_group Character. Name of the variable used to group the data (default: NULL).
#' @param group_title Character. Title for the group variable (default: "").
#' @param tests A value in order to add p value. Defaut to `FALSE` OPTION :
#'   - `FALSE`: No p-value add
#'   - `TRUE`: Add p-value made by default by gtsummary. See gtsummary add_p() options.
#'   - `list()`: To force tests. See gtsummary add_p() options.
#'
#' @return A `gtsummary` object representing the descriptive table.
#'
#' @details
#' - Categorical variables are displayed with statistics like `{n} ({p}%)`.
#' - Continuous variables are displayed with statistics such as
#'   `{mean} ({sd})`, `{min} ; {max}`, `{median} ({p25};{p75})`.
#' - Columns are formatted and customized with options for style, titles, and footnotes.
#'
#' @examples
#' # Example usage:
#' data <- data.frame(
#'   group = c("A", "B", "A", "B"),
#'   gender = factor(c("Male", "Female", "Female", "Male")),
#'   age = c(34, 29, 45, 36)
#' )
#' desc_degroup(
#'   data1 = data,
#'   table_title = "Descriptive Table",
#'   quali = c("gender"),
#'   quanti = c("age"),
#'   var_group = "group",
#'   tests = FALSE
#' )
#'
#' @import dplyr
#' @import gtsummary
#' @importFrom rlang ensym
#' @export



desc_degroup <- function (data1,
                       table_title = "",
                       ## Titre de la table
                       quali = NULL,
                       ## Vecteur des variables quali ~tatives mal decrites
                       quanti = NULL,
                       round_quanti = c(1),
                       round_quali = c(0,1),
                       var_title = "Variable",
                       var_group = NULL,
                       group_title = "",
                       tests = FALSE) {

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
  # Add tests tests 
  if (is.list(tests)) {
    desc_degrou <- desc_degrou %>%
      gtsummary::add_p(test = tests) %>%
      gtsummary::separate_p_footnotes()
  } else if (isTRUE(tests)) {
    desc_degrou <- desc_degrou %>%
      gtsummary::add_p() %>%
      gtsummary::separate_p_footnotes()
  } 
  
  return(desc_degrou)
  
  
}
