# Code example from 'brainflowprobes-vignette' vignette. See references/ for full tutorial.

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("knitcitations")

## Load knitcitations with a clean bibliography
cleanbib()
cite_options(hyperlink = "to.doc", citation_format = "text", style = "html")
# Note links won't show for now due to the following issue
# https://github.com/cboettig/knitcitations/issues/63

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle"),
    derfinder = citation("derfinder")[1],
    derfinderPlot = citation("derfinderPlot")[1],
    sessioninfo = citation("sessioninfo"),
    GenomicRanges = citation("GenomicRanges"),
    knitcitations = citation("knitcitations"),
    knitr = citation("knitr")[3],
    rmarkdown = citation("rmarkdown")[1],
    rtracklayer = citation("rtracklayer"),
    testthat = citation("testthat"),
    ggplot2 = citation("ggplot2"),
    cowplot = citation("cowplot"),
    BSgenome.Hsapiens.UCSC.hg19 = citation("BSgenome.Hsapiens.UCSC.hg19"),
    Biostrings = citation("Biostrings"),
    RColorBrewer = citation("RColorBrewer"),
    bumphunter = citation("bumphunter")[1],
    GenomicState = citation("GenomicState")
)

write.bibtex(bib, file = "brainflowprobes_ref.bib")

## ----'install', eval = FALSE--------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE)) {
#        install.packages("BiocManager")
#    }
#  
#  BiocManager::install("brainflowprobes")
#  
#  ## Check that you have a valid Bioconductor installation
#  BiocManager::valid()
#  
#  ## If you want to force the installation of the development version, you can
#  ## do so by running. However, we suggest that you wait for Bioconductor to
#  ## run checks and build the latest release.
#  BiocManager::install("LieberInstitute/brainflowprobes")

## ----'citation'---------------------------------------------------------------
## Citation info
citation("brainflowprobes")

## ----'start', message=FALSE---------------------------------------------------
## Load brainflowprobes R package
library("brainflowprobes")

## ----'annotate'---------------------------------------------------------------
region_info("chr2:162279880-162282378:+", CSV = FALSE, SEQ = TRUE, OUTDIR = ".")

## ----'visualize coverage', eval = FALSE---------------------------------------
#  plot_coverage("chr2:162279880-162282378:+",
#      PDF = "regionCoverage_fractionedData.pdf",
#      OUTDIR = ".",
#      COVERAGE = NULL, VERBOSE = FALSE
#  )

## ---- include=TRUE, fig.align="center", echo=FALSE, out.height = 850----------
knitr::include_graphics("regionCoverage_fractionedData.pdf")

## ----'visualize shorter region coverage', eval = FALSE------------------------
#  plot_coverage("chr2:162280900-162282378:+",
#      PDF = "regionCoverage_fractionedData_shorter.pdf",
#      OUTDIR = ".",
#      COVERAGE = NULL, VERBOSE = FALSE
#  )

## ---- include=TRUE, fig.align="center", echo=FALSE, out.height = 850----------
knitr::include_graphics("regionCoverage_fractionedData_shorter.pdf")

## ----'precalculate coverage', eval = FALSE------------------------------------
#  tbr1.cov <- brainflowprobes_cov("chr2:162280900-162282378:+", VERBOSE = FALSE)

## ----'plot four panels', eval = FALSE-----------------------------------------
#  four_panels("chr2:162280900-162282378:+",
#      PDF = "four_panels.pdf",
#      OUTDIR = ".",
#      JUNCTIONS = FALSE,
#      COVERAGE = tbr1.cov, VERBOSE = FALSE
#  )

## ---- include=TRUE, fig.align="center", echo=FALSE, out.height = 1000---------
knitr::include_graphics("four_panels.pdf")

## ----'annotate multiple'------------------------------------------------------
candidates <- c(
    "chr2:162279880-162282378:+",
    "chr11:31806351-31811553",
    "chr7:103112236-103113354"
)

region_info(candidates, CSV = FALSE, SEQ = FALSE)

## ----'plot multiple', eval=FALSE----------------------------------------------
#  plot_coverage(candidates,
#      PDF = "regionCoverage_fractionedData_multiple.pdf", OUTDIR = "."
#  )
#  
#  four_panels(candidates, PDF = "four_panels_multiple.pdf", OUTDIR = ".")

## ----'PENK', eval=FALSE-------------------------------------------------------
#  PENK_exons <- c(
#      "chr8:57353587-57354496:-",
#      "chr8:57358375-57358515:-",
#      "chr8:57358985-57359040:-",
#      "chr8:57359128-57359292:-"
#  )
#  
#  four_panels(PENK_exons, JUNCTIONS = TRUE, PDF = "PENK_panels.pdf")

## ----createVignette, eval=FALSE-----------------------------------------------
#  ## Create the vignette
#  library("rmarkdown")
#  system.time(render("brainflowprobes-vignette.Rmd", "BiocStyle::html_document"))
#  
#  ## Extract the R code
#  library("knitr")
#  knit("brainflowprobes-vignette.Rmd", tangle = TRUE)

## ----createVignette2----------------------------------------------------------
## Clean up
file.remove("brainflowprobes_ref.bib")

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
bibliography()

