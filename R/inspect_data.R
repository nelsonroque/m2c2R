#' m2c2R
#' @export
inspect_data <- function(data) {
  return(list(ncol=ncol(data), nrow=nrow(data), names=names(data)))
}