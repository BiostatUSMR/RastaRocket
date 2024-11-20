add_by_n <- function(data, variable, by, tbl, ...) {
  n_all = nrow(data)
  data %>%
    select(all_of(c(variable, by))) %>%
    dplyr::group_by(.data[[by]]) %>%
    dplyr::summarise_all(list(nb = ~ sum(!is.na(.)),
                              nb_NA =  ~ sum(is.na(.)),
                              nb_percent = ~ round(sum(is.na(.))/n_all*100)),1) %>%
    rlang::set_names(c("by", "variable", "nb_NA","nb_percent")) %>% 
    dplyr::left_join(
      tbl$df_by %>% select(by, by_col),
      by = "by") %>% 
    mutate(
      by_col = paste0("add_n_",by_col),
      variable = style_number(variable),
      variable = paste0(variable, "(", nb_NA ," ; ", nb_percent, "%",  ")")
    )  %>% 
    select(-c(by,nb_NA,nb_percent)) %>% 
    tidyr::pivot_wider(names_from = by_col, 
                       values_from = variable)
}


####

add_by_n_2 <- function(data, variable, by, tbl, ...) {
  col_by = ensym(by)
  n_all = nrow(data)
  n_by_tot_1 = data %>% filter(!!col_by== levels(factor(!!col_by))[1]) %>% summarise(nb = n()) 
  n_by_tot_2 = data %>% filter(!!col_by== levels(factor(!!col_by))[2]) %>% summarise(nb = n()) 
  data_test <- data %>% 
    select(variable,by) %>% 
    dplyr::group_by(.data[[by]]) %>%
    dplyr::summarise_all(list(nb = ~ sum(!is.na(.)),
                              nb_NA =  ~ sum(is.na(.)))) 
  ###
  
  data_test %>% dplyr::mutate(nb_percent = case_when(
    !!col_by== levels(as.factor(!!col_by))[1] ~ round(data_test$nb_NA[1]/ n_by_tot_1 * 100, 1),
    !!col_by== levels(as.factor(!!col_by))[2] ~ round(data_test$nb_NA[2]/ n_by_tot_2 * 100, 1))) %>% 
    rlang::set_names(c("by", "variable", "nb_NA","nb_percent")) %>%
    dplyr::left_join(
      tbl$df_by %>% select(by, by_col),
      by = "by") %>%
    mutate(
      by_col = paste0("add_n_",by_col),
      variable = style_number(variable),
      variable = paste0(variable, "(", nb_NA ,";", nb_percent$nb, "%",  ")")
    )  %>%
    select(-c(by,nb_NA,nb_percent)) %>%
    tidyr::pivot_wider(names_from = by_col,
                       values_from = variable)
}



#### 

#### Fonction  descriptive (Reporting) Version 5.0 --------

