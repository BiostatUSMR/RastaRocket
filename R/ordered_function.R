

# Fonction pour ordonner les variables qualitatives dans un jeu de données

ordonner_variables_qualitatives <- function(data) {
  # Appliquer des transformations aux colonnes du data.frame
  data %>%
    dplyr::mutate(
      # Sélectionner les colonnes de type "factor" et les réordonner
      dplyr::across(
        where(is.factor),                       # Appliquer l'opération uniquement sur les colonnes de type facteur
        ~ forcats::fct_infreq(.)               # Réordonner les niveaux des facteurs par fréquence décroissante
      )
    )
}
