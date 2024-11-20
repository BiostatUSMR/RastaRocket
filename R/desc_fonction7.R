##  Fonction des tables descriptives à actualiser ----- 

### Fonction pour degrouper le nbre de NA et pourcentage par rapport aux total ----- 

# add_by_n <- function(data, variable, by, tbl, ...) {
#   n_all = nrow(data)
#   data %>%
#     select(all_of(c(variable, by))) %>%
#     dplyr::group_by(.data[[by]]) %>%
#     dplyr::summarise_all(list(nb = ~ sum(!is.na(.)),
#                               nb_NA =  ~ sum(is.na(.)),
#                               nb_percent = ~ round(sum(is.na(.))/n_all*100)),1) %>%
#     rlang::set_names(c("by", "variable", "nb_NA","nb_percent")) %>% 
#     dplyr::left_join(
#       tbl$df_by %>% select(by, by_col),
#       by = "by") %>% 
#     mutate(
#       by_col = paste0("add_n_",by_col),
#       variable = style_number(variable),
#       variable = paste0(variable, "(", nb_NA ," ; ", nb_percent, "%",  ")")
#     )  %>% 
#     select(-c(by,nb_NA,nb_percent)) %>% 
#     tidyr::pivot_wider(names_from = by_col, 
#                        values_from = variable)
# }


#### 

add_by_n <- function(data, variable, by, tbl, ...) {
  n_all = nrow(data)
  data %>%
    dplyr::select(all_of(c(variable, by))) %>%
    dplyr::group_by(.data[[by]]) %>%
    dplyr::summarise_all(list(nb = ~ sum(!is.na(.)),
                              nb_NA =  ~ sum(is.na(.)),
                              nb_percent = ~ round(sum(is.na(.))/n_all*100)),1) %>%
    rlang::set_names(c("by", "variable", "nb_NA","nb_percent"))  %>% 
    dplyr::mutate(
      by_col = paste0("add_n_stat_",dplyr::row_number()),
      variable = style_number(variable),
      variable = paste0(variable, " ", "(", nb_NA ," ; ", nb_percent, "%",  ")")
    )  %>% 
    dplyr::select(-c(by,nb_NA,nb_percent)) %>% 
    tidyr::pivot_wider(names_from = by_col, 
                       values_from = variable)
}



### Fonction pour degrouper le nbre de NA et pourcentage par rapport aux nbre total par modalité. -----  


add_by_n_2 <- function(data, variable, by, tbl, ...) {
  # Convertir 'by' en symbole
  col_by = rlang::ensym(by)
  # Calcul du nombre total de lignes dans les données
  n_all = nrow(data)
  # Calcul du nombre total d'observations pour chaque modalité de la variable 'by'
  n_by_tot_1 = data %>% dplyr::filter(!!col_by== levels(factor(!!col_by))[1]) %>% dplyr::summarise(nb = n()) 
  n_by_tot_2 = data %>% dplyr::filter(!!col_by== levels(factor(!!col_by))[2]) %>% dplyr::summarise(nb = n()) 
  # Sélection des colonnes 'variable' et 'by' et résumé des statistiques pour chaque groupe
  data_test <- data %>% 
    dplyr::select(variable,by) %>% 
    dplyr::group_by(.data[[by]]) %>%
    dplyr::summarise_all(list(nb = ~ sum(!is.na(.)),
                              nb_NA =  ~ sum(is.na(.)))) 
  ###
  
  # Calcul du pourcentage de NA pour chaque modalité de 'by'
  data_test %>% dplyr::mutate(nb_percent = dplyr::case_when(
    !!col_by == levels(as.factor(!!col_by))[1] ~ round(data_test$nb_NA[1]/ n_by_tot_1 * 100, 1),
    !!col_by == levels(as.factor(!!col_by))[2] ~ round(data_test$nb_NA[2]/ n_by_tot_2 * 100, 1))) %>% 
    # Renommage des colonnes
    rlang::set_names(c("by", "variable", "nb_NA","nb_percent")) %>%
    # Jointure à gauche avec un tableau spécifié par 'tbl'
    dplyr::left_join(
      tbl$df_by %>% select(by, by_col),
      by = "by") %>%
    # Modification des noms de colonnes et de variables pour rendre les résultats plus lisibles
    dplyr::mutate(
      by_col = paste0("add_n_",by_col),
      variable = style_number(variable),
      variable = paste0(variable, "(", nb_NA ,";", nb_percent$nb, "%",  ")")
    )  %>%
    # Sélection des colonnes à conserver et suppression des colonnes inutiles
    dplyr::select(-c(by,nb_NA,nb_percent)) %>%
    # Pivotage des données pour obtenir un format large
    tidyr::pivot_wider(names_from = by_col,
                       values_from = variable)
}


### Ordonner les variables quali ~tatives en amont pour que gtsummary puisse les reconnaitre -----
### l'ordre des frequences des modalités.  

ordonner_variables_qualitatives <- function(data) {
  data %>% dplyr::mutate(dplyr::across(where(is.factor), ~ forcats::fct_infreq(.)))
} 

### Fonction pour enveler les modalités avec zéro effectif ----- 

remove_zero_levels <- function(var) {forcats::fct_drop(var)} 

 

#### Rélabelliser ------ 

ajouter_label_ndm <- function(data) {
  # Boucle pour changer les labels de toutes les variables
  for (i in seq_along(data)) {
    label_actuel <- labelled::var_label(data[[i]])
    nouveau_label <- paste0(label_actuel, " ", "n (dm ; %dm)")
    data[[i]] <- labelled::set_variable_labels(data[[i]], nouveau_label)
  }
  return(data)
}




#### Fonction  descriptive (Reporting) Version 5.0 --------

desc_var_7 <- ## Les arugments de la fonction
  function(data1,
           ##  Jeux de données numéro 1.
           table_title = "",
           ## Titre de la table
           quali = NULL,
           ## Vecteur des variables quali ~tatives mal decrites
           quanti = NULL,
           ## Vecteur des variables quantitatives mal decrites
           group,
           var_title = "Variable",
           ## booléen pour préciser s'il faut degroupé ou pas les tables.
           var_group = NULL, ## Variable de groupe (dégroupée les tables)
           group_title = "",
           DM = "NULL") {
    
    data1 <- data1 %>% ajouter_label_ndm() 
    data1 <- data1 %>% tidyr::drop_na({{ var_group }})
    
    
    if(DM == "tout") { 
      data1 <- ordonner_variables_qualitatives(data1) %>% 
        dplyr::mutate(across(where(is.factor), remove_zero_levels)) 
      if (group == "ALL") {
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <- data1 %>% 
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
            digits = list(all_continuous() ~ 1, all_categorical() ~ c(0, 0, 1)) ## le nbre de décimale pour les variables.
          ) %>%
          gtsummary::bold_labels() %>%  ## Variables en gras.
          gtsummary::add_overall(col_label = "**Total**", last = TRUE) %>%
          gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)", last = TRUE) %>%
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
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          }) %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0("**",group_title,"**"))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0("**",table_title,"**")) %>% 
          gtsummary::bold_labels() ## Titre pour la table.
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
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
          gtsummary::add_stat(fns = everything() ~ add_by_n) %>% 
          gtsummary::modify_header(
            list(
              label ~ paste0("**",var_title,"**"),
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% 
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          }) %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()## Titre pour la table.
        return(desc_degrou)
      } else if(group == FALSE) {
        desc_degrou <- data1 %>% gtsummary::tbl_summary(
          type = list(
            ## Traitement des variables par type.
            where(is.factor) ~ "categorical",
            ## type des var (qualitatives)
            all_continuous() ~ "continuous2",
            ## type des var (continues)
            quali ~ "categorical",
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
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          )) %>%
          gtsummary::modify_table_body(~ {
            .x <- .x %>%
              dplyr::mutate(
                stat_0 = dplyr::case_when(
                  is.na(.data$stat_0 == TRUE) ~ paste0( .data$n),
                  TRUE ~ .data$stat_0
                )
              ) %>%
              dplyr::select(-n) # Supprime la colonne 'n' après son intégration dans 'stat_0'
            return(.x)
          }) %>% 
          gtsummary::modify_footnote(everything() ~ NA) %>% 
          gtsummary::modify_caption(paste0(table_title)) %>%
          gtsummary::bold_labels()
        return(desc_degrou)
      }
    }
    else if(DM == "tri") {
      data1 <- ordonner_variables_qualitatives(data1) 
      if (group == "ALL") {
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
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
          gtsummary::add_overall(col_label = "**Total**") %>%
          gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          gtsummary::modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% 
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          }) %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
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
          # gtsummary::add_overall(col_label = "") %>%
          gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          gtsummary::modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          ) %>%
          gtsummary::modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% 
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          })  %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
        
      } else if(group == FALSE) {
        desc_degrou <- data1 %>% gtsummary::tbl_summary(
          type = list(
            ## Traitement des variables par type.
            where(is.factor) ~ "categorical",
            ## type des var (qualitatives)
            all_continuous() ~ "continuous2",
            ## type des var (continues)
            quali ~ "categorical",
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
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          ))  %>%
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          }) %>% 
          gtsummary::modify_footnote(everything() ~ NA) %>% 
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
      }
    }
    else if (DM == "remove") {
      data1 <- data1 %>% dplyr::mutate(across(where(is.factor), remove_zero_levels)) 
      if (group == "ALL") {
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
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
          gtsummary::add_overall(col_label = "**Total**") %>%
          gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          gtsummary::modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% 
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          }) %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
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
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>%
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          }) %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0(table_title)) %>% bold_labels()
        return(desc_degrou)
        
      } else if(group == FALSE) {
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
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          )) %>% 
          gtsummary::modify_table_body(~ {
            .x <- .x %>%
              dplyr::mutate(
                stat_0 = dplyr::case_when(
                  is.na(.data$stat_0 == TRUE) ~ paste0( .data$n),
                  TRUE ~ .data$stat_0
                )
              ) %>%
              dplyr::select(-n) # Supprime la colonne 'n' après son intégration dans 'stat_0'
            return(.x)
          }) %>% 
          gtsummary::modify_footnote(everything() ~ NA) %>% 
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
      }
    }
    else if (DM== "NULL") {
      if (group == "ALL") {
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          gtsummary::tbl_summary(
            type = list(
              where(is.factor) ~ "categorical",
              ## type des var (qualitatives)
              all_continuous() ~ "continuous2",
              ## type des var (continus)
              quali ~  "categorical",
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
          gtsummary::add_overall(col_label = "**Total**") %>%
          gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          gtsummary:: modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% 
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          })  %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% dplyr::mutate({{ var_group }} := factor({{ var_group }}))
        col_1 <- rlang::ensym(var_group) ## Préciser la variable pour degrouper.
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
          gtsummary::italicize_levels() %>%  ## Variables en labels.# add_overall(col_label = "") %>%
          gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          gtsummary::add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          gtsummary::modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% 
          gtsummary::modify_table_body(~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <- .x  %>% 
                dplyr::rename("add_n_stat_0" = n) %>% 
                dplyr::mutate(dplyr::across(
                  matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% 
                dplyr::select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% dplyr::select(-starts_with("add_n_stat"))
            }
            
            return(.x)
          })  %>%
          gtsummary::modify_footnote(everything() ~ NA) %>% ## Note de page.
          gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
        
      } else if(group == FALSE) {
        desc_degrou <- data1 %>% gtsummary::tbl_summary(
          type = list(
            ## Traitement des variables par type.
            where(is.factor) ~ "categorical",
            ## type des var (qualitatives)
            all_continuous() ~ "continuous2",
            ## type des var (continues)
            quali ~ "categorical",
            quanti ~ "continuous2"
          ),
          missing = "no",
          ## Ne pas afficher les NA
          statistic = list(
            all_continuous2() ~ c("{mean} ({sd})", "{min} ; {max}", "{median} ({p25};{p75})"),
            ## Stat à afficher pour les VAR (quantitatives)
            all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (quali ~tatives)
          ),
          digits = list(all_continuous() ~ 1, all_categorical() ~ c(0, 0, 1)) ## Nbre de décimales pour les variables.
        ) %>%
          gtsummary::bold_labels() %>%  ## Variables en gras
          gtsummary::italicize_levels() %>%  ## modalités en italique
          gtsummary::add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          gtsummary::modify_header(list(
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          )) %>%
          gtsummary::modify_table_body(~ {
            .x <- .x %>%
              dplyr::mutate(
                stat_0 = dplyr::case_when(
                  is.na(.data$stat_0 == TRUE) ~ paste0( .data$n),
                  TRUE ~ .data$stat_0
                )
              ) %>%
              dplyr::select(-n) # Supprime la colonne 'n' après son intégration dans 'stat_0'
            return(.x)
          }) %>%  
          gtsummary::modify_footnote(everything() ~ NA) %>% 
          gtsummary::modify_caption(paste0(table_title)) %>% 
          gtsummary::bold_labels()
        return(desc_degrou)
      }
    }
    
  }

