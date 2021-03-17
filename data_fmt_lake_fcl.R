
#' combine data of Vander-Zanden 2007 and Ward 2017

# setup -------------------------------------------------------------------

  pacman::p_load(tidyverse)


# data --------------------------------------------------------------------
  
  # data from Vander Zanden 2007, Oikos
  d1 <- read_csv("data_raw/data_oikos2007.csv") %>% 
    mutate(lake_id = str_to_lower(ecosystem),
           ecosystem_key = str_to_lower(ecosystem)) %>% 
    mutate(ecosystem_key = str_remove_all(ecosystem_key, pattern = "\\s"))
  
  # data from Ward and McCann 2017, Nature Communications
  d2 <- read_csv("data_raw/data_ward2017.csv") %>% 
    mutate(ecosystem_key = str_to_lower(Ecosystem)) %>% 
    mutate(ecosystem_key = str_remove_all(ecosystem_key, pattern = "\\s")) %>% 
    mutate(ecosystem_key = str_replace(ecosystem_key,
                                       pattern = "lakewinnipegsouthbasin",
                                       replacement = "lakewinnepeg")) %>% 
    mutate(ecosystem_key = str_replace(ecosystem_key,
                                       pattern = "macdonaldlake\\(priortobassintroduction\\)",
                                       replacement = "macdonaldlake")) %>% 
    mutate(ecosystem_key = str_replace(ecosystem_key,
                                       pattern = "happyislelake",
                                       replacement = "happyisle")) %>% 
    mutate(ecosystem_key = str_replace(ecosystem_key,
                                       pattern = "gunthorpehalllake",
                                       replacement = "gunthropehalllake")) %>% 
    mutate(ecosystem_key = str_replace(ecosystem_key,
                                       pattern = "ryans1billabonglake",
                                       replacement = "ryan's1")) %>% 
    mutate(ecosystem_key = str_replace(ecosystem_key,
                                       pattern = "lakecoquiero",
                                       replacement = "lakecoqueiro")) %>% 
    rename(TP = 'Total Phosphorus (ug/L)') %>% 
    rename(fcl = "Maximum trophic position") %>% 
    select(TP, ecosystem_key)
    
  dat <- d1 %>% 
    left_join(d2, by = c("ecosystem_key"))

# export ------------------------------------------------------------------

  write_csv(dat, "data_fmt/data_fcl_lake.csv")    
    
    
