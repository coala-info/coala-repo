# Code example from 'RICorrection' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----LibraryPreload--------------------------------------------------------
library(TargetSearch)
library(TargetSearchData)

## ----cdffiles--------------------------------------------------------------
cdfPath <- tsd_data_path()
dir(cdfPath, pattern="cdf$")

## ----samples---------------------------------------------------------------
samples.all <- ImportSamplesFromDir(cdfPath)
RIpath(samples.all) <- "."

## ----rim-------------------------------------------------------------------
rimLimits <- ImportFameSettings(tsd_file_path("rimLimits.txt"))
rimLimits

## ----ricorrect-------------------------------------------------------------
RImatrix <- RIcorrect(samples.all, rimLimits, writeCDF4path=FALSE,
            Window=15, pp.method="ppc", IntThreshold=50)
RImatrix

## ----isRIMarker------------------------------------------------------------
isRIMarker <- rep(FALSE, length(samples.all))
isRIMarker[c(1, 6, 11)] <- TRUE

## ----updateRImatrix2-------------------------------------------------------
RImatrix2 <- RImatrix
RImatrix2[, 2:5]   <- RImatrix[,1]
RImatrix2[, 7:10]  <- RImatrix[,6]
RImatrix2[, 12:15] <- RImatrix[,11]

## ----updateRImatrix--------------------------------------------------------
RImatrix2 <- RImatrix
z <- cumsum(as.numeric(isRIMarker))
for(i in unique(z))
    RImatrix2[, z==i] <- RImatrix[, z==i][,1]
RImatrix2

## ----fixRI-----------------------------------------------------------------
fixRI(samples.all, rimLimits, RImatrix2, which(!isRIMarker))

## ----finally---------------------------------------------------------------
samples <- samples.all[!isRIMarker]
RImatrix <- RImatrix2[, !isRIMarker]

## ----sessionInfo, results="asis", echo=FALSE-------------------------------
toLatex(sessionInfo())

