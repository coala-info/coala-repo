# Code example from 'SCnorm' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----eval=FALSE, echo=TRUE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SCnorm")

## ----eval=FALSE, echo=TRUE-------------------------------------------------
# install.packages("SCnorm_x.x.x.tar.gz", repos=NULL, type="source")
# #OR
# library(devtools)
# devtools::install_github("rhondabacher/SCnorm", ref="devel")

## ----eval=TRUE, echo=TRUE,warning=FALSE------------------------------------
library(SCnorm)

## ----eval=TRUE-------------------------------------------------------------
data(ExampleSimSCData)
ExampleSimSCData[1:5,1:5]
str(ExampleSimSCData)

## ----eval=TRUE-------------------------------------------------------------
library(SingleCellExperiment)
ExampleSimSCData <- SingleCellExperiment(assays = list('counts' = ExampleSimSCData))

## ----eval=FALSE------------------------------------------------------------
# ExampleSimSCData <- as(ExampleSimSCData, "SingleCellExperiment")

## ----eval=TRUE-------------------------------------------------------------
Conditions = rep(c(1), each= 90)
head(Conditions)

## ----eval=TRUE-------------------------------------------------------------
pdf("check_exampleData_count-depth_evaluation.pdf", height=5, width=7)
countDeptEst <- plotCountDepth(Data = ExampleSimSCData, Conditions = Conditions,
                 FilterCellProportion = .1, NCores=3)
dev.off()
str(countDeptEst)
head(countDeptEst[[1]])

## ----eval=TRUE, fig.height=5, fig.width=7, fig.align='center', out.width='0.4\\textwidth'----
ExampleSimSCData = SingleCellExperiment::counts(ExampleSimSCData)
# Total Count normalization, Counts Per Million, CPM.
ExampleSimSCData.CPM <- t((t(ExampleSimSCData) / colSums(ExampleSimSCData)) *
                        mean(colSums(ExampleSimSCData)))


countDeptEst.CPM <- plotCountDepth(Data = ExampleSimSCData,
                                  NormalizedData = ExampleSimSCData.CPM,
                                   Conditions = Conditions,
                                   FilterCellProportion = .1, NCores=3)

str(countDeptEst.CPM)
head(countDeptEst.CPM[[1]])

## ----eval=TRUE-------------------------------------------------------------
Conditions = rep(c(1), each= 90)
pdf("MyNormalizedData_k_evaluation.pdf")
par(mfrow=c(2,2))
DataNorm <- SCnorm(Data = ExampleSimSCData,
                   Conditions = Conditions,
                   PrintProgressPlots = TRUE,
                   FilterCellNum = 10, K = 1,
                   NCores=3, reportSF = TRUE)
dev.off()
DataNorm
NormalizedData <- SingleCellExperiment::normcounts(DataNorm)
NormalizedData[1:5,1:5]


## ----eval=TRUE-------------------------------------------------------------
GenesNotNormalized <- results(DataNorm, type="GenesFilteredOut")
str(GenesNotNormalized)

## ----eval=TRUE-------------------------------------------------------------
ScaleFactors <- results(DataNorm, type="ScaleFactors")
str(ScaleFactors)

## ----eval=TRUE, fig.height=5, fig.width=7, fig.align='center', out.width='0.4\\textwidth'----

countDeptEst.SCNORM <- plotCountDepth(Data = ExampleSimSCData,
                                      NormalizedData = NormalizedData,
                                      Conditions = Conditions,
                                      FilterCellProportion = .1, NCores=3)

str(countDeptEst.SCNORM)
head(countDeptEst.SCNORM[[1]])

## ----eval=FALSE------------------------------------------------------------
# Conditions = rep(c(1, 2), each= 90)
# DataNorm <- SCnorm(Data = MultiCondData,
#                   Conditions = Conditions,
#                   PrintProgressPlots = TRUE,
#                   FilterCellNum = 10,
#                   NCores=3,
#                   useZerosToScale=TRUE)

## ----eval=FALSE------------------------------------------------------------
# 
# DataNorm1 <- SCnorm(Data = ExampleSimSCData[,1:45],
#                    Conditions = rep("1", 45),
#                    PrintProgressPlots = TRUE,
#                    FilterCellNum = 10,
#                    NCores=3, reportSF = TRUE)
# 
# 
# DataNorm2 <- SCnorm(Data = ExampleSimSCData[,46:90],
#                   Conditions = rep("2", 45),
#                   PrintProgressPlots = TRUE,
#                   FilterCellNum = 10,
#                   NCores=3, reportSF = TRUE)

