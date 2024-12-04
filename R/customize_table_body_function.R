

customize_table_body <- function(data) {
  data <- data %>%
    dplyr::mutate(stat_0 = dplyr::case_when(
      is.na(.data$stat_0) ~ paste0(.data$n),
      TRUE ~ .data$stat_0
    )) %>%
    dplyr::select(-n) # Supprime la colonne 'n' après son intégration dans 'stat_0'
  return(data)
}
