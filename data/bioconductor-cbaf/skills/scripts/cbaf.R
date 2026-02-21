# Code example from 'cbaf' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("cbaf", dependencies = TRUE)

## ----results='hide', warning=FALSE, message=FALSE-----------------------------
library(cbaf)

## ----eval = FALSE-------------------------------------------------------------
# availableData("list.2020-05-05")

## ----eval=FALSE---------------------------------------------------------------
# cleanDatabase("Whole2")

## -----------------------------------------------------------------------------
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A", "KDM2B", "KDM3A", "KDM3B", "JMJD1C", "KDM4A"), K.methyltransferases = c("SUV39H1", "SUV39H2", "EHMT1", "EHMT2", "SETDB1", "SETDB2", "KMT2A", "KMT2A"))

processOneStudy(genes, "test", "Breast Invasive Carcinoma (TCGA, Cell 2015)", "RNA-Seq", desiredCaseList = c(2,3,4,5), calculate = c("frequencyPercentage",  "frequencyRatio"), heatmapFileFormat = "TIFF")

## -----------------------------------------------------------------------------
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A", "KDM2B", "KDM3A", "KDM3B", "JMJD1C", "KDM4A"), K.methyltransferases = c("SUV39H1", "SUV39H2", "EHMT1", "EHMT2", "SETDB1", "SETDB2", "KMT2A", "KMT2A"))

studies <- c("Acute Myeloid Leukemia (TCGA, Provisional)", "Adrenocortical Carcinoma (TCGA, Provisional)", "Bladder Urothelial Carcinoma (TCGA, Provisional)", "Brain Lower Grade Glioma (TCGA, Provisional)", "Breast Invasive Carcinoma (TCGA, Provisional)") 

processMultipleStudies(genes, "test2", studies, "RNA-Seq", calculate = c("frequencyPercentage", "frequencyRatio"), heatmapFileFormat = "TIFF")

## -----------------------------------------------------------------------------
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A"), K.acetyltransferases = c("CLOCK", "CREBBP", "ELP3", "EP300"))

obtainOneStudy(genes, "test", "Breast Invasive Carcinoma (TCGA, Cell 2015)", "RNA-Seq", desiredCaseList = c(2,3,4,5))

## -----------------------------------------------------------------------------
genes <- list(K.demethylases = c("KDM1A", "KDM1B", "KDM2A"), K.acetyltransferases = c("CLOCK", "CREBBP", "ELP3", "EP300"))

# Specifying names of cancer studies by standard study names
cancernames <- c("Acute Myeloid Leukemia (TCGA, Provisional)", "Adrenocortical Carcinoma (TCGA, Provisional)", "Bladder Urothelial Carcinoma (TCGA, Provisional)", "Brain Lower Grade Glioma (TCGA, Provisional)", "Breast Invasive Carcinoma (TCGA, Provisional)")

# Specifying names of cancer studies by creating a matrix that includes standard and desired study names
cancernames <- matrix(c("Acute Myeloid Leukemia (TCGA, Provisional)", "acute myeloid leukemia", "Adrenocortical Carcinoma (TCGA, Provisional)", "adrenocortical carcinoma", "Bladder Urothelial Carcinoma (TCGA, Provisional)", "bladder urothelial carcinoma", "Brain Lower Grade Glioma (TCGA, Provisional)", "brain lower grade glioma", "Breast Invasive Carcinoma (TCGA, Provisional)",  "breast invasive carcinoma"), nrow = 5, ncol=2 , byrow = TRUE)


obtainMultipleStudies(genes, "test2", cancernames, "RNA-Seq")

## -----------------------------------------------------------------------------
automatedStatistics("test", obtainedDataType = "single study", calculate = c("frequencyPercentage", "frequencyRatio"))

## ----eval = FALSE-------------------------------------------------------------
# heatmapOutput("test", shortenStudyNames = TRUE, heatmapMargines = c(13,5), heatmapColor = "RdGr", genesToDrop = c("PVT1", "SNHG6"), reverseColor = FALSE, heatmapFileFormat = "JPG")

## ----eval = FALSE-------------------------------------------------------------
# xlsxOutput("test")

