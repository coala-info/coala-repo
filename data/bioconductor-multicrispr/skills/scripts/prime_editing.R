# Code example from 'prime_editing' vignette. See references/ for full tutorial.

## ----include=TRUE, echo=FALSE, message=FALSE----------------------------------
knitr::opts_chunk$set(echo = TRUE, collapse = TRUE, cache = FALSE)
#str(knitr::opts_chunk$get())

## ----fig.small = TRUE, echo = FALSE, fig.cap = 'gRNAs for Crispr/Cas9 (A) and Prime Editing'----
knitr::include_graphics("../inst/extdata/pe.png")

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

## ----fig.width=3.5, fig.height=1.5--------------------------------------------
# char_to_granges: Anzalone et al. (2019) prime editing targets
require(multicrispr)
bsgenome <- BSgenome.Hsapiens.UCSC.hg38::BSgenome.Hsapiens.UCSC.hg38  
targets <- char_to_granges(c(PRNP = 'chr20:4699600:+'), bsgenome)
plot_intervals(targets)

## ----fig.width=3.3, fig.height=1.7, message = FALSE, warning = FALSE----------
spacers <- find_primespacers(targets, bsgenome=bsgenome, edits = "T") 

## -----------------------------------------------------------------------------
  str(gr2dt(spacers), vec.len=2)

