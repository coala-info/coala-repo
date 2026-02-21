# Code example from 'CluMSID_GC-EI-MS' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    echo = TRUE
)

## ----captions, include=FALSE--------------------------------------------------
fig1 <- paste("**Figure 1:**",
                "Barplot for pseudospectrum 27,",
                "displaying fragment *m/z* on the x-axis",
                "and intensity normalised to the maximum intensity",
                "on the y-axis.")
fig2 <- paste("**Figure 2:**",
                "Symmetric heat map of the distance matrix displaying",
                "pseudospectra similarities",
                "of the GC-EI-MS example data set",
                "along with dendrograms resulting from",
                "hierarchical clustering based on the distance matrix.",
                "The colour encoding is shown in the top-left insert.")
fig3 <- paste("**Figure 3:**",
                "Correlation network plot based on",
                "pseudospectra similarities",
                "of the GC-EI-MS example data set,",
                "generated with the default similarity threshold of `0.1`.",
                "Grey dots indicate non-identified features,",
                "orange dots identified ones.",
                "Labels display feature IDs, along with",
                "feature annotations, if existent.",
                "Edge widths are proportional to spectral similarity",
                "of the connected features.")
fig4 <- paste("**Figure 4:**",
                "Correlation network plot based on",
                "pseudospectra similarities",
                "of the GC-EI-MS example data set,",
                "generated with the custom similarity threshold of `0.4`.",
                "Grey dots indicate non-identified features,",
                "orange dots identified ones.",
                "Labels display feature IDs, along with",
                "feature annotations, if existent.",
                "Edge widths are proportional to spectral similarity",
                "of the connected features.")
fig5 <- paste("**Figure 5:**",
                "Circularised dendrogram as a result of",
                "agglomerative hierarchical clustering with average linkage",
                "as agglomeration criterion based on",
                "pseudospectra similarities",
                "of the GC-EI-MS example data set.",
                "Each leaf represents one feature and colours encode",
                "cluster affiliation of the features.",
                "Leaf labels display feature IDs, along with",
                "feature annotations, if existent.",
                "Distance from the central point is indicative",
                "of the height of the dendrogram.")

## ----packages, message=FALSE, warning=FALSE-----------------------------------
library(CluMSID)
library(CluMSIDdata)
library(metaMS)
library(metaMSdata)
data(FEMsettings)

## ----loading------------------------------------------------------------------
pool <- system.file("extdata", 
                    "1800802_TD_pool_total_1.cdf", 
                    package = "CluMSIDdata")

## ----runCAMERA----------------------------------------------------------------
xA <- metaMS::runCAMERA(xcms::xcmsSet(pool), 
                chrom = "GC", 
                settings = metaMS::metaSetting(TSQXLS.GC, "CAMERA"))

## ----extract------------------------------------------------------------------
pslist <- extractPseudospectra(xA, min_peaks = 0)

## ----Featurelist, eval=FALSE--------------------------------------------------
# writeFeaturelist(pslist, "GC_pre.csv")

## ----temporary, fig.width=5, fig.asp=0.85, fig.cap=fig1-----------------------
specplot(pslist[[27]])

## ----annotate-----------------------------------------------------------------
apslist <- addAnnotations(featlist = pslist, 
                            annolist = system.file("extdata", 
                            "GC_post.csv", 
                            package = "CluMSIDdata"))

## ----distmat------------------------------------------------------------------
pseudodistmat <- distanceMatrix(apslist, mz_tolerance = 0.02)

## ----heatmap, fig.width=7, fig.asp=1, fig.cap=fig2----------------------------
HCplot(pseudodistmat, type = "heatmap",
                cexRow = 0.4, cexCol = 0.4,
                margins = c(7,7))

## ----network, fig.width=4.5, fig.asp=1, fig.cap=fig3--------------------------
networkplot(pseudodistmat, highlight_annotated = TRUE, 
                show_labels = TRUE, exclude_singletons = TRUE)

## ----network2, fig.width=4.5, fig.asp=1, fig.cap=fig4-------------------------
networkplot(pseudodistmat, highlight_annotated = TRUE, 
                show_labels = TRUE, exclude_singletons = TRUE,
                min_similarity = 0.4)

## ----dendrogram, fig.width=7, fig.asp=1, fig.cap=fig5-------------------------
HCplot(pseudodistmat, h = 0.7, cex = 0.5)

## ----fragment-----------------------------------------------------------------
fragmentlist <- findFragment(apslist, mz = 315, tolerance = 0.5/315)

vapply(X = fragmentlist, FUN = accessID, FUN.VALUE = integer(1))

## ----session------------------------------------------------------------------
sessionInfo()

