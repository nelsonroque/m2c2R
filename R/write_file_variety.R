#' m2c2R
#' @export
write_file_variety <- function(data, filename) {
  if(filename != "" | !is.na(filename) | !is.null(filename)) {
    write_csv(data, filename)
    data_to_json(data, filename = filename)
  } else {
    stop("`filename` invalid. Please try again.")
  }
} 
