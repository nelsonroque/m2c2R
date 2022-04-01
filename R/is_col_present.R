#' m2c2R
#' @name is_col_present
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of a tibble or data frame
#' @param colname Name of a column to check for, in quotes ("participant_id")
#' @details This function checks whether a given column (colname) is in the 
#' specified data frame or tibble.  
#' @return Returns TRUE/FALSE.
#' @import tidyverse
is_col_present <- function(data, colname) {
  if(is_data_frame_tibble(data)) {
    if(colname %in% colnames(data)) {
      v <- T
    } else{
      v <- F
    }
  } else {
    stop("`data` is not a data.frame or tibble. Please try again.")
  }
  return(v)
}