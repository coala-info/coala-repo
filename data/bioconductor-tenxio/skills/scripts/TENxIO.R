# Code example from 'TENxIO' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("waldronlab/TENxIO")

## ----include=TRUE,results="hide",message=FALSE,warning=FALSE------------------
library(TENxIO)

## -----------------------------------------------------------------------------
showClass("TENxFile")

## -----------------------------------------------------------------------------
hub <- ExperimentHub::ExperimentHub()
hub["EH1039"]

## ----eval=FALSE---------------------------------------------------------------
# fname <- hub[["EH1039"]]
# TENxFile(fname, extension = "h5", group = "mm10", version = "2")

## -----------------------------------------------------------------------------
TENxIO:::h5.version.map

## -----------------------------------------------------------------------------
h5f <- system.file(
    "extdata", "pbmc_granulocyte_ff_bc_ex.h5",
    package = "TENxIO", mustWork = TRUE
)
library(rhdf5)
h5ls(h5f)

## -----------------------------------------------------------------------------
con <- TENxH5(h5f)
con

## -----------------------------------------------------------------------------
import(con)

## -----------------------------------------------------------------------------
mtxf <- system.file(
    "extdata", "pbmc_3k_ff_bc_ex.mtx",
    package = "TENxIO", mustWork = TRUE
)
con <- TENxMTX(mtxf)
con

## -----------------------------------------------------------------------------
import(con)

## -----------------------------------------------------------------------------
fl <- system.file(
    "extdata", "pbmc_granulocyte_sorted_3k_ff_bc_ex_matrix.tar.gz",
    package = "TENxIO", mustWork = TRUE
)
untar(fl, list = TRUE)

## -----------------------------------------------------------------------------
con <- TENxFileList(fl)
import(con)

## -----------------------------------------------------------------------------
pfl <- system.file(
    "extdata", "pbmc_granulocyte_sorted_3k_ex_atac_peak_annotation.tsv",
    package = "TENxIO", mustWork = TRUE
)
tenxp <- TENxPeaks(pfl)
peak_anno <- import(tenxp)
peak_anno

## -----------------------------------------------------------------------------
fr <- system.file(
    "extdata", "pbmc_3k_atac_ex_fragments.tsv.gz",
    package = "TENxIO", mustWork = TRUE
)

## -----------------------------------------------------------------------------
tfr <- TENxFragments(fr)
tfr

## -----------------------------------------------------------------------------
fra <- import(tfr)
fra

## -----------------------------------------------------------------------------
rowRanges(fra)

## ----session-info, echo=FALSE, results='asis'---------------------------------
html_output <- paste0(
    "<details><summary>",
    "Click to expand <code>sessionInfo()</code>",
    "</summary>\n\n",
    "<pre><code>",
    paste(capture.output(sessionInfo()), collapse = "\n"),
    "</code></pre>\n</details>"
)
cat(html_output)

