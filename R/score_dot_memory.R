#' m2c2R
#' @export
score_dot_memory <- function(data, square_size=5, n_dots=3, grid_convert=F) {
  
  convert_dotmemory_grid_1d_2d <- function(v, grid_size=square_size) {
    d_x = v%%grid_size
    d_y = floor((v/grid_size))
    return(paste0(d_x, "_", d_y))
  }
  
  # check if data.frame or tibble
  if(is_data_frame_tibble(data)) {
    
    if(grid_convert) {
      data_p = data %>%
        # from dot_locations to underscore delimited coord pairs (starting 0)
        mutate(dot_locations_v1_candD = dot_locations,
               user_answers_v1_candD = user_answers) %>%
        select(-dot_locations, -user_answers) %>%
        rowwise() %>%
        mutate(dot1_conv = convert_dotmemory_grid_1d_2d(dot1), # insert translator
               dot2_conv = convert_dotmemory_grid_1d_2d(dot2),
               dot3_conv = convert_dotmemory_grid_1d_2d(dot3)) %>%
        mutate(dot_locations = paste(dot1_conv, dot2_conv, dot3_conv)) %>%
        mutate(resp1_conv = convert_dotmemory_grid_1d_2d(resp1), # insert translator
               resp2_conv = convert_dotmemory_grid_1d_2d(resp2),
               resp3_conv = convert_dotmemory_grid_1d_2d(resp3)) %>%
        mutate(user_answers = paste(resp1_conv, resp2_conv, resp3_conv))
    } else {
      data_p = data
    }
    
    # score the data
    scored <- data_p %>% 
      separate(dot_locations, c("dot1","dot2","dot3"), " ", convert=T) %>%
      separate(dot1, c("dot1_rx", "dot1_ry"), "_", convert=T) %>%
      separate(dot2, c("dot2_rx", "dot2_ry"), "_", convert=T) %>%
      separate(dot3, c("dot3_rx", "dot3_ry"), "_", convert=T) %>%
      separate(user_answers, c('user_dot1', "user_dot2", "user_dot3"), " ", convert=T) %>%
      separate(user_dot1, c("user_dot1_rx", "user_dot1_ry"), "_", convert=T) %>%
      separate(user_dot2, c("user_dot2_rx", "user_dot2_ry"), "_", convert=T) %>%
      separate(user_dot3, c("user_dot3_rx", "user_dot3_ry"), "_", convert=T) %>%
      mutate(r1_d1_distance = distance(user_dot1_rx, dot1_rx,
                                       user_dot1_ry, dot1_ry),
             r1_d2_distance = distance(user_dot1_rx, dot2_rx,
                                       user_dot1_ry, dot2_ry),
             r1_d3_distance = distance(user_dot1_rx, dot3_rx,
                                       user_dot1_ry, dot3_ry),
             
             r2_d1_distance = distance(user_dot2_rx, dot1_rx,
                                       user_dot2_ry, dot1_ry),
             r2_d2_distance = distance(user_dot2_rx, dot2_rx,
                                       user_dot2_ry, dot2_ry),
             r2_d3_distance = distance(user_dot2_rx, dot3_rx,
                                       user_dot2_ry, dot3_ry),
             
             r3_d1_distance = distance(user_dot3_rx, dot1_rx,
                                       user_dot3_ry, dot1_ry),
             r3_d2_distance = distance(user_dot3_rx, dot2_rx,
                                       user_dot3_ry, dot2_ry),
             r3_d3_distance = distance(user_dot3_rx, dot3_rx,
                                       user_dot3_ry, dot3_ry)) %>%
      rowwise() %>%
      mutate(r1_min_dist = min(c(r1_d1_distance, r1_d2_distance, r1_d3_distance)),
             r2_min_dist = min(c(r2_d1_distance, r2_d2_distance, r2_d3_distance)),
             r3_min_dist = min(c(r3_d1_distance, r3_d2_distance, r3_d3_distance))) %>%
      rowwise() %>%
      mutate(r1_which_dot = which.min(c(r1_d1_distance, r1_d2_distance, r1_d3_distance)),
             r2_which_dot = which.min(c(r2_d1_distance, r2_d2_distance, r2_d3_distance)),
             r3_which_dot = which.min(c(r3_d1_distance, r3_d2_distance, r3_d3_distance))) %>%
      rowwise() %>%
      mutate(r1_n_unique_distances = length(unique(c(r1_d1_distance, r1_d2_distance, r1_d3_distance))),
             r2_n_unique_distances = length(unique(c(r2_d1_distance, r2_d2_distance, r2_d3_distance))),
             r3_n_unique_distances = length(unique(c(r3_d1_distance, r3_d2_distance, r3_d3_distance)))) %>%
      mutate(r1_n_amb_dots = n_dots - r1_n_unique_distances,
             r2_n_amb_dots = n_dots - r2_n_unique_distances,
             r3_n_amb_dots = n_dots - r3_n_unique_distances) %>%
      rowwise() %>%
      mutate(r1_n_at_min = length(which(c(r1_d1_distance, r1_d2_distance, r1_d3_distance) == min(c(r1_d1_distance, r1_d2_distance, r1_d3_distance)))),
             r2_n_at_min = length(which(c(r2_d1_distance, r2_d2_distance, r2_d3_distance) == min(c(r2_d1_distance, r2_d2_distance, r2_d3_distance)))),
             r3_n_at_min = length(which(c(r3_d1_distance, r3_d2_distance, r3_d3_distance) == min(c(r3_d1_distance, r3_d2_distance, r3_d3_distance))))) %>%
      mutate(r1_perfect = ifelse(r1_min_dist == 0, 1, 0),
             r2_perfect = ifelse(r2_min_dist == 0, 1, 0),
             r3_perfect = ifelse(r3_min_dist == 0, 1, 0),
             is_perfect_trial = ifelse(r1_min_dist == 0 & r2_min_dist == 0 & r3_min_dist == 0,1,0)) %>%
      rowwise() %>%
      mutate(sum_perfect_dots = sum(c(r1_perfect, r2_perfect, r3_perfect))) %>%
      mutate(prop_perfect_dots = sum_perfect_dots / n_dots) %>%
      rowwise() %>%
      mutate(hausdorff_distance = pracma::hausdorff_dist(matrix(c(dot1_rx, dot1_ry,
                                                                  dot2_rx, dot2_ry,
                                                                  dot3_rx, dot3_ry),
                                                                ncol=2, nrow=3, byrow=T),
                                                         matrix(c(user_dot1_rx, user_dot1_ry,
                                                                  user_dot2_rx, user_dot2_ry,
                                                                  user_dot3_rx, user_dot3_ry),
                                                                ncol=2, nrow=3, byrow=T))) %>%
      mutate(min_error_distance = min(r1_min_dist, r2_min_dist, r3_min_dist),
             mean_error_distance = mean(r1_min_dist, r2_min_dist, r3_min_dist),
             sum_error_distance = sum(r1_min_dist, r2_min_dist, r3_min_dist),
             n_ambiguous_responses = sum(r1_n_amb_dots, r2_n_amb_dots, r3_n_amb_dots)) %>%
      mutate(prop_ambiguous_responses = n_ambiguous_responses / n_dots) %>%
      mutate(sum_error_distance_adj_ambiguous = sum_error_distance / (1 - prop_ambiguous_responses))
    
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