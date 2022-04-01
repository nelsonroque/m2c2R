#' m2c2R
#' @name append_colname_prefix
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of tibble or data frame
#' @param group_var Name of grouping variable, in quotes (for example: "participant_id")
#' @param var_prefix Prefix to be added to the name of each variable (for example: "study1_")
#' @details This function adds a prefix to variable names in a specified tibble or data frame. 
#' @return Returns input data frame with modified variable names (for example: "study1_participant_id."
append_colname_prefix <- function(data, group_var, var_prefix) {
  len_group_var = length(group_var)
  names(data)[(len_group_var + 1):ncol(data)] <- paste0(var_prefix, ".", names(data)[(len_group_var + 1):ncol(data)])
  return(data)
}