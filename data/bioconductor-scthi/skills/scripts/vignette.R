# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----echo = FALSE, message=FALSE,warning=FALSE, eval=FALSE, echo=TRUE---------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scTHI")

## ----warning=FALSE------------------------------------------------------------
library(scTHI)
library(scTHI.data)
set.seed(1234)
data("H3K27")
data("H3K27.meta")

## -----------------------------------------------------------------------------
table(H3K27.meta$Type)

## -----------------------------------------------------------------------------
Malignant <-
rownames(H3K27.meta)[H3K27.meta$Type == "Malignant"][1:100]
Immune <- rownames(H3K27.meta)[H3K27.meta$Type == "Immune cell"]

## ----warning=FALSE------------------------------------------------------------
H3K27.result <-
scTHI_score(
expMat = H3K27,
cellCusterA = Malignant,
cellCusterB = Immune,
cellCusterAName = "Malignant",
cellCusterBName = "Immune",
topRank = 10,
PValue = TRUE,
pvalueCutoff = 0.05,
nPermu = 10,
ncore = 1
)

## -----------------------------------------------------------------------------
head(H3K27.result$result)

## -----------------------------------------------------------------------------
scTHI_plotResult(scTHIresult = H3K27.result,
                cexNames = 0.7,
                plotType = "score")

## -----------------------------------------------------------------------------
scTHI_plotResult(scTHIresult = H3K27.result,
                cexNames = 0.7,
                plotType = "pair")

## -----------------------------------------------------------------------------
H3K27.result <- scTHI_runTsne(scTHIresult = H3K27.result)

## -----------------------------------------------------------------------------
scTHI_plotCluster(scTHIresult = H3K27.result,
                cexPoint = 0.8,
                legendPos = "bottomleft")

## -----------------------------------------------------------------------------
scTHI_plotPairs(
scTHIresult = H3K27.result,
cexPoint = 0.8,
interactionToplot = "THY1_ITGAX:ITGB2"
)

## -----------------------------------------------------------------------------
Tme.cells <-
rownames(H3K27.meta)[which(H3K27.meta$Type != "Malignant")]
H3K27.tme <- H3K27[, Tme.cells]

## ----message=FALSE------------------------------------------------------------
Class <- TME_classification(expMat = H3K27.tme, minLenGeneSet = 10)

## -----------------------------------------------------------------------------
table(Class$Class[Tme.cells], H3K27.meta[Tme.cells, "Type"])

## -----------------------------------------------------------------------------
TME_plot(tsneData = H3K27.result$tsneData, Class, cexPoint = 0.8)

## -----------------------------------------------------------------------------
sessionInfo()

