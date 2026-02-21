# Code example from 'MsBackendMassbank' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(Spectra)
knitr::opts_chunk$set(echo = TRUE, message = FALSE)
library(BiocStyle)

## ----load-libs----------------------------------------------------------------
library(Spectra)
library(MsBackendMassbank)
fls <- dir(system.file("extdata", package = "MsBackendMassbank"),
           full.names = TRUE, pattern = "txt$")
fls

## ----import, warning = FALSE--------------------------------------------------
sps <- Spectra(fls,
               source = MsBackendMassbank(),
               backend = MsBackendDataFrame(),
               nonStop = TRUE)

## ----spectravars--------------------------------------------------------------
spectraVariables(sps)

## -----------------------------------------------------------------------------
sps$name

## ----metadata-----------------------------------------------------------------
#' define the metadata blocks to import
mdb <- metaDataBlocks(ac = TRUE, ms = TRUE)

#' import the data
sps <- Spectra(fls,
               source = MsBackendMassbank(),
               metaBlock = mdb)

## -----------------------------------------------------------------------------
spectraVariables(sps)

## -----------------------------------------------------------------------------
sps <- dropNaSpectraVariables(sps)
spectraVariables(sps)

## ----mysql, eval = FALSE------------------------------------------------------
# library(RMariaDB)
# con <- dbConnect(MariaDB(), host = "localhost", user = "massbank",
#                  dbname = "MassBank")

## ----sqlite-------------------------------------------------------------------
library(RSQLite)
con <- dbConnect(SQLite(), system.file("sql", "minimassbank.sqlite",
                                       package = "MsBackendMassbank"))

## -----------------------------------------------------------------------------
mb <- Spectra(con, source = MsBackendMassbankSql())
mb

## -----------------------------------------------------------------------------
spectraVariables(mb)

## -----------------------------------------------------------------------------
head(msLevel(mb))

## -----------------------------------------------------------------------------
head(mb$msLevel)

## -----------------------------------------------------------------------------
mz(mb)

## -----------------------------------------------------------------------------
table(mb$instrument_type)

## -----------------------------------------------------------------------------
mb <- mb[mb$ionization == "ESI"]
length(mb)

## -----------------------------------------------------------------------------
library(MsCoreUtils)
sims <- compareSpectra(mb[11], mb[-11], FUN = ndotproduct, ppm = 40)
max(sims)

## -----------------------------------------------------------------------------
plotSpectraMirror(mb[11], mb[(which.max(sims) + 1)], ppm = 40)

## -----------------------------------------------------------------------------
mb_match <- mb[c(11, which.max(sims) + 1)]
compounds(mb_match)

## -----------------------------------------------------------------------------
sessionInfo()

