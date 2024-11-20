look_for(hm_1)
  
group = "ALL"

look_for(rd)

tab_1 <- hm_1  %>% select(hmtrpamo, 19:22,rdgrp,hmirmt,hmtrpa,hmtr) 




look_for(hm_1)
 
 


#### 

hm_1 %>% 
  dplyr::select(hmtrpamo,10:11, 19:22) %>%
  desc_var_7(
    table_title = "Histoire de la maladie",
    group =  "ALL",
    var_group =   hmtrpamo,
    group_title = "Traitement",
    DM = "tout"
  ) 


 ####


his_mal <- gtsummary::tbl_stack(list(
    ## Filtre sur l'IRM réalisée à la pré-inclusion
    
    hm_1 %>% filter(hmirmbr == "Oui") %>% select(hmtrpamo, 19:22) %>%
      desc_var_6(
        table_title = "**Histoire de la maladie**",
        group = group,
        var_group =   hmtrpamo,
        group_title = "**Traitement**"
      ),
    
    
    hm_1 %>% filter(hmirm == "Oui") %>% select(hmtrpamo, 24:28) %>%
      desc_var_6(
        group = group,
        var_group = hmtrpamo,
        group_title = "**Traitement**"
      ),
    
    
    
    hm_1 %>% filter(hmirm == "Oui") %>% select(hmtrpamo, hmirmga) %>%
      desc_var_6(
        group = group,
        var_group = hmtrpamo,
        group_title = "**Traitement**"
      )),
    quiet = TRUE
  
)


his_mal



#### Partie FALSE à mettre à jour 

look_for(hm)


tab_hm <- hm %>%
  select(6, 9, 11) %>%
  gtsummary::tbl_summary(
    type = list(
      ## Traitement des variables par type
      where(is.factor) ~ "categorical",
      ## Type des var (qualitatives)
      all_continuous() ~ "continuous2"
    ),
    missing = "no",  ## Ne pas afficher les NA
    statistic = list(
      all_continuous2() ~ c("{mean} ({sd})", "{min} ; {max}", "{median} ({p25};{p75})"),
      ## Stat à afficher pour les VAR (quantitatives)
      all_categorical() ~ "{n} ({p}%)" ## Stat à afficher pour les VAR (qualitatives)
    ),
    digits = list(all_continuous() ~ 1, all_categorical() ~ c(0, 0, 1)) ## Nbre de décimales pour les variables
  ) %>%
  bold_labels() %>%  ## Variables en gras
  italicize_levels() %>%  ## Modalités en italique
  gtsummary::add_n("+{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
  gtsummary::modify_header(list(
    label  ~ "**Variable**",
    ## Titre des variables du tableau
    stat_0 ~ "**TOTAL** (n={N})",
    ## Label des Totals
    n      ~ "**Total** (**dm** ; **%dm**)"  ## Labels des stats des NA
  )) %>%
  gtsummary::modify_table_body(~ {
    .x <- .x %>%
      mutate(
        stat_0 = case_when(
          is.na(.data$stat_0 == TRUE) ~ paste0( .data$n),
          TRUE ~ .data$stat_0
        )
      ) %>%
      select(-n) # Supprime la colonne 'n' après son intégration dans 'stat_0'
    return(.x)
  }) %>% 
  modify_footnote(everything() ~ NA) %>% 
  gtsummary::modify_caption("test") %>% 
  bold_labels()




### Partie "ALL" à mettre à jour 



####

add_by_n <- function(data, variable, by, tbl, ...) {
  n_all = nrow(data)
  data %>%
    select(all_of(c(variable, by))) %>%
    dplyr::group_by(.data[[by]]) %>%
    dplyr::summarise_all(list(nb = ~ sum(!is.na(.)),
                              nb_NA =  ~ sum(is.na(.)),
                              nb_percent = ~ round(sum(is.na(.))/n_all*100)),1) %>%
    rlang::set_names(c("by", "variable", "nb_NA","nb_percent"))  %>% 
    mutate(
      by_col = paste0("add_n_stat_",dplyr::row_number()),
      variable = style_number(variable),
      variable = paste0(variable, "(", nb_NA ," ; ", nb_percent, "%",  ")")
    )  %>% 
    select(-c(by,nb_NA,nb_percent)) %>% 
    tidyr::pivot_wider(names_from = by_col, 
                       values_from = variable)
}


n_all <- nrow(hm_1)


hm_1 %>% dplyr::select(hmirm, rdgrp) %>%
  dplyr::group_by(rdgrp) %>%
  dplyr::summarise_all(list(
    nb = ~ sum(!is.na(.)),
    nb_NA =  ~ sum(is.na(.)),
    nb_percent = ~ round(sum(is.na(.))/n_all*100,1))) %>%
  rlang::set_names(c("by", "variable", "nb_NA", "nb_percent")) %>%
  dplyr::mutate(
    by_col = paste0("add_n_stat_",dplyr::row_number()),
    variable = style_number(variable),
    variable = paste0(variable, "(", nb_NA ," ; ", nb_percent, "%",  ")")
  )  %>% 
  dplyr::select(-c(by,nb_NA,nb_percent)) %>% 
  tidyr::pivot_wider(names_from = by_col, 
                     values_from = variable)


#####






  
  

#########group1_level#
 



tbl_hm <- hm_1 %>% select(hmirm,rdgrp,hmtrpa) %>% 
  tbl_summary(
    type = list(
      where(is.factor) ~ "categorical",
      ## type des var (qualitatives)
      all_continuous() ~ "continuous2"
    ),
    by = rdgrp, ## Pour degrouper les tables
    missing = "no", ## Ne pas afficher les NA
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
  add_n("{N_nonmiss} ({N_miss} ; {p_miss}%)", col_label = "**N** (**dm** ; **%dm**)") %>%
  add_stat(fns = everything() ~ add_by_n) %>% 
  gtsummary::modify_header(
    list(
      label ~ "**Variable**",
      ## Titre des variables du tableau.
      starts_with("add_n_stat") ~ "",
      all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
      ## labels Stat des colonnes.
      n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
    )
  )  

#####

tbl_hm %>%
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
  gtsummary::modify_spanning_header(c(all_stat_cols(F) ~ "Traitement")) %>% ## Titre pour la variable de groupe.
  gtsummary::modify_caption("Test") %>% 
  gtsummary::bold_labels()
  
  












%>% ## Stat en colonnes (Total et données manquantes)
  modify_header(
    list(
      label ~ "**Variable**",
      ## Titre des variables du tableau.
      starts_with("add_n_stat") ~ "",
      all_stat_cols(stat_0 = FALSE) ~ "**_{level}_ (n={n}, {style_percent(p)}%**)",
      ## labels Stat des colonnes.
      n ~  "**Total (**dm** ; **%dm**)**" ## labels des Stat des NA.
    )
  )  



%>% modify_table_body ( ~ {
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
  modify_spanning_header(c(all_stat_cols(F) ~ "Groupe de traitement")) %>% ## Titre pour la variable de groupe.
  modify_caption("Test ALL") %>% bold_labels() ## Titre pour la table.






 






























####






