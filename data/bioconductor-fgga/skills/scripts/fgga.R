# Code example from 'fgga' vignette. See references/ for full tutorial.

## ----settings, include = FALSE--------------------------------------------------------------------
#library(knitr)
#opts_chunk$set(warning=TRUE, message = FALSE, cache = FALSE, tidy = FALSE, tidy.opts = list(width.cutoff = 60))
options(width = 100)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>",class.source = "whiteCode")

## ----message = FALSE, eval = FALSE----------------------------------------------------------------
# ## From Bioconductor repository
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#         install.packages("BiocManager")
#     }
# BiocManager::install("fgga")
# 
# ## Or from GitHub repository using devtools
# BiocManager::install("devtools")
# devtools::install_github("fspetale/fgga")

## ----setup, eval = TRUE, message=FALSE------------------------------------------------------------
library(fgga)

## ----message = FALSE, eval = TRUE-----------------------------------------------------------------
# Loading Canis lupus familiaris dataset and example R objects
data(CfData)


## ----message = FALSE, eval = TRUE-----------------------------------------------------------------
# To see the summarized experiment object
summary(CfData)

# To see the information of characterized data
dim(CfData$dxCf)

colnames(CfData$dxCf)[1:20]

rownames(CfData$dxCf)[1:10]

head.matrix(CfData$dxCf[, 51:61], n = 10)

# to see the information of GO data
dim(CfData$tableCfGO)

colnames(CfData$tableCfGO)[1:10]

rownames(CfData$tableCfGO)[1:10]

head(CfData$tableCfGO)[, 1:8]

## ----message = FALSE, eval = TRUE-----------------------------------------------------------------
# Checking the amount of annotations by GO-term

apply(CfData$tableCfGO, MARGIN=2, sum)

## ----message = FALSE, eval = TRUE-----------------------------------------------------------------
library(GO.db)
library(GOstats)

mygraph <- GOGraph(CfData$nodesGO, GOMFPARENTS)

# Delete root node called all
mygraph <- subGraph(CfData$nodesGO, mygraph)

# We adapt the graph to the format used by FGGA
mygraph <- t(as(mygraph, "matrix"))
mygraphGO <- as(mygraph, "graphNEL")

# We search the root GO-term
rootGO <- leaves(mygraphGO, "in")

rootGO

plot(mygraphGO)

## ----message = FALSE, eval = FALSE----------------------------------------------------------------
# # We add GO-terms corresponding to Cellular Component subdomain
# myGOs <- c(CfData[['nodesGO']], "GO:1902494", "GO:0032991", "GO:1990234",
#             "GO:0005575")
# 
# # We build a graph respecting the GO constraints of inference to MF, CC and BP subdomains
# mygraphGO <- preCoreFG(myGOs, domains="GOMF")
# 
# plot(mygraphGO)

## ----message=FALSE, include=FALSE, results='hide'-------------------------------------------------
mygraphGO <- as(CfData[["graphCfGO"]], "graphNEL")

rootGO <- leaves(mygraphGO, "in")

## ----message = FALSE, eval = TRUE-----------------------------------------------------------------
modelFGGA <- fgga2bipartite(mygraphGO)

## ----message = FALSE, eval = TRUE-----------------------------------------------------------------
# We take a subset of Cf data to train our model
idsTrain <- CfData$indexGO[["indexTrain"]][1:750]

# We build our model of binary SVM classifiers
modelSVMs <- lapply(CfData[["nodesGO"]], FUN = svmTrain, 
                    tableOntoTerms = CfData[["tableCfGO"]][idsTrain, ], 
                    dxCharacterized = CfData[["dxCf"]][idsTrain, ], 
                    graphOnto = mygraphGO, kernelSVM = "radial")

## ----message = FALSE, eval = FALSE----------------------------------------------------------------
# # We calculate the reliability of each GO-term
# varianceGOs <- varianceOnto(tableOntoTerms = CfData[["tableCfGO"]][idsTrain, ],
#                         dxCharacterized = CfData[["dxCf"]][idsTrain, ],
#                         kFold = 5, graphOnto = mygraphGO, rootNode = rootGO,
#                         kernelSVM = "radial")
# 
# varianceGOs

## ----echo=FALSE, message=FALSE--------------------------------------------------------------------
CfData[["varianceGOs"]]

varianceGOs <- CfData[["varianceGOs"]]

## ----message = FALSE, eval = TRUE-----------------------------------------------------------------

dxTestCharacterized <- CfData[["dxCf"]][CfData$indexGO[["indexTest"]][1:50], ]

matrixGOTest <- svmOnto(svmMoldel = modelSVMs, 
                    dxCharacterized = dxTestCharacterized, 
                    rootNode = rootGO, 
                    varianceSVM = varianceGOs)

head(matrixGOTest)[,1:8]

## ----message = FALSE, eval = TRUE-----------------------------------------------------------------
matrixFGGATest <- t(apply(matrixGOTest, MARGIN = 1, FUN = msgFGGA, 
                        matrixFGGA = modelFGGA, graphOnto = mygraphGO,
                        tmax = 50, epsilon = 0.001))

head(matrixFGGATest)[,1:8]

## ----message = FALSE, eval  = TRUE----------------------------------------------------------------
fHierarchicalMeasures(CfData$tableCfGO[rownames(matrixFGGATest), ], 
                        matrixFGGATest, mygraphGO)

## ----message = FALSE, eval = FALSE----------------------------------------------------------------
# # Computing F-score
# Fs <- fMeasures(CfData$tableCfGO[rownames(matrixFGGATest), ], matrixFGGATest)
# 
# # Average F-score
# Fs$perfByTerms[4]
# 
# library(pROC)
# 
# # Computing ROC curve to the first term
# rocGO <- roc(CfData$tableCfGO[rownames(matrixFGGATest), 1],  matrixFGGATest[, 1])
# 
# # Average AUC the first term
# auc(roc)
# 
# # Computing precision at different recall levels to the first term
# rocGO <- roc(CfData$tableCfGO[rownames(matrixFGGATest), 1],
#             matrixFGGATest[, 1], percent=TRUE)
# PXR <- coords(rocGO, "all", ret = c("recall", "precision"), transpose = FALSE)
# 
# # Average PxR to the first term
# apply(as.matrix(PXR$precision[!is.na(PXR$precision)]), MARGIN = 2, mean

## ----session,eval=TRUE,echo=FALSE-----------------------------------------------------------------
sessionInfo()

