# Code example from 'seahtrue' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  #rmarkdown.html_vignette.check_title = FALSE
)

## ----load packages, include=FALSE---------------------------------------------

suppressPackageStartupMessages({
  library(dplyr)
  library(seahtrue)
  #library(ggplot2)
})



## -----------------------------------------------------------------------------

# data_file_path <- 
#   system.file("data", 
#               "revive_output_donor_A.rda", 
#               package = "seahtrue")
# 
# load(data_file_path)


#library(seahtrue)
#library(tidyverse)
revive_output_donor_A <- 
  system.file("extdata", 
              "20191219_SciRep_PBMCs_donor_A.xlsx",
              package = "seahtrue") %>% 
  seahtrue::revive_xfplate()
  


## -----------------------------------------------------------------------------
revive_output_donor_A %>%  
  dplyr::glimpse()


## -----------------------------------------------------------------------------
revive_output_donor_A %>%  
  purrr::pluck("rate_data", 1)


## -----------------------------------------------------------------------------
revive_output_donor_A %>%  
  purrr::pluck("raw_data", 1)


## -----------------------------------------------------------------------------
revive_output_donor_A %>%  
  purrr::pluck("assay_info", 1) %>% 
  pull(cartridge_barcode)


## -----------------------------------------------------------------------------
# KSV in barcode
revive_output_donor_A %>%  
  purrr::pluck("assay_info", 1) %>% 
  pull(cartridge_barcode) %>% 
  stringr::str_sub(-18, -13)
  
# KSV in assay info sheet
revive_output_donor_A %>%  
  purrr::pluck("assay_info", 1) %>% 
  pull(KSV) 

# F0 can be calculated using the stern-volmer equation
# and the info 
# emission target at ambient O2 = 12500
# O2 level at ambient in sample medium in well = 151.69
#
# F0/F = 1 + KSV*O2
# F0 = (1+KSV*O2)*F
# F0 = (1+ KSV*151.69)*12500

# F0 from assay info sheet
revive_output_donor_A %>%  
  purrr::pluck("assay_info", 1) %>% 
  pull(F0) 

## -----------------------------------------------------------------------------
revive_output_donor_A %>%  
  purrr::pluck("assay_info", 1) %>% 
  pull(minutes_to_start_measurement_one)


## -----------------------------------------------------------------------------
revive_output_donor_A %>%  
  purrr::pluck("rate_data", 1) %>% str()


## -----------------------------------------------------------------------------
  revive_output_donor_A %>%  
    purrr::pluck("rate_data", 1) %>% 
    attributes() %>% 
    purrr::pluck("was_background_corrected")


## -----------------------------------------------------------------------------
  revive_output_donor_A %>%  
    purrr::pluck("injection_info", 1)


## -----------------------------------------------------------------------------
sessionInfo()

