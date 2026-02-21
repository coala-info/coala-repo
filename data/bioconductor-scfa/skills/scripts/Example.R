# Code example from 'Example' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE------------------
library(knitr)
opts_chunk$set(fig.align = 'center', fig.width = 6, fig.height = 5, dev = 'png')

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# 
# BiocManager::install("SCFA")

## ----eval=FALSE---------------------------------------------------------------
# library(SCFA)
# 
# # If libtorch is not automatically installed by torch, it can be installed manually using:
# torch::install_torch()

## ----eval=TRUE----------------------------------------------------------------
#Load required library
library(SCFA)
library(survival)

# Load example data (GBM dataset), for other dataset, download the rds file from the Data folder at https://bioinformatics.cse.unr.edu/software/scfa/Data/ and load the rds object
data("GBM")
# List of one matrix of microRNA data, other examples would have 3 matrices of 3 data types
dataList <- GBM$data
# Survival information
survival <- GBM$survival

## ----eval=TRUE----------------------------------------------------------------
# Generating subtyping result
set.seed(1)
subtype <- SCFA(dataList, seed = 1, ncores = 4L)

# Perform survival analysis on the result
coxFit <- coxph(Surv(time = Survival, event = Death) ~ as.factor(subtype), data = survival, ties="exact")
coxP <- round(summary(coxFit)$sctest[3],digits = 20)
print(coxP)

## ----eval=TRUE----------------------------------------------------------------
# Split data to train and test
set.seed(1)
idx <- sample.int(nrow(dataList[[1]]), round(nrow(dataList[[1]])/2) )

survival$Survival <- survival$Survival - min(survival$Survival) + 1 # Survival time must be positive

trainList <- lapply(dataList, function(x) x[idx, ] )
trainSurvival <- Surv(time = survival[idx,]$Survival, event =  survival[idx,]$Death)

testList <- lapply(dataList, function(x) x[-idx, ] )
testSurvival <- Surv(time = survival[-idx,]$Survival, event =  survival[-idx,]$Death)

# Perform risk prediction
result <- SCFA.class(trainList, trainSurvival, testList, seed = 1, ncores = 4L)

# Validation using concordance index
c.index <- survival::concordance(coxph(testSurvival ~ result))$concordance
print(c.index)

## ----eval=TRUE----------------------------------------------------------------
sessionInfo()

