# Code example from 'breakpointR' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results='asis'--------------------
BiocStyle::latex()

## ----include=FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)

## ----include=FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)

## ----options, results='hide', message=FALSE, eval=TRUE, echo=FALSE----------------------
library(breakpointR)
options(width=90)

## ----eval=FALSE-------------------------------------------------------------------------
# library(breakpointR)
# ## Run breakpointR with a default parameters
# breakpointr(inputfolder='folder-with-BAMs', outputfolder='output-folder')

## ----eval=TRUE--------------------------------------------------------------------------
?breakpointr

## ----eval=FALSE-------------------------------------------------------------------------
# breakpointr(..., configfile='breakpointR.config')

## ----eval=FALSE-------------------------------------------------------------------------
# callHotSpots=TRUE

## ----eval=TRUE, message=FALSE-----------------------------------------------------------
library(breakpointR)

## Get some example files
datafolder <- system.file("extdata", "example_bams", package="breakpointRdata")
outputfolder <- tempdir()
## Run breakpointR
breakpointr(inputfolder = datafolder, outputfolder = outputfolder, 
            chromosomes = 'chr22', pairedEndReads = FALSE,
            reuse.existing.files = FALSE, windowsize = 1000000, 
            binMethod = 'size', pair2frgm = FALSE, min.mapq = 10, 
            filtAlt = TRUE)


## ----eval=FALSE-------------------------------------------------------------------------
# breakpointr(..., min.mapq = 10, filtAlt = TRUE)

## ----eval=FALSE-------------------------------------------------------------------------
# library(breakpointR)
# ## Binning strategy based on desired bin length
# breakpointr(inputfolder='folder-with-BAM', outputfolder='output-folder',
#             windowsize=1e6, binMethod='size')
# ## Binning strategy based user-defined number of reads in each bin
# breakpointr(inputfolder='folder-with-BAM', outputfolder='output-folder',
#             windowsize=100, binMethod='reads')

## ----eval=TRUE, warning=FALSE, message=FALSE--------------------------------------------
## Example deltaW values
exampleFolder <- system.file("extdata", "example_results",
                             package="breakpointRdata")
exampleFile <- list.files(exampleFolder, full.names=TRUE)[1]
breakpoint.object <- loadFromFiles(exampleFile)
head(breakpoint.object[[1]]$deltas)

## ----eval=FALSE-------------------------------------------------------------------------
# ## To run breakpoint hotspot analysis using the main breakpointR function
# breakpointr(..., callHotSpots=TRUE)

## ----eval=TRUE, message=FALSE-----------------------------------------------------------
## To run breakpoint hotspot analysis using exported data
exampleFolder <- system.file("extdata", "example_results", 
                             package="breakpointRdata")
exampleFiles <- list.files(exampleFolder, full.names=TRUE)
breakpoint.objects <- loadFromFiles(exampleFiles)
## Extract breakpoint coordinates
breaks <- lapply(breakpoint.objects, '[[', 'breaks')
## Get hotspot coordinates
hotspots <- hotspotter(breaks, bw=1e6)

## ----eval=TRUE, warning=FALSE, message=FALSE, fig.width=12, fig.height=4----------------
## Plotting a single library
exampleFolder <- system.file("extdata", "example_results",
                             package="breakpointRdata")
exampleFile <- list.files(exampleFolder, full.names=TRUE)[1]
plotBreakpoints(exampleFile)

## ----eval=TRUE, warning=FALSE, message=FALSE, fig.width=12, fig.height=5----------------
## Plotting a single library
exampleFolder <- system.file("extdata", "example_results",
                             package="breakpointRdata")
exampleFiles <- list.files(exampleFolder, full.names=TRUE)[1:4]
plotBreakpointsPerChr(exampleFiles, chromosomes = 'chr7')

## ----sessionInfo, results='asis', eval=TRUE---------------------------------------------
toLatex(sessionInfo())

