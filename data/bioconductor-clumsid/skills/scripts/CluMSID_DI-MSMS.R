# Code example from 'CluMSID_DI-MSMS' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    echo = TRUE,
    warning = FALSE
)

## ----captions, include=FALSE--------------------------------------------------
fig1 <- paste("**Figure 1:**",
                "Circularised dendrogram as a result of",
                "agglomerative hierarchical clustering with average linkage",
                "as agglomeration criterion based on",
                "MS^2^ spectra similarities",
                "of the DI-MS/MS example data set.",
                "Each leaf represents one feature and colours encode",
                "cluster affiliation of the features.",
                "Leaf labels display feature IDs, along with",
                "feature annotations, if existent.",
                "Distance from the central point is indicative",
                "of the height of the dendrogram.")

## ----packages, message=FALSE, warning=FALSE-----------------------------------
library(CluMSID)
library(CluMSIDdata)

DIfile <- system.file("extdata", 
                        "PA14_maxis_DI.mzXML",
                        package = "CluMSIDdata")

## ----extract------------------------------------------------------------------
ms2list <- extractMS2spectra(DIfile)
length(ms2list)

## ----merge--------------------------------------------------------------------
featlist <- mergeMS2spectra(ms2list, rt_tolerance = 1)
length(featlist)

## ----merge2-------------------------------------------------------------------
testlist <- mergeMS2spectra(ms2list, rt_tolerance = 250)
length(testlist)

## ----distmat, eval=FALSE------------------------------------------------------
# distmat <- distanceMatrix(featlist)

## ----distmat2, include=FALSE--------------------------------------------------
load(file = system.file("extdata", "di-distmat.RData", package = "CluMSIDdata"))

## ----dendrogram, fig.width=7, fig.asp=1, fig.cap=fig1-------------------------
HCplot(distmat, cex = 0.5)

## ----session------------------------------------------------------------------
sessionInfo()

