



desc_false <- function(data1,
                       table_title = "",
                       ## Titre de la table
                       quali = NULL,
                       ## Vecteur des variables quali ~tatives mal decrites
                       quanti = NULL,
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
    digits = list(all_continuous() ~ 1, all_categorical() ~ c(0, 0, 1)) ## Nbre de décimales pour les variables.
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
    gtsummary::modify_table_body( ~ {
      .x <- .x %>%
        dplyr::mutate(stat_0 = dplyr::case_when(
          is.na(.data$stat_0 == TRUE) ~ paste0(.data$n),
          TRUE ~ .data$stat_0
        )) %>%
        dplyr::select(-n) # Supprime la colonne 'n' après son intégration dans 'stat_0'
      return(.x)
    }) %>%
    gtsummary::modify_footnote(everything() ~ NA) %>%
    gtsummary::modify_caption(paste0("**", table_title, "**")) %>%
    gtsummary::bold_labels()


}






