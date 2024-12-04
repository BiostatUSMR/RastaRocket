

#' Create a Descriptive Summary Table
#'
#' Generates a summary table of descriptive statistics for quantitative and qualitative variables,
#' grouped by a specific variable if provided.
#'
#' @param data1 A data frame containing the variables to summarize.
#' @param table_title A string specifying the title of the table. Defaults to an empty string.
#' @param quali A vector of variable names (as strings) that should be treated as qualitative.
#' @param quanti A vector of variable names (as strings) that should be treated as quantitative.
#' @param var_title A string specifying the column label for variables in the summary table. Defaults to "Variable".
#' @param var_group A grouping variable (unquoted) to generate group-wise summaries. If `NULL`, no grouping is applied.
#' @param group_title A string specifying the column label for the grouping variable in the table. Defaults to an empty string.
#'
#' @return A `gtsummary` object representing the formatted summary table.
#'
#' @details
#' This function leverages the `gtsummary` package to create a highly customizable summary table.
#' Quantitative variables are summarized with mean (standard deviation), median (interquartile range),
#' and range (minimum, maximum). Qualitative variables are summarized with counts and percentages.
#' The table includes options for overall summaries, missing data statistics, and grouped summaries.
#'
#' @examples
#' library(dplyr)
#' library(gtsummary)
#'
#' data(mtcars)
#' desc_all(
#'   data1 = mtcars,
#'   table_title = "Descriptive Summary of mtcars",
#'   quali = c("cyl", "gear"),
#'   quanti = c("mpg", "hp"),
#'   var_group = cyl,
#'   group_title = "Cylinders"
#' )
#'
#' @export

# desc_all <- function(data1,
#                      table_title = "",
#                      ## Titre de la table
#                      quali = NULL,
#                      ## Vecteur des variables quali ~tatives mal decrites
#                      quanti = NULL,
#                      var_title = "Variable",
#                      var_group = NULL,
#                      group_title = "") {
#
#
#
#
#   col_1 <- rlang::ensym(var_group)
#
#   ###
#
#   desc_group <-   data1 %>%
#   gtsummary::tbl_summary(
#     type = list(
#       where(is.factor) ~ "categorical",
#       ## type des var (qualitatives)
#       all_continuous() ~ "continuous2",
#       ## type des var (continus)
#       quali ~ "categorical",
#       quanti ~ "continuous2"
#     ),
#     by = !!col_1,
#     ## Pour degrouper les tables
#     missing = "no",
#     ## Ne pas afficher les NA
#     statistic = list(
#       all_continuous2() ~ c("{mean} ({sd})", "{median} ({p25} ; {p75})","{min} ; {max}"),
#       ## Stat à afficher pour les VAR (quantitatives)
#       all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (categorielles)
#     ),
#     digits = list(all_continuous() ~ 1, all_categorical() ~ c(0, 0, 1)) ## le nbre de décimale pour les variables.
#   ) %>%
#   gtsummary::bold_labels() %>%  ## Variables en gras.
#   gtsummary::add_overall(col_label = "**Total**") %>%
#   gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
#   gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
#   gtsummary::modify_header(
#     list(
#       label ~ paste0("**",var_title,"**"),
#       ## Titre des variables du tableau.
#       starts_with("add_n_stat") ~ "",
#       all_stat_cols(stat_0 = FALSE) ~ "**{level}**",
#       ## labels Stat des colonnes.
#       n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
#     )
#   )  %>%
#   gtsummary::modify_table_body(~ {
#     add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
#     if (all(add_n_stat_cols %in% colnames(.x))) {
#       .x <- .x  %>%
#         dplyr::rename("add_n_stat_0" = n) %>%
#         dplyr::mutate(dplyr::across(
#           matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
#           ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
#         )) %>%
#         dplyr::select(-starts_with("add_n_stat_"))
#     } else {
#       .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
#     }
#
#     return(.x)
#   }) %>%
#   gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
#   gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0("**",group_title,"**"))) %>% ## Titre pour la variable de groupe.
#   gtsummary::modify_caption(paste0("**",table_title,"**")) %>%
#   gtsummary::bold_labels() ## Titre pour la table.
#
#   return(desc_group)
#
# }
#
#





desc_all <- function(data1,
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

  ###

  desc_group <-   data1 %>%
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
        all_continuous2() ~ c("{mean} ({sd})", "{median} ({p25} ; {p75})","{min} ; {max}"),
        ## Stat à afficher pour les VAR (quantitatives)
        all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (categorielles)
      ),
      digits = list(all_continuous() ~ round_quanti, all_categorical() ~ round_quali) ## le nbre de décimale pour les variables.
    ) %>%
    gtsummary::bold_labels() %>%  ## Variables en gras.
    gtsummary::add_overall(col_label = "**Total**") %>%
    gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
    gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
    gtsummary::modify_header(
      list(
        label ~ paste0("**",var_title,"**"),
        ## Titre des variables du tableau.
        starts_with("add_n_stat") ~ "",
        all_stat_cols(stat_0 = FALSE) ~ "**{level}**",
        ## labels Stat des colonnes.
        n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
      )
    )  %>%
    gtsummary::modify_table_body(~ modify_table_body_func(.)) %>%  ## Appel de la fonction externe pour modifier le corps du tableau
    gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
    gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0("**",group_title,"**"))) %>% ## Titre pour la variable de groupe.
    gtsummary::modify_caption(paste0("**",table_title,"**")) %>%
    gtsummary::bold_labels() ## Titre pour la table.

  return(desc_group)
}
