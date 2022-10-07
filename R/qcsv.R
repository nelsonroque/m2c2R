#' m2c2R

#' @name qcsv
#' @param . class: data.frame
#' @param ts class: boolean
#' @param tz class: string
#' @examples
#' qcsv(., ts=T, tz="UTC")
#' @export
qcsv <- function(., ts=T, tz="UTC") {
  dname <- deparse(substitute(.))
  if(ts){
    ts_v <- m2c2R::make_tidy_datetime()
    write_csv(., paste0(dname, "_", ts_v,".csv"))
  } else {
    write_csv(., paste0(dname, ".csv"))
  }
}