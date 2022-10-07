#' m2c2R
#' @name make_tidy_datetime
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @param delim Delimiter to use in separating parts of the datetime object.
#' @details This function pulls and formats the Sys.time() from the current R session, using
#' the specified delimiter. 
#' @return Returns formatted datetime.
#' @export
make_tidy_datetime <- function(delim = "_") {
  cur_dts <- Sys.time()
  dt <- format(cur_dts, paste("%Y", "%m", "%d", "T", "%H", "%M", "%S", sep=delim))
  return(dt)
}
