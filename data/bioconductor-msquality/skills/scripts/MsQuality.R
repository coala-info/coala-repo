# Code example from 'MsQuality' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----env, include=FALSE, echo=FALSE, cache=FALSE------------------------------
library("knitr")
opts_chunk$set(stop_on_error = 1L)
suppressPackageStartupMessages(library("MsQuality"))
suppressPackageStartupMessages(library("Spectra"))

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# if (!requireNamespace("remotes", quietly = TRUE))
#     install.packages("remotes")
# 
# ## to install from Bioconductor
# BiocManager::install("MsQuality")
# 
# ## to install from GitHub
# BiocManager::install("tnaake/MsQuality")

## ----load_Spectra-------------------------------------------------------------
library("Spectra")
library("MsExperiment")
library("MsQuality")

## ----spectra_sciex, eval = FALSE, echo = TRUE---------------------------------
# ## this example is taken from the Spectra vignette
# fls <- dir(system.file("sciex", package = "msdata"), full.names = TRUE)
# sps_sciex <- Spectra(fls, backend = MsBackendMzR())

## ----msexp_sciex, eval = FALSE, echo = TRUE-----------------------------------
# ## this example is taken from the Spectra vignette
# lmse <- MsExperiment()
# sd <- DataFrame(sample_id = c("QC1", "QC2"),
#     sample_name = c("QC Pool", "QC Pool"),
#     injection_idx = c(1, 3))
# sampleData(lmse) <- sd
# ## add mzML files to the experiment
# experimentFiles(lmse) <- MsExperimentFiles(mzML_files = fls)
# ## add the Spectra object to the experiment
# spectra(lmse) <- sps_sciex
# ## use linkSampleData to establish and define relationships between sample
# ## annotations and MS data
# lmse <- linkSampleData(lmse, with = "experimentFiles.mzML_file",
#     sampleIndex = c(1, 2), withIndex = c(1, 2))

## ----load_Lee2019, eval = TRUE, echo = TRUE-----------------------------------
data("Lee2019", package = "MsQuality")

## ----combine_sps_rplc_sps_hilic, eval = TRUE, echo = TRUE---------------------
sps_comb <- c(sps_rplc, sps_hilic)

## -----------------------------------------------------------------------------
qualityMetrics(sps_comb)

## ----calculateMetrics---------------------------------------------------------
## subset the Spectra objects
sps_comb_subset <- sps_comb[grep("Sample.1_", sps_comb$dataOrigin), ]

## for RPLC and HILIC
metrics_sps_Q1 <- calculateMetrics(object = sps_comb_subset,
    metrics = qualityMetrics(sps_comb_subset), filterEmptySpectra = FALSE,
    relativeTo = "Q1", msLevel = 1L)
metrics_sps_Q1
metrics_sps_previous <- calculateMetrics(object = sps_comb_subset,
    metrics = qualityMetrics(sps_comb_subset), filterEmptySpectra = FALSE,
    relativeTo = "previous", msLevel = 1L)
metrics_sps_previous

## ----metrics_rplc_hilic_lee2019-----------------------------------------------
## subset the MsExperiment objects
msexp_rplc_subset <- msexp_rplc[1:20]
msexp_hilic_subset <- msexp_hilic[1:20]

## define metrics
metrics_sps <- c("chromatographyDuration", "ticQuantileRtFraction", "rtOverMsQuarters",
    "ticQuartileToQuartileLogRatio", "numberSpectra", "medianPrecursorMz",
    "rtIqr", "rtIqrRate", "areaUnderTic")

## for RPLC-derived MsExperiment
metrics_rplc_msexp <- calculateMetrics(object = msexp_rplc_subset,
    metrics = qualityMetrics(msexp_rplc_subset), filterEmptySpectra = TRUE,
    relativeTo = "Q1", msLevel = 1L)

## for HILIC-derived MsExperiment
metrics_hilic_msexp <- calculateMetrics(object = msexp_hilic_subset,
    metrics = qualityMetrics(msexp_hilic_subset), filterEmptySpectra = TRUE,
    relativeTo = "Q1", msLevel = 1L)

## ----paged_table_metrics, eval = TRUE, echo = FALSE---------------------------
print("metrics_rplc_msexp")
rmarkdown::paged_table(as.data.frame(metrics_rplc_msexp))
print("metrics_hilic_msexp")
rmarkdown::paged_table(as.data.frame(metrics_hilic_msexp))

## -----------------------------------------------------------------------------
metrics_msexp <- rbind(metrics_rplc_msexp, metrics_hilic_msexp)
plotMetric(qc = metrics_msexp, metric = "numberSpectra")

## -----------------------------------------------------------------------------
plotMetric(qc = metrics_msexp, metric = "ticQuartileToQuartileLogRatio")

## ----eval = FALSE-------------------------------------------------------------
# shinyMsQuality(qc = metrics_msexp)

## ----session,eval=TRUE, echo=FALSE--------------------------------------------
sessionInfo()

