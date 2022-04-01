#' m2c2R
#' @name append_process_cols
#' 
#' @author Nelson Roque, \email{Nelson.Roque@@ucf.edu}
#' 
#' @export
#' @param data Name of a tibble or data frame
#' @details This function creates MD5 checksum for data file and add as variable 
#' (m2c2_processing_hash) and adds a data processing timestamp to denote when
#' the data were processed.  
#' @return Returns input data frame with m2c2_processing_hash and m2c2_processing_timestamp added.
#' @import tidyverse
#' @import digest
append_process_cols <- function(data, algo="md5") {
  # parameter validation
  # verify data passed in is data.frame or tibble
  if(is_data_frame_tibble(data)) {
    
    # generate MD5 checksum of `data`
    data_md5 <- digest::digest(data, algo=algo)
    
    # append MD5 checksum and file processing timestamp to `data`
    data_stamped <- data %>% 
      mutate(m2c2_processing_hash = data_md5) %>%
      mutate(m2c2_processing_timestamp = format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
    
    # add package version
    
  } else {
    
    # if data is valid, stop code execution and present an error message
    stop("`data` is not a data.frame or tibble. Please try again.")
  }
  
  return(data_stamped)
}
