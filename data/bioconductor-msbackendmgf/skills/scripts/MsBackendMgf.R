# Code example from 'MsBackendMgf' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(Spectra)
library(BiocStyle)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MsBackendMgf")

## ----load-libs----------------------------------------------------------------
library(Spectra)
library(MsBackendMgf)

fls <- dir(system.file("extdata", package = "MsBackendMgf"),
           full.names = TRUE, pattern = "^spectra(.*).mgf$")
fls

## ----import-------------------------------------------------------------------
sps <- Spectra(fls, source = MsBackendMgf())

## ----spectravars--------------------------------------------------------------
spectraVariables(sps)

## ----instrument---------------------------------------------------------------
sps$rtime
sps$TITLE

## ----spectravariables---------------------------------------------------------
spectraVariableMapping(MsBackendMgf())

## ----map----------------------------------------------------------------------
map <- c(spectrumName = "TITLE", spectraVariableMapping(MsBackendMgf()))
map

## ----import2------------------------------------------------------------------
sps <- Spectra(fls, source = MsBackendMgf(), mapping = map)

## ----spectrumName-------------------------------------------------------------
sps$spectrumName

## ----mz-----------------------------------------------------------------------
mz(sps)
intensity(sps)

## ----export-------------------------------------------------------------------
fl <- tempfile()
export(sps, backend = MsBackendMgf(), file = fl, mapping = map)

## ----export-check-------------------------------------------------------------
readLines(fl)[1:12]

## -----------------------------------------------------------------------------
sps$new_variable <- "A"
export(sps, backend = MsBackendMgf(), file = fl)
readLines(fl)[1:12]

## -----------------------------------------------------------------------------
sps_ex <- selectSpectraVariables(sps, c("mz", "intensity", "rtime",
                                        "acquisitionNum", "precursorMz",
                                        "precursorCharge"))
export(sps_ex, backend = MsBackendMgf(), file = fl, exportTitle = FALSE)
readLines(fl)[1:12]

## -----------------------------------------------------------------------------
fl <- dir(system.file("extdata", package = "MsBackendMgf"),
          pattern = "fiora", full.names = TRUE)
readLines(fl, 10)

## -----------------------------------------------------------------------------
sps_ann <- Spectra(fl, source = MsBackendAnnotatedMgf())
sps_ann

## -----------------------------------------------------------------------------
peaksVariables(sps_ann)

## -----------------------------------------------------------------------------
pd <- peaksData(sps_ann, columns = c("mz", "intensity", "V1"))

## -----------------------------------------------------------------------------
pd[[1L]] |>
    head()

## -----------------------------------------------------------------------------
sessionInfo()

