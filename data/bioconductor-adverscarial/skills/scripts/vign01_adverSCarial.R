# Code example from 'vign01_adverSCarial' vignette. See references/ for full tutorial.

## ----installation, eval=FALSE-------------------------------------------------
# ## Install BiocManager is necessary
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# BiocManager::install('adverSCarial')

## ----load libraries, warning = FALSE, message=FALSE---------------------------
library(adverSCarial)
library(LoomExperiment)

## ----min change attack, message=FALSE, warning = FALSE------------------------
pbmcPath <- system.file("extdata", "pbmc_short.loom", package="adverSCarial")
lfile <- import(pbmcPath, type="SingleCellLoomExperiment")

## ----extract matrix data------------------------------------------------------
matPbmc <- counts(lfile)

## ----visualize1, message=FALSE, warning = FALSE-------------------------------
matPbmc[1:5, 1:5]

## ----load annnots, message=FALSE, warning = FALSE-----------------------------
cellTypes <- rowData(lfile)$cell_type

## ----visualize2, message=FALSE, warning = FALSE-------------------------------
head(cellTypes)

## ----first classif, message=FALSE---------------------------------------------
for ( cell_type in unique(cellTypes)){
    resClassif <- MClassifier(matPbmc, cellTypes, cell_type)
    print(paste0("Expected: ", cell_type, ", predicted: ", resClassif[1]))
}

## ----markers------------------------------------------------------------------
# Known markers for each cell type
markers <- c("IL7R", "CCR7", "CD14", "LYZ", "S100A4", "MS4A1", "CD8A", "FCGR3A", "MS4A7",
              "GNLY", "NKG7", "FCER1A", "CST3", "PPBP")

## ----search min change attack, message=FALSE, warning = FALSE-----------------
genesMinChange <- advSingleGene(matPbmc, cellTypes, "DC",
                        MClassifier, exclGenes = markers, advMethod = "perc99",
                        returnFirstFound = TRUE, changeType = "not_na",
                        firstDichot = 10)

## ----search min change attack bis, warning = FALSE----------------------------
genesMinChange

## ----run min change attack, message=FALSE, warning = FALSE--------------------
matAdver <- advModifications(matPbmc, names(genesMinChange@values)[1], cellTypes, "DC")

## ----verify the min change attack, warning = FALSE, message = FALSE-----------
resClassif <- MClassifier(matAdver, cellTypes, "DC")

## ----verify the min change attack bis, warning = FALSE------------------------
resClassif

## ----search max change attack, warning = FALSE, message=FALSE-----------------
genesMaxChange <- advMaxChange(matPbmc, cellTypes, "Memory CD4 T", MClassifier,
                    exclGenes = markers, advMethod = "perc99")

## ----search max change attack bis, warning = FALSE----------------------------
length(genesMaxChange@values)

## ----run max change attack, message=FALSE, warning=FALSE----------------------
matMaxAdver <- advModifications(matPbmc, genesMaxChange@values, cellTypes, "Memory CD4 T")

## ----verify max change attack, warning = FALSE, message=FALSE-----------------
resClassif <- MClassifier(matMaxAdver, cellTypes, "Memory CD4 T")

## ----verify max change attack bis, warning = FALSE----------------------------
resClassif

## ----CGD1, warning = FALSE----------------------------------------------------
resCGD <- advCGD(as.data.frame(matPbmc), cellTypes,
                "Memory CD4 T", MClassifier, alpha=1, epsilon=1,
                genes=colnames(matPbmc)[ncol(matPbmc):1])

## ----CGD2, warning = FALSE----------------------------------------------------
tail(resCGD$byGeneSummary)

## ----CGD2_bis, warning = FALSE------------------------------------------------
resCGD$oneRowSummary

## ----CGD3, warning = FALSE----------------------------------------------------
modifiedMatrix <- resCGD$expr

## ----CGD4, warning = FALSE----------------------------------------------------
resCGD$modGenes

## ----CGD5, warning = FALSE----------------------------------------------------
MClassifier(modifiedMatrix, cellTypes, "Memory CD4 T")$prediction

## ----session info-------------------------------------------------------------
sessionInfo()

