# Code example from 'MOFAdata' vignette. See references/ for full tutorial.

## ----warning=FALSE, message=FALSE---------------------------------------------
library(MOFAdata)
library(MultiAssayExperiment)

## ----warning=FALSE, message=FALSE---------------------------------------------
# Load data
# import list with mRNA, Methylation, Drug Response and Mutation data. 
data("CLL_data") 
lapply(CLL_data, dim) 

# Load sample metadata: Sex and Diagnosis
data("CLL_covariates")
head(CLL_covariates)

## ----warning=FALSE, message=FALSE---------------------------------------------
data("scMT_data") 
scMT_data

