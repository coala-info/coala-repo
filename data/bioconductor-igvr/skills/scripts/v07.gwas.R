# Code example from 'v07.gwas' vignette. See references/ for full tutorial.

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
# setBrowserWindowTitle(igv, "AD GWAS")
# setGenome(igv, "hg38")
# tbl.gwas <- read.table(system.file(package="igvR", "extdata", "gwas", "bellenguez.bed"),
#                        sep="\t", as.is=TRUE, header=TRUE, nrow=-1)
# track <- GWASTrack("bellenguuez", tbl.gwas, chrom.col=1, pos.col=2, pval.col=5, trackHeight=80)
# displayTrack(igv, track)

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/gwas-01.png")

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/gwas-02.png")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------
# url <- "https://s3.amazonaws.com/igv.org.demo/gwas_sample.tsv.gz"
# track <- GWASUrlTrack("igv sample", url,chrom.col=12, pos.col=13, pval.col=28)
# displayTrack(igv, track)

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/gwas-03.png")

## ----eval=TRUE, echo=FALSE, out.width="95%"---------------------------------------------------------------------------
knitr::include_graphics("images/gwas-04.png")

## ----eval=TRUE--------------------------------------------------------------------------------------------------------
sessionInfo()

