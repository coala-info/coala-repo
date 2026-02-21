# Code example from 'RTCGAToolbox-vignette' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("RTCGAToolbox")

## -----------------------------------------------------------------------------
library(RTCGAToolbox)
# Valid aliases
getFirehoseDatasets()

## -----------------------------------------------------------------------------
# Valid stddata runs
getFirehoseRunningDates(last = 3)

## -----------------------------------------------------------------------------
# Valid analysis running dates (will return 3 recent date)
getFirehoseAnalyzeDates(last=3)

## ----message=FALSE------------------------------------------------------------
# READ mutation data and clinical data
brcaData <- getFirehoseData(dataset="READ", runDate="20160128",
    forceDownload=TRUE, clinical=TRUE, Mutation=TRUE)

## -----------------------------------------------------------------------------
brcaData

## -----------------------------------------------------------------------------
data(accmini)
accmini

## -----------------------------------------------------------------------------
biocExtract(accmini, "RNASeq2Gene")

biocExtract(accmini, "CNASNP")

## -----------------------------------------------------------------------------
head(getData(accmini, "clinical"))

getData(accmini, "RNASeq2GeneNorm")

getData(accmini, "GISTIC", "AllByGene")

## -----------------------------------------------------------------------------
sessionInfo()

