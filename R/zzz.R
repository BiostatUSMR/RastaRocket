.onLoad <- function(libname, pkgname){
  message("Welcome dear user, check vignette(SetupProject) and vignette(DescusmrVignette) for some help. May the force be with you and make your analysis swift and smooth.")
  vec_citation <- c("On est exhaustifs dans la bouse ! 04/04/2023",
                    "Toute pandémie est une syndémie en fait non ? 11/09/2023",
                    "Pas besoin de creuser, la merde est déjà là ! 22/03/2023")
  message("--- Now a small citation from great philosophers ---")
  message(sample(vec_citation, size = 1))
}