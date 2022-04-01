#' m2c2R
#' @name add_data_tag
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of tibble or data frame
#' @param tag_name Name of tag to be added to the data, in quotes
#' @param tag_value TRUE/FALSE 
#' @details This function is used by the scoring functions in the m2c2R package
#' to flag whether data has been scored or not. 
#' @return Returns input data frame with attributes added.
add_data_tag <- function(data, tag_name = "", tag_value = T) {
  # add summary attribute
  attr(data, tag_name) <- tag_value
  
  return(data)
}