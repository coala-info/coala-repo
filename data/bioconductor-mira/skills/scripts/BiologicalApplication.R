# Code example from 'BiologicalApplication' vignette. See references/ for full tutorial.

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
library(MIRA)
library(data.table) # for the functions: fread, setkey, merge
library(GenomicRanges) # for the functions: GRanges, resize
library(ggplot2) # for the function: ylab
exampleAnnoDT2 <- fread(system.file("extdata", "exampleAnnoDT2.txt", 
                                   package="MIRA")) 

## ----eval=FALSE---------------------------------------------------------------
# # 12 Ewing samples: T1-T12
# pathToData <- "/path/to/MIRA_Ewing_Vignette_Files/"
# ewingFiles <- paste0(pathToData, "EWS_T", 1:12, ".bed")
# # 12 muscle related samples, 3 of each type
# muscleFiles <- c("Hsmm_", "Hsmmt_", "Hsmmfshd_","Hsmmtubefshd_")
# muscleFiles <- paste0(pathToData, muscleFiles, rep(1:3, each=4), ".bed")
# RRBSFiles <- c(ewingFiles, muscleFiles)
# regionSetFiles <- paste0(pathToData, c("sknmc_specific.bed", "muscle_specific.bed"))

## ----eval=FALSE---------------------------------------------------------------
# BSDTList <- lapply(X=RRBSFiles, FUN=BSreadBiSeq)
# regionSets <- lapply(X=regionSetFiles, FUN=fread)

## ----eval=FALSE---------------------------------------------------------------
# names(BSDTList) <- tools::file_path_sans_ext(basename(RRBSFiles))
# regionSets <- lapply(X=regionSets,
#                     FUN=function(x) setNames(x, c("chr", "start", "end")))
# regionSets <- lapply(X=regionSets, FUN=
#                         function(x) GRanges(seqnames=x$chr,
#                                               ranges=IRanges(x$start, x$end)))

## ----eval=FALSE---------------------------------------------------------------
# regionSets[[1]] <- resize(regionSets[[1]], 5000, fix="center")
# regionSets[[2]] <- resize(regionSets[[2]], 5000, fix="center")
# names(regionSets) <- c("Ewing_Specific", "Muscle_Specific")

## ----eval=FALSE---------------------------------------------------------------
# subBSDTList <- BSDTList[c(1, 5, 9, 13, 17, 21)]
# bigBin <- lapply(X=subBSDTList, FUN=aggregateMethyl, GRList=regionSets,
#                 binNum=21, minBaseCovPerBin=0)

## ----eval=FALSE---------------------------------------------------------------
# bigBinDT1 <- rbindNamedList(bigBin, newColName = "sampleName")

## ----eval=TRUE----------------------------------------------------------------
# from data included with MIRA package
data(bigBinDT1)

## ----eval=TRUE----------------------------------------------------------------
setkey(exampleAnnoDT2, sampleName)
setkey(bigBinDT1, sampleName)
bigBinDT1 <- merge(bigBinDT1, exampleAnnoDT2, all.x=TRUE)

## ----eval=TRUE----------------------------------------------------------------
plotMIRAProfiles(binnedRegDT=bigBinDT1)

## ----eval=FALSE---------------------------------------------------------------
# regionSets[[1]] <- resize(regionSets[[1]], 4000, fix="center") # Ewing
# regionSets[[2]] <- resize(regionSets[[2]], 1750, fix="center") # muscle

## ----eval=FALSE---------------------------------------------------------------
# bigBin <- lapply(X=BSDTList, FUN=aggregateMethyl, GRList=regionSets,
#                 binNum=21, minBaseCovPerBin=0)
# bigBinDT2 <- rbindNamedList(bigBin)

## ----eval=TRUE----------------------------------------------------------------
# from data included with MIRA package
data(bigBinDT2)

## ----eval=TRUE----------------------------------------------------------------
# data.table functions are used to add info from annotation object to bigBinDT2
setkey(exampleAnnoDT2, sampleName)
setkey(bigBinDT2, sampleName)
bigBinDT2 <- merge(bigBinDT2, exampleAnnoDT2, all.x=TRUE)

## ----eval=TRUE----------------------------------------------------------------
plotMIRAProfiles(binnedRegDT=bigBinDT2)

## ----eval=TRUE, results="hide"------------------------------------------------
bigBinDT2[, methylProp := methylProp - min(methylProp) + .05, by=.(featureID, sampleName)]

## ----eval=TRUE----------------------------------------------------------------
normPlot <- plotMIRAProfiles(binnedRegDT=bigBinDT2)
normPlot + ylab("Normalized DNA Methylation (%)")

## ----eval=TRUE----------------------------------------------------------------
sampleScores <- calcMIRAScore(bigBinDT2,
                        shoulderShift="auto",
                        regionSetIDColName="featureID",
                        sampleIDColName="sampleName")
head(sampleScores)

## ----eval=TRUE----------------------------------------------------------------
setkey(exampleAnnoDT2, sampleName)
setkey(sampleScores, sampleName)
sampleScores <- merge(sampleScores, exampleAnnoDT2, all.x=TRUE)
plotMIRAScores(sampleScores)

## -----------------------------------------------------------------------------
EwingSampleEwingRegions <- sampleScores[sampleScores$sampleType == "Ewing" &
                                           sampleScores$featureID ==
                                           "Ewing_Specific", ]
myoSampleEwingRegions <- sampleScores[sampleScores$sampleType == "Muscle-related" &
                                           sampleScores$featureID ==
                                           "Ewing_Specific", ]
wilcox.test(EwingSampleEwingRegions$score, myoSampleEwingRegions$score)

## -----------------------------------------------------------------------------
EwingSampleMyoRegions <- sampleScores[sampleScores$sampleType == "Ewing" &
                                           sampleScores$featureID ==
                                           "Muscle_Specific", ]
myoSampleMyoRegions <- sampleScores[sampleScores$sampleType == "Muscle-related" &
                                           sampleScores$featureID ==
                                           "Muscle_Specific", ]
wilcox.test(EwingSampleMyoRegions$score, myoSampleMyoRegions$score)