desc_var_6 <- ## Les arugments de la fonction
  function(data1,
           ##  Jeux de données numéro 1.
           table_title = "",
           ## Titre de la table
           quali = NULL,
           ## Vecteur des variables quali ~tatives mal decrites
           quanti = NULL,
           ## Vecteur des variables quantitatives mal decrites
           group,
           ## booléen pour préciser s'il faut degroupé ou pas les tables.
           var_group = NULL, ## Variable de groupe (dégroupée les tables)
           group_title = "",
           DM = "NULL") {
    
    data1 <- data1 %>% ajouter_label_ndm() 
    
    if(DM == "tout") { 
      data1 <- ordonner_variables_qualitatives(data1) %>% 
        mutate(across(where(is.factor), remove_zero_levels)) 
      if (group == "ALL") {
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <- data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.
          add_overall(col_label = "**Total**") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels() ## Titre pour la table.
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.
          # add_overall(col_label = "") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% 
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels()## Titre pour la table.
        return(desc_degrou)
      } else if(group == FALSE) {
        desc_degrou <- data1 %>% tbl_summary(
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
          bold_labels() %>%  ## Variables en gras
          italicize_levels() %>%  ## modalités en italique
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          modify_header(list(
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          )) %>% modify_footnote(everything() ~ NA) %>% 
          modify_caption(paste0(table_title)) %>% bold_labels()
        
        return(desc_degrou)
      }
      return(desc_degrou)
    }
    else if(DM == "tri") {
      data1 <- ordonner_variables_qualitatives(data1) 
      if (group == "ALL") {
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.
          add_overall(col_label = "") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels()
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.
          # add_overall(col_label = "") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          ) %>%modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels()
        return(desc_degrou)
        
      } else if(group == FALSE) {
        desc_degrou <- data1 %>% tbl_summary(
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
          bold_labels() %>%  ## Variables en gras
          italicize_levels() %>%  ## modalités en italique
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          modify_header(list(
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          )) %>% modify_footnote(everything() ~ NA) %>% 
          modify_caption(paste0(table_title)) %>% 
          bold_labels()
        return(desc_degrou)
      }
      return(desc_degrou)
    }
    else if (DM == "remove") {
      data1 <- data1 %>% mutate(across(where(is.factor), remove_zero_levels)) 
      if (group == "ALL") {
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.
          add_overall(col_label = "") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels()
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.
          # add_overall(col_label = "") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels()
        return(desc_degrou)
        
      } else if(group == FALSE) {
        desc_degrou <- data1 %>% tbl_summary(
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
          bold_labels() %>%  ## Variables en gras
          italicize_levels() %>%  ## modalités en italique
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          modify_header(list(
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          )) %>% modify_footnote(everything() ~ NA) %>% 
          modify_caption(paste0(table_title)) %>% 
          bold_labels()
        return(desc_degrou)
      }
      return(desc_degrou)
    }
    else if (DM== "NULL") {
      if (group == "ALL") {
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.
          add_overall(col_label = "**Total**") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels()
        return(desc_degrou)
      }  else if(group == TRUE) { 
        data1  <- data1 %>% mutate({{ var_group }} := as.character({{ var_group }}))
        col_1 <- ensym(var_group) ## Préciser la variable pour degrouper.
        desc_degrou <-
          data1 %>% 
          tbl_summary(
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
          bold_labels() %>%  ## Variables en gras.
          italicize_levels() %>%  ## Variables en labels.# add_overall(col_label = "") %>%
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          add_stat(fns = everything() ~ add_by_n) %>% ## Stat en colonnes (Total et données manquantes)
          modify_header(
            list(
              label ~ "**Variable**",
              ## Titre des variables du tableau.
              starts_with("add_n_stat") ~ "",
              all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
              ## labels Stat des colonnes.
              n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
            )
          )  %>% modify_table_body ( ~ {
            add_n_stat_cols <- grep("^add_n_stat_", colnames(.x), value = TRUE)
            
            if (all(add_n_stat_cols %in% colnames(.x))) {
              .x <-  .x  %>% rename("add_n_stat_0" = n) %>% 
                mutate(across(
                  starts_with("stat_"),
                  ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
                )) %>% select(-starts_with("add_n_stat_")) 
            } else {
              .x <- .x %>% select(-starts_with("add_n_stat"))
            }
            return(.x)
          }
          ) %>%
          modify_footnote(everything() ~ NA) %>% ## Note de page.
          modify_spanning_header(c(all_stat_cols(F) ~ paste0(group_title))) %>% ## Titre pour la variable de groupe.
          modify_caption(paste0(table_title)) %>% bold_labels()
        return(desc_degrou)
        
      } else if(group == FALSE) {
        desc_degrou <- data1 %>% tbl_summary(
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
          bold_labels() %>%  ## Variables en gras
          italicize_levels() %>%  ## modalités en italique
          add_n("{n} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
          modify_header(list(
            label  ~ "**Variable**",
            ## Titre des variables du tableaux.
            stat_0 ~ "**TOTAL** (n={N})",
            ## label des Totals.
            n      ~  "**Total** (**dm** ; **%dm**)"  ## labels des stats des NA.
          )) %>% modify_footnote(everything() ~ NA) %>% 
          modify_caption(paste0(table_title)) %>% 
          bold_labels()
        return(desc_degrou)
      }
      return(desc_degrou)
    }  
  }



