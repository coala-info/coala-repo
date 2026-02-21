# Code example from 'GENIE3' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
exprMatr <- matrix(sample(1:10, 100, replace=TRUE), nrow=20)
rownames(exprMatr) <- paste("Gene", 1:20, sep="")
colnames(exprMatr) <- paste("Sample", 1:5, sep="")
head(exprMatr)

## -----------------------------------------------------------------------------
library(GENIE3)
set.seed(123) # For reproducibility of results
weightMat <- GENIE3(exprMatr)

## -----------------------------------------------------------------------------
dim(weightMat)
weightMat[1:5,1:5]

## -----------------------------------------------------------------------------
# Genes that are used as candidate regulators
regulators <- c(2, 4, 7)
# Or alternatively:
regulators <- c("Gene2", "Gene4", "Gene7")
weightMat <- GENIE3(exprMatr, regulators=regulators)

## -----------------------------------------------------------------------------
regulatorsList <- list("Gene1"=rownames(exprMatr)[1:10],
                       "Gene2"=rownames(exprMatr)[10:20],
                       "Gene20"=rownames(exprMatr)[15:20])
set.seed(123)
weightList <- GENIE3(exprMatr, nCores=1, targets=names(regulatorsList), regulators=regulatorsList, returnMatrix=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# # Use Extra-Trees (ET) method
# # 7 randomly chosen candidate regulators at each node of a tree
# # 5 trees per ensemble
# weightMat <- GENIE3(exprMatr, treeMethod="ET", K=7, nTrees=50)

## ----eval=FALSE---------------------------------------------------------------
# set.seed(123) # For reproducibility of results
# weightMat <- GENIE3(exprMatr, nCores=4, verbose=TRUE)

## -----------------------------------------------------------------------------
?GENIE3

## -----------------------------------------------------------------------------
linkList <- getLinkList(weightMat)
dim(linkList)
head(linkList)

## ----eval=FALSE---------------------------------------------------------------
# linkList <- getLinkList(weightMat, reportMax=5)

## ----eval=FALSE---------------------------------------------------------------
# linkList <- getLinkList(weightMat, threshold=0.1)

