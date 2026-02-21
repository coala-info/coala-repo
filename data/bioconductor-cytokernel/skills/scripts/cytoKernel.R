# Code example from 'cytoKernel' vignette. See references/ for full tutorial.

## ----include=FALSE, echo=FALSE------------------------------------------------
# date: "`r doc_date()`"
# "`r pkg_ver('BiocStyle')`"
# <style>
#     pre {
#     white-space: pre !important;
#     overflow-y: scroll !important;
#     height: 50vh !important;
#     }
# </style>

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----echo=FALSE, fig.cap="Feature-Sample data matrix", out.width = '100%'-----
knitr::include_graphics("cytoSchematic.png")

## ----load-lib, message=FALSE--------------------------------------------------
library(cytoKernel) 

## ----data-1, message=FALSE, warning=FALSE-------------------------------------
data("cytoHDBMW")
cytoHDBMW

## ----CytoK_output-------------------------------------------------------------
library(cytoKernel)
CytoK_output<- CytoK(cytoHDBMW,group_factor = rep(c(0, 1),
               c(4, 4)),lowerRho=2,upperRho=12,gridRho=4,
               alpha = 0.05,featureVars = NULL)
CytoK_output
## Head of the data.frame containing shrunken effect sizes, shrunken ##effect size sd's, p values and adjusted p values
head(CytoKFeatures(CytoK_output))
## Head of the data.frame containing shrunken effect sizes, shrunken ##effect size sd's, p values and adjusted p values ordered by ##adjusted p values from low to high
head(CytoKFeaturesOrdered(CytoK_output))
## Percent of differentially expressed features
CytoKDEfeatures(CytoK_output)

## ----byFeatures---------------------------------------------------------------
## Filtering the data by reproducible features
CytoKDEData_HD<- CytoKDEData(CytoK_output, by = "features")
CytoKDEData_HD

## ----fig.cap="Differentially expressed (top 10) cluster-marker data using cytoKernel", plot-CytoK-Heatmap----
heatmap1<- plotCytoK(CytoK_output,
group_factor = rep(c(0, 1), c(4, 4)),topK=10,
featureVars = NULL)
featureOrderedExtracted<- CytoKFeaturesOrdered(CytoK_output)
rowmeta_cluster<- featureOrderedExtracted$cluster
topK<- 10
rowmeta_clusterTopK<- rowmeta_cluster[seq_len(topK)]
library(ComplexHeatmap)
heatmap2<- Heatmap(rowmeta_clusterTopK,
             name = "cluster")
heatmap2+heatmap1

## ----session-info-------------------------------------------------------------
sessionInfo() 

