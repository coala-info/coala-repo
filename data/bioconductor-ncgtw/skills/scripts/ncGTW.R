# Code example from 'ncGTW' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse=TRUE,
    comment="#>"
)

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_github("ChiungTingWu/ncGTW")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ncGTW")

## ----eval = FALSE-------------------------------------------------------------
# excluGroups <- misalignDetect(xcmsLargeWin, xcmsSmallWin, ppm)

## ----message = FALSE----------------------------------------------------------
library(xcms)
library(ncGTW)
filepath <- system.file("extdata", package = "ncGTW")
file <- list.files(filepath, pattern = "mzxml", full.names = TRUE)
# The paths of the 20 samples

## -----------------------------------------------------------------------------
tempInd <- matrix(0, length(file), 1)
for (n in seq_along(file)){
    tempCha <- file[n]
    tempLen <- nchar(tempCha)
    tempInd[n] <- as.numeric(substr(tempCha, regexpr("example", tempCha) + 7, 
        tempLen - 6))
}
file <- file[sort.int(tempInd, index.return = TRUE)$ix]
# Sort the paths by data acquisition order to incorporate the RT structure

## ----message = FALSE, warning = FALSE-----------------------------------------
CPWmin <- 2 
CPWmax <- 25 
ppm <- 15 
xsnthresh <- 3 
LM <- FALSE
integrate <- 2 
RTerror <- 6 
MZerror <- 0.05
prefilter <- c(8, 1000)
# XCMS parameters
ds <- xcmsSet(file, method="centWave", peakwidth=c(CPWmin, CPWmax), ppm=ppm, 
    noise=xsnthresh, integrate=integrate, prefilter=prefilter)
gds <- group(ds, mzwid=MZerror, bw=RTerror)
agds <- retcor(gds, missing=5)
# XCMS peak detection and RT alignment

## ----message = FALSE----------------------------------------------------------
bwLarge <- RTerror
bwSmall <- 0.3
# Two different values of bw parameter
xcmsLargeWin <- group(agds, mzwid=MZerror, bw=bwLarge)
xcmsSmallWin <- group(agds, mzwid=MZerror, bw=bwSmall, minfrac=0)
# Two resolution of XCMS grouping results

## ----message = FALSE----------------------------------------------------------
excluGroups <- misalignDetect(xcmsLargeWin, xcmsSmallWin, ppm)
# Detect misaligned features
show(excluGroups)

## ----message = FALSE----------------------------------------------------------
ncGTWinputs <- loadProfile(file, excluGroups)
# Load raw profiles from the files

## ----message = FALSE----------------------------------------------------------
for (n in seq_along(ncGTWinputs))
    plotGroup(ncGTWinputs[[n]], slot(xcmsLargeWin, 'rt')$corrected, ind=n)
    # (Optional) Draw the detected misaligned features

## ----message = FALSE----------------------------------------------------------
ncGTWoutputs <- vector('list', length(ncGTWinputs))
# Prepare the output variable
ncGTWparam <- new("ncGTWparam")
# Initialize the parameters of ncGTW alignment with default
for (n in seq_along(ncGTWinputs))
    ncGTWoutputs[[n]] <- ncGTWalign(ncGTWinputs[[n]], xcmsLargeWin, parSamp=5,
        bpParam=SnowParam(workers=4), ncGTWparam=ncGTWparam)
# Perform ncGTW alignment

## ----message = FALSE----------------------------------------------------------
ncGTWres <- xcmsLargeWin
# Prepare a new xcmsSet to contain the realignment result
ncGTWRt <- vector('list', length(ncGTWinputs))
for (n in seq_along(ncGTWinputs)){
    adjustRes <- adjustRT(ncGTWres, ncGTWinputs[[n]], ncGTWoutputs[[n]], ppm)
    # Generate the new warping functions
    peaks(ncGTWres) <- ncGTWpeaks(adjustRes)
    # Relocate the peaks to the new RT points according to the realignment.  
    ncGTWRt[[n]] <- rtncGTW(adjustRes)
    # Temporary variable for new warping functions 
}

## ----message = FALSE----------------------------------------------------------
for (n in seq_along(ncGTWinputs))
    plotGroup(ncGTWinputs[[n]], ncGTWRt[[n]], ind = n)
    # (Optional) Draw the realigned features

## ----message = FALSE----------------------------------------------------------
groups(ncGTWres) <- excluGroups[ , 2:9]
groupidx(ncGTWres) <- groupidx(xcmsLargeWin)[excluGroups[ , 1]]
# Only consider the misaligned features
rtCor <- vector('list', length(file))
for (n in seq_along(file)){
    rtCor[[n]] <- vector('list', dim(excluGroups)[1])
    for (m in seq_len(dim(groups(ncGTWres))[1]))
        rtCor[[n]][[m]] <- ncGTWRt[[m]][[n]]
}
slot(ncGTWres, 'rt')$corrected <- rtCor
# Replace the XCMS warping function to ncGTW warping function
XCMSres <- xcmsLargeWin
groups(XCMSres) <- excluGroups[ , 2:9]
groupidx(XCMSres) <- groupidx(xcmsLargeWin)[excluGroups[ , 1]]
# Consider only the misaligned features with XCMS warping function

## ----message = FALSE----------------------------------------------------------
assignInNamespace("fillPeaksChromPar", ncGTW:::fillPeaksChromPar, ns="xcms",
    envir=as.environment("package:xcms"))
# Replace fillPeaksChromPar() in XCMS
ncGTWresFilled <- fillPeaks(ncGTWres)
XCMSresFilled <- fillPeaks(XCMSres)
# Peak-filling with old and new warping functions
compCV(XCMSresFilled)
compCV(ncGTWresFilled)
# Compare the coefficient of variation

