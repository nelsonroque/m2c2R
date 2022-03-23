#' m2c2R
#' @name inspect_data
#' @export
#' @param data class: data.frame
#' @import tidyverse
inspect_data <- function(data) {
  return(list(ncol=ncol(data), nrow=nrow(data), names=names(data)))
}