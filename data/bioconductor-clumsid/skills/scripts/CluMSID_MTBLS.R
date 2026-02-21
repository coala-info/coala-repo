# Code example from 'CluMSID_MTBLS' vignette. See references/ for full tutorial.

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
                "of the MTBLS433 LC-MS/MS example data set.",
                "Each leaf represents one feature and colours encode",
                "cluster affiliation of the features.",
                "Leaf labels display feature IDs.",
                "Distance from the central point is indicative",
                "of the height of the dendrogram.")
fig2 <- paste("**Figure 2:**",
                "Barplot for the feature M283.2642T14.62,",
                "identified as stearic acid,",
                "displaying fragment *m/z* on the x-axis",
                "and intensity normalised to the maximum intensity",
                "on the y-axis.")
fig3 <- paste("**Figure 3:**",
                "Barplot for the feature M311.3046T15.1,",
                "identified as arachidic acid,",
                "displaying fragment *m/z* on the x-axis",
                "and intensity normalised to the maximum intensity",
                "on the y-axis.")

## ----load, eval=TRUE, message=FALSE-------------------------------------------
library(CluMSID)
library(CluMSIDdata)

## ----import-------------------------------------------------------------------
YH1 <- system.file("extdata", "YH1_GA7_01_10463.mzML",
                    package = "CluMSIDdata")
AX1 <- system.file("extdata", "AX1_GB5_01_10470.mzML",
                    package = "CluMSIDdata")
LP1 <- system.file("extdata", "LP1_GB3_01_10467.mzML",
                    package = "CluMSIDdata")
BR1 <- system.file("extdata", "BR1_GB6_01_10471.mzML",
                    package = "CluMSIDdata")

YH1list <- extractMS2spectra(YH1)
AX1list <- extractMS2spectra(AX1)
LP1list <- extractMS2spectra(LP1)
BR1list <- extractMS2spectra(BR1)

raw_oillist <- c(YH1list, AX1list, LP1list, BR1list)

## ----peaks, message=FALSE-----------------------------------------------------
raw_mtbls_df <- system.file("extdata", 
                "m_mtbls433_metabolite_profiling_mass_spectrometry_v2_maf.tsv",
                package = "CluMSIDdata")

require(magrittr)

mtbls_df <- readr::read_delim(raw_mtbls_df, "\t") %>%
    dplyr::mutate(metabolite_identification = 
                stringr::str_replace(metabolite_identification, 
                                    "unknown", "")) %>%
    dplyr::mutate(id = paste0("M", mass_to_charge, "T", retention_time)) %>%
    dplyr::mutate(retention_time = retention_time * 60) %>%
    dplyr::select(id,
            mass_to_charge, 
            retention_time, 
            metabolite_identification) %>%
    dplyr::rename(mz = mass_to_charge,
            rt = retention_time,
            annotation = metabolite_identification)

## ----accuracy-----------------------------------------------------------------
## Define theoretical m/z
th <- 311.2956

## Get measured m/z for arachidic acid data from mtbls_df
ac <- mtbls_df %>%
    dplyr::filter(annotation == "Arachidic acid") %>%
    dplyr::select(mz) %>%
    as.numeric()

## Calculate relative m/z difference in ppm
abs(th - ac)/th * 1e6

## ----merge, eval=FALSE--------------------------------------------------------
# oillist <- mergeMS2spectra(raw_oillist,
#                                 peaktable = mtbls_df[,1:3],
#                                 exclude_unmatched = TRUE,
#                                 rt_tolerance = 60,
#                                 mz_tolerance = 3e-5)

## ----merge2, include=FALSE----------------------------------------------------
load(file = system.file("extdata", "oillist.RData", package = "CluMSIDdata"))

## ----annos--------------------------------------------------------------------
fl <- featureList(oillist)
fl_annos <- dplyr::left_join(fl, mtbls_df, by = "id")

annolist <- addAnnotations(oillist, fl_annos, annotationColumn = 6)

## ----distance, eval=FALSE-----------------------------------------------------
# distmat <- distanceMatrix(annolist, mz_tolerance = 3e-5)

## ----distance2, include=FALSE-------------------------------------------------
load(file = system.file("extdata", "oil-distmat.RData", 
                        package = "CluMSIDdata"))

## ----dendro, fig.width=7, fig.asp=1.2, fig.cap=fig1---------------------------
HCplot(distmat, h = 0.7, cex = 0.7)

## ----stearate, fig.width=5, fig.asp=0.85, fig.cap=fig2------------------------
specplot(getSpectrum(annolist, "annotation", "Stearic acid"))

## ----arachidate, fig.width=5, fig.asp=0.85, fig.cap=fig3----------------------
specplot(getSpectrum(annolist, "annotation", "Arachidic acid"))

## ----session------------------------------------------------------------------
sessionInfo()

