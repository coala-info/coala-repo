# Code example from 'annotate_features' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>"
)

## ----message=FALSE, xcms------------------------------------------------------
library(cliqueMS)
mzfile <- system.file("standards.mzXML", package = "cliqueMS")
library(xcms)
mzraw <- MSnbase::readMSData(files = mzfile, mode = "onDisk")
cpw <- CentWaveParam(ppm = 15, peakwidth = c(5,20), snthresh = 10)
mzData <- findChromPeaks(object = mzraw, param = cpw)

## ----anclique-----------------------------------------------------------------
ex.anClique <- createanClique(mzData)
show(ex.anClique)

## ----cliquefind, include = TRUE-----------------------------------------------
set.seed(2)
ex.cliqueGroups <- getCliques(mzData, filter = TRUE)
show(ex.cliqueGroups)

## ----isotopes, include = TRUE-------------------------------------------------
ex.Isotopes <- getIsotopes(ex.cliqueGroups, ppm = 10)
show(ex.Isotopes)

## ----positive, include = TRUE-------------------------------------------------
data(positive.adinfo)
head(positive.adinfo)
data(negative.adinfo)
head(negative.adinfo)

## ----adducts, include = TRUE--------------------------------------------------
ex.Adducts <- getAnnotation(ex.Isotopes, ppm = 10,
    adinfo = positive.adinfo, polarity = "positive",
    normalizeScore = TRUE)
show(ex.Adducts)

## ----peaklist, include = TRUE-------------------------------------------------
features.clique6 <- getlistofCliques(ex.Adducts)[[6]]
head(getPeaklistanClique(ex.Adducts)[features.clique6,
    c("an1","mass1","an2", "mass2", "an3", "mass3", "an4", "mass4", "an5",
    "mass5")], n = 10)

