# Code example from 'derfinder-quickstart' vignette. See references/ for full tutorial.

## ----'installDer', eval = FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("derfinder")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'citation'---------------------------------------------------------------
## Citation info
citation("derfinder")

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    derfinder = citation("derfinder")[1],
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[3],
    rmarkdown = citation("rmarkdown")[1],
    brainspan = RefManageR::BibEntry(
        bibtype = "Unpublished",
        key = "brainspan",
        title = "Atlas of the Developing Human Brain [Internet]. Funded by ARRA Awards 1RC2MH089921-01, 1RC2MH090047-01, and 1RC2MH089929-01.",
        author = "BrainSpan", year = 2011, url = "http://www.brainspan.org/"
    ),
    originalder = citation("derfinder")[2],
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
    bumphunter = citation("bumphunter")[1],
    TxDb.Hsapiens.UCSC.hg19.knownGene = citation("TxDb.Hsapiens.UCSC.hg19.knownGene")[1],
    AnnotationDbi = RefManageR::BibEntry(
        bibtype = "manual",
        key = "AnnotationDbi",
        author = "Hervé Pagès and Marc Carlson and Seth Falcon and Nianhua Li",
        title = "AnnotationDbi: Annotation Database Interface",
        year = 2017, doi = "10.18129/B9.bioc.AnnotationDbi"
    ),
    BiocParallel = citation("BiocParallel")[1],
    derfinderHelper = citation("derfinderHelper")[1],
    GenomicAlignments = citation("GenomicAlignments")[1],
    GenomicFeatures = citation("GenomicFeatures")[1],
    GenomicFiles = citation("GenomicFiles")[1],
    Hmisc = citation("Hmisc")[1],
    qvalue = citation("qvalue")[1],
    Rsamtools = citation("Rsamtools")[1],
    rtracklayer = citation("rtracklayer")[1],
    S4Vectors = RefManageR::BibEntry(
        bibtype = "manual", key = "S4Vectors",
        author = "Hervé Pagès and Michael Lawrence and Patrick Aboyoun",
        title = "S4Vectors: S4 implementation of vector-like and list-like objects",
        year = 2017, doi = "10.18129/B9.bioc.S4Vectors"
    ),
    bumphunterPaper = RefManageR::BibEntry(
        bibtype = "article",
        key = "bumphunterPaper",
        title = "Bump hunting to identify differentially methylated regions in epigenetic epidemiology studies",
        author = "Jaffe, Andrew E and Murakami, Peter and Lee, Hwajin and Leek, Jeffrey T and Fallin, M Daniele and Feinberg, Andrew P and Irizarry, Rafael A",
        year = 2012, journal = "International Journal of Epidemiology"
    ),
    derfinderData = citation("derfinderData")[1],
    RefManageR = citation("RefManageR")[1]
)

## ----'ultraQuick', eval = FALSE-----------------------------------------------
# ## Load libraries
# library("derfinder")
# library("derfinderData")
# library("GenomicRanges")
# 
# ## Determine the files to use and fix the names
# files <- rawFiles(system.file("extdata", "AMY", package = "derfinderData"),
#     samplepatt = "bw", fileterm = NULL
# )
# names(files) <- gsub(".bw", "", names(files))
# 
# ## Load the data from disk -- On Windows you have to load data from Bam files
# fullCov <- fullCoverage(files = files, chrs = "chr21", verbose = FALSE)
# 
# ## Get the region matrix of Expressed Regions (ERs)
# regionMat <- regionMatrix(fullCov, cutoff = 30, L = 76, verbose = FALSE)
# 
# ## Get pheno table
# pheno <- subset(brainspanPheno, structure_acronym == "AMY")
# 
# ## Identify which ERs are differentially expressed, that is, find the DERs
# library("DESeq2")
# 
# ## Round matrix
# counts <- round(regionMat$chr21$coverageMatrix)
# 
# ## Round matrix and specify design
# dse <- DESeqDataSetFromMatrix(counts, pheno, ~ group + gender)
# 
# ## Perform DE analysis
# dse <- DESeq(dse, test = "LRT", reduced = ~gender, fitType = "local")
# 
# ## Extract results
# mcols(regionMat$chr21$regions) <- c(mcols(regionMat$chr21$regions), results(dse))
# 
# ## Save info in an object with a shorter name
# ers <- regionMat$chr21$regions
# ers

