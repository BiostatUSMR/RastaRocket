
# Fonction pour ajouter une indication "n (dm ; %dm)" aux labels des variables
ajouter_label_ndm <- function(data) {

  # Boucle pour itérer sur toutes les colonnes du jeu de données
  for (i in seq_along(data)) {
    # Obtenir le label actuel de la variable (si défini)
    label_actuel <- labelled::var_label(data[[i]])

    # Créer un nouveau label en ajoutant "n (dm ; %dm)" au label existant
    nouveau_label <- paste0(label_actuel, " ", "n (dm ; %dm)")

    # Appliquer le nouveau label à la variable en utilisant la fonction set_variable_labels
    data[[i]] <- labelled::set_variable_labels(data[[i]], nouveau_label)
  }

  # Retourner le jeu de données modifié avec les nouveaux labels
  return(data)
}
