#' m2c2R
#' @export
read_m2c2_local <- function(filepath,na=na) {
  if(get_file_ext(filepath) == "csv"){
    df <- readr::read_csv(filepath)
  } else{
    if(get_file_ext(filepath) == "sav"){
      df <- foreign::read_spss(filepath)
    } else {
      if(get_file_ext(filepath) == "sas7bdat"){
        df <- haven::read_sas(filepath)
      } else{
        if(get_file_ext(filepath) == "txt"){
          df <- readr::read_delim(filepath,"|", escape_double = FALSE, trim_ws = TRUE, na=na)
        } 
      }
    }
  }
  return(df)
}