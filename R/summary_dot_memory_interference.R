#' m2c2R
#' @export
summary_dot_memory_interference <- function(data, group_var, var_prefix = "dot_memory", experimental = F, total_time_exp = NA) {
  
  # check if data.frame or tibble
  if(is_data_frame_tibble(data)) {
    
    # check if data is scored
    if(is_data_tag_valid(data, tag_name = "is_m2c2_scored", tag_value = T)) {
      
      # produce primary outcome summary
      summary_data <- data %>%
        group_by(.dots = group_var) %>%
        mutate(timestamp_diff = timestamp - lag(timestamp)) %>%
        summarise(n_correct_taps = sum(tap_correct[tap_correct == 1], na.rm=T),
                  n_total_taps = n(),
                  mean_intertap_time_ms = mean(timestamp_diff, na.rm=T)) %>%
        mutate(n_incorrect_taps = n_total_taps - n_correct_taps) %>%
        mutate(tap_throughput = n_total_taps / total_time_exp,
               tap_throughput_correct = n_correct_taps / total_time_exp)
      
      if(experimental) {
        stop("Sorry, this function does not yet have experimental output.")
      }
      
    } else {
      
      # raise error if `data` not scored
      stop("Please score `data` first. Please try again.")
    }
    
  } else {
    
    # raise error if not a data.frame or tibble
    stop("`data` is not a data.frame or tibble. Please try again.")
  }
  
  # make sure that all non-ID columns have a prefix that is unique to the task
  summary_data <- append_colname_prefix(summary_data, group_var, var_prefix)
  
  # add processing hash and timestamp
  summary_data <- summary_data %>%
    append_process_cols()
  
  # add summary attribute
  summary_data <- add_data_tag(summary_data, tag_name="is_m2c2_summary", tag_value=T)
  
  return(summary_data)
}