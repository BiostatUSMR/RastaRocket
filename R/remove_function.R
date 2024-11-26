### Fonction pour enveler les modalités avec zéro effectif dans une variable de type facteur


remove_zero_levels <- function(var) {
  # Appel de la fonction forcats::fct_drop pour éliminer les niveaux inutilisés
  forcats::fct_drop(var)
}
