# Code example from 'MicrobiomeBenchmarkData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----installation, eval=FALSE-------------------------------------------------
# ## Install BioConductor if not installed
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# ## Release version (not yet in Bioc, so it doesn't work yet)
# BiocManager::install("MicrobiomeBenchmarkData")
# 
# ## Development version
# BiocManager::install("waldronlab/MicrobiomeBenchmarkData")

## ----message=FALSE------------------------------------------------------------
library(MicrobiomeBenchmarkData)
library(purrr)

## -----------------------------------------------------------------------------
data('sampleMetadata', package = 'MicrobiomeBenchmarkData')
## Get columns present in all samples
sample_metadata <- sampleMetadata |> 
    discard(~any(is.na(.x))) |> 
    head()
knitr::kable(sample_metadata)

## -----------------------------------------------------------------------------
dats <- getBenchmarkData()

## -----------------------------------------------------------------------------
dats

## -----------------------------------------------------------------------------
tse <- getBenchmarkData('HMP_2012_16S_gingival_V35_subset', dryrun = FALSE)[[1]]
tse

## -----------------------------------------------------------------------------
list_tse <- getBenchmarkData(dats$Dataset[2:4], dryrun = FALSE)
str(list_tse, max.level = 1)

## -----------------------------------------------------------------------------
mbd <- getBenchmarkData(dryrun = FALSE)
str(mbd, max.level = 1)

## -----------------------------------------------------------------------------
## In the case, the column is named as taxon_annotation 
tse <- mbd$HMP_2012_16S_gingival_V35_subset
rowData(tse)

## ----eval=FALSE---------------------------------------------------------------
# removeCache()

## -----------------------------------------------------------------------------
sessionInfo()

