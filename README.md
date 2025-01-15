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

### Access tutorial

After installing the package with `build_vignettes = TRUE`, you can access the `Descusmr` tutorial contained within the vignette. To verify and view the tutorial, run the following command:

```r
vignette("DescusmrVignette")
```

If everything is set up correctly, the vignette should open, providing a detailed guide to using the package.

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

Après avoir installé le package avec l’option build_vignettes = TRUE, vous pouvez accéder au tutoriel Descusmr contenu dans la vignette. Pour vérifier et afficher le tutoriel, exécutez la commande suivante :

```r
vignette("DescusmrVignette")
```

Si tout est correctement configuré, la vignette s’ouvrira et fournira un guide détaillé pour utiliser le package.