## ----'start', message=FALSE---------------------------------------------------
## Load libraries
library("derfinder")
library("derfinderData")
library("GenomicRanges")

## ----'locateAMYfiles'---------------------------------------------------------
## Determine the files to use and fix the names
files <- rawFiles(system.file("extdata", "AMY", package = "derfinderData"),
    samplepatt = "bw", fileterm = NULL
)
names(files) <- gsub(".bw", "", names(files))

## ----'getData', eval = .Platform$OS.type != "windows"-------------------------
## Load the data from disk
fullCov <- fullCoverage(
    files = files, chrs = "chr21", verbose = FALSE,
    totalMapped = rep(1, length(files)), targetSize = 1
)

## ----'getDataWindows', eval = .Platform$OS.type == "windows", echo = FALSE----
# ## Load data in Windows case
# foo <- function() {
#     load(system.file("extdata", "fullCov", "fullCovAMY.RData",
#         package = "derfinderData"
#     ))
#     return(fullCovAMY)
# }
# fullCov <- foo()

## ----'regionMatrix'-----------------------------------------------------------
## Get the region matrix of Expressed Regions (ERs)
regionMat <- regionMatrix(fullCov, cutoff = 30, L = 76, verbose = FALSE)

## ----'exploreRegMatRegs'------------------------------------------------------
## regions output
regionMat$chr21$regions

## ----'exploreRegMatBP'--------------------------------------------------------
## Base-level coverage matrices for each of the regions
## Useful for plotting
lapply(regionMat$chr21$bpCoverage[1:2], head, n = 2)

## Check dimensions. First region is 565 long, second one is 138 bp long.
## The columns match the number of samples (12 in this case).
lapply(regionMat$chr21$bpCoverage[1:2], dim)

## ----'exploreRegMatrix'-------------------------------------------------------
## Dimensions of the coverage matrix
dim(regionMat$chr21$coverageMatrix)

## Coverage for each region. This matrix can then be used with limma or other pkgs
head(regionMat$chr21$coverageMatrix)

## ----'phenoData'--------------------------------------------------------------
## Get pheno table
pheno <- subset(brainspanPheno, structure_acronym == "AMY")

## ----'identifyDERsDESeq2'-----------------------------------------------------
## Identify which ERs are differentially expressed, that is, find the DERs
library("DESeq2")

## Round matrix
counts <- round(regionMat$chr21$coverageMatrix)

## Round matrix and specify design
dse <- DESeqDataSetFromMatrix(counts, pheno, ~ group + gender)

## Perform DE analysis
dse <- DESeq(dse, test = "LRT", reduced = ~gender, fitType = "local")

## Extract results
mcols(regionMat$chr21$regions) <- c(
    mcols(regionMat$chr21$regions),
    results(dse)
)

## Save info in an object with a shorter name
ers <- regionMat$chr21$regions
ers

## ----'vennRegions', fig.cap = "Venn diagram showing ERs by annotation class."----
## Find overlaps between regions and summarized genomic annotation
annoRegs <- annotateRegions(ers, genomicState$fullGenome, verbose = FALSE)

library("derfinderPlot")
venn <- vennRegions(annoRegs,
    counts.col = "blue",
    main = "Venn diagram using TxDb.Hsapiens.UCSC.hg19.knownGene annotation"
)

## ----'nearestGene'------------------------------------------------------------
## Load database of interest
library("TxDb.Hsapiens.UCSC.hg19.knownGene")
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
seqlevels(txdb) <- "chr21"

## Find nearest feature
library("bumphunter")
genes <- annotateTranscripts(txdb)
annotation <- matchGenes(ers, subject = genes)

## Restore seqlevels
txdb <- restoreSeqlevels(txdb)

## View annotation results
head(annotation)
## You can use derfinderPlot::plotOverview() to visualize this information

## ----'firstfive', fig.cap = paste0("Base-pair resolution plot of differentially expressed region ", 1:5, ".")----
## Extract the region coverage
regionCov <- regionMat$chr21$bpCoverage
plotRegionCoverage(
    regions = ers, regionCoverage = regionCov,
    groupInfo = pheno$group, nearestAnnotation = annotation,
    annotatedRegions = annoRegs, whichRegions = seq_len(5), txdb = txdb,
    scalefac = 1, ask = FALSE, verbose = FALSE
)

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("derfinder-quickstart.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("derfinder-quickstart.Rmd", tangle = TRUE)

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

