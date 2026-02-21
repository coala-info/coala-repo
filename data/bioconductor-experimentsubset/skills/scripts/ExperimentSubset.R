# Code example from 'ExperimentSubset' vignette. See references/ for full tutorial.

## ----options, include=FALSE, echo=FALSE---------------------------------------
knitr::opts_chunk$set(warning=FALSE, error=FALSE, message=FALSE)

## ----eval= FALSE--------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE)){
#     install.packages("BiocManager")}
# BiocManager::install("ExperimentSubset")

## ----eval = FALSE-------------------------------------------------------------
# library(devtools)
# install_github("campbio/ExperimentSubset")

## -----------------------------------------------------------------------------
library(ExperimentSubset)

## -----------------------------------------------------------------------------
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(list(counts = counts))
es <- ExperimentSubset(sce)
es

## -----------------------------------------------------------------------------
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
ExperimentSubset(list(counts = counts))

## -----------------------------------------------------------------------------
es <- createSubset(es, 
                   subsetName = "subset1",
                   rows = c(1:2),
                   cols = c(1:5),
                   parentAssay = "counts")
es

## -----------------------------------------------------------------------------
subset1Assay <- assay(es, "subset1")
subset1Assay[,] <- subset1Assay[,] + 1
es <- setSubsetAssay(es, 
                  subsetName = "subset1", 
                  inputMatrix = subset1Assay, 
                  subsetAssayName = "subset1Assay")
es

## -----------------------------------------------------------------------------
#get assay from 'subset1'
getSubsetAssay(es, "subset1")

#get internal 'subset1Assay'
getSubsetAssay(es, "subset1Assay")

## -----------------------------------------------------------------------------
subsetSummary(es)

## -----------------------------------------------------------------------------
#store colData to parent object
colData(es) <- cbind(colData(es), sampleID = seq(1:dim(es)[2]))

#store colData to 'subset1' using option 1
colData(es, subsetName = "subset1") <- cbind(
  colData(es, subsetName = "subset1"), 
  subsetSampleID1 = seq(1:subsetDim(es, "subset1")[2]))

#store colData to 'subset1' using option 2
subsetColData(es, "subset1") <- cbind(
  subsetColData(es, "subset1"), 
  subsetSampleID2 = seq(1:subsetDim(es, "subset1")[2]))

#get colData from 'subset1' without parent colData
subsetColData(es, "subset1", parentColData = FALSE)

#get colData from 'subset1' with parent colData
subsetColData(es, "subset1", parentColData = TRUE)

#same applies to `colData` and `rowData` methods when using with subsets
colData(es, subsetName = "subset1", parentColData = FALSE) #without parent data
colData(es, subsetName = "subset1", parentColData = TRUE) #with parent data


## -----------------------------------------------------------------------------
#creating a dummy ES object
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(list(counts = counts))
es <- ExperimentSubset(sce)

#create a subset
es <- createSubset(es, subsetName = "subset1", rows = c(1:2), cols = c(1:4))

#store an assay inside the newly created 'subset1'
#note that 'assay<-' setter has two important parameters 'x' and 'i' where
#'x' is the object and 'i' is the assay name, but in the case of storing to a
#subset we use 'x' as the object, 'i' as the subset name inside which the assay
#should be stored and an additional 'subsetAssayName' parameter which defines
#the name of the new assay
assay(
  x = es, 
  i = "subset1", 
  subsetAssayName = "subset1InternalAssay") <- matrix(rpois(100, lambda = 10), 
                                                      ncol=4, nrow=2)

## -----------------------------------------------------------------------------
#assay getter has parameters 'x' which is the input object, 'i' which can either
#be a assay name in the parent object, a subset name or a subset assay name

#getting 'counts' from parent es object
assay(
  x = es,
  i = "counts"
)

#getting just the 'subset1' from es object
assay(
  x = es,
  i = "subset1"
)

#getting the 'subset1InternalAssay' from inside the 'subset1'
assay(
  x = es,
  i = "subset1InternalAssay"
)

## -----------------------------------------------------------------------------
counts <- matrix(rpois(100, lambda = 10), ncol=10, nrow=10)
sce <- SingleCellExperiment(list(counts = counts))
es <- ExperimentSubset(sce)
subsetSummary(es)

## -----------------------------------------------------------------------------
es <- createSubset(es, 
                   subsetName = "subset1",
                   rows = c(1:5),
                   cols = c(1:5),
                   parentAssay = "counts")
subsetSummary(es)

## -----------------------------------------------------------------------------
es <- createSubset(es, 
                   subsetName = "subset2",
                   rows = c(1:2),
                   cols = c(1:5),
                   parentAssay = "subset1")
subsetSummary(es)

## -----------------------------------------------------------------------------
subset2Assay <- assay(es, "subset2")
subset2Assay[,] <- subset2Assay[,] + 1

## -----------------------------------------------------------------------------
#approach 1
es <- setSubsetAssay(es, 
                  subsetName = "subset2", 
                  inputMatrix = subset2Assay, 
                  subsetAssayName = "subset2Assay_a1")

#approach 2
assay(es, "subset2", subsetAssayName = "subset2Assay_a2") <- subset2Assay
subsetSummary(es)

## -----------------------------------------------------------------------------
altExp(x = es,
       e = "subset2_alt1",
       subsetName = "subset2") <- SingleCellExperiment(assay = list(
         counts = assay(es, "subset2")
       ))

## -----------------------------------------------------------------------------
subsetSummary(es)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install(version = "3.11", ask = FALSE)
# BiocManager::install(c("TENxPBMCData", "scater", "scran"))

## ----eval = FALSE-------------------------------------------------------------
# library(ExperimentSubset)
# library(TENxPBMCData)
# library(scater)
# library(scran)

## ----eval = FALSE-------------------------------------------------------------
# tenx_pbmc4k <- TENxPBMCData(dataset = "pbmc4k")
# es <- ExperimentSubset(tenx_pbmc4k)
# subsetSummary(es)

## ----eval = FALSE-------------------------------------------------------------
# perCellQCMetrics <- perCellQCMetrics(assay(es, "counts"))
# colData(es) <- cbind(colData(es), perCellQCMetrics)

## ----eval = FALSE-------------------------------------------------------------
# filteredCellsIndices <- which(colData(es)$sum > 1500)
# es <- createSubset(es, "filteredCells", cols = filteredCellsIndices, parentAssay = "counts")
# subsetSummary(es)

## ----eval = FALSE-------------------------------------------------------------
# assay(es, "filteredCells", subsetAssayName = "filteredCellsNormalized") <- normalizeCounts(assay(es, "filteredCells"))
# subsetSummary(es)

## ----eval = FALSE-------------------------------------------------------------
# topHVG1000 <- getTopHVGs(modelGeneVar(assay(es, "filteredCellsNormalized")), n = 1000)
# es <- createSubset(es, "hvg1000", rows = topHVG1000, parentAssay = "filteredCellsNormalized")
# subsetSummary(es)

## ----eval = FALSE-------------------------------------------------------------
# reducedDim(es, type = "PCA", subsetName = "hvg1000") <- calculatePCA(assay(es, "hvg1000"))

## ----eval = FALSE-------------------------------------------------------------
# subsetSummary(es)

## -----------------------------------------------------------------------------
sessionInfo()

