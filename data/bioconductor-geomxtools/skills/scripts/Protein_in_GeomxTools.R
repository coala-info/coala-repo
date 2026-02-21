# Code example from 'Protein_in_GeomxTools' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  fig.width = 10
)

## ----Load Libraries-----------------------------------------------------------
library(GeomxTools)

## ----Read in Data-------------------------------------------------------------
datadir <- system.file("extdata","DSP_Proteogenomics_Example_Data",
                       package = "GeomxTools")

DCCFiles <- unzip(zipfile = file.path(datadir,  "/DCCs.zip"))
PKCFiles <- unzip(zipfile = file.path(datadir,  "/pkcs.zip"))
SampleAnnotationFile <- file.path(datadir, "Annotation.xlsx")


RNAData <- suppressWarnings(readNanoStringGeoMxSet(dccFiles = DCCFiles,
                                                   pkcFiles = PKCFiles,
                                                   phenoDataFile = SampleAnnotationFile,
                                                   phenoDataSheet = "Annotations",
                                                   phenoDataDccColName = "Sample_ID",
                                                   protocolDataColNames = c("Tissue", 
                                                                            "Segment_Type", 
                                                                            "ROI.Size"),
                                                   configFile = NULL,
                                                   analyte = "RNA",
                                                   phenoDataColPrefix = "",
                                                   experimentDataColNames = NULL))

proteinData <- suppressWarnings(readNanoStringGeoMxSet(dccFiles = DCCFiles,
                                                       pkcFiles = PKCFiles,
                                                       phenoDataFile = SampleAnnotationFile,
                                                       phenoDataSheet = "Annotations",
                                                       phenoDataDccColName = "Sample_ID",
                                                       protocolDataColNames = c("Tissue", 
                                                                                "Segment_Type", 
                                                                                "ROI.Size"),
                                                       configFile = NULL,
                                                       analyte = "protein",
                                                       phenoDataColPrefix = "",
                                                       experimentDataColNames = NULL))

RNAData <- aggregateCounts(RNAData)
RNAData

#Protein Data is aggregated automatically on readin
proteinData

## ----GeomxTools QC------------------------------------------------------------
proteinData <- setSegmentQCFlags(proteinData, qcCutoffs = list(percentSaturation = 45,
                                                               minSegmentReads=1000, 
                                                               percentAligned=80, 
                                                               minNegativeCount=10, 
                                                               maxNTCCount=60, 
                                                               minNuclei=16000, 
                                                               minArea=20))

# low sequenced ROIs
lowSaturation <- which(as.data.frame(protocolData(proteinData)[["QCFlags"]])["LowSaturation"] == TRUE)

# remove low quality ROIs
passedQC <- proteinData[, -lowSaturation]
dim(proteinData)
dim(passedQC)

## ----HK and IgGs--------------------------------------------------------------
hk.names <- hkNames(proteinData)
hk.names

igg.names <- iggNames(proteinData)
igg.names

## ----target QC, fig.width= 16, fig.height=7-----------------------------------
fig <- qcProteinSignal(object = proteinData, neg.names = igg.names)

proteinOrder <- qcProteinSignalNames(object = proteinData, neg.names = igg.names)
genesOfInterest <- c(which(proteinOrder == "Tyrosine Hydroxylase"),
                     which(proteinOrder == "ApoA-I"),
                     which(proteinOrder == "EpCAM"))

fig()
rect(xleft = 0, xright = 4, 
     ybottom = -2, ytop = 2, density = 0, col = "#1B9E77", lwd = 2)
rect(xleft = genesOfInterest[1]-1, xright = genesOfInterest[1]+1, 
     ybottom = -2, ytop = 1.25, density = 0, col = "#D95F02", lwd = 2)
rect(xleft = genesOfInterest[2]-1, xright = genesOfInterest[2]+1, 
     ybottom = -1, ytop = 3, density = 0, col = "#66A61E", lwd = 2)
rect(xleft = genesOfInterest[3]-1, xright = genesOfInterest[3]+1, 
     ybottom = -3, ytop = 6.5, density = 0, col = "#E7298A", lwd = 2)

## ----fig.width= 16, fig.height=7----------------------------------------------
proteinOrder <- qcProteinSignalNames(object = proteinData, neg.names = igg.names)

P62 <- which(proteinOrder == "P62")

fig()
rect(xleft = 3.5, xright = P62, ybottom = -6, ytop = 10, density = 2, col = "red", lty = 3)

## ----fig.width= 16, fig.height=7, eval=FALSE----------------------------------
# proteinOrder <- qcProteinSignalNames(object = proteinData, neg.names = igg.names)
# length(proteinOrder)
# 
# P62 <- which(proteinOrder == "P62")
# 
# fig()
# rect(xleft = 3.5, xright = P62, ybottom = -6, ytop = 10, density = 2, col = "red", lty = 3)
# 
# #Right most protein where all proteins to the left will get removed
# #start after the IgG targets
# proteinOrder <- proteinOrder[-c((length(igg.names)+1):P62)]
# length(proteinOrder)
# 
# #replot with fewer targets
# fig <- qcProteinSignal(object = proteinData[proteinOrder,], neg.names = igg.names)
# fig()

## ----fig.width= 12, fig.height=7, eval=FALSE----------------------------------
# proteinOrder <- qcProteinSignalNames(object = proteinData[proteinOrder,], neg.names = igg.names)
# #which proteins to remove from analysis
# lowTargets <- c("pan-RAS", "Neprilysin", "Olig2", "P2ry12", "p53", "NY-ESO-1", "INPP4B", "CD31", "Phospho-Alpha-synuclein (S129)", "Bcl-2")
# proteinOrder <- proteinOrder[-c(which(proteinOrder %in% lowTargets))]
# length(proteinOrder)
# 
# fig <- qcProteinSignal(object = proteinData[proteinOrder,], neg.names = igg.names)
# fig()

## ----IgG concordance, fig.height=8, fig.width=8-------------------------------
plotConcordance(object = proteinData, targetList = igg.names, plotFactor = "Tissue")

## ----norm concordance, fig.height=8, fig.width=8------------------------------
normfactors <- computeNormalizationFactors(object = proteinData,
                                           area = "AOI.Size.um2",
                                           nuclei = "Nuclei.Counts")

plotNormFactorConcordance(object = proteinData, plotFactor = "Tissue",
                          normfactors = normfactors)

## ----GeomxTools Normalization-------------------------------------------------
#HK normalization
proteinData <- normalize(proteinData, norm_method="hk", toElt = "hk_norm")

#Background normalization
proteinData <- normalize(proteinData, norm_method="neg", toElt = "neg_norm")

#Quantile normalization
proteinData <- normalize(proteinData, norm_method="quant", desiredQuantile = .75, toElt = "q_norm")

names(proteinData@assayData)

## -----------------------------------------------------------------------------
sessionInfo()

