#' m2c2R
#' @export
get_file_ext <- function(filepath) {
  file_info = strsplit(filepath,"\\.")
  file_ext = file_info[[1]][2]
  return(file_ext)
}