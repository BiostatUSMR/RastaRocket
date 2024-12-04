

# Fonction pour modifier le corps du tableau
modify_table_body_func <- function(data) {
  add_n_stat_cols <- grep("^add_n_stat_", colnames(data), value = TRUE)

  if (all(add_n_stat_cols %in% colnames(data))) {
    data <- data %>%
      dplyr::rename("add_n_stat_0" = n) %>%
      dplyr::mutate(dplyr::across(
        matches("^stat_\\d+$"),  # Utilise une expression régulière pour sélectionner 'stat_' suivi d'un ou plusieurs chiffres
        ~ ifelse(is.na(.), get(paste0("add_n_stat_", sub("^stat_", "", cur_column()))), .)
      )) %>%
      dplyr::select(-starts_with("add_n_stat_"))
  } else {
    data <- data %>% dplyr::select(-starts_with("add_n_stat"))
  }

  return(data)
}

