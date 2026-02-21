# Code example from 'DepecheR_test' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='hide', message=FALSE-------------------------
library(BiocStyle)
library(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
knitr::opts_chunk$set(echo = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("DepecheR")

## -----------------------------------------------------------------------------
library(DepecheR)
data('testData')
str(testData)

## ----eval=FALSE---------------------------------------------------------------
# testDataDepeche <- depeche(testData[, 2:15])

## -----------------------------------------------------------------------------
## [1] "Files will be saved to ~/Desktop"
## [1] "As the dataset has less than 100 columns, peak centering is applied."
## [1] "Set 1 with 7 iterations completed in 14 seconds."
## [1] "Set 2 with 7 iterations completed in 6 seconds."
## [1] "Set 3 with 7 iterations completed in 6 seconds."
## [1] "The optimization was iterated 21 times."

## ----echo=FALSE---------------------------------------------------------------
data("testDataDepeche")

## -----------------------------------------------------------------------------
str(testDataDepeche)

## ----eval=FALSE---------------------------------------------------------------
# library(Rtsne)
# testDataSNE <- Rtsne(testData[,2:15], pca=FALSE)

## ----echo=FALSE---------------------------------------------------------------
    data("testDataSNE")

## -----------------------------------------------------------------------------
dColorPlot(colorData = testDataDepeche$clusterVector, xYData = testDataSNE$Y, 
           colorScale = "dark_rainbow", plotName = "Cluster")

## -----------------------------------------------------------------------------
dColorPlot(colorData = testData[2], xYData = testDataSNE$Y)


## -----------------------------------------------------------------------------
densContour <- dContours(testDataSNE$Y)

dDensityPlot(xYData = testDataSNE$Y, plotName = 'All_events', 
             colorScale="purple3", densContour = densContour)

#Here the data for the first group is plotted
dDensityPlot(xYData = testDataSNE$Y[testData$label==0,], plotName = 'Group_0', 
             colorScale="blue", densContour = densContour)

#And here comes the second group
dDensityPlot(xYData = testDataSNE$Y[testData$label==1,], plotName = 'Group_1', 
             colorScale="red", densContour = densContour)


## -----------------------------------------------------------------------------
dResidualPlot(
    xYData = testDataSNE$Y, groupVector = testData$label,
    clusterVector = testDataDepeche$clusterVector)

## -----------------------------------------------------------------------------
dWilcoxResult <- dWilcox(
    xYData = testDataSNE$Y, idsVector = testData$ids,
    groupVector = testData$label, clusterVector = testDataDepeche$clusterVector)

## ----eval=FALSE---------------------------------------------------------------
# sPLSDAObject <- dSplsda(xYData = testDataSNE$Y, idsVector = testData$ids,
#                         groupVector = testData$label,
#                         clusterVector = testDataDepeche$clusterVector)
# ## Saving 3 x 3 in image
# 
# ## [1] "The separation of the datasets was perfect, with no overlap between
# ## the groups"
# 
# ## [1] "Files were saved at /Users/jakthe/Labbet/GitHub/DepecheR/vignettes"
# 

## ----eval---------------------------------------------------------------------
dViolins(testDataDepeche$clusterVector, inDataFrame = testData, 
         plotClusters = 3, plotElements = testDataDepeche$essenceElementList)

## -----------------------------------------------------------------------------
sessionInfo()

