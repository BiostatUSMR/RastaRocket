

## Fonction pour degrouper l'effectif et les pourcentages des données manquantes.



add_by_n <- function(data, variable, by, tbl, ...) {
  # Calcul du nombre total de lignes dans le jeu de données
  n_all = nrow(data)

  data %>%
    # Sélection des colonnes pertinentes : la variable cible et la colonne de regroupement
    dplyr::select(all_of(c(variable, by))) %>%

    # Regrouper les données en fonction de la colonne spécifiée par "by"
    dplyr::group_by(.data[[by]]) %>%

    # Calcul des statistiques pour chaque groupe
    dplyr::summarise_all(
      list(
        nb = ~ sum(!is.na(.)),           # Nombre de valeurs non manquantes
        nb_NA = ~ sum(is.na(.)),        # Nombre de valeurs manquantes
        nb_percent = ~ round(sum(is.na(.)) / n_all * 100) # Pourcentage de valeurs manquantes
      ), 1 # Marginalisation pour appliquer les fonctions
    ) %>%

    # Renommage des colonnes pour une meilleure lisibilité
    rlang::set_names(c("by", "variable", "nb_NA", "nb_percent")) %>%

    # Création de nouvelles colonnes pour la sortie formatée
    dplyr::mutate(
      by_col = paste0("add_n_stat_", dplyr::row_number()), # ID unique basé sur le numéro de ligne
      variable = style_number(variable),                  # Formatage éventuel de la variable (fonction externe)
      variable = paste0(variable, " ", "(", nb_NA, " ; ", nb_percent, "%", ")") # Concaténation des stats dans une chaîne lisible
    ) %>%

    # Suppression des colonnes intermédiaires inutiles
    dplyr::select(-c(by, nb_NA, nb_percent)) %>%

    # Transformation des données en format large
    tidyr::pivot_wider(
      names_from = by_col,         # Utiliser "by_col" comme noms de colonnes
      values_from = variable       # Les valeurs proviennent de la colonne "variable"
    )
}
