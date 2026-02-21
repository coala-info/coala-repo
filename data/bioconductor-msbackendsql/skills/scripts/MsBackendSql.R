# Code example from 'MsBackendSql' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(MsBackendSql)
knitr::opts_chunk$set(echo = TRUE, message = FALSE)
library(BiocStyle)

## ----message = FALSE, results = "hide"----------------------------------------
library(RSQLite)

dbfile <- tempfile()
con <- dbConnect(SQLite(), dbfile)

library(Spectra)
library(MsBackendSql)
fls <- dir(system.file("sciex", package = "msdata"), full.names = TRUE)
createMsBackendSqlDatabase(con, fls)
dbDisconnect(con)

## -----------------------------------------------------------------------------
sps <- Spectra(dbname = dbfile, source = MsBackendOfflineSql(), drv = SQLite())
sps

## -----------------------------------------------------------------------------
sps_mem <- setBackend(sps, MsBackendMemory())
sps_mem

## ----warnings = FALSE---------------------------------------------------------
sps2 <- setBackend(sps_mem, MsBackendOfflineSql(), drv = SQLite(),
                   dbname = tempfile())
sps2

## ----spectraVariables---------------------------------------------------------
spectraVariables(sps)

## -----------------------------------------------------------------------------
peaksData(sps)[[5]] |>
head()

## -----------------------------------------------------------------------------
print(object.size(sps), units = "KB")

## -----------------------------------------------------------------------------
sps$rtime <- sps$rtime + 10

## -----------------------------------------------------------------------------
print(object.size(sps), units = "KB")

## -----------------------------------------------------------------------------
system.time(msLevel(sps))
sps$msLevel <- msLevel(sps)
system.time(msLevel(sps))

## -----------------------------------------------------------------------------
sps <- reset(sps)

## -----------------------------------------------------------------------------
con <- dbConnect(SQLite(), dbfile)
sps <- Spectra(con, source = MsBackendSql())
sps_mzr <- Spectra(fls, source = MsBackendMzR())
sps_im <- setBackend(sps_mzr, backend = MsBackendMemory())

## -----------------------------------------------------------------------------
print(object.size(sps), units = "KB")
print(object.size(sps_mzr), units = "KB")
print(object.size(sps_im), units = "KB")

## -----------------------------------------------------------------------------
library(microbenchmark)
microbenchmark(msLevel(sps),
               msLevel(sps_mzr),
               msLevel(sps_im))

## -----------------------------------------------------------------------------
microbenchmark(peaksData(sps, BPPARAM = SerialParam()),
               peaksData(sps_mzr, BPPARAM = SerialParam()),
               peaksData(sps_im, BPPARAM = SerialParam()),
               times = 10)

## -----------------------------------------------------------------------------
m2 <- MulticoreParam(2)
microbenchmark(peaksData(sps, BPPARAM = m2),
               peaksData(sps_mzr, BPPARAM = m2),
               peaksData(sps_im, BPPARAM = m2),
               times = 10)

## -----------------------------------------------------------------------------
microbenchmark(filterRt(sps, rt = c(50, 100)),
               filterRt(sps_mzr, rt = c(50, 100)),
               filterRt(sps_im, rt = c(50, 100)))

## -----------------------------------------------------------------------------
idx <- sample(seq_along(sps), 10)
microbenchmark(sps[idx],
               sps_mzr[idx],
               sps_im[idx])

## -----------------------------------------------------------------------------
sps_10 <- sps[idx]
sps_mzr_10 <- sps_mzr[idx]
sps_im_10 <- sps_im[idx]

microbenchmark(peaksData(sps_10),
               peaksData(sps_mzr_10),
               peaksData(sps_im_10),
               times = 10)

## -----------------------------------------------------------------------------
sessionInfo()

