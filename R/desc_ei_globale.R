

desc_ei_global <- function(data, data_2, soc_name, pt_name, var_group, soc) {
  
  # Récupérer toutes les modalités uniques de la variable SOC
  all_soc <- unique(data[[soc_name]])

  # Utiliser lapply pour appliquer la fonction tab_ei_SOC_PT sur chaque SOC unique
  all_results <- lapply(all_soc, function(soc) {
    tab_ei_SOC_PT(
      data = data,
      soc_name = soc_name,
      pt_name = pt_name,
      soc = soc,
      data_2 = data_2,
      var_group = var_group
    )
  })

  # Associer les noms des modalités SOC aux résultats obtenus
  names(all_results) <- all_soc

  # Générer un tableau de synthèse global en utilisant tab_ei_tot_SOC
  tab_dat <- tab_ei_tot_SOC(
    data = data,
    soc_name = soc_name,
    pt_name = pt_name,
    data_2 = data_2,
    var_group = var_group
  )

  # Convertir le tableau en data.frame pour une manipulation plus facile
  tab_dat_final <- tab_dat %>% as.data.frame() 

  # Convertir chaque résultat de all_results en data.frame et concaténer en un seul tableau
  tab_gt <- do.call(rbind, lapply(all_results, as.data.frame)) 

  # Fusionner le tableau global avec les résultats détaillés des SOC
  tab_gt_final <- rbind(tab_dat_final, tab_gt) %>% 
    # Remplacer toutes les valeurs "NA" sous forme de texte par de véritables valeurs NA
    dplyr::mutate_all(~replace(., . == "NA", NA)) %>%
    # Convertir le tableau final en un tableau `gt`
    gt::gt(rowname_col = "pt_name", groupname_col = "soc_name") %>%
    # Ajouter un en-tête pour les événements indésirables
    gt::tab_stubhead(label = gt::md("**Evénements indésirables**")) %>%
    # Remplacer les valeurs manquantes par une chaîne vide
    gt::sub_missing(missing_text = "") %>%
    # Appliquer un style spécifique aux lignes contenant "Total"
    gt::tab_style(
      locations = gt::cells_body(rows = gt::starts_with("Total")),
      style = gt::cell_fill(color = "lightblue" |> gt::adjust_luminance(steps = +1))
    ) %>%
    # Appliquer un style spécifique aux groupes de lignes (SOC)
    gt::tab_style(
      locations = gt::cells_row_groups(),
      style = gt::cell_fill(color = "#c5c5c5" |> gt::adjust_luminance(steps = +1))
    ) %>%
    # Ajouter des en-têtes de colonnes pour structurer le tableau
    gt::tab_spanner(label = gt::md("**EI**"), columns = c("N", "%")) %>%
    gt::tab_spanner(label = gt::md("**Patients**"), columns = c("  N", "  %")) %>%
    gt::tab_spanner(label = gt::md(" **EI** "), columns = c(" N ", " % ")) %>%
    gt::tab_spanner(label = gt::md(" **Patients** "), columns = c("N  ", "%  ")) %>%
    gt::tab_spanner(label = gt::md("**EI** "), columns = c("N ", "% ")) %>%
    gt::tab_spanner(label = gt::md("**Patients** "), columns = c(" N", " %")) %>%
    # Ajouter un groupe global pour les totaux EI et Patients
    gt::tab_spanner(label = gt::md("**TOTAL**"), spanners = c("**EI**", "**Patients**")) %>%
    # Ajouter un groupe pour le premier bras de traitement
    gt::tab_spanner(
      label = gt::md(paste0("**", levels(data[[var_group]])[1], "**")),
      spanners = c(" **EI** ", " **Patients** ")
    ) %>%
    # Ajouter un groupe pour le deuxième bras de traitement
    gt::tab_spanner(
      label = gt::md(paste0("**", levels(data[[var_group]])[2], "**")),
      spanners = c("**EI** ", "**Patients** ")
    ) %>%
    # Ajouter un en-tête global
    gt::tab_header(title = "", subtitle = gt::md("**Événements indésirables (PT) par SOC (Tous grades confondus)**"))

  # Retourner le tableau formaté
  return(tab_gt_final)
}


####

tab_final_soc <- desc_ei_global(
  data = data_SOC_PT,
  soc_name = "soc_name",
  pt_name = "pt_name",
  soc = soc,
  data_2 = ic_1,
  var_group = "traitement_reel"
)
