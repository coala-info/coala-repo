# Code example from 'QC' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, results="hide"-----------------------------
library(sesame)
sesameDataCache()

## ----qc1, eval=FALSE----------------------------------------------------------
# ## calculate metrics on all IDATs in a specific folder
# sesameQCtoDF(openSesame(idat_dir, prep="", func=sesameQC_calcStats))
# ## or a list of prefixes, with parallel processing
# sesameQCtoDF(openSesame(sprintf("%s/%s", idat_dir, idat_prefixes), prep="",
#     func=sesameQC_calcStats, BPPARAM=BiocParallel::MulticoreParam(24)))

## ----echo=FALSE---------------------------------------------------------------
library(knitr)
kable(data.frame(
    "Short Key" = c(
        "detection",
        "numProbes",
        "intensity",
        "channel",
        "dyeBias",
        "betas"),
    "Description" = c(
        "Signal Detection",
        "Number of Probes",
        "Signal Intensity",
        "Color Channel",
        "Dye Bias",
        "Beta Value")))

## ----qc2----------------------------------------------------------------------
sdfs <- sesameDataGet("EPIC.5.SigDF.normal")[1:2] # get two examples
## only compute signal detection stats
qcs = openSesame(sdfs, prep="", func=sesameQC_calcStats, funs="detection")
qcs[[1]]

## ----qc3----------------------------------------------------------------------
sesameQC_getStats(qcs[[1]], "frac_dt")

## ----qc4----------------------------------------------------------------------
## combine a list of sesameQC into a data frame
head(do.call(rbind, lapply(qcs, as.data.frame)))

## ----qc5, message=FALSE-------------------------------------------------------
sdf <- sesameDataGet('EPIC.1.SigDF')
qc = openSesame(sdf, prep="", func=sesameQC_calcStats, funs=c("detection"))
## equivalent direct call
qc = sesameQC_calcStats(sdf, c("detection"))
qc

## ----qc6, echo=FALSE----------------------------------------------------------
options(rmarkdown.html_vignette.check_title = FALSE)

## ----qc7----------------------------------------------------------------------
sdf <- sesameDataGet('EPIC.1.SigDF')
qc <- sesameQC_calcStats(sdf, "intensity")
qc
sesameQC_rankStats(qc, platform="EPIC")

## -----------------------------------------------------------------------------
sessionInfo()

