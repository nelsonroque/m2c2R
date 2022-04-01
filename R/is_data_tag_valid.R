#' m2c2R
#' @name is_data_tag_valid
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of a tibble or data frame
#' @param tag_name Name of data tag
#' @param tag_value Tag value (TRUE/FALSE)
#' @details This function checks whether a specified data tag is present in the supplied
#' data frame or tibble. If present, the function checks whether the tag has the specified
#' tag value.
#' @return Returns TRUE/FALSE. 

is_data_tag_valid <- function(data, tag_name = "", tag_value = T) {
  
  # does the attribute exist?
  if(is.null(attr(data, tag_name))){
    v <- F
    
  } else {
    
    # check attribute against provided value
    if(attr(data, tag_name) == tag_value) {
      v <- T
    } else {
      v <- F
    }
  }
  
  return(v)
}
