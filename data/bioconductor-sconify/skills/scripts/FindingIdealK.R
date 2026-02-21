# Code example from 'FindingIdealK' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      results = "markup", 
                      message = FALSE, 
                      warning = FALSE)
library(Sconify)
library(dplyr)

## ----eval = FALSE-------------------------------------------------------------
# # Multiples of 10 from 10 to 100, for dataset of 1000 cells
# wand.k.titration <- 1:100 %>% .[. %% 10 == 0]
# wand.ideal.k <- ImputeTesting(k.titration = wand.k.titration,
#                               cells = wand.il7,
#                               input.markers = input.markers,
#                               test.markers = funct.markers)

## -----------------------------------------------------------------------------
wand.ideal.k

