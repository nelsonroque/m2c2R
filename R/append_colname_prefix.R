#' m2c2R
#' @export
append_colname_prefix <- function(data, group_var, var_prefix) {
  len_group_var = length(group_var)
  names(data)[(len_group_var + 1):ncol(data)] <- paste0(var_prefix, ".", names(data)[(len_group_var + 1):ncol(data)])
  return(data)
}