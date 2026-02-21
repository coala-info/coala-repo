# Code example from 'MetaGxPancreas' vignette. See references/ for full tutorial.

## ----installation, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("MetaGxPancreas")

## ----load---------------------------------------------------------------------
library(MetaGxPancreas)

## ----load_datasets------------------------------------------------------------
pancreasData <- loadPancreasDatasets()
duplicates <- pancreasData$duplicates
SEs <- pancreasData$SummarizedExperiments

## ----sample_size--------------------------------------------------------------
numSamples <- vapply(
  SEs,
  function(SE) length(colnames(SE)),
  FUN.VALUE = numeric(1)
)

sampleNumberByDataset <- data.frame(
  numSamples = numSamples,
  row.names = names(SEs)
)

totalNumSamples <- sum(sampleNumberByDataset$numSamples)
sampleNumberByDataset <- rbind(sampleNumberByDataset, totalNumSamples)
rownames(sampleNumberByDataset)[nrow(sampleNumberByDataset)] <- 'Total'

knitr::kable(sampleNumberByDataset)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

