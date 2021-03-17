
#' Pre-analysis

# setup -------------------------------------------------------------------

  pacman::p_load(tidyverse)
  dat <- read_csv("data_fmt/data_fcl_lake.csv") %>% 
    drop_na(lat, lake_area, TP)


# plot --------------------------------------------------------------------
  
  dat %>% 
    mutate(resid_fcl = resid(lm(fcl ~ log(lake_area), data = .))) %>% 
    ggplot() + 
    geom_point(aes(x = log(TP, 10), y = resid_fcl, color = abs(lat)))
  