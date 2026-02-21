# Code example from 'muscData' vignette. See references/ for full tutorial.

## ----message = FALSE----------------------------------------------------------
library(muscData)
Kang18_8vs8()

## ----message = FALSE----------------------------------------------------------
# create Hub instance
library(ExperimentHub)
eh <- ExperimentHub()
(q <- query(eh, "muscData"))

## ----message = FALSE, results = 'hide'----------------------------------------
# load data via accession ID
eh[["EH2259"]]

## ----message = FALSE----------------------------------------------------------
listResources(eh, "muscData")

## ----message = FALSE, results = 'hide'----------------------------------------
# view metadata
mcols(q)
Kang18_8vs8(metadata = TRUE)

# load data using metadata search terms
loadResources(eh, "muscData", c("PBMC", "INF-beta"))

## -----------------------------------------------------------------------------
sessionInfo()

