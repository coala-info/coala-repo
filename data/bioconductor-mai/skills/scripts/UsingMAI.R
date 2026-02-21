# Code example from 'UsingMAI' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MAI")

## -----------------------------------------------------------------------------
# Load the MAI package
library(MAI)
# Load the example data with missing values
data("untargeted_LCMS_data")
# Set a seed for reproducibility
## Estimating pattern of missingness involves imposing MCAR/MAR into the data
## these are done at random and as such may slightly change the results of the
## estimated parameters.
set.seed(137690)
# Impute the data using BPCA for predicted MCAR value imputation and
# use Single imputation for predicted MNAR value imputation

Results = MAI(data_miss = untargeted_LCMS_data, # The data with missing values
          MCAR_algorithm = "BPCA", # The MCAR algorithm to use
          MNAR_algorithm = "Single", # The MNAR algorithm to use
          assay_ix = 1, # If SE, designates the assay to impute
          forest_list_args = list( # random forest arguments for training
            ntree = 300,
            proximity = FALSE
        ),
          verbose = TRUE # allows console message output
        )

# Get MAI imputations
Results[["Imputed_data"]][1:5, 1:5] # show only 5x5

## -----------------------------------------------------------------------------
# Get the estimated mixed missingness parameters
Results[["Estimated_Params"]]

## -----------------------------------------------------------------------------
# Load the SummarizedExperiment package
suppressMessages(
  library(SummarizedExperiment)
)

# Load the example data with missing values
data("untargeted_LCMS_data")
# Turn the data to a SummarizedExperiment
se = SummarizedExperiment(untargeted_LCMS_data)
# Set a seed for reproducibility
## Estimating pattern of missingness involves imposing MCAR/MAR into the data
## these are done at random and as such may slightly change the results of the
## estimated parameters.
set.seed(137690)
# Impute the data using BPCA for predicted MCAR value imputation and
# use Single imputation for predicted MNAR value imputation

Results = MAI(se, # The data with missing values
          MCAR_algorithm = "BPCA", # The MCAR algorithm to use
          MNAR_algorithm= "Single", # The MNAR algorithm to use
          assay_ix = 1, # If SE, designates the assay to impute
          forest_list_args = list( # random forest arguments for training
            ntree = 300,
            proximity = FALSE
        ),
          verbose = TRUE # allows console message output
        )

# Get MAI imputations
assay(Results)[1:5, 1:5] # show only 5x5

## -----------------------------------------------------------------------------
# Get the estimated mixed missingness parameters
metadata(Results)[["meta_assay_1"]][["Estimated_Params"]]

## -----------------------------------------------------------------------------
sessionInfo()