## ----eval=FALSE------------------------------------------------------------
# normalizedDataSet1 <- results(DataNorm1, type = "NormalizedData")
# normalizedDataSet2 <- results(DataNorm2, type = "NormalizedData")
# 
# NormList <- list(list(NormData = normalizedDataSet1),
#                     list(NormData = normalizedDataSet2))
# OrigData <- ExampleSimSCData
# Genes <- rownames(ExampleSimSCData)
# useSpikes = FALSE
# useZerosToScale = FALSE
# 
# DataNorm <- scaleNormMultCont(NormData = NormList,
#                   OrigData = OrigData,
#                   Genes = Genes, useSpikes = useSpikes,
#                   useZerosToScale = useZerosToScale)
# 
# 
# str(DataNorm$ScaledData)
# myNormalizedData <- DataNorm$ScaledData

## ----eval=FALSE------------------------------------------------------------
# checkCountDepth(Data = umiData, Conditions = Conditions,
#                 FilterCellProportion = .1, FilterExpression = 2)
# 
# DataNorm <- SCnorm(Data = umiData, Conditions= Conditions,
#                   PrintProgressPlots = TRUE,
#                   FilterCellNum = 10,
#                   PropToUse = .1,
#                   Thresh = .1,
#                   ditherCounts = TRUE)

## ----eval=FALSE------------------------------------------------------------
# 
# ExampleSimSCData.SCE <- SingleCellExperiment::SingleCellExperiment(assays = list('counts' = ExampleSimSCData))
# 
# ## Assuming the spikes are ERCC, otherwise specify which features are spike-ins manuallly using the splitAltExps function.
# myspikes <- grepl("^ERCC-", rownames(ExampleSimSCData.SCE))
# ExampleSimSCData.SCE <- SingleCellExperiment::splitAltExps(ExampleSimSCData.SCE, ifelse(myspikes, "ERCC", "gene"))
# 
# DataNorm <- SCnorm(Data = ExampleSimSCData.SCE, Conditions = Conditions,
#                    PrintProgressPlots = TRUE,
#                    FilterCellNum = 10, useSpikes=TRUE)

## ----eval=TRUE, fig.height=5, fig.width=10, fig.align='center', out.width='0.8\\textwidth'----
#Colors each sample:
exampleGC <- runif(dim(ExampleSimSCData)[1], 0, 1)
names(exampleGC) <- rownames(ExampleSimSCData)
withinFactorMatrix <- plotWithinFactor(Data = ExampleSimSCData, withinSample = exampleGC)

head(withinFactorMatrix)

## ----eval=TRUE, fig.height=3, fig.width=4, fig.align='center'--------------
#Colors samples by Condition:
Conditions <- rep(c(1,2), each=45)
withinFactorMatrix <- plotWithinFactor(ExampleSimSCData, withinSample = exampleGC,
                                       Conditions=Conditions)

head(withinFactorMatrix)

## ----eval=FALSE------------------------------------------------------------
# # To run correction use:
# DataNorm <- SCnorm(ExampleSimSCData, Conditions,
#                    PrintProgressPlots = TRUE,
#                    FilterCellNum = 10, withinSample = exampleGC)
# 

## ----eval=TRUE-------------------------------------------------------------
  print(sessionInfo())

## ----eval=FALSE------------------------------------------------------------
# library(dynamicTreeCut)
# distM <- as.dist( 1 - cor(BigData, method = 'spearman'))
# htree <- hclust(distM, method='ward.D')
# clusters <- factor(unname(cutreeDynamic(htree, minClusterSize = 50,
#                     method="tree", respectSmallClusters = FALSE)))
# names(clusters) <- colnames(BigData)
# Conditions = clusters
# 
# DataNorm <- SCnorm(Data = BigData,
#                   Conditions = Conditions,
#                   PrintProgressPlots = TRUE
#                   FilterCellNum = 10,
#                   NCores=3, useZerosToScale=TRUE)

## ----eval=FALSE------------------------------------------------------------
# MedExpr <- apply(Data, 1, function(c) median(c[c != 0]))
# plot(density(log(MedExpr), na.rm=T))
# abline(v=log(c(1,2,3,4,5)))
# # might set FilterExpression equal to one of these values.

