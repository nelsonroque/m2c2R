#' m2c2R
#' @name create_n_batches
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of a tibble or data frame
#' @param batches Number of batches desired
#' @details This function splits an input data frame into a specified number of batches for processing. 
#' @return Returns list of data, split into specified number ofbatches
create_n_batches <- function(.data, batches = 10) {
  batch_list = split(.data, ceiling(seq_along(.data)/batches))
  return(batch_list)
}