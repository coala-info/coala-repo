# Code example from 'CluMSID_lowres-LC-MSMS' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    echo = TRUE,
    warning = FALSE
)

## ----captions, include=FALSE--------------------------------------------------
fig1 <- paste("**Figure 1:**",
                "Multidimensional scaling plot as a visualisation of",
                "MS^2^ spectra similarities",
                "of the low resolution LC-MS/MS example data set.",
                "Black dots signify spectra from unknown metabolites.")
fig2 <- paste("**Figure 2:**",
                "Symmetric heat map of the distance matrix displaying",
                "MS^2^ spectra similarities",
                "of the low resolution LC-MS/MS example data set.",
                "along with dendrograms resulting from",
                "hierarchical clustering based on the distance matrix.",
                "The colour encoding is shown in the top-left insert.")
fig3 <- paste("**Figure 3:**",
                "Circularised dendrogram as a result of",
                "agglomerative hierarchical clustering with average linkage",
                "as agglomeration criterion based on",
                "MS^2^ spectra similarities",
                "of the low resolution LC-MS/MS example data set.",
                "Each leaf represents one feature and colours encode",
                "cluster affiliation of the features.",
                "Leaf labels display feature IDs.",
                "Distance from the central point is indicative",
                "of the height of the dendrogram.")

## ----packages, message=FALSE, warning=FALSE-----------------------------------
library(CluMSID)
library(CluMSIDdata)

lowresfile <- system.file("extdata", 
                        "PA14_amazon_lowres.mzXML",
                        package = "CluMSIDdata")

## ----load, include=FALSE------------------------------------------------------
load(file = system.file("extdata", 
                        "lowres-featlist.RData", 
                        package = "CluMSIDdata"))
load(file = system.file("extdata", 
                        "lowres-distmat.RData", 
                        package = "CluMSIDdata"))

## ----extract------------------------------------------------------------------
ms2list <- extractMS2spectra(lowresfile)
length(ms2list)

## ----merge, eval=FALSE--------------------------------------------------------
# featlist <- mergeMS2spectra(ms2list, mz_tolerance = 0.02)

## ----length-------------------------------------------------------------------
length(featlist)

## ----distmat, eval=FALSE------------------------------------------------------
# distmat <- distanceMatrix(featlist)

## ----MDS, fig.cap=fig1--------------------------------------------------------
MDSplot(distmat)

## ----heatmap, fig.width=6, fig.asp=1, fig.cap=fig2----------------------------
HCplot(distmat, type = "heatmap", 
                cexRow = 0.1, cexCol = 0.1,
                margins = c(6,6))

## ----dendro, fig.width=6, fig.asp=1, fig.cap=fig3-----------------------------
HCplot(distmat, h = 0.8, cex = 0.3)

## ----session------------------------------------------------------------------
sessionInfo()

