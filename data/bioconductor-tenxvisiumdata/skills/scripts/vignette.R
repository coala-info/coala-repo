# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE, error = FALSE)

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
(q <- query(eh, "TENxVisium"))

## -----------------------------------------------------------------------------
library(TENxVisiumData)
spe <- HumanHeart()

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()        # initialize hub instance
q <- query(eh, "TENxVisium") # retrieve 'TENxVisiumData' records
id <- q$ah_id[1]             # specify dataset ID to load
spe <- eh[[id]]              # load specified dataset

## -----------------------------------------------------------------------------
spe

## -----------------------------------------------------------------------------
head(spatialCoords(spe))

## -----------------------------------------------------------------------------
head(spatialData(spe))

## -----------------------------------------------------------------------------
imgData(spe)

## -----------------------------------------------------------------------------
spe <- MouseBrainSagittalAnterior()
table(spe$sample_id)

## -----------------------------------------------------------------------------
spe <- HumanOvarianCancer()
altExpNames(spe)

## -----------------------------------------------------------------------------
sessionInfo()

