# Code example from 'IPO' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE, warning = FALSE---------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
library(faahKO)

## ----install_IPO, eval=FALSE--------------------------------------------------
# # try http:// if https:// URLs are not supported
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("IPO")

## ----install_IPO_suggestions, eval=FALSE--------------------------------------
# # for examples of peak picking parameter optimization:
# BiocManager::install("msdata")
# # for examples of optimization of retention time correction and grouping
# # parameters:
# BiocManager::install("faahKO")

## ----file_choosing------------------------------------------------------------
datapath <- system.file("cdf", package = "faahKO")
datafiles <- list.files(datapath, recursive = TRUE, full.names = TRUE)

## ----load_IPO, message=FALSE--------------------------------------------------
library(IPO)

## ----optimize_peak_picking, fig.height=7, fig.width=7, warning=FALSE----------
peakpickingParameters <- getDefaultXcmsSetStartingParams('matchedFilter')
#setting levels for step to 0.2 and 0.3 (hence 0.25 is the center point)
peakpickingParameters$step <- c(0.2, 0.3)
peakpickingParameters$fwhm <- c(40, 50)
#setting only one value for steps therefore this parameter is not optimized
peakpickingParameters$steps <- 2

time.xcmsSet <- system.time({ # measuring time
resultPeakpicking <- 
  optimizeXcmsSet(files = datafiles[1:2], 
                  params = peakpickingParameters, 
                  nSlaves = 1, 
                  subdir = NULL,
                  plot = TRUE)
})

## ----optimize_peak_picking_result---------------------------------------------
resultPeakpicking$best_settings$result
optimizedXcmsSetObject <- resultPeakpicking$best_settings$xset

## ----optimize_retcor_group, fig.height=7, fig.width=7, warning = FALSE--------
retcorGroupParameters <- getDefaultRetGroupStartingParams()
retcorGroupParameters$profStep <- 1
retcorGroupParameters$gapExtend <- 2.7
time.RetGroup <- system.time({ # measuring time
resultRetcorGroup <-
  optimizeRetGroup(xset = optimizedXcmsSetObject, 
                   params = retcorGroupParameters, 
                   nSlaves = 1, 
                   subdir = NULL,
                   plot = TRUE)
})

## ----display_settings---------------------------------------------------------
writeRScript(resultPeakpicking$best_settings$parameters, 
             resultRetcorGroup$best_settings)

## ----times--------------------------------------------------------------------
time.xcmsSet # time for optimizing peak picking parameters
time.RetGroup # time for optimizing retention time correction and grouping parameters

sessionInfo()

