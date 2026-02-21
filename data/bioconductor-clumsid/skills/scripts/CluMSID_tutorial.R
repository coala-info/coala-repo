# Code example from 'CluMSID_tutorial' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    echo = TRUE
)

## ----captions, include=FALSE--------------------------------------------------
fig1 <- paste("**Figure 1:**",
                "Multidimensional scaling plot as a visualisation of",
                "MS^2^ spectra similarities",
                "of the example data set.",
                "Red dots signify annotated spectra,",
                "black dots spectra from unknown metabolites.")
fig2 <- paste("**Figure 2:**",
                "Multidimensional scaling plot as a visualisation of",
                "neutral loss similarities",
                "of the example data set.",
                "Red dots signify annotated spectra,",
                "black dots spectra from unknown metabolites.")
fig3 <- paste("**Figure 3:**",
                "Screenshot of the interactive version of the",
                "Multidimensional scaling plot visualising",
                "MS^2^ spectra similarities",
                "of the example data set (cf Figure 1).",
                "Zoomed image section with tooltip displaying",
                "feature information upon mouse-over.")
fig4 <- paste("**Figure 4:**",
                "Reachability distance plot resulting from",
                "OPTICS density based clustering of the",
                "MS^2^ spectra similarities",
                "of the example data set.",
                "Bars represent features in OPTICS order",
                "with heights corresponding to the",
                "reachability distance to the next feature.",
                "The dashed horizontal line marks the reachability threshold",
                "that separates clusters.",
                "The resulting clusters are colour-coded",
                "with black representing noise, i.e. features not assigned",
                "to any cluster.")
fig5 <- paste("**Figure 5:**",
                "Reachability distance plot resulting from",
                "OPTICS density based clustering of the",
                "neutral loss similarities",
                "of the example data set",
                "(cf Figure 4).")
fig6 <- paste("**Figure 6:**",
                "Symmetric heat map of the distance matrix displaying",
                "MS^2^ spectra similarities",
                "of the example data set",
                "along with dendrograms resulting from",
                "hierarchical clustering based on the distance matrix.",
                "The colour encoding is shown in the top-left insert.")
fig7 <- paste("**Figure 7:**",
                "Symmetric heat map of the distance matrix displaying",
                "neutral loss similarities",
                "of the example data set",
                "along with dendrograms resulting from",
                "hierarchical clustering based on the distance matrix.",
                "The colour encoding is shown in the top-left insert.")
fig8 <- paste("**Figure 8:**",
                "Circularised dendrogram as a result of",
                "agglomerative hierarchical clustering with average linkage",
                "as agglomeration criterion based on",
                "MS^2^ spectra similarities",
                "of the example data set.",
                "Each leaf represents one feature and colours encode",
                "cluster affiliation of the features.",
                "Leaf labels display feature IDs, along with",
                "feature annotations, if existent.",
                "Distance from the central point is indicative",
                "of the height of the dendrogram.")
fig9 <- paste("**Figure 9:**",
                "Correlation network plot based on",
                "MS^2^ spectra similarities",
                "of the example data set.",
                "Grey dots indicate non-identified features,",
                "orange dots identified ones.",
                "Labels display feature IDs, along with",
                "feature annotations, if existent.",
                "Edge widths are proportional to spectral similarity",
                "of the connected features.")
fig10 <- paste("**Figure 10:**",
                "Screenshot of the interactive version of the",
                "Correlation network plot based on",
                "MS^2^ spectra similarities",
                "of the example data set (cf Figure 9).",
                "Zoomed image section with tooltip displaying",
                "feature information upon mouse-over.")
fig11 <- paste("**Figure 11:**",
                "Correlation network plot based on",
                "neutral loss similarities",
                "of the example data set (cf Figure 9).")
fig12 <- paste("**Figure 12:**",
                "Correlation network plot based on",
                "similarities of pseudospectra",
                "of the example data set (cf Figure 9).")

## ----load_package_0, eval=FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install(c("CluMSIDdata", "CluMSID"))

