# Code example from 'methylcockData' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----get_experimenthub, warning = FALSE, message=FALSE------------------------
library(ExperimentHub)
library(methylclockData)

# Get experimentHub records
eh <- ExperimentHub()

# Get data about methylclockData experimentHub
pData <- query(eh , "methylclockData")

# Get information rows about methylclockData
df <- mcols(pData)
df

# Retrieve data with Hobarth's clock coefficients
pData["EH6071"]



## ----get_Clocks, warning = FALSE, message=FALSE-------------------------------

#  Hovarths CpGs to train a Bayesian Neural Network
cpgs.bn <- get_cpgs_bn()
head(cpgs.bn)

# Hannum's clock coefficients
coefHannum <- get_coefHannum()
head(coefHannum)

# Hobarth's clock coefficients
coefHorvath <- get_coefHorvath()
head(coefHorvath)

# Knight's clock coefficients
coefKnightGA <- get_coefKnightGA()
head(coefKnightGA)

# Lee's Gestational Age clock coefficients
coefLeeGA <- get_coefLeeGA()
head(coefLeeGA)

# Levine's clock coefficients
coefLevine <- get_coefLevine()
head(coefLevine)

# Mayne's clock coefficients
coefMayneGA <- get_coefMayneGA()
head(coefMayneGA)

# PedBE's clock coefficients
coefPedBE <- get_coefPedBE()
head(coefPedBE)

#  Horvath's skin+blood clock coefficients
coefSkin <- get_coefSkin()
head(coefSkin)

# Telomere Length clock coefficients
coefTL <- get_coefTL()
head(coefTL)

# BLUP clock coefficients
coefBLUP <- get_coefBLUP()
head(coefBLUP)

# EN clock coefficients
coefEN <- get_coefEN()
head(coefEN)

# EPIC clock coefficients
coefEPIC <- get_coefEPIC()
head(coefEPIC)

#  Wu's clock coefficients
Wu <- get_coefWu()
head(Wu)

# # references
references <- get_references()
load(references)


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

