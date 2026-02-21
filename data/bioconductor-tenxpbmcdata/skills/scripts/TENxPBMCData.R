# Code example from 'TENxPBMCData' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## -----------------------------------------------------------------------------
library(TENxPBMCData)
tenx_pbmc4k <- TENxPBMCData(dataset = "pbmc4k")
tenx_pbmc4k

## -----------------------------------------------------------------------------
args(TENxPBMCData)

## -----------------------------------------------------------------------------
counts(tenx_pbmc4k)

## -----------------------------------------------------------------------------
options(DelayedArray.block.size=1e9)

## ----eval = FALSE-------------------------------------------------------------
# lib.sizes <- colSums(counts(tenx_pbmc4k))
# n.exprs <- colSums(counts(tenx_pbmc4k) != 0L)
# ave.exprs <- rowMeans(counts(tenx_pbmc4k))

## ----eval=FALSE---------------------------------------------------------------
# destination <- tempfile()
# saveRDS(tenx_pbmc4k, file = destination)

## -----------------------------------------------------------------------------
tenx_pbmc5k_CITEseq <- TENxPBMCData(dataset = "pbmc5k-CITEseq")

counts(altExp(tenx_pbmc5k_CITEseq))

## -----------------------------------------------------------------------------
sessionInfo()