## ----load_package_2, eval=TRUE------------------------------------------------
library(CluMSID)
library(CluMSIDdata)

## ----extractMS2spectra_1, warning=FALSE---------------------------------------
ms2list <- extractMS2spectra(system.file("extdata", 
                                            "PoolA_R_SE.mzXML", 
                                            package = "CluMSIDdata"), 
                                min_peaks = 2, 
                                recalibrate_precursor = TRUE, 
                                RTlims = c(0,25))


## ----extractMS2spectra_2------------------------------------------------------
length(ms2list)

## ----extractMS2spectra_3------------------------------------------------------
head(ms2list, 4)

## ----extractMS2spectra_4------------------------------------------------------
showDefault(ms2list[[2]])

## ----mergeMS2spectra_1--------------------------------------------------------
featlist <- mergeMS2spectra(ms2list)

## ----mergeMS2spectra_2--------------------------------------------------------
length(featlist)

## ----mergeMS2spectra_3--------------------------------------------------------
head(featlist, 4)

## ----mergeMS2spectra_4--------------------------------------------------------
accessNeutralLosses(featlist[[1]])

## ----mergeMS2spectra_5--------------------------------------------------------
ms2list2 <- extractMS2spectra(system.file("extdata", 
                                            "TD035-PoolMSMS2.mzXML", 
                                            package = "CluMSIDdata"), 
                                min_peaks = 2, 
                                recalibrate_precursor = TRUE, 
                                RTlims = c(0,25))

## ----mergeMS2spectra_6, message=FALSE, warning=FALSE--------------------------
require(magrittr)
ptable <- 
    readr::read_delim(file = system.file("extdata", 
                                        "TD035_XCMS.annotated.diffreport.tsv", 
                                        package = "CluMSIDdata"), 
                    delim = "\t") %>%
    dplyr::select(c(name, mzmed, rtmed)) %>%
    dplyr::mutate(rtmed = rtmed * 60)

head(ptable)

## ----mergeMS2spectra_7, warning=FALSE-----------------------------------------
featlist2 <- mergeMS2spectra(ms2list2, 
                                peaktable = ptable,
                                exclude_unmatched = FALSE)

head(featlist2, 4)

## ----addAnnotations_0, eval=FALSE---------------------------------------------
# writeFeaturelist(featlist, "pre_anno.csv")

## ----addAnnotations_1---------------------------------------------------------
annotatedSpeclist <- addAnnotations(featlist, system.file("extdata", 
                                                    "post_anno.csv", 
                                                    package = "CluMSIDdata"))

## ----addAnnotations_2, include=FALSE------------------------------------------
require(magrittr)
annos <- read.csv(system.file("extdata", 
                                "post_anno.csv", 
                                package = "CluMSIDdata"), 
                    stringsAsFactors = FALSE) %>%
    dplyr::filter(nchar(annotation) > 1) %>%
    dplyr::select(id, annotation)

## ----addAnnotations_3---------------------------------------------------------
str(annos)
head(annos)

## ----addAnnotations_4---------------------------------------------------------
fl <- featureList(featlist)

fl_annos <- dplyr::left_join(fl, annos, by = "id")

## ----distanceMatrix_0, include=FALSE------------------------------------------
load(file = system.file("extdata", "distmat.RData", package = "CluMSIDdata"))
load(file = system.file("extdata", "nlmat.RData", package = "CluMSIDdata"))

## ----distanceMatrix_1, eval=FALSE---------------------------------------------
# distmat <- distanceMatrix(annotatedSpeclist)

## ----distanceMatrix_2, eval=FALSE---------------------------------------------
# nlmat <- distanceMatrix(annotatedSpeclist, type = "neutral_losses")

## ----MDSplotplot_1, fig.width=5, fig.asp=1, fig.cap=fig1, message=FALSE-------
MDSplot(distmat, highlight_annotated = TRUE)

