#' Remove the "labelled" class from a variable while keeping its label
#'
#' Strips the `labelled` type (as created by the \pkg{haven} or \pkg{labelled}
#' packages) from a vector and converts it back to a plain base R character or
#' numeric vector. The variable label, stored in the `"label"` attribute, is
#' preserved on the returned vector. Value labels (`"labels"` attribute) are
#' not carried over.
#'
#' Detection relies on [pillar::type_sum()], so a vector is treated as labelled
#' when its type summary is `"labelled"`. Any other input is returned
#' unchanged.
#'
#' @param x A vector, typically a column of a data frame. If `x` is a labelled
#'   character or numeric vector, it is converted to a base `character` or
#'   `numeric` vector. Otherwise it is returned as is.
#'
#' @return A vector of the same values as `x`:
#' \itemize{
#'   \item if `x` is labelled and character, a `character` vector;
#'   \item if `x` is labelled and numeric, a `numeric` vector;
#'   \item if `x` is not labelled, `x` unchanged.
#' }
#' When `x` carries a variable label, it is kept in the `"label"` attribute of
#' the result.
#'
#' @section Errors:
#' An error is thrown if `x` is labelled but is neither character nor numeric
#' (for example a labelled factor or logical vector).
#'
#' @seealso [pillar::type_sum()], [haven::zap_labels()], [haven::labelled()]
#'
#' @importFrom pillar type_sum
#' @examples
#' library(haven)
#'
#' # Labelled numeric vector
#' x <- labelled(c(1, 2, 1), labels = c(No = 1, Yes = 2))
#' attr(x, "label") <- "Answer to question 1"
#'
#' y <- remove_labelled_type(x)
#' class(y)          # "numeric"
#' attr(y, "label")  # "Answer to question 1"
#'
#' # Labelled character vector
#' z <- labelled(c("a", "b"), labels = c(Alpha = "a", Beta = "b"))
#' remove_labelled_type(z)
#'
#' # Non-labelled input is returned unchanged
#' remove_labelled_type(c(1, 2, 3))
#'
#' @export
remove_labelled_type <- function(x) {
  
  if(pillar::type_sum(x) == "labelled"){
    # If it is a labelled variable, proceed
    lab <- attr(x, "label", exact = TRUE)   # save the variable label
    
    if(is.character(x)){
      x <- as.character(x)
    } else if (is.numeric(x)){
      x <- as.numeric(x)
    } else {
      stop("Type is neither character or numeric, not supported")
    }
    # put label back
    if (!is.null(lab)) attr(x, "label") <- lab
    
    return(x)
    
  } else {
    # If not a labelled variable, return the variable
    return(x)
  }
}