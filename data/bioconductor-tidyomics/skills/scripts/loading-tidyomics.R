# Code example from 'loading-tidyomics' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "# "
)

## ----eval = FALSE-------------------------------------------------------------
# tidyomics_packages()

## ----echo = FALSE-------------------------------------------------------------
# Call tidyomics_packages before attaching tidyomics to preserve logical presentation order
tidyomics::tidyomics_packages()

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("tidyomics")

## ----eval = FALSE-------------------------------------------------------------
# # Additional manipulation package
# BiocManager::install("plyinteractions")
# 
# # Analysis packages
# BiocManager::install("tidybulk")
# BiocManager::install("nullranges")

## ----eval = FALSE-------------------------------------------------------------
# library(tidyomics)

## ----eval = FALSE-------------------------------------------------------------
# # Additional manipulation package
# library(plyinteractions)
# 
# # Analysis packages
# library(tidybulk)
# library(nullranges)

## -----------------------------------------------------------------------------
sessionInfo()

