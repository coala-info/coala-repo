# Code example from 'MsBackendMsp' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(Spectra)
library(BiocStyle)
library(BiocParallel)
register(SerialParam())

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MsBackendMsp")

## ----message = FALSE----------------------------------------------------------
library(MsBackendMsp)

nist <- system.file("extdata", "spectrum2.msp", package = "MsBackendMsp")

## -----------------------------------------------------------------------------
sp <- Spectra(nist, source = MsBackendMsp())

## ----spectravars--------------------------------------------------------------
spectraVariables(sp)

## -----------------------------------------------------------------------------
sp$msLevel
sp$name
sp$adduct

## -----------------------------------------------------------------------------
spectraVariableMapping(MsBackendMsp())

## -----------------------------------------------------------------------------
mona <- system.file("extdata", "minimona.msp", package = "MsBackendMsp")
head(readLines(mona))

## -----------------------------------------------------------------------------
head(readLines(nist))

## -----------------------------------------------------------------------------
spectraVariableMapping(MsBackendMsp(), "mona")

## -----------------------------------------------------------------------------
sp_mona <- Spectra(mona, source = MsBackendMsp(),
                   mapping = spectraVariableMapping(MsBackendMsp(), "mona"))
sp_mona$precursorMz

## -----------------------------------------------------------------------------
sp_mona[29:30]$synonym

## -----------------------------------------------------------------------------
tmpf <- tempfile()

export(sp_mona, backend = MsBackendMsp(), file = tmpf,
       mapping = spectraVariableMapping(MsBackendMsp()))
head(readLines(tmpf))

## -----------------------------------------------------------------------------
tmpf <- tempfile()

export(sp, backend = MsBackendMsp(), file = tmpf,
       mapping = spectraVariableMapping(MsBackendMsp(), "mona"))
head(readLines(tmpf))

## -----------------------------------------------------------------------------
sessionInfo()

