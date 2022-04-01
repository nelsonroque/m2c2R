#' m2c2R
#' @name get_file_ext
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param filepath Path to a file
#' @details This function takes a file path as input and returns the file extension
#' (csv, txt, xls, etc.) 
#' @return Returns file extension
get_file_ext <- function(filepath) {
  file_info = strsplit(filepath,"\\.")
  file_ext = file_info[[1]][2]
  return(file_ext)
}
