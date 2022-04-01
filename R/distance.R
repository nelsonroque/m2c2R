#' m2c2R
#' @name distance
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param x1,x1,y1,y2 coordinates on an X/Y grid corresponding to the position of two dots. 
#' @details This function calculates the distance between two dots on an X/Y grid.  
#' @return Returns numeric value for the distance between two dots.
distance <- function(x1,x2,y1,y2) {
  d = sqrt(((x2 - x1)^2 + (y2 - y1)^2))
  return(d)
}