tab_ei_SOC_PT <- function(data, data_2, soc_name,pt_name, var_group, soc) {
  
  # Convertir var_group et soc_name en symboles pour une utilisation dynamique
  
  var_group_sym <- rlang::sym(var_group)
  soc_name_sym <- rlang::sym(soc_name)
  pt_name_sym <- rlang::sym(pt_name)
  
  # Calcul des totaux pour les événements indésirables et les patients
  
  nb_ei_all_soc <- nrow(data)
  nb_pat_tot <- nrow(data_2)
  
  # Calcul pour les groupes définis par var_group
  
  nb_ei_BRASA <- data %>%
    dplyr::filter(!!var_group_sym == levels(data[[var_group]])[1]) %>%
    nrow()
  
  nb_ei_BRASB <- data %>%
    dplyr::filter(!!var_group_sym == levels(data[[var_group]])[2]) %>%
    nrow()
  
  # Nombre de patients distincts pour les deux groupes
  
  nb_pat_BRASA <- data_2 %>%
    dplyr::filter(!!var_group_sym == levels(data[[var_group]])[1]) %>%
    dplyr::distinct(usubjid) %>%
    nrow()
  
  nb_pat_BRASB <- data_2 %>%
    dplyr::filter(!!var_group_sym == levels(data[[var_group]])[2]) %>%
    dplyr::distinct(usubjid) %>%
    nrow()
  
  
  ### Calcul des statistiques pour le Bras A
  
  common_results_A <- data %>%
    dplyr::filter(
      !!soc_name_sym == soc &
        !!var_group_sym == levels(data[[var_group]])[1]
    ) %>%
    dplyr::group_by(!!var_group_sym) %>%
    dplyr::summarise(
      nb_ei_group = n(),
      ei_group_per = round((nb_ei_group / nb_ei_BRASA) * 100, 1),
      nb_pat_group = n_distinct(usubjid),
      pat_group_per = round((nb_pat_group / nb_pat_BRASA) * 100, 1)
    )
  
  ### Calcul des statistiques pour le Bras B
  
  common_results_B <- data %>%
    dplyr::filter(
      !!soc_name_sym == soc &
        !!var_group_sym == levels(data[[var_group]])[2]
    ) %>%
    dplyr::group_by(!!var_group_sym) %>%
    dplyr::summarise(
      nb_ei_group = n(),
      ei_group_per = round((nb_ei_group / nb_ei_BRASB) * 100, 1),
      nb_pat_group = n_distinct(usubjid),
      pat_group_per = round((nb_pat_group / nb_pat_BRASB) * 100, 1)
    )
  
  ### Combinaison des résultats pour les Bras A et B
  
  common_results <- dplyr::bind_rows(common_results_A, common_results_B)
  
  ### Calcul des statistiques globales
  
  result_part1 <- common_results %>%
    tidyr::complete(
      !!var_group_sym := c(
        levels(data[[var_group]])[1],
        levels(data[[var_group]])[2]
      ),
      fill = list(
        nb_ei_group = NA,
        ei_group_per = NA,
        nb_pat_group = NA,
        pat_group_per = NA
      )
    ) %>%
    dplyr::mutate(
      !!var_group_sym := if_else(is.na(!!var_group_sym), "Total", as.character(!!var_group_sym))
    ) %>%
    dplyr::relocate(!!var_group_sym, .before = nb_ei_group)
  
  ### Calcul des totaux et des pourcentages 
  
  result_tot <- result_part1 %>%
    dplyr::summarise(
      nb_ei_group = sum(nb_ei_group, na.rm = TRUE),
      ei_group_per = round((nb_ei_group / nb_ei_all_soc) * 100, 1),
      nb_pat_group = sum(nb_pat_group, na.rm = TRUE),
      pat_group_per = round((nb_pat_group / nb_pat_tot) * 100, 1)
    ) %>%
    dplyr::mutate(!!var_group_sym := "Total") %>%
    dplyr::relocate(!!var_group_sym, .before = nb_ei_group)
  
  ### Combinaison finale des résultats
  
  result_final <- dplyr::bind_rows(result_tot, result_part1) 
  
  
  
  # Construction de la table principale et jointures pour les deux groupes
  
  tab_test <- data %>%
    dplyr::filter(!!soc_name_sym == soc) %>%
    dplyr::group_by(!!pt_name_sym, !!soc_name_sym) %>%
    dplyr::summarise(
      nb_ei = n(),
      nb_patient = n_distinct(usubjid),
      .groups = 'drop'
    ) %>%
    as.data.frame() %>%
    dplyr::mutate(
      pt_name = trimws(pt_name),
      ei_percent_per = as.numeric(round(nb_ei / nb_ei_all_soc * 100, 1)),
      nb_patient_per = as.numeric(round(nb_patient / nb_pat_tot * 100, 1))
    ) %>%
    dplyr::relocate(ei_percent_per, .after = nb_ei) %>%
    dplyr::relocate(nb_patient_per, .after = nb_patient) %>%
    dplyr::left_join(
      data %>% filter(
        !!var_group_sym == levels(data[[var_group]])[1]
      ) %>%
        dplyr::group_by(!!pt_name_sym, !!var_group_sym, !!soc_name_sym) %>%
        dplyr::summarise(
          `Nombre d'EIs` = n(),
          `Nombre de patients` = n_distinct(usubjid),
          .groups = 'drop'
        ) %>%
        as.data.frame() %>%
        dplyr::mutate(
          pt_name = trimws(pt_name),
          ei_percent = as.numeric(round(`Nombre d'EIs` / nb_ei_BRASA * 100, 1)),
          nb_patient = as.numeric(round(`Nombre de patients` / nb_pat_BRASA * 100, 1))
        ) %>%
        dplyr::relocate(ei_percent, .after = `Nombre d'EIs`) %>%
        dplyr::relocate(nb_patient, .after = `Nombre de patients`) %>%
        as.data.frame() %>%
        tidyr::pivot_longer(
          cols = c("Nombre d'EIs", "ei_percent", "Nombre de patients", "nb_patient")
        ) %>%
        dplyr::mutate(name = paste0(!!var_group_sym, "_", name)) %>%
        dplyr::select(-!!var_group_sym) %>%
        tidyr::pivot_wider(names_from = name, values_from = value) %>%
        as.data.frame() %>%
        dplyr::select(-!!soc_name_sym) %>% 
        dplyr::rename(
          " N " = paste0(levels(data[[var_group]])[1],"_Nombre d'EIs"),
          " % " = paste0(levels(data[[var_group]])[1],"_ei_percent"),
          "N  " = paste0(levels(data[[var_group]])[1],"_Nombre de patients"),
          "%  " = paste0(paste0(levels(data[[var_group]])[1],"_nb_patient"))
        ) %>% 
        labelled::set_variable_labels(" N " = "EI_brasA")
      , 
      by = "pt_name"
    ) %>%
    dplyr::left_join(
      data %>%
        dplyr::filter(!!var_group_sym == levels(data[[var_group]])[2]) %>%
        dplyr::group_by(!!pt_name_sym, !!var_group_sym, !!soc_name_sym) %>%
        dplyr::summarise(
          `Nombre d'EIs` = n(),
          `Nombre de patients` = n_distinct(usubjid),
          .groups = 'drop'
        ) %>%
        as.data.frame() %>%
        dplyr::mutate(
          pt_name = trimws(pt_name),
          ei_percent = as.numeric(round(`Nombre d'EIs`/
                                          nb_ei_BRASB * 100, 1)),
          nb_patient = as.numeric(round(`Nombre de patients`/
                                          nb_pat_BRASB * 100, 1))) %>%
        dplyr::relocate(ei_percent, .after = `Nombre d'EIs`) %>%
        dplyr::relocate(nb_patient, .after = `Nombre de patients`) %>%
        as.data.frame() %>%
        tidyr::pivot_longer(
          cols = c("Nombre d'EIs", "ei_percent", "Nombre de patients", "nb_patient")
        ) %>%
        dplyr::mutate(name = paste0(!!var_group_sym, "_", name)) %>%
        dplyr::select(-!!var_group_sym) %>%
        tidyr::pivot_wider(names_from = name, values_from = value) %>%
        as.data.frame() %>% 
        dplyr::select(-!!soc_name_sym) %>% 
        dplyr::rename(
          "N " = paste0(levels(data[[var_group]])[2],"_Nombre d'EIs"),
          "% " = paste0(levels(data[[var_group]])[2],"_ei_percent"),
          " N" = paste0(levels(data[[var_group]])[2],"_Nombre de patients"),
          " %" = paste0(levels(data[[var_group]])[2],"_nb_patient")
        ) 
      ,by = "pt_name") %>% 
    dplyr::rename(
      "N" = "nb_ei",
      "%" = "ei_percent_per",
      "  N"  = "nb_patient",
      "  %"  = "nb_patient_per"
    ) %>%  
    gt::gt(rowname_col = "pt_name",groupname_col = "soc_name") %>%
    gt::tab_stubhead(label = gt::md("**Evénements indésirables**"))
  
  
  #### Ajout des totaux au tableau final
  
  tab_final_soc <- tab_test %>%
    gt::rows_add(
      pt_name = "Total",
      N = result_final$nb_ei_group[1],
      `N  ` = result_final$nb_pat_group[2],
      `N ` = result_final$nb_ei_group[3],
      `%` = result_final$ei_group_per[1],
      `  N` = result_final$nb_pat_group[1],
      `  %` = result_final$pat_group_per[1],
      ` N ` = result_final$nb_ei_group[2],
      ` % ` = result_final$ei_group_per[2],
      `%  ` = result_final$pat_group_per[2],
      `% ` = result_final$ei_group_per[3],
      ` N` = result_final$nb_pat_group[3],
      ` %` = result_final$pat_group_per[3],
      .before = 1,
      soc_name = soc
    ) %>%
    gt::tab_style(
      locations = cells_body(rows = "Total"),
      style = cell_fill(color = "lightblue" |> adjust_luminance(steps = +1))
    ) %>%
    gt::tab_style(locations = cells_row_groups(),
              style = cell_fill(color = "#c5c5c5" |> adjust_luminance(steps = +1))) %>% 
    gt::tab_spanner(label = gt::md("**EI**"), columns = c("N", "%")) %>%
    gt::tab_spanner(label = gt::md("**Patients**"), columns = c("  N", "  %")) %>%
    gt::tab_spanner(label = gt::md(" **EI** "), columns = c(" N ", " % ")) %>%
    gt::tab_spanner(label = gt::md(" **Patients** "), columns = c("N  ", "%  ")) %>%
    gt::tab_spanner(label = gt::md("**EI** "), columns = c("N ", "% ")) %>%
    gt::tab_spanner(label = gt::md("**Patients** "), columns = c(" N", " %")) %>%
    gt::tab_spanner(label = gt::md("**TOTAL**"), spanners = c("**EI**", "**Patients**")) %>%
    gt::tab_spanner(
      label = gt::md(paste0("**",levels(data[[var_group]])[1],"**")),
      spanners = c(" **EI** ", " **Patients** ")
    ) %>%
    gt::tab_spanner(
      label = gt::md(paste0("**",levels(data[[var_group]])[2],"**")),
      spanners = c("**EI** ", "**Patients** ")
    ) %>%
    gt::tab_header(title = "", subtitle = gt::md("**Evenements indésirables( PT) par SOC (Tout les grades confondus)**"))
  
  
  
  return(tab_final_soc)
}