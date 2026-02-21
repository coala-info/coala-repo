# Code example from 'v05.ucscTableBrowser' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
options(width=120)
knitr::opts_chunk$set(
   collapse = TRUE,
   eval=interactive(),
   echo=TRUE,
   comment = "#>"
)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# library(igvR)
# igv <- igvR()
# setBrowserWindowTitle(igv, "H3K4Me3 GATA2")
# setGenome(igv, "hg38")
# showGenomicRegion(igv, "GATA2")
# zoomOut(igv)
# zoomOut(igv)

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/gata2-63kb.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# getGenomicRegion(igv)

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/ucscTableBrowser.png")

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/ucscTableBrowserOutput.png")

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/ucscTableBrowser-getOutput.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# tbl <- read.table("~/drop/k562-h3k4me3-gata2.tsv", sep="\t", skip=1, as.is=TRUE, fill=TRUE)
# colnames(tbl) <- c("chrom", "start", "end", "score")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# lapply(tbl, class)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# track <- DataFrameQuantitativeTrack("H3K4Me3 K562", tbl, autoscale=TRUE, color="darkGreen")
# displayTrack(igv, track)

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/gata2-63kb-h3k4me3.png")

## ----eval=TRUE--------------------------------------------------------------------------------------------------------
sessionInfo()

