#' m2c2R
#' @name is_data_frame_tibble
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of an object in R
#' @details This function checks whether a given object is a data frame or tibble.  
#' @return Returns TRUE/FALSE.
#' @import tidyverse
is_data_frame_tibble <- function(data) {
  # check if data is tibble or data.frame
  if(is_tibble(data) | is.data.frame(data)) {
    v <- T
  } else {
    v <- F
  }
  return(v)
}
