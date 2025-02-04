#' css_generator
#'
#' @description
#' Generate css to be included in quarto.
#' 
#'
#' @param path_logo The path to logo, will automatically be guessed on the package.
#'
#' @return A css string
#' @export
#' 
css_generator <- function(path_logo = NULL){
  if(is.null(path_logo)){
    path_logo <- system.file("LogoCHUBdx.jpg", package = "Descusmr")
  }
  
  css_style <- paste0('<style>
#TOC::after {
  content: "Entité d’application/Emetteur : USMR -- EN-USM-508 DOCUMENT D’ENREGISTREMENT -- Ind : 09";
  display: block;
  text-align: left;
  font-size: 10px;
  color: black
}
#TOC {
  background: url(', path_logo, ');
  background-size: 50%;
  padding-top: 80px !important;
  background-repeat: no-repeat;
}
</style>')

  return(css_style)
}