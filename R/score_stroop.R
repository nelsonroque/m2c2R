#' m2c2R
#' @export
#' @param data name of tibble or data frame
#' @details Scores Stroop/Color Naming Task data. Takes tibble or data frame as
#' input, renames necessary variables, adds data tag to mark the data as 
#' scored, and adds columns to denote the scoring (m2c2_processing_hash, 
#' m2c2_processing_timestamp). 
#' @returns Returns a data frame of scored data
score_stroop <- function(data) {
  
  # check if data.frame or tibble
  if(is_data_frame_tibble(data)) {
    
    # score the data
    # since there is already an accuracy column in the data, only renaming 
    # RT to response_time is necessary
    scored <- data %>% 
      rename(response_time = RT)
    # %>% 
    #   mutate(accuracy = ifelse(user_response == correct_response, 1, 0))
    
  } else {
    
    # raise error if not a data.frame or tibble
    stop("`data` is not a data.frame or tibble. Please try again.")
  }
  
  # add processing hash and timestamp
  scored <- scored %>%
    append_process_cols()
  
  # add scored attribute
  scored <- add_data_tag(scored, tag_name="is_m2c2_scored", tag_value=T)

  return(scored)
}
