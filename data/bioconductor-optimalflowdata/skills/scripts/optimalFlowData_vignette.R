# Code example from 'optimalFlowData_vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----ej0, eval = FALSE--------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("optimalFlowData")

## ----ej01, eval = TRUE--------------------------------------------------------
library(optimalFlowData)
head(Cytometry1)

## ----ej1, eval = TRUE---------------------------------------------------------
database <- buildDatabase(
  dataset_names = paste0('Cytometry', c(2:5, 7:9, 12:17, 19, 21)),
    population_ids = c('Monocytes', 'CD4+CD8-', 'Mature SIg Kappa', 'TCRgd-'))

## ----ej2, echo = TRUE---------------------------------------------------------
pairs(database[[1]][,c(4, 3, 9)], col = droplevels(database[[1]][, 11]))

## ----ej3, echo = TRUE---------------------------------------------------------
help("cytometry.diagnosis") # for an explanation of the abbreviations
cytometry.diagnosis