## ----MDSplotplot_2, fig.width=5, fig.asp=1, fig.cap=fig2, message=FALSE-------
MDSplot(nlmat, highlight_annotated = TRUE)

## ----MDSplotplot_3, eval=FALSE------------------------------------------------
# my_mds <- MDSplot(distmat, interactive = TRUE, highlight_annotated = TRUE)
# 
# htmlwidgets::saveWidget(my_mds, "mds.html")

## ----MDSplotplot_4, echo=FALSE, out.width="100%", fig.cap=fig3----------------
knitr::include_graphics(system.file("extdata", 
                                    "interactive_mds.png", 
                                    package = "CluMSIDdata"))

## ----OPTICSplot, fig.width=7, fig.asp=0.6, fig.cap=c(fig4, fig5)--------------
OPTICSplot(distmat)
OPTICSplot(nlmat, eps_cl = 0.7)

## ----OPTICStbl----------------------------------------------------------------
OPTICStbl <- OPTICStbl(distmat)

head(OPTICStbl)

## ----HCplot_1, fig.width=7, fig.asp=1, fig.cap=c(fig6, fig7)------------------
HCplot(distmat, type = "heatmap", 
                cexRow = 0.1, cexCol = 0.1,
                margins = c(6,6))
HCplot(nlmat, type = "heatmap", 
                cexRow = 0.1, cexCol = 0.1,
                margins = c(6,6))

## ----HCplot_2, eval=FALSE-----------------------------------------------------
# pdf(file = "CluMSID_dendro.pdf", width = 20, height = 20)
# HCplot(distmat)
# dev.off()

## ----HCplot_3, echo=FALSE, out.width="100%", fig.asp=1, fig.cap=fig8----------
knitr::include_graphics(system.file("extdata", 
                                    "CluMSID_dendro2.png", 
                                    package = "CluMSIDdata"))

## ----HCtbl--------------------------------------------------------------------
HCtbl <- HCtbl(distmat)

head(HCtbl)

## ----networkplot_1, message=FALSE, fig.width=7, fig.asp=1, fig.cap=fig9-------
networkplot(distmat, highlight_annotated = TRUE, 
                show_labels = TRUE, interactive = FALSE)

## ----networkplot_2, eval=FALSE------------------------------------------------
# my_net <- networkplot(distmat, interactive = TRUE,
#                             highlight_annotated = TRUE)
# 
# htmlwidgets::saveWidget(my_net, "net.html")

## ----networkplot_3, echo=FALSE, out.width="95%", fig.cap=fig10----------------
knitr::include_graphics(system.file("extdata", 
                                    "interactive_net.png", 
                                    package = "CluMSIDdata"))

## ----networkplot_4, message=FALSE, fig.width=7, fig.asp=1, fig.cap=fig11------
networkplot(nlmat, highlight_annotated = TRUE, 
                show_labels = TRUE, exclude_singletons = TRUE)

## ----getSpectrum_1------------------------------------------------------------
getSpectrum(annotatedSpeclist, "id", "M244.17T796.4")

## ----getSpectrum_2------------------------------------------------------------
getSpectrum(annotatedSpeclist, "annotation", "HHQ")

## ----getSpectrum_3------------------------------------------------------------
getSpectrum(annotatedSpeclist, "annotation", "C7-HQ")

## ----getSpectrum_4------------------------------------------------------------
getSpectrum(annotatedSpeclist, "precursor", 286.18, mz.tol = 1E-03)

## ----getSpectrum_5------------------------------------------------------------
six_eight <- getSpectrum(annotatedSpeclist, "rt", 420, rt.tol = 60)
length(six_eight)

## ----findFragment_1-----------------------------------------------------------
putativeAQs <- findFragment(annotatedSpeclist, 159.068)

## ----findNeutralLoss_1--------------------------------------------------------
findNL(annotatedSpeclist, 212.009)

## ----getSimilarities_1--------------------------------------------------------
pyo <- getSpectrum(annotatedSpeclist, "annotation", "pyocyanin")

