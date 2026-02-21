# Code example from 'GettingStarted' vignette. See references/ for full tutorial.

## ----echo=FALSE, warning=FALSE------------------------------------------------
library(MIRA)
data(exampleBins)
plotMIRAProfiles(exampleBins)
exScores <- calcMIRAScore(exampleBins, 
                    regionSetIDColName="featureID",
                    sampleIDColName="sampleName")
# normally sampleType would come from annotation object 
# but for this example we are manually adding sampleType column
sampleType <- c("Condition1", "Condition2")
exScores <- cbind(exScores, sampleType)
exScores

## -----------------------------------------------------------------------------
data("exampleBSDT", package="MIRA")
head(exampleBSDT)

## ----message=FALSE------------------------------------------------------------
data("exampleRegionSet", package="MIRA")
head(exampleRegionSet)

## ----message=FALSE------------------------------------------------------------
library(MIRA)
library(GenomicRanges) # for the `resize`, `width` functions
data("exampleRegionSet", package="MIRA")
data("exampleBSDT", package="MIRA")

## -----------------------------------------------------------------------------
BSDTList <- list(exampleBSDT)
names(BSDTList) <- "Gm06990_1"

## -----------------------------------------------------------------------------
BSDTList <- addMethPropCol(BSDTList)

## -----------------------------------------------------------------------------
mean(width(exampleRegionSet))

## -----------------------------------------------------------------------------
exampleRegionSet <- resize(exampleRegionSet, 4000, fix="center")
mean(width(exampleRegionSet))

## -----------------------------------------------------------------------------
exampleRegionSetGRL <- GRangesList(exampleRegionSet)
names(exampleRegionSetGRL) <- "lymphoblastoid_NRF1"

## ----Aggregate_methylation, message=FALSE, warning=FALSE----------------------
bigBin <- lapply(X=BSDTList, FUN=aggregateMethyl, GRList=exampleRegionSetGRL, 
                binNum=11)
bigBinDT <- bigBin[[1]]

## ----Plot profiles, message=FALSE, warning=FALSE------------------------------
sampleName = rep(names(bigBin), nrow(bigBinDT))
bigBinDT = cbind(bigBinDT, sampleName)
plotMIRAProfiles(binnedRegDT=bigBinDT)

## ----Scoring, warning=FALSE---------------------------------------------------
sampleScores <- calcMIRAScore(bigBinDT,
                        regionSetIDColName="featureID",
                        sampleIDColName="sampleName")
head(sampleScores)

## ----eval=FALSE---------------------------------------------------------------
# library(LOLA)
# pathToDB <- "path/to/LOLACore/hg38"
# regionDB <- loadRegionDB(pathToDB)

