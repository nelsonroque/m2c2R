#' m2c2R
#' @export
get_tidy_datetime <- function(delim = "_") {
  cur_dts <- Sys.time()
  dt <- format(cur_dts, paste("%Y", "%m", "%d", "T", "%H", "%M", "%S", sep=delim))
  return(dt)
}