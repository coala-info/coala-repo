# Code example from 'MsBackendMetaboLights' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(Spectra)
library(BiocStyle)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("RforMassSpectrometry/MsBackendMetaboLights")

## -----------------------------------------------------------------------------
library(MsBackendMetaboLights)

#' List files of a MetaboLights data set
all_files <- mtbls_list_files("MTBLS39")

## -----------------------------------------------------------------------------
mtbls_ftp_path("MTBLS39")

## ----echo = FALSE-------------------------------------------------------------
Sys.sleep(4)

## -----------------------------------------------------------------------------
#' Get the assay files of the data set
grep("^a_", all_files, value = TRUE)

#' Read the assay file
a <- retry(read.table(paste0(mtbls_ftp_path("MTBLS39"),
                             grep("^a_", all_files, value = TRUE)),
                      sep = "\t", header = TRUE, check.names = FALSE),
           ntimes = 5, sleep_mult = 7)

## -----------------------------------------------------------------------------
colnames(a)

## -----------------------------------------------------------------------------
a[, c("Raw Spectral Data File", "Derived Spectral Data File")]

## -----------------------------------------------------------------------------
library(Spectra)

#' Load MS data files of one data set
s <- Spectra("MTBLS39", filePattern = "63A.cdf",
             source = MsBackendMetaboLights())
s

## -----------------------------------------------------------------------------
spectraVariables(s)

## -----------------------------------------------------------------------------
spectraData(s, c("mtbls_id", "mtbls_assay_name",
                 "derived_spectral_data_file"))

## ----echo = FALSE-------------------------------------------------------------
Sys.sleep(4)

## -----------------------------------------------------------------------------
mtbls_sync(s@backend)

## -----------------------------------------------------------------------------
res <- mtbls_sync_data_files("MTBLS39", fileName = "AM063A.cdf")
res

## -----------------------------------------------------------------------------
mtbls_cached_data_files()

## -----------------------------------------------------------------------------
sessionInfo()

