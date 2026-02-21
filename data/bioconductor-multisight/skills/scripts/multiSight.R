# Code example from 'multiSight' vignette. See references/ for full tutorial.

## ---- eval = FALSE------------------------------------------------------------
#  #To install this package ensure you have BiocManager installed
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  #The following initializes usage of Bioc devel
#  BiocManager::install("multiSight")

## ----model_biosigner, echo=TRUE, message=FALSE, warning=FALSE-----------------
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")

splitData <- splitDatatoTrainTest(omic2, freq = 0.8)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build model and one biosignature by omic dataset.
biosignerRes <- runSVMRFmodels_Biosigner(data.train)

## Results
biosignerModels <- biosignerRes$model #list of SVM/RF models for each omic.
biosignerFeats <- biosignerRes$biosignature #selected features for each omic.

## Assess model classification performances
biosignerPerf <- assessPerformance_Biosigner(modelList = biosignerModels, 
                                             dataTest = data.test)
print(biosignerPerf) #confusion matrices and performance metrics

## ----model_DIABLO, message=FALSE, warning=FALSE-------------------------------
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")

splitData <- splitDatatoTrainTest(omic2, freq = 0.9)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build model and one biosignature by omic dataset.
# diabloRes <- runSPLSDA(data.train)
# diabloRes #internal object of package to save time

## Results
diabloModels <- diabloRes$model #sPLS-DA model using all omics.
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Asses model classification performances
diabloPerf <- assessPerformance_Diablo(splsdaModel = diabloModels, 
                                          dataTest = data.test)
print(diabloPerf) #confusion matrices and performance metrics

## ----model_DIABLO, message=FALSE, warning=FALSE-------------------------------
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")

splitData <- splitDatatoTrainTest(omic2, freq = 0.9)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build model and one biosignature by omic dataset.
# diabloRes <- runSPLSDA(data.train)
# diabloRes #internal object of package to save time

## Results
diabloModels <- diabloRes$model #sPLS-DA model using all omics.
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Asses model classification performances
diabloPerf <- assessPerformance_Diablo(splsdaModel = diabloModels, 
                                          dataTest = data.test)
print(diabloPerf) #confusion matrices and performance metrics

## ----message=FALSE------------------------------------------------------------
if (requireNamespace("org.Mm.eg.db", quietly = TRUE))
{
  library(org.Mm.eg.db)
  columns(org.Mm.eg.db)
}

## ----multiOmicEnrichment_DESeq2, message=FALSE, warning=FALSE-----------------
require(multiSight)

## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("deseqRes", package = "multiSight")
# deseqRes <- runMultiDeseqAnalysis(omicDataList = omic2, 
                                  # padjUser = 0.05)
## One Differential Expression Analysis table for each omic dataset
# View(deseqRes$DEtable) 
## One feature selected list for each omic according to padjust user threshold
multiOmic_biosignature <- deseqRes$selectedFeatures
# View(multiOmic_biosignature)

## Multi-omics enrichment
### convert features
dbList <- list(rnaRead = "ENSEMBL",
               dnaRead = "ENSEMBL")
convFeat <- convertToEntrezid(multiOmic_biosignature, dbList, "org.Mm.eg.db")

### ORA enrichment analysis
if (requireNamespace("org.Mm.eg.db", quietly = TRUE))
{
    # database <- c("kegg", "wikiPathways", "reactome", "MF", "CC", "BP")
    database <- c("reactome")
    data("enrichResList", package = "multiSight")
    # enrichResList <- runMultiEnrichment(omicSignature = convFeat, 
    #                                    databasesChosen = database, 
    #                                    organismDb = "org.Mm.eg.db", 
    #                                    pvAdjust = "BH", #default value
    #                                    minGSSize = 5, #default value
    #                                    maxGSSize = 800, #default value
    #                                    pvStouffer = 0.1) #default value
    reacRes <- enrichResList$pathways$reactome
    names(reacRes$result) # classical enrichment tables, multi-omics and EMap
}

## ----multiOmicEnrichment_DIABLO, message=FALSE, warning=FALSE-----------------
require(multiSight)
## omic2 is a multi-omics dataset of 2 simulated omics included in package
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")
# splitData <- splitDatatoTrainTest(omic2, 0.8)
# data.train <- splitData$data.train
# data.test <- splitData$data.test
# 
# diabloRes <- runSPLSDA(data.train)
# diabloRes #internal object of package to save time
diabloModels <- diabloRes$model #sPLS-DA model using all omics.
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Multi-omics enrichment
### convert features
names(diabloFeats) #/!\use same names for dbList and omic datasets.
dbList <- list(rnaRead = "ENSEMBL", #feature names origin
               dnaRead = "ENSEMBL")

if (requireNamespace("org.Mm.eg.db", quietly = TRUE))
{
    convFeat <- convertToEntrezid(diabloFeats, 
                                  dbList, 
                                  "org.Mm.eg.db")
    
    ### ORA enrichment analysis for omic feature lists
    # database <- c("kegg", "wikiPathways", "reactome", "MF", "CC", "BP")
    database <- c("reactome")
    multiOmicRes <- runMultiEnrichment(omicSignature = convFeat, 
                                       databasesChosen = database, 
                                       organismDb = "org.Mm.eg.db",
                                       pvAdjust = "BH", #default value
                                       minGSSize = 5, #default value
                                       maxGSSize = 800, #default value
                                       pvStouffer = 0.1) #default value
    
    ## Results
    reacRes <- multiOmicRes$pathways$reactome
    names(reacRes$result) # classical enrichment tables, multi-omics and EMap
}

## ----networkInference, message=FALSE, warning=FALSE---------------------------
require(multiSight)
data("omic2", package = "multiSight")
data("diabloRes", package = "multiSight")
## omic2 is a multi-omics dataset of 2 simulated omics included in package
splitData <- splitDatatoTrainTest(omic2, 0.8)
data.train <- splitData$data.train
data.test <- splitData$data.test

## Build sPLS-DA models
# diabloRes <- runSPLSDA(data.train)
diabloFeats <- diabloRes$biosignature #selected features for each omic.

## Build biosigner models
biosignerRes <- runSVMRFmodels_Biosigner(data.train)
biosignerFeats <- biosignerRes$biosignature #selected features for each omic.

## Network inference
### DIABLO features
concatMat_diablo <- getDataSelectedFeatures(omic2, diabloFeats)
corrRes_diablo <- correlationNetworkInference(concatMat_diablo, 0.85)
pcorRes_diablo <- partialCorrelationNI(concatMat_diablo, 0.4)
miRes_diablo <- mutualInformationNI(concatMat_diablo, 0.2)

### biosigner features
concatMat_biosigner <- getDataSelectedFeatures(omic2, biosignerFeats)
corrRes_bios <- correlationNetworkInference(concatMat_biosigner, 0.85)
pcorRes_bios <- partialCorrelationNI(concatMat_biosigner, 0.4)
miRes_bios <- mutualInformationNI(concatMat_biosigner, 0.2)

corrRes_diablo$graph

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

