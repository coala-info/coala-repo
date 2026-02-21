# Code example from 'derfinderPlot' vignette. See references/ for full tutorial.

## ----'installDer', eval = FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("derfinderPlot")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'citation'---------------------------------------------------------------
## Citation info
citation("derfinderPlot")

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    derfinderPlot = citation("derfinderPlot")[1],
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[3],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    derfinder = citation("derfinder")[1],
    ggbio = citation("ggbio")[1],
    brainspan = RefManageR::BibEntry(
        bibtype = "Unpublished",
        key = "brainspan",
        title = "Atlas of the Developing Human Brain [Internet]. Funded by ARRA Awards 1RC2MH089921-01, 1RC2MH090047-01, and 1RC2MH089929-01.",
        author = "BrainSpan", year = 2011, url = "http://www.brainspan.org/"
    ),
    R = citation(),
    IRanges = citation("IRanges")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    GenomeInfoDb = RefManageR::BibEntry(
        bibtype = "manual",
        key = "GenomeInfoDb",
        author = "Sonali Arora and Martin Morgan and Marc Carlson and H. Pagès",
        title = "GenomeInfoDb: Utilities for manipulating chromosome and other 'seqname' identifiers",
        year = 2017, doi = "10.18129/B9.bioc.GenomeInfoDb"
    ),
    GenomicRanges = citation("GenomicRanges")[1],
    ggplot2 = citation("ggplot2")[1],
    plyr = citation("plyr")[1],
    RColorBrewer = citation("RColorBrewer")[1],
    reshape2 = citation("reshape2")[1],
    scales = citation("scales")[1],
    biovizBase = citation("biovizBase")[1],
    bumphunter = citation("bumphunter")[1],
    TxDb.Hsapiens.UCSC.hg19.knownGene = citation("TxDb.Hsapiens.UCSC.hg19.knownGene")[1],
    bumphunterPaper = RefManageR::BibEntry(
        bibtype = "article",
        key = "bumphunterPaper",
        title = "Bump hunting to identify differentially methylated regions in epigenetic epidemiology studies",
        author = "Jaffe, Andrew E and Murakami, Peter and Lee, Hwajin and Leek, Jeffrey T and Fallin, M Daniele and Feinberg, Andrew P and Irizarry, Rafael A",
        year = 2012, journal = "International Journal of Epidemiology"
    ),
    derfinderData = citation("derfinderData")[1]
)

## ----'start'------------------------------------------------------------------
## Load libraries
suppressPackageStartupMessages(library("derfinder"))
library("derfinderData")
library("derfinderPlot")

## ----'phenoData', results = 'asis'--------------------------------------------
library("knitr")
## Get pheno table
pheno <- subset(brainspanPheno, structure_acronym == "A1C")

## Display the main information
p <- pheno[, -which(colnames(pheno) %in% c(
    "structure_acronym",
    "structure_name", "file"
))]
rownames(p) <- NULL
kable(p, format = "html", row.names = TRUE)

## ----'getData', eval = .Platform$OS.type != 'windows'-------------------------
## Determine the files to use and fix the names
files <- rawFiles(system.file("extdata", "A1C", package = "derfinderData"),
    samplepatt = "bw", fileterm = NULL
)
names(files) <- gsub(".bw", "", names(files))

## Load the data from disk
system.time(fullCov <- fullCoverage(files = files, chrs = "chr21"))

## ----'getDataWindows', eval = .Platform$OS.type == 'windows', echo = FALSE----
# ## Load data in Windows case
# foo <- function() {
#     load(system.file("extdata", "fullCov", "fullCovA1C.RData",
#         package = "derfinderData"
#     ))
#     return(fullCovA1C)
# }
# fullCov <- foo()

## ----'webData', eval = FALSE--------------------------------------------------
# ## Determine the files to use and fix the names
# files <- pheno$file
# names(files) <- gsub(".A1C", "", pheno$lab)
# 
# ## Load the data from the web
# system.time(fullCov <- fullCoverage(files = files, chrs = "chr21"))

## ----'models'-----------------------------------------------------------------
## Get some idea of the library sizes
sampleDepths <- sampleDepth(collapseFullCoverage(fullCov), 1)

## Define models
models <- makeModels(sampleDepths,
    testvars = pheno$group,
    adjustvars = pheno[, c("gender")]
)

## ----'analyze'----------------------------------------------------------------
## Filter coverage
filteredCov <- lapply(fullCov, filterData, cutoff = 3)

## Perform differential expression analysis
suppressPackageStartupMessages(library("bumphunter"))
system.time(results <- analyzeChr(
    chr = "chr21", filteredCov$chr21,
    models, groupInfo = pheno$group, writeOutput = FALSE,
    cutoffFstat = 5e-02, nPermute = 20, seeds = 20140923 + seq_len(20)
))

## Quick access to the results
regions <- results$regions$regions

## Annotation database to use
suppressPackageStartupMessages(library("TxDb.Hsapiens.UCSC.hg19.knownGene"))
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

## ----'plotOverview', bootstrap.show.warning=FALSE, fig.cap = "Location of the DERs in the genome. This plot is was designed for many chromosomes but only one is shown here for simplicity."----
## Q-values overview
plotOverview(regions = regions, annotation = results$annotation, type = "qval")

## ----'plotOverview2', bootstrap.show.warning=FALSE, fig.cap = "Location of the DERs in the genome and colored by annotation class. This plot is was designed for many chromosomes but only one is shown here for simplicity."----
## Annotation overview
plotOverview(
    regions = regions, annotation = results$annotation,
    type = "annotation"
)

## ----'regionData'-------------------------------------------------------------
## Get required information for the plots
annoRegs <- annotateRegions(regions, genomicState$fullGenome)
regionCov <- getRegionCoverage(fullCov, regions)

## ----'plotRegCov', fig.cap = paste0("Base-pair resolution plot of differentially expressed region ", 1:10, ".")----
## Plot top 10 regions
plotRegionCoverage(
    regions = regions, regionCoverage = regionCov,
    groupInfo = pheno$group, nearestAnnotation = results$annotation,
    annotatedRegions = annoRegs, whichRegions = 1:10, txdb = txdb, scalefac = 1,
    ask = FALSE, verbose = FALSE
)

## ----'plotCluster', warning=FALSE, fig.cap = "Cluster plot for cluster 1 using ggbio."----
## First cluster
plotCluster(
    idx = 1, regions = regions, annotation = results$annotation,
    coverageInfo = fullCov$chr21, txdb = txdb, groupInfo = pheno$group,
    titleUse = "pval"
)

## ----'plotCluster2', bootstrap.show.warning=FALSE, fig.cap = "Cluster plot for cluster 2 using ggbio."----
## Second cluster
plotCluster(
    idx = 2, regions = regions, annotation = results$annotation,
    coverageInfo = fullCov$chr21, txdb = txdb, groupInfo = pheno$group,
    titleUse = "pval"
)

## ----'vennRegions', fig.cap = "Venn diagram of regions by annotation class."----
## Make venn diagram
venn <- vennRegions(annoRegs)

## It returns the actual venn counts information
venn

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("derfinderPlot.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("derfinderPlot.Rmd", tangle = TRUE)

## ----createVignette2----------------------------------------------------------
## Clean up
unlink("chr21", recursive = TRUE)

## ----reproducibility1, echo=FALSE---------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproducibility2, echo=FALSE---------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproducibility3, echo=FALSE-------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = 'asis', echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

