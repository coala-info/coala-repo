# Code example from 'yamss' vignette. See references/ for full tutorial.

## ----dependencies, warning=FALSE, message=FALSE-------------------------------
library(yamss)
library(mtbls2)

## -----------------------------------------------------------------------------
filepath <- file.path(find.package("mtbls2"), "mzML")
files <- list.files(filepath, pattern = "MSpos-Ex1", recursive = TRUE, full.names = TRUE)
classes <- rep(c("wild-type", "mutant"), each = 4)

## -----------------------------------------------------------------------------
colData <- DataFrame(sampClasses = classes, ionmode = "pos")
cmsRaw <- readMSdata(files = files, colData = colData, mzsubset = c(500,520), verbose = TRUE)
cmsRaw

## -----------------------------------------------------------------------------
cmsProc <- bakedpi(cmsRaw, dbandwidth = c(0.01, 10), dgridstep = c(0.01, 1),
                   outfileDens = NULL, dortalign = TRUE, mzsubset = c(500, 520), verbose = TRUE)
cmsProc

## -----------------------------------------------------------------------------
cmsSlice <- slicepi(cmsProc, cutoff = NULL, verbose = TRUE)
cmsSlice

## -----------------------------------------------------------------------------
dr <- diffrep(cmsSlice, classes = classes)
head(dr)

## -----------------------------------------------------------------------------
topPeaks <- as.numeric(rownames(dr)[1:10])
topPeaks

## -----------------------------------------------------------------------------
bounds <- peakBounds(cmsSlice)
idx <- match(topPeaks, bounds[,"peaknum"])
bounds[idx,]

## -----------------------------------------------------------------------------
dmat <- densityEstimate(cmsProc)

## -----------------------------------------------------------------------------
mzrange <- c(bounds[idx[1], "mzmin"], bounds[idx[1], "mzmax"])
scanrange <- c(bounds[idx[1], "scanmin"], bounds[idx[1], "scanmax"])
plotDensityRegion(cmsProc, mzrange = mzrange + c(-0.5,0.5), scanrange = scanrange + c(-30,30))

## -----------------------------------------------------------------------------
cmsSlice2 <- slicepi(cmsProc, densityCutoff(cmsSlice)*0.99)
dqs <- densityQuantiles(cmsProc)
head(dqs)
cmsSlice3 <- slicepi(cmsProc, dqs["98.5%"])
nrow(peakBounds(cmsSlice)) # Number of peaks detected - original
nrow(peakBounds(cmsSlice2)) # Number of peaks detected - updated
nrow(peakBounds(cmsSlice3)) # Number of peaks detected - updated

## ----sessionInfo, results='asis', echo=FALSE----------------------------------
sessionInfo()

