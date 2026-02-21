# Code example from 'PoDCall' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----installation, eval=FALSE-------------------------------------------------
# ## Install from Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("PoDCall")
# 
# 
# ## Install PoDCall from GitHub
# install.packages("devtools")
# devtools::install_github("HansPetterBrodal/PoDCall")
# 
# ## Install PoDCall from source file
# install.packages("remotes")
# remotes::install_local("path/to/PoDCall_x.y.z.tar.gz")
# 

## ----loading, eval=TRUE-------------------------------------------------------

library(PoDCall)


## ----eval=FALSE---------------------------------------------------------------
# ## Run PoDCall
# thresholdTable <- podcallDdpcr(dataDirectory="path/to/data/",
#                                 software="QuantaSoft")

## ----import-amplitude-data, echo=TRUE-----------------------------------------
## Path to example data files included in PoDCall
path <- system.file("extdata", "Amplitudes/", package="PoDCall")

## Read in data files
dataList <- importAmplitudeData(dataDirectory=path, skipLines=0)
str(dataList)

## ----import-sample-sheet, echo=TRUE-------------------------------------------
## Path to example files included in PoDCall
path <- system.file("extdata", "Sample_names.csv", package="PoDCall")

## Select wells to get information for
well_id <- c("A04", "B04", "D04")

## Read in sample sheet information for selected wells
sampleSheet <- importSampleSheet(sampleSheet=path, well_id=well_id,
                                software="QuantaSoft")
print(sampleSheet)


## ----set-thresholds, eval=FALSE-----------------------------------------------
# ## Path to example data files included in PoDCall
# path <- system.file("extdata", "Amplitudes/", package="PoDCall")
# 
# ## Read in data files
# ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
# 
# ## Calculate thresholds, metrics, concentrations
# thresholdTable <- podcallThresholds(plateData=ampData)
# print(thresholdTable)

## ----channel-plot, echo=TRUE--------------------------------------------------
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
data("thrTable")
thresholdTable <- thrTable

## Select channel and well to plot
ch <- 1 # target channel
well_id <- names(ampData)[1] # First well in list

## Plot title
plotTitle <- paste0(well_id, ", Ch", ch)

## Create plot
podcallChannelPlot(channelData=ampData[[well_id]][,ch],
                    thr=thresholdTable[well_id, "thr_target"],
                    channel=ch,
                    plotId=plotTitle)

## ----scatter-plot, echo=TRUE--------------------------------------------------
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
thresholdTable <- thrTable

## Select channel and well to plot
ch <- 1 # target channel
well_id <- names(ampData)[1] # First well in list

## Plot title
plotTitle <- paste0(well_id, ", Ch", ch)

## Create plot
podcallScatterplot(channelData=ampData[[well_id]][,ch],
                    thr=thresholdTable[well_id, "thr_target"],
                    channel=ch,
                    plotId=plotTitle)


## ----plot-histogram, echo=TRUE------------------------------------------------
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
thresholdTable <- thrTable

## Select channel and well to plot
ch <- 1 # target channel
well_id <- names(ampData)[1] # First well in list

## Plot title
plotTitle <- paste0(well_id, ", Ch", ch)

## Create plot
podcallHistogram(channelData=ampData[[well_id]][,ch],
                thr=thresholdTable[well_id, "thr_target"],
                channel=ch,
                plotId=plotTitle)

## ----comparison-plot, echo=TRUE-----------------------------------------------
## Read in data and threshold table
path <- system.file("extdata", "Amplitudes/", package="PoDCall")
ampData <- importAmplitudeData(dataDirectory=path, skipLines=0)
thresholdTable <- thrTable

## Channel to plot
ch <- "target"

## Create comparison plot
podcallMultiplot(plateData=ampData,
                thresholds=thresholdTable[names(ampData),], 
                channel=ch, colCh=1)


## ----launch-shiny-app, eval=FALSE---------------------------------------------
# podcallShiny()

## ----example-data, eval=TRUE--------------------------------------------------
## Path to files
path <- system.file("extdata", "Amplitudes/", package="PoDCall")

## List files
list.files(path)

## ----example-thresholds, echo=TRUE--------------------------------------------
## The threshold table
thrTable

## ----session-info, eval=TRUE--------------------------------------------------
sessionInfo()

