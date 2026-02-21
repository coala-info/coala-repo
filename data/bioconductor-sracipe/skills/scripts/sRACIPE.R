# Code example from 'sRACIPE' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, fig.width = 7, fig.height = 5)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
# install.packages("BiocManager")
# BiocManager::install("sRACIPE")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install(“lusystemsbio/sRACIPE”)

## ----Load, message=FALSE------------------------------------------------------
library(sRACIPE)

## ----eval=TRUE----------------------------------------------------------------
suppressWarnings(suppressPackageStartupMessages(library(sRACIPE)))

# Load a demo circuit
data("demoCircuit")
demoCircuit


## -----------------------------------------------------------------------------

rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 20,
                             plots = FALSE, integrateStepSize = 0.1, 
                             numConvergenceIter = 5)
cd <- sracipeConverge(rSet)


## ----eval=TRUE----------------------------------------------------------------
rSet <- sRACIPE::sracipeNormalize(rSet)
rSet <- sRACIPE::sracipePlotData(rSet, plotToFile = FALSE)


## ----eval=FALSE---------------------------------------------------------------
# data("demoCircuit")
# 
# rSet <- SRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 10,
#                              plots = FALSE, integrateStepSize = 0.1,
#                              numConvergenceIter = 5, nIC = 2)
# stateLst <- sracipeUniqueStates(rSet)
# 

## ----eval=TRUE----------------------------------------------------------------
data("demoCircuit")
rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit, 
                             numModels = 50, plots = FALSE, 
                             integrateStepSize = 0.1, 
                             numConvergenceIter = 5)
kd <- sRACIPE::sracipeKnockDown(rSet, plotToFile = FALSE,
                                reduceProduction=50)

## ----eval=FALSE---------------------------------------------------------------
#  sRACIPE::sracipePlotCircuit(rSet, plotToFile = FALSE, physics = TRUE)

## ----eval=TRUE----------------------------------------------------------------
data("repressilator")
rSet <- sRACIPE::sracipeSimulate(circuit = repressilator, 
                             numModels = 30, plots = FALSE, 
                             integrateStepSize = 0.1, 
                             numConvergenceIter = 5,
                             limitcycles = TRUE)

## ----eval=TRUE----------------------------------------------------------------
rSet <- sracipeSimulate(circuit = demoCircuit,
                        numConvergenceIter = 5,
                        numModels = 10,
                        integrateStepSize = 0.1, 
                        geneClamping = data.frame(A = c(1))
                        )

## ----eval=TRUE----------------------------------------------------------------
rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 20, 
                             initialNoise = 15, noiseScalingFactor = 0.1,
                             nNoise = 2,
                             plots = TRUE, plotToFile = FALSE, 
                             integrateStepSize = 0.1, 
                             simulationTime = 30)


## ----eval=TRUE----------------------------------------------------------------
rSet <- sRACIPE::sracipeSimulate(circuit = demoCircuit, numModels = 20, 
                             plots = FALSE, integrate = FALSE)
params <- sRACIPE::sracipeParams(rSet)
modifiedParams <- as.matrix(params) 
modifiedParams[,1] <- 0.1*modifiedParams[,1]
sRACIPE::sracipeParams(rSet) <- DataFrame(modifiedParams)
rSet <- sRACIPE::sracipeSimulate(rSet, plots = FALSE, genParams = FALSE)


## -----------------------------------------------------------------------------
sessionInfo()

