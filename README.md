# develloppementFonction

## English

### Package installation

To install the `Descusmr` package, use the following code. Note that the devtools package must be installed beforehand. Ensure the `build_vignettes = TRUE` option is set during installation to access the included tutorial vignette:

```r
devtools::install_git(
  "https://gitlabp.chu-bordeaux.fr/gitlab_usmr/developpementfonction/develloppementfonction.git",
  build_vignettes = TRUE
  )
```

### Access tutorials

After installing the package with `build_vignettes = TRUE`, you can access the `Descusmr` tutorials contained within the vignette. Two tutorials are included :

#### Setup project

To see how you can setup a project, please look at `SetupProject` vignette 

```r
vignette("SetupProject")
```

#### Description function

To view the tutorial on how to use the descriptive functions, run the following command:

```r
vignette("DescusmrVignette")
vignette("DescribeAE")
```

#### Adverse Event Description

To view the tutorial on how to use the adverse event descriptive functions, run the following command:

```r
vignette("DescribeAE")
```

If everything is set up correctly, the vignettes should open, providing a detailed guide to using the package.

## Français

### Installation du package

Pour installer le package `Descusmr`, utilisez le code suivant. Notez que le package `devtools` doit être installé au préalable. Assurez-vous que l’option `build_vignettes = TRUE` est activée lors de l’installation pour accéder au tutoriel inclus sous forme de vignette :

```r
devtools::install_git(
  "https://gitlabp.chu-bordeaux.fr/gitlab_usmr/developpementfonction/develloppementfonction.git",
  build_vignettes = TRUE
  )
```

### Accéder au tutoriel


Après avoir installé le package avec l'argument `build_vignettes = TRUE`, vous avez accès aux deux tutoriels de `Descusmr` :

#### Démarrer un projet

Pour voir comment démarrer un projet, vous pouvez regarder la vignette `SetupProject` :

```r
vignette("SetupProject")
```

#### Fonction de description

Pour voir le tutoriel sur les fonctions de description, vous pouvez ouvrir la vignette `DescusmrVignette` :

```r
vignette("DescusmrVignette")
```

Si tout est bien installé, les deux vignettes devraient s'ouvrir.