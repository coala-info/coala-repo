# Code example from 'easylift' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
  BiocStyle::markdown()

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("easylift")

## ----doc, eval = FALSE--------------------------------------------------------
# browseVignettes("easylift")

## ----setup--------------------------------------------------------------------
library("easylift")

## ----example------------------------------------------------------------------
gr <- GRanges(
  seqname = Rle(
    c("chr1", "chr2"), 
    c(100000, 100000)
  ),
  ranges = IRanges(
    start = 1, end = 200000
  )
)
# Here, "hg19" is the source genome
genome(gr) <- "hg19"

# Here, we use the `system.file()` function because the chain file is in the
# package (however if you need to point to any other file on your machine,
# just do 'chain <- "path/to/your/hg19ToHg38.over.chain.gz"'):
chain <- system.file("extdata", "hg19ToHg38.over.chain.gz", package = "easylift")

gr

## ----run----------------------------------------------------------------------
# Here, "hg38" is the target genome
easylift(gr, "hg38", chain)

## ----bioCache, eval=FALSE-----------------------------------------------------
# chain_file <- "/path/to/your/hg19ToHg38.over.chain.gz"
# bfc <- BiocFileCache()
# 
# # Add chain file to cache if already not available
# if (nrow(bfcquery(bfc, basename(chain_file))) == 0)
#     bfcadd(bfc, chain_file)

## ----bioCache2, eval=FALSE----------------------------------------------------
# easylift(gr, "hg38")
# # or
# gr |> easylift("hg38")

## -----------------------------------------------------------------------------
sessionInfo()

