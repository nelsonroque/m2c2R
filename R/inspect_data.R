#' m2c2R
#' @name inspect_data
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of a tibble or data frame
#' @details This function "inspects" the data by pulling the number of rows and 
#' columns, as well as the variable names.
inspect_data <- function(data) {
  return(list(ncol=ncol(data), nrow=nrow(data), names=names(data)))
}
