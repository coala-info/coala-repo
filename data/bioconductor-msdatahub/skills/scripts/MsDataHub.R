# Code example from 'MsDataHub' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----env, echo = FALSE, message = FALSE---------------------------------------
library(Spectra)
library(PSMatch)
library(QFeatures)

## ----data---------------------------------------------------------------------
library("MsDataHub")
DT::datatable(MsDataHub())

## ----install1, eval = FALSE---------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# 
# BiocManager::install("MsDataHub")

## ----eval = TRUE--------------------------------------------------------------
f <- PestMix1_DDA.mzML()
library(Spectra)
Spectra(f)

## ----eval = TRUE--------------------------------------------------------------
f <- PestMix1_SWATH.mzML()
Spectra(f)

## ----eval = TRUE--------------------------------------------------------------
f <- X20171016_POOL_POS_1_105.134.mzML()
Spectra(f)

## ----eval = TRUE--------------------------------------------------------------
f <- X20171016_POOL_POS_3_105.134.mzML()
Spectra(f)

## ----eval = TRUE--------------------------------------------------------------
f <- TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.20141210.mzML.gz()
Spectra(f)

## ----eval = TRUE--------------------------------------------------------------
f <- TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01.20141210.mzid()
library(PSMatch)
PSM(f)

## ----eval = TRUE--------------------------------------------------------------
library(QFeatures)
f <- cptac_peptides.txt()
ecols <- grep("Intensity\\.", names(read.delim(f)))
readSummarizedExperiment(f, ecols, sep = "\t")

## ----eval = TRUE--------------------------------------------------------------
cptac_a_b_c_peptides.txt()
cptac_a_b_peptides.txt()

## ----eval = TRUE--------------------------------------------------------------
f <- ko15.CDF()
Spectra(f)

## ----lfdia, eval = TRUE, message = FALSE--------------------------------------
library(QFeatures)
lfdia <- read.delim(MsDataHub::benchmarkingDIA.tsv())
readQFeaturesFromDIANN(lfdia)

## ----pledia, eval = TRUE, message = FALSE-------------------------------------
plexdia <- read.delim(MsDataHub::Report.Derks2022.plexDIA.tsv())
readQFeaturesFromDIANN(plexdia, multiplexing = "mTRAQ")

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

