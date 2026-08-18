# RastaRocket

<!-- badges: start -->
  [![R-CMD-check](https://github.com/BiostatUSMR/RastaRocket/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/BiostatUSMR/RastaRocket/actions/workflows/R-CMD-check.yaml)
  [![Documentation](https://img.shields.io/badge/docs-online-blue.svg)](https://biostatusmr.github.io/RastaRocket/)
<!-- badges: end -->

## NB

Dans cette branche, j’ai initié la transition vers une programmation orientée objet en convertissant les fonctions `desc_ei_per_pt()`  et  `desc_ei_per_grade()` en génériques basées sur le système S3.

- Pour `desc_ei_per_pt()`:
  - `ae_data()` : constructeur de l’objet
  - `desc_ei_per_pt()` : fonction générique S3
  - `desc_ei_per_pt.default()` : implémentation par défaut, correspondant à l’appel original avec deux data frames. 
  - `desc_ei_per_pt.ae_data()` : méthode spécifique pour l’objet ae_data
  
- Pour `desc_ei_per_grade()`:
  - `ae_grade_data()` : constructeur de l’objet
  - `desc_ei_per_grade()` : fonction générique S3
  - `desc_ei_per_grade.default()` : implémentation par défaut, correspondant à l’appel original avec deux data frame.
  - `desc_ei_per_grade.ae_grade_data()` : méthode spécifique pour l’objet `ae_grade_data`.

  
- Amélioration et développements en cours:
  - Création d'un constructeur d’objet unique, intégrant tous les arguments des différentes fonctions.
  - Développement des méthodes S3 associées à ce nouvel objet unifié, afin de simplifier  et améliorer le package.


## English

### Package installation

Install from CRAN:

install.packages("RastaRocket")   

Or install the latest development version on GitHub. Note that the devtools package must be installed beforehand. Ensure the `build_vignettes = TRUE` option is set during installation to access the included tutorial vignette:

```r
devtools::install_github("BiostatUSMR/RastaRocket", build_vignettes = TRUE)
```

### Access tutorials

After installing the package with `build_vignettes = TRUE`, you can access the `RastaRocket` tutorials contained within the vignette. Two tutorials are included :

#### Setup project

To see how you can setup a project, please look at `SetupProject` vignette 

```r
vignette("SetupProject")
```

#### Description function

To view the tutorial on how to use the descriptive functions, run the following command:

```r
vignette("RastaRocketVignette")
```

#### Adverse Event Description

To view the tutorial on how to use the adverse event descriptive functions, run the following command:

```r
vignette("DescribeAE")
```

If everything is set up correctly, the vignettes should open, providing a detailed guide to using the package.

## Français

### Installation du package

Installation depuis le CRAN :

install.packages("RastaRocket")

Ou installez la dernière version de développement disponible sur GitHub. Notez que le package `devtools` doit être installé au préalable. Assurez-vous que l’option `build_vignettes = TRUE` est activée lors de l’installation pour accéder au tutoriel inclus sous forme de vignette :

```r
devtools::install_github("BiostatUSMR/RastaRocket", build_vignettes = TRUE)
```

### Accéder au tutoriel


Après avoir installé le package avec l'argument `build_vignettes = TRUE`, vous avez accès aux deux tutoriels de `RastaRocket` :

#### Démarrer un projet

Pour voir comment démarrer un projet, vous pouvez regarder la vignette `SetupProject` :

```r
vignette("SetupProject")
```

#### Fonction de description

Pour voir le tutoriel sur les fonctions de description, vous pouvez ouvrir la vignette `RastaRocketVignette` :

```r
vignette("RastaRocketVignette")
```

#### Description d'évenements indésirables

Pour consulter le tutoriel sur l'utilisation des fonctions descriptives des évènements indésirables, exécuter la commande suivante:  


```r
vignette("DescribeAE")
```



Si tout est bien installé, les deux vignettes devraient s'ouvrir.
