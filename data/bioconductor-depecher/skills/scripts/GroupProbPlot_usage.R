# Code example from 'GroupProbPlot_usage' vignette. See references/ for full tutorial.

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
data("testData")
data("testDataSNE")

## ----eval = FALSE-------------------------------------------------------------
# dataTrans <-
#   testData[, c("SYK", "CD16", "CD57", "EAT.2", "CD8", "NKG2C", "CD2", "CD56")]
# 
# testData$groupProb <- groupProbPlot(xYData = testDataSNE$Y,
#                                     groupVector = testData$label,
#                                     groupName1 = "Group_1",
#                                     groupName2 = "Group_2",
#                                     dataTrans = dataTrans)
# ## [1] "Done with k-means"
# ## [1] "Now the first bit is done, and the iterative part takes off"
# ## [1] "Clusters 1 to 7 smoothed in 2.9159369468689 . Now, 13 clusters are
# ## [1] left."
# ## [1] "Clusters 8 to 14 smoothed in 0.925199031829834 . Now, 6 clusters are
# ## [1] left."
# ## [1] "Clusters 15 to 20 smoothed in 0.905373096466064 . Now, 0 clusters are
# ## [1] left."

## -----------------------------------------------------------------------------
sessionInfo()

