# Code example from 'frenchFISH' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(frenchFISH)
set.seed(366)

## ----readin_autocounts--------------------------------------------------------
fishalyserCsvPath <- system.file("extdata", 
                                 "SampleFISH.jpg_data.csv", 
                                 package="frenchFISH")
automatic_counts <- convertFishalyserCsvToCountMatrix(fishalyserCsvPath)

## ----correct_autocounts-------------------------------------------------------
set.seed(366)
nuclear_radius <- 40
section_height <- 5
corrected_automatic_counts <- getAutomaticCountsEstimates(automatic_counts, 
                                                          nuclear_radius, 
                                                          section_height)

## ----print_corrected_autocounts-----------------------------------------------
print(corrected_automatic_counts)

## ----readin_manualcounts------------------------------------------------------
manual_counts <- cbind(red = round(runif(20,0,5), 0), 
                       green = round(runif(20,0,5), 0), 
                       blue = round(runif(20,0,5), 0))

## ----correct_manualcounts-----------------------------------------------------
nuclear_radius <- 8
section_height <- 4
corrected_manual_counts <- getManualCountsEstimates(manual_counts, 
                                                    nuclear_radius, 
                                                    section_height)

## ----print_corrected_manualcounts---------------------------------------------
print(corrected_manual_counts)