sim_pyo <- getSimilarities(pyo, annotatedSpeclist, hits_only = TRUE)
sim_pyo

## ----getSimilarities_2--------------------------------------------------------
highest_sim <- sort(sim_pyo, decreasing = TRUE)[2]

sim_spec <- getSpectrum(annotatedSpeclist, "id", names(highest_sim))
sim_spec

## ----getSimilarities_3--------------------------------------------------------
phenazines <- list()
phenazines[[1]] <- getSpectrum(annotatedSpeclist, 
                                "annotation", "pyocyanin")
phenazines[[2]] <- getSpectrum(annotatedSpeclist, 
                                "annotation", "phenazine-1-carboxamide")
phenazines[[3]] <- getSpectrum(annotatedSpeclist, 
                                "annotation", "phenazine-1-carboxylic acid")
phenazines[[4]] <- getSpectrum(annotatedSpeclist, 
                                "annotation", "phenazine-1,6-dicarboxylic acid")
phenazines[[5]] <- new("MS2spectrum", id = "lib_entry_1", 
                        annotation = "1-hydroxyphenazine",
                        spectrum = matrix(c(168.0632, 14,
                                            169.0711, 288,
                                            170.0743, 33,
                                            179.0551, 62,
                                            197.0653, 999),
                                        byrow = TRUE,
                                        ncol = 2))
phenazines[[6]] <- new("MS2spectrum", id = "lib_entry_2", 
                        annotation = "2-hydroxy-phenazine-1-carboxylic acid",
                        spectrum = matrix(c(167.0621, 43,
                                            179.0619, 93,
                                            180.0650, 12,
                                            195.0564, 40,
                                            223.0509, 999,
                                            224.0541, 142,
                                            241.0611, 60),
                                        byrow = TRUE,
                                        ncol = 2))
phenazines[[7]] <- new("MS2spectrum", id = "lib_entry_3", 
                        annotation = "pyocyanin (library spectrum)",
                        spectrum = matrix(c(168.0690, 58,
                                            183.0927, 152,
                                            184.0958, 19,
                                            196.0640, 118,
                                            197.0674, 15,
                                            211.0873, 999,
                                            212.0905, 145),
                                        byrow = TRUE,
                                        ncol = 2))

getSimilarities(sim_spec, phenazines, hits_only = FALSE)

## ----convertSpectrum_1, eval=FALSE--------------------------------------------
# CluMSID_object <- as.MS2spectrum(MSnbase_object)
# # or alternatively
# CluMSID_object <- as(MSnbase_object, "MS2spectrum")

## ----polarities_1, eval=FALSE-------------------------------------------------
# raw_list_mixedpolarities <- extractMS2spectra("raw_file_mixedpolarities.mzXML")
# 
# raw_list_positive <- splitPolarities(raw_list_mixedpolarities, "positive")
# raw_list_negative <- splitPolarities(raw_list_mixedpolarities, "negative")
# 
# speclist_positive <- mergeMS2spectra(raw_list_positive)
# speclist_negative <- mergeMS2spectra(raw_list_negative)

## ----Pseudospectra_1, message=FALSE, warning=FALSE----------------------------
pstable <- 
    readr::read_delim(file = system.file("extdata", 
                                        "TD035_XCMS.annotated.diffreport.tsv", 
                                        package = "CluMSIDdata"), 
                    delim = "\t") 

pseudospeclist <- extractPseudospectra(pstable, min_peaks = 2)

## ----Pseudospectra_2, eval=FALSE----------------------------------------------
# pseudodistmat <- distanceMatrix(pseudospeclist)

## ----Pseudospectra_3, include=FALSE-------------------------------------------
load(file = system.file("extdata", 
                        "pseudodistmat.RData", 
                        package = "CluMSIDdata"))

## ----Pseudospectra_4, , fig.width=5, fig.asp=1, fig.cap=fig12-----------------
networkplot(pseudodistmat, show_labels = TRUE, exclude_singletons = TRUE)

## ----session------------------------------------------------------------------
sessionInfo()

