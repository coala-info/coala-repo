# Code example from 'Autotuner' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----dev installation, eval=FALSE---------------------------------------------
#  devtools::install_github("crmclean/Autotuner")

## ----BioC installation, eval=FALSE--------------------------------------------
#  if(!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("Autotuner")

## ----setup, warning=FALSE-----------------------------------------------------
library(Autotuner)
library(mtbls2)  

## ----loading mass spec data---------------------------------------------------
rawPaths <- c(
    system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-1_1-B,3_01_9828.mzData", 
                             package = "mtbls2"),
system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-2_1-B,4_01_9830.mzData", 
            package = "mtbls2"),
system.file("mzData/MSpos-Ex2-cyp79-48h-Ag-4_1-B,4_01_9834.mzData", 
            package = "mtbls2"))

if(!all(file.exists(rawPaths))) {
    stop("Not all files matched here exist.")
}

## ----filetype-----------------------------------------------------------------
print(basename(rawPaths))

## -----------------------------------------------------------------------------
print(rawPaths)

## ----loading in metadata------------------------------------------------------
metadata <- read.table(system.file(
    "a_mtbl2_metabolite_profiling_mass_spectrometry.txt", 
    package = "mtbls2"), header = TRUE, stringsAsFactors = FALSE)

metadata <- metadata[sub("mzData/", "", metadata$Raw.Spectral.Data.File) %in% 
                         basename(rawPaths),]

## -----------------------------------------------------------------------------
print(metadata)

## -----------------------------------------------------------------------------
Autotuner <- createAutotuner(rawPaths,
                             metadata,
                             file_col = "Raw.Spectral.Data.File",
                             factorCol = "Factor.Value.genotype.")

## -----------------------------------------------------------------------------
lag <- 25
threshold<- 3.1
influence <- 0.1
signals <- lapply(getAutoIntensity(Autotuner), 
                 ThresholdingAlgo, lag, threshold, influence)

## ----plotting TIC, ig.width=6, fig.height=4-----------------------------------
plot_signals(Autotuner, 
             threshold, 
             ## index for which data files should be displayed
             sample_index = 1:3, 
             signals = signals)
rm(lag, influence, threshold)

## -----------------------------------------------------------------------------
Autotuner <- isolatePeaks(Autotuner = Autotuner, 
                          returned_peaks = 10, 
                          signals = signals)

## -----------------------------------------------------------------------------
for(i in 1:5) {
    plot_peaks(Autotuner = Autotuner, 
           boundary = 100, 
           peak = i)    
}

## -----------------------------------------------------------------------------
## error with peak width estimation
## idea - filter things by mass. smaler masses are more likely to be 
## random assosications
eicParamEsts <- EICparams(Autotuner = Autotuner, 
                          massThresh = .005, 
                          verbose = FALSE,
                          returnPpmPlots = FALSE,
                          useGap = TRUE)

## -----------------------------------------------------------------------------
returnParams(eicParamEsts, Autotuner)

## -----------------------------------------------------------------------------
sessionInfo()

