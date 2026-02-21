# Code example from 'crispr_grna_design' vignette. See references/ for full tutorial.

## ----include=TRUE, echo=FALSE, message=FALSE----------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, cache = FALSE)
#str(knitr::opts_chunk$get())

## ----fig.normal = TRUE, echo = FALSE------------------------------------------
knitr::include_graphics("../inst/extdata/crispr.png")

## ----overview, fig.wide = TRUE, out.width = "100%", echo = FALSE--------------
knitr::include_graphics("../inst/extdata/overview.png")

## ----eval = FALSE-------------------------------------------------------------
# # From BioC
# install.packages("BiocManager")
# BiocManager::install(version='devel')
# BiocManager::install("multicrispr")
# 
# # From gitlab:
# #url <- 'https://gitlab.gwdg.de/loosolab/software/multicrispr.git'
# #remotes::install_git(url, repos = BiocManager::repositories())

## ----eval = FALSE-------------------------------------------------------------
# # Install once
#   # reticulate::conda_create('azienv', 'python=2.7')
#   # reticulate::conda_install('azienv', 'azimuth', pip = TRUE)
#   # reticulate::conda_install('azienv', 'scikit-learn==0.17.1', pip = TRUE)
# # Then activate
#   reticulate::use_condaenv('azienv')

## ----eval = FALSE-------------------------------------------------------------
# index_genome(BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10)
# index_genome(BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38  )

## ----echo = FALSE, results = FALSE, message=FALSE-----------------------------
  # Not required
  # Done to load dependencies silently - keeping focus
  #require(GenomicRanges)
  #require(Biostrings)
  #require(dplyr)
  #require(dbplyr)
  #require(htmltools)
  #require(htmlwidgets)

## ----message=FALSE, out.width="60%"-------------------------------------------
require(magrittr)
require(multicrispr)
bedfile <- system.file('extdata/SRF.bed', package = 'multicrispr')
targets0 <- bed_to_granges(bedfile, genome = 'mm10')

## ----message=FALSE, out.width="60%"-------------------------------------------
entrezfile <- system.file('extdata/SRF.entrez', package = 'multicrispr')
txdb <- TxDb.Mmusculus.UCSC.mm10.knownGene::TxDb.Mmusculus.UCSC.mm10.knownGene
invisible(genefile_to_granges(entrezfile, txdb, complement = TRUE))

## ----fig.width=3.5, fig.height=1.5, out.width="50%"---------------------------
bsgenome <- BSgenome.Mmusculus.UCSC.mm10::BSgenome.Mmusculus.UCSC.mm10
plot_intervals(char_to_granges(c(srf1 = 'chr13:119991554-119991569:+'), bsgenome))

## ----fig.wide = TRUE, fig.show = 'hold', message = FALSE, out.width="60%", fig.width=7, fig.height=3----
# Up flank
    invisible(up_flank(  targets0, -200, -1))
# Down flank
    invisible(down_flank( targets0, 1, 200))
# Double flank
    invisible(double_flank(targets0, -200, -1, +1, +200))
# Extend
    targets <- extend(targets0, -22, 22, plot = TRUE)

## ----message=FALSE------------------------------------------------------------
spacers <- find_spacers(
    targets, bsgenome, complement=FALSE, mismatches=0, subtract_targets = TRUE)

## -----------------------------------------------------------------------------
  str(gr2dt(spacers), vec.len=2)

