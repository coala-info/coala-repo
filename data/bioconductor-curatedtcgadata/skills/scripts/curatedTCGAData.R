# Code example from 'curatedTCGAData' vignette. See references/ for full tutorial.

## ----install, eval=FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("curatedTCGAData")

## ----load-packages, include=TRUE,results="hide",message=FALSE,warning=FALSE----
library(curatedTCGAData)
library(MultiAssayExperiment)
library(TCGAutils)

## ----citation, eval=FALSE-----------------------------------------------------
# citation("curatedTCGAData")
# citation("MultiAssayExperiment")

## ----old-version--------------------------------------------------------------
head(
    curatedTCGAData(
        diseaseCode = "COAD", assays = "*", version = "1.1.38"
    )
)

## ----disease-codes------------------------------------------------------------
data('diseaseCodes', package = "TCGAutils")
head(diseaseCodes)

## ----all-data, eval=FALSE-----------------------------------------------------
# curatedTCGAData(
#     diseaseCode = "*", assays = "*", version = "2.0.1"
# )

## ----coad-assays--------------------------------------------------------------
head(
    curatedTCGAData(
        diseaseCode = "COAD", assays = "*", version = "2.0.1"
    )
)

## ----download-acc, message=FALSE----------------------------------------------
(accmae <- curatedTCGAData(
    "ACC", c("CN*", "Mutation"), version = "2.0.1", dry.run = FALSE
))

## ----subtype-map--------------------------------------------------------------
head(getSubtypeMap(accmae))

## ----clinical-names-----------------------------------------------------------
head(getClinicalNames("ACC"))

colData(accmae)[, getClinicalNames("ACC")][1:5, 1:5]

## ----sample-tables------------------------------------------------------------
sampleTables(accmae)

## ----sample-types-------------------------------------------------------------
data(sampleTypes, package = "TCGAutils")
head(sampleTypes)

## ----split-assays-------------------------------------------------------------
sampleTypes[sampleTypes[["Code"]] %in% c("01", "10"), ]

TCGAsplitAssays(accmae, c("01", "10"))

## ----select-tumors------------------------------------------------------------
tums <- TCGAsampleSelect(colnames(accmae), "01")

## ----primary-tumors-----------------------------------------------------------
(primaryTumors <- TCGAprimaryTumors(accmae))

## ----primary-tumors-tables----------------------------------------------------
sampleTables(primaryTumors)

## ----with-coldata-------------------------------------------------------------
(accmut <- getWithColData(accmae, "ACC_Mutation-20160128", mode = "append"))
head(colData(accmut)[, 1:4])

## ----ragged-experiment--------------------------------------------------------
ragex <- accmae[["ACC_Mutation-20160128"]]
## convert score to numeric
mcols(ragex)$Entrez_Gene_Id <- as.numeric(mcols(ragex)[["Entrez_Gene_Id"]])
sparseAssay(ragex, i = "Entrez_Gene_Id", sparse=TRUE)[1:6, 1:3]

## ----ragged-to-granges--------------------------------------------------------
as(ragex, "GRangesList")

## ----export-class-------------------------------------------------------------
td <- tempdir()
tempd <- file.path(td, "ACCMAE")
if (!dir.exists(tempd))
    dir.create(tempd)

exportClass(accmae, dir = tempd, fmt = "csv", ext = ".csv")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

