

### Packages

library(tidyverse)
library(dplyr)
library(gtsummary)
library(labelled)
library(rlang)
library(tidyr)

### Chargement des tables



# Charger le package nécessaire
set.seed(123)  # Pour garantir la reproductibilité

# Création du data frame
data <- data.frame(
  Age = c(rnorm(45, mean = 50, sd = 10), rep(NA, 5)),  # Renommée Age
  sexe = sample(c(0, 1), 50, replace = TRUE, prob = c(0.6, 0.4)),  # Renommée sexe
  quatre_modalites = sample(c("A", "B", "C"), 50, replace = TRUE, prob = c(0.2, 0.5, 0.3)),  # Modalités sans "D"
  traitement = sample(c("BRAS-A", "BRAS-B"), 50, replace = TRUE, prob = c(0.55, 0.45)),  # Nouvelle variable traitement
  echelle = sample(0:5, 50, replace = TRUE)  # Nouvelle variable entière de 0 à 5
)

# Ajouter la modalité "D" comme niveau sans effectif
data$quatre_modalites <- factor(data$quatre_modalites, levels = c("A", "B", "C", "D"))

# Ajouter des labels à la variable sexe
data$sexe <- factor(data$sexe, levels = c(0, 1), labels = c("Femme", "Homme"))

# Aperçu des données



data <- data %>% labelled::set_variable_labels( Age = "Age",
                                                sexe = "sexe",
                                                traitement  = "traitement",
                                                quatre_modalites = "quatres niveaux",
                                                echelle = "Echelle")
