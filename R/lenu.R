#' m2c2R

#' @name lenu
#' @param v class: vector
#' @examples
#' lenu(c(0,1,1,2))
#' @export
lenu <- function(v) {
  return(lenu <- length(unique(v)))
}