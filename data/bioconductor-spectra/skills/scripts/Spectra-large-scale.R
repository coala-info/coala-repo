# Code example from 'Spectra-large-scale' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(Spectra)
register(SerialParam())
library(BiocStyle)

## -----------------------------------------------------------------------------
library(Spectra)

#' Define the file names from which to import the data
fls <- c(
    system.file("TripleTOF-SWATH", "PestMix1_DDA.mzML", package = "msdata"),
    system.file("TripleTOF-SWATH", "PestMix1_SWATH.mzML", package = "msdata"),
    system.file("sciex", "20171016_POOL_POS_1_105-134.mzML",
                package = "msdata"),
    system.file("sciex", "20171016_POOL_POS_3_105-134.mzML",
                package = "msdata"))

#' Creating a Spectra object representing the MS data
sps_mzr <- Spectra(fls, source = MsBackendMzR())
sps_mzr

## -----------------------------------------------------------------------------
sps_mem <- setBackend(sps_mzr, MsBackendMemory())

print(object.size(sps_mzr), units = "MB")
print(object.size(sps_mem), units = "MB")

## -----------------------------------------------------------------------------
#' Disable parallel processing globally
register(SerialParam())

## -----------------------------------------------------------------------------
processingChunkFactor(sps_mem)

## -----------------------------------------------------------------------------
processingChunkFactor(sps_mzr) |> table()

## -----------------------------------------------------------------------------
processingChunkSize(sps_mem) <- 3000
processingChunkFactor(sps_mem) |> table()

## -----------------------------------------------------------------------------
processingChunkSize(sps_mzr) <- 3000
processingChunkFactor(sps_mzr) |> table()

## -----------------------------------------------------------------------------
tic <- ionCount(sps_mem)

## ----si-----------------------------------------------------------------------
sessionInfo()

