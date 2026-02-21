# Code example from 'healthyControlsPresenceChecker' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
  BiocStyle::markdown()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(healthyControlsPresenceChecker)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))`
#         `install.packages("BiocManager")
# 
# BiocManager::install("healthyControlsPresenceChecker")

## ----eval=FALSE---------------------------------------------------------------
# library("healthyControlsPresenceChecker")

## ----eval=TRUE----------------------------------------------------------------
outcomeGSE47407 <- healthyControlsCheck("GSE47407", TRUE)

## ----tidy=TRUE----------------------------------------------------------------
sessionInfo()

