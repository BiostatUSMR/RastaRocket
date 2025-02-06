#' Generate a CSS File
#'
#' This function creates and writes a CSS file with predefined styling for tables and text formatting.
#'
#' @param path Character string specifying the file path where the CSS file will be saved.
#'
#' @return None. The function writes a CSS file to the specified file path.
#'
#' @export
write_css <- function(path){
  css_string <- "table {
    width: 100% !important;
    border-collapse: collapse !important;
  }
  
  td, th {
    border: 1px solid black !important;
    text-align: center !important;
    padding: 5px !important;
  }
  
  .cent-gras {
    text-align: center !important;
    font-weight: bolder !important;
    text-transform: uppercase !important;
  }"
  
  write.table(css_string, 
              file = path, 
              quote = FALSE,
              col.names = FALSE,
              row.names = FALSE)
}