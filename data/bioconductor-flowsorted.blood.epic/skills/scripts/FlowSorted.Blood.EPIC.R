# Code example from 'FlowSorted.Blood.EPIC' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=TRUE----------------------------------------------------------------
library(FlowSorted.Blood.EPIC)
FlowSorted.Blood.EPIC <- libraryDataGet('FlowSorted.Blood.EPIC')
FlowSorted.Blood.EPIC

## ----eval=FALSE---------------------------------------------------------------
# data("IDOLOptimizedCpGs")
# head(IDOLOptimizedCpGs)

## ----eval=FALSE---------------------------------------------------------------
# data("IDOLOptimizedCpGs450klegacy")
# head(IDOLOptimizedCpGs450klegacy)

## ----eval=TRUE----------------------------------------------------------------
# Step 1: Load the reference library to extract the artificial mixtures
FlowSorted.Blood.EPIC <- libraryDataGet('FlowSorted.Blood.EPIC')
FlowSorted.Blood.EPIC

library(minfi)
# Note: If your machine does not allow access to internet you can download
# and save the file. Then load it manually into the R environment


# Step 2 separate the reference from the testing dataset if you want to run 
# examples for estimations for this function example

RGsetTargets <- FlowSorted.Blood.EPIC[,
             FlowSorted.Blood.EPIC$CellType == "MIX"]
             
sampleNames(RGsetTargets) <- paste(RGsetTargets$CellType,
                            seq_len(dim(RGsetTargets)[2]), sep = "_")
RGsetTargets

# Step 3: use your favorite package for deconvolution.
# Deconvolve a target data set consisting of EPIC DNA methylation 
# data profiled in blood, using your prefered method.

# You can use our IDOL optimized DMR library for the EPIC array.  This object
# contains a vector of length 450 consisting of the IDs of the IDOL optimized
# CpG probes.  These CpGs are used as the backbone for deconvolution and were
# selected because their methylation signature differs across the six normal 
# leukocyte subtypes. Use the option "IDOL"

head (IDOLOptimizedCpGs)
# If you need to deconvolve a 450k legacy dataset use 
# IDOLOptimizedCpGs450klegacy instead

# We recommend using Noob processMethod = "preprocessNoob" in minfi for the 
# target and reference datasets. 
# Cell types included are "CD8T", "CD4T", "NK", "Bcell", "Mono", "Neu"

# To use the IDOL optimized list of CpGs (IDOLOptimizedCpGs) use 
# estimateCellCounts2 an adaptation of the popular estimateCellCounts in 
# minfi. This function also allows including customized reference arrays. 

# Do not run with limited RAM the normalization step requires a big amount 
# of memory resources

 propEPIC<-estimateCellCounts2(RGsetTargets, compositeCellType = "Blood", 
                                processMethod = "preprocessNoob",
                                probeSelect = "IDOL", 
                                cellTypes = c("CD8T", "CD4T", "NK", "Bcell", 
                                "Mono", "Neu"))
                                
print(head(propEPIC$prop))
percEPIC<-round(propEPIC$prop*100,1)

## ----eval=TRUE----------------------------------------------------------------

noobset<- preprocessNoob(RGsetTargets)
#or from estimateCellCounts2 returnAll=TRUE

 propEPIC<-projectCellType_CP (
 getBeta(noobset)[IDOLOptimizedCpGs,],
 IDOLOptimizedCpGs.compTable, contrastWBC=NULL, nonnegative=TRUE,
 lessThanOne=FALSE)

print(head(propEPIC))
percEPIC<-round(propEPIC*100,1)


# If you prefer CIBERSORT or RPC deconvolution use EpiDISH or similar

# Example not to run

# library(EpiDISH)
# RPC <- epidish(getBeta(noobset)[IDOLOptimizedCpGs,],
# IDOLOptimizedCpGs.compTable, method = "RPC")
# RPC$estF#RPC proportion estimates
# percEPICRPC<-round(RPC$estF*100,1)#percentages
# 
# CBS <- epidish(getBeta(noobset)[IDOLOptimizedCpGs,],
# IDOLOptimizedCpGs.compTable, method = "CBS")
# CBS$estF#CBS proportion estimates
# percEPICCBS<-round(CBS$estF*100,1)#percentages

## ----Umbilical Cord Blood, eval=FALSE-----------------------------------------
# # # UMBILICAL CORD BLOOD DECONVOLUTION
# #
# # library (FlowSorted.CordBloodCombined.450k)
# # # Step 1: Load the reference library to extract the umbilical cord samples
# # FlowSorted.CordBloodCombined.450k <-
# #     libraryDataGet('FlowSorted.CordBloodCombined.450k')
# #
# # FlowSorted.CordBloodCombined.450k
# #
# # # Step 2 separate the reference from the testing dataset if you want to run
# # # examples for estimations for this function example
# #
# # RGsetTargets <- FlowSorted.CordBloodCombined.450k[,
# # FlowSorted.CordBloodCombined.450k$CellType == "WBC"]
# # sampleNames(RGsetTargets) <- paste(RGsetTargets$CellType,
# #                               seq_len(dim(RGsetTargets)[2]), sep = "_")
# # RGsetTargets
# #
# # # Step 3: use your favorite package for deconvolution.
# # # Deconvolve a target data set consisting of 450K DNA methylation
# # # data profiled in blood, using your prefered method.
# # # You can use our IDOL optimized DMR library for the Cord Blood,  This object
# # # contains a vector of length 517 consisting of the IDs of the IDOL optimized
# # # CpG probes.  These CpGs are used as the backbone for deconvolution and were
# # # selected because their methylation signature differs across the six normal
# # # leukocyte subtypes plus the nucleated red blood cells.
# #
# # # We recommend using Noob processMethod = "preprocessNoob" in minfi for the
# # # target and reference datasets.
# # # Cell types included are "CD8T", "CD4T", "NK", "Bcell", "Mono", "Gran",
# # # "nRBC"
# # # To use the IDOL optimized list of CpGs (IDOLOptimizedCpGsCordBlood) use
# # # estimateCellCounts2 from FlowSorted.Blood.EPIC.
# # # Do not run with limited RAM the normalization step requires a big amount
# # # of memory resources. Use the parameters as specified below for
# # # reproducibility.
# # #
# #
# #     propUCB<-estimateCellCounts2(RGsetTargets,
# #                                     compositeCellType =
# #                                                "CordBloodCombined",
# #                                     processMethod = "preprocessNoob",
# #                                     probeSelect = "IDOL",
# #                                     cellTypes = c("CD8T", "CD4T", "NK",
# #                                     "Bcell", "Mono", "Gran", "nRBC"))
# #
# #     head(propUCB$prop)
# #     percUCB<-round(propUCB$prop*100,1)
# 

## ----cell counts, eval=FALSE--------------------------------------------------
# # library(FlowSorted.Blood.450k)
# # RGsetTargets2 <- FlowSorted.Blood.450k[,
# #                              FlowSorted.Blood.450k$CellType == "WBC"]
# # sampleNames(RGsetTargets2) <- paste(RGsetTargets2$CellType,
# #                              seq_len(dim(RGsetTargets2)[2]), sep = "_")
# # RGsetTargets2
# # propEPIC2<-estimateCellCounts2(RGsetTargets2, compositeCellType = "Blood",
# #                              processMethod = "preprocessNoob",
# #                              probeSelect = "IDOL",
# #                              cellTypes = c("CD8T", "CD4T", "NK", "Bcell",
# #                              "Mono", "Neu"), cellcounts = rep(10000,6))
# # head(propEPIC2$prop)
# # head(propEPIC2$counts)
# # percEPIC2<-round(propEPIC2$prop*100,1)

## ----Blood extended deconvolution, eval=FALSE---------------------------------
# # # Blood Extended deconvolution or any external reference
# # #please contact <Technology.Transfer@dartmouth.edu>
# #
# # # Do not run
# # library (FlowSorted.BloodExtended.EPIC)
# # #
# # # Step 1: Extract the mix samples
# #
# # FlowSorted.Blood.EPIC <- libraryDataGet('FlowSorted.Blood.EPIC')
# #
# # # Step 2 separate the reference from the testing dataset if you want to run
# # # examples for estimations for this function example
# #
# # RGsetTargets <- FlowSorted.Blood.EPIC[,
# # FlowSorted.Blood.EPIC$CellType == "MIX"]
# # sampleNames(RGsetTargets) <- paste(RGsetTargets$CellType,
# #                               seq_len(dim(RGsetTargets)[2]), sep = "_")
# # RGsetTargets
# #
# # # Step 3: use your favorite package for deconvolution.
# # # Deconvolve the target data set 450K or EPIC blood DNA methylation.
# # # We recommend ONLY the IDOL method, the automatic method can lead to severe
# # # biases.
# #
# # # We recommend using Noob processMethod = "preprocessNoob" in minfi for the
# # # target and reference datasets.
# # # Cell types included are "Bas", "Bmem", "Bnv", "CD4mem", "CD4nv",
# # # "CD8mem", "CD8nv", "Eos", "Mono", "Neu", "NK", and "Treg"
# # # Use estimateCellCounts2 from FlowSorted.Blood.EPIC.
# # # Do not run with limited RAM the normalization step requires a big amount
# # # of memory resources. Use the parameters as specified below for
# # # reproducibility.
# # #
# #
# #     prop_ext<-estimateCellCounts2(RGsetTargets,
# #                                     compositeCellType =
# #                                                "BloodExtended",
# #                                     processMethod = "preprocessNoob",
# #                                     probeSelect = "IDOL",
# #                                     cellTypes = c("Bas", "Bmem", "Bnv",
# #                                                "CD4mem", "CD4nv",
# #                                               "CD8mem", "CD8nv", "Eos",
# #                                               "Mono", "Neu", "NK", "Treg"),
# #     CustomCpGs =if(RGsetTargets@annotation[1]=="IlluminaHumanMethylationEPIC"){
# #     IDOLOptimizedCpGsBloodExtended}else{IDOLOptimizedCpGsBloodExtended450k})
# #
# #    perc_ext<-round(prop_ext$prop*100,1)
# #    head(perc_ext)
# 

## -----------------------------------------------------------------------------
sessionInfo()

