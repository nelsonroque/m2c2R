#' m2c2R
#' @name read_m2c2_local
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param filepath Path to a data file
#' @param na If reading in a .txt file, note the value used for missing data. 
#' @details This function reads in M2C2 data files from a local file path and saves 
#' to a data frame in R.  
#' @return Returns data frame created from provided data file. 
#' @import tidyverse
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