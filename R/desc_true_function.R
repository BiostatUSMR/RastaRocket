


desc_true <- function (data1,
                       table_title = "",
                       ## Titre de la table
                       quali = NULL,
                       ## Vecteur des variables quali ~tatives mal decrites
                       quanti = NULL,
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
      digits = list(all_continuous() ~ 1, all_categorical() ~ c(0, 0, 1)) ## le nbre de décimale pour les variables.
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
    gtsummary::modify_table_body( ~ {
      add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
      if (all(add_n_stat_cols %in% colnames(.x))) {
        .x <- .x  %>%
          dplyr::rename("add_n_stat_0" = n) %>%
          dplyr::mutate(dplyr::across(matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                                      ~ ifelse(is.na(.), get(
                                        paste0("add_n_stat_", sub("^stat_", "", cur_column()))
                                      ), .))) %>%
          dplyr::select(-starts_with("add_n_stat_"))
      } else {
        .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
      }

      return(.x)
    }) %>%
    gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
    gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0("**", group_title, "**"))) %>% ## Titre pour la variable de groupe.
    gtsummary::modify_caption(paste0("**", table_title, "**")) %>% bold_labels()

}
