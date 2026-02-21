# Code example from 'EpiTxDb-creation' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo = FALSE-------------------------------------------------------------
suppressPackageStartupMessages({
    library(GenomicRanges)
    library(EpiTxDb)
})

## ----eval = FALSE-------------------------------------------------------------
# library(GenomicRanges)
# library(EpiTxDb)

## -----------------------------------------------------------------------------
gr <- GRanges(seqnames = "test",
              ranges = IRanges::IRanges(1,1),
              strand = "+",
              DataFrame(mod_id = 1L,
                        mod_type = "Am",
                        mod_name = "Am_1"))
etdb <- makeEpiTxDbFromGRanges(gr, metadata = data.frame(name = "test",
                                                         value = "Yes"))
etdb
metadata(etdb)

## ----eval=FALSE---------------------------------------------------------------
# # Currently not run since the server is not available
# etdb <- makeEpiTxDbFromtRNAdb("Saccharomyces cerevisiae")
# etdb

## ----eval=FALSE---------------------------------------------------------------
# etdb <- makeEpiTxDbFromRMBase(organism = "yeast",
#                               genome = "sacCer3",
#                               modtype = "m1A")

## -----------------------------------------------------------------------------
sessionInfo()

