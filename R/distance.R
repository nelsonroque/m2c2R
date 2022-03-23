#' m2c2R
#' @export
distance <- function(x1,x2,y1,y2) {
  d = sqrt(((x2 - x1)^2 + (y2 - y1)^2))
  return(d)
}