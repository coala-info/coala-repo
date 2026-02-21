# Code example from 'billing' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager", repos = "https://cran.r-project.org")
# BiocManager::install("AnVILBilling")

## ----message =FALSE, eval = TRUE, cache = FALSE-------------------------------
library(AnVILBilling)

## ----lkd----------------------------------------------------------------------
suppressPackageStartupMessages({
library(AnVILBilling)
library(dplyr)
library(magrittr)
library(BiocStyle)
})

demo_rec

## ----lklklk-------------------------------------------------------------------
v = getValues(demo_rec@reckoning, "terra-submission-id")
v

## ----adasd--------------------------------------------------------------------
s = subsetByKeyValue(demo_rec@reckoning, "terra-submission-id", v)
s

## ----vars---------------------------------------------------------------------
names(s)

## ----lkpr---------------------------------------------------------------------
AnVILBilling:::getSkus(s)

## ----cost---------------------------------------------------------------------
data(demo_rec) # makes rec
v = getValues(demo_rec@reckoning, "terra-submission-id")[1] # for instance
getSubmissionCost(demo_rec@reckoning,v)

## ----ram----------------------------------------------------------------------
data(demo_rec) # makes rec
v = getValues(demo_rec@reckoning, "terra-submission-id")[1] # for instance
getSubmissionRam(demo_rec@reckoning,v)

## ----getsin-------------------------------------------------------------------
sessionInfo()

