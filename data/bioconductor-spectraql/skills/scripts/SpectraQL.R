# Code example from 'SpectraQL' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
library(BiocStyle)
BiocStyle::markdown()

## ----eval = FALSE-------------------------------------------------------------
# ## Install BiocManager, if not already installed
# install.packages("BiocManager")
# ## Install the package
# BiocManager::install("SpectraQL")

## ----message = FALSE----------------------------------------------------------
library(Spectra)
library(SpectraQL)
library(msdata)

fl <- system.file("TripleTOF-SWATH", "PestMix1_DDA.mzML", package = "msdata")
dda <- Spectra(fl)

## -----------------------------------------------------------------------------
#' Number of MS1 and MS2 spectra
table(msLevel(dda))

#' retention time range
range(rtime(dda))

## -----------------------------------------------------------------------------
dda_rt <- query(dda, "QUERY * WHERE RTMIN = 200 AND RTMAX = 300")
dda_rt

## -----------------------------------------------------------------------------
range(rtime(dda_rt))

## -----------------------------------------------------------------------------
dda_pmz <- query(
    dda,
    "query * where ms2prec = 278.093:toleancemz=0:toleranceppm=30")
length(dda_pmz)
dda_pmz

## -----------------------------------------------------------------------------
precursorMz(dda_pmz)

## -----------------------------------------------------------------------------
dda_rt <- query(dda,
                paste0("query * where rtmin = 200 and rtmax = 300 and ",
                       "ms2prec = 278.093:toleranceppm = 30"))
dda_rt

## -----------------------------------------------------------------------------
query(dda, "QUERY * WHERE MS1MZ = (123 OR 234.1 OR 300):TOLERANCEMZ=0.05")

## -----------------------------------------------------------------------------
pks <- query(dda, "query ms2data where rtmin = 200 and rtmax = 300")
length(pks)
head(pks[[1L]])

## -----------------------------------------------------------------------------
tic <- query(dda, "query scansum(ms1data)")

## -----------------------------------------------------------------------------
plot(tic, type = "l", xlab = "scan index")

## -----------------------------------------------------------------------------
si <- query(dda, "query scaninfo(*) where rtmin = 300 and rtmax = 500")
si

## -----------------------------------------------------------------------------
ic <- query(
    dda, "query scansum(ms1data) filter ms1mz = 219.095:tolerancemz=0.1")
plot(ic, type = "l", xlab = "scan index")

## -----------------------------------------------------------------------------
ic <- query(
    dda,
    paste0("query scansum(ms1data) where rtmin = 235 and rtmax = 250",
           " filter ms1mz = 219.095:tolerancemz=0.1"))
plot(ic, type = "l", xlab = "scan index")

## -----------------------------------------------------------------------------
res <- dda |>
    filterMsLevel(1L) |>
    filterRt(c(235, 250)) |>
    filterMzValues(219.095, tolerance = 0.1) |>
    ionCount()

plot(res, type = "l", xlab = "scan index")

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

