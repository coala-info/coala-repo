# Code example from 'BioMMtutorial' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'---------------------------------
BiocStyle::markdown()

## ----global_options, include=FALSE----------------------------------------------------------------
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, fig.width=8, 
fig.height=8)
options(width=100) 

## ----eval=FALSE-----------------------------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("transbioZI/BioMM")

## ----loadPkg, eval=TRUE, results="hide"-----------------------------------------------------------
library(BioMM)  
library(BiocParallel)  
library(ranger)
library(rms) 
library(glmnet) 
library(e1071) 
library(variancePartition)  

## ----studyData, eval=TRUE-------------------------------------------------------------------------
## Get DNA methylation data 
studyData <- readRDS(system.file("extdata", "/methylData.rds", 
                     package="BioMM"))
head(studyData[,1:5])
dim(studyData)

## ----annotationFile, eval=TRUE--------------------------------------------------------------------
## Load annotation data
featureAnno <- readRDS(system.file("extdata", "cpgAnno.rds", package="BioMM")) 
pathlistDB <- readRDS(system.file("extdata", "goDB.rds", package="BioMM")) 
head(featureAnno)
str(pathlistDB[1:3])

## ----chrlist, eval=TRUE---------------------------------------------------------------------------
## Map to chromosomes
chrlist <- omics2chrlist(data=studyData, probeAnno=featureAnno) 

## ----pathlist, eval=TRUE--------------------------------------------------------------------------
## Map to pathways (input 100 pathways only)
pathlistDBsub <- pathlistDB[1:100]
pathlist <- omics2pathlist(data=studyData, pathlistDBsub, featureAnno, 
                           restrictUp=100, restrictDown=20, minPathSize=10) 

## ----genelist, eval=FALSE-------------------------------------------------------------------------
#  ## Map to genes
#  studyDataSub <- studyData[,1:2000]
#  genelist <- omics2genelist(data=studyDataSub, featureAnno,
#                             restrictUp=200, restrictDown=2)

## ----BioMMrandForest, eval=TRUE-------------------------------------------------------------------
## Parameters
supervisedStage1=TRUE
classifier1=classifier2 <- "randForest"
predMode1=predMode2 <- "classification"
paramlist1=paramlist2 <- list(ntree=300, nthreads=10)   
param1 <- MulticoreParam(workers = 1)
param2 <- MulticoreParam(workers = 10)

studyDataSub <- studyData[,1:2000] ## less computation
result <- BioMM(trainData=studyDataSub, testData=NULL,
                stratify="chromosome", pathlistDB, featureAnno, 
                restrictUp=10, restrictDown=200, minPathSize=10, 
                supervisedStage1, typePCA="regular", 
                resample1="BS", resample2="CV", dataMode="allTrain", 
                repeatA1=50, repeatA2=1, repeatB1=20, repeatB2=1, 
                nfolds=10, FSmethod1=NULL, FSmethod2=NULL, 
                cutP1=0.1, cutP2=0.1, fdr1=NULL, fdr2=NULL, FScore=param1, 
                classifier1, classifier2, predMode1, predMode2, 
                paramlist1, paramlist2, innerCore=param2,  
                outFileA2=NULL, outFileB2=NULL)
print(result)

## ----BioMMpara, eval=TRUE-------------------------------------------------------------------------
## SVM 
supervisedStage1=TRUE
classifier1=classifier2 <- "SVM"
predMode1=predMode2 <- "classification"
paramlist1=paramlist2 <- list(tuneP=FALSE, kernel="radial", 
                              gamma=10^(-3:-1), cost=10^(-3:1))

## GLM with elastic-net
supervisedStage1=TRUE
classifier1=classifier2 <- "glmnet"
predMode1=predMode2 <- "classification" 
paramlist1=paramlist2 <- list(family="binomial", alpha=0.5, 
                              typeMeasure="mse", typePred="class")

## PCA + random forest
supervisedStage1=FALSE
classifier2 <- "randForest"
predMode2 <- "classification"
paramlist2 <- list(ntree=300, nthreads=10)  

## ----BioMMpathway, eval=TRUE----------------------------------------------------------------------
## Parameters
supervisedStage1=FALSE
classifier <- "randForest"
predMode <- "classification"
paramlist <- list(ntree=300, nthreads=10)   
param1 <- MulticoreParam(workers = 1)
param2 <- MulticoreParam(workers = 10)

result <- BioMM(trainData=studyData, testData=NULL,
                stratify="pathway", pathlistDBsub, featureAnno, 
                restrictUp=100, restrictDown=10, minPathSize=10, 
                supervisedStage1, typePCA="regular", 
                resample1="BS", resample2="CV", dataMode="allTrain", 
                repeatA1=40, repeatA2=1, repeatB1=40, repeatB2=1, 
                nfolds=10, FSmethod1=NULL, FSmethod2=NULL, 
                cutP1=0.1, cutP2=0.1, fdr1=NULL, fdr2=NULL, FScore=param1, 
                classifier1, classifier2, predMode1, predMode2, 
                paramlist1, paramlist2, innerCore=param2,  
                outFileA2=NULL, outFileB2=NULL)
print(result)

## ----stage2data, eval=TRUE------------------------------------------------------------------------
## Pathway level data or stage-2 data prepared by BioMMreconData()
stage2dataA <- readRDS(system.file("extdata", "/stage2dataA.rds", 
                       package="BioMM"))

head(stage2dataA[,1:5])
dim(stage2dataA)

## ----stage2dataAprepare, eval=FALSE---------------------------------------------------------------
#  #### Alternatively, 'stage2dataA' can be created by the following code:
#  ## Parameters
#  classifier <- "randForest"
#  predMode <- "probability"
#  paramlist <- list(ntree=300, nthreads=40)
#  param1 <- MulticoreParam(workers = 1)
#  param2 <- MulticoreParam(workers = 10)
#  set.seed(123)
#  ## This will take a bit longer to run
#  stage2dataA <- BioMMreconData(trainDataList=pathlist, testDataList=NULL,
#                              resample="BS", dataMode="allTrain",
#                              repeatA=25, repeatB=1, nfolds=10,
#                              FSmethod=NULL, cutP=0.1, fdr=NULL, FScore=param1,
#                              classifier, predMode, paramlist,
#                              innerCore=param2, outFileA=NULL, outFileB=NULL)
#  

## ----stage2dataViz, eval=TRUE---------------------------------------------------------------------
param <- MulticoreParam(workers = 1) 
plotVarExplained(data=stage2dataA, posF=TRUE, 
                 stratify="pathway", core=param, fileName=NULL)

## ----topFstage2data, eval=TRUE--------------------------------------------------------------------
param <- MulticoreParam(workers = 1) 
plotRankedFeature(data=stage2dataA, 
                  posF=TRUE, topF=10, 
                  blocklist=pathlist, 
                  stratify="pathway",
                  rankMetric="R2", 
                  colorMetric="size", 
                  core=param, fileName=NULL)

## ----sessioninfo, eval=TRUE-----------------------------------------------------------------------
sessionInfo()

