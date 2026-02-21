# Code example from 'regionReport' vignette. See references/ for full tutorial.

## ----'installDer', eval = FALSE---------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("regionReport")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----'citation'-------------------------------------------------------------------------------------------------------
## Citation info
citation("regionReport")

## ----vignetteSetup, echo = FALSE, message = FALSE, warning = FALSE----------------------------------------------------
## Track time spent on making the vignette
startTimeVignette <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    derfinder = citation("derfinder")[1],
    regionReport = citation("regionReport")[1],
    knitrBootstrap = citation("knitrBootstrap")[1],
    BiocStyle = citation("BiocStyle")[1],
    ggbio = citation("ggbio")[1],
    ggplot2 = citation("ggplot2")[1],
    knitr = citation("knitr")[3],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    DT = citation("DT")[1],
    R = citation(),
    IRanges = citation("IRanges")[1],
    sessioninfo = citation("sessioninfo")[1],
    GenomeInfoDb = RefManageR::BibEntry(
        bibtype = "manual",
        key = "GenomeInfoDb",
        author = "Sonali Arora and Martin Morgan and Marc Carlson and H. Pagès",
        title = "GenomeInfoDb: Utilities for manipulating chromosome and other 'seqname' identifiers",
        year = 2017, doi = "10.18129/B9.bioc.GenomeInfoDb"
    ),
    GenomicRanges = citation("GenomicRanges")[1],
    biovizBase = citation("biovizBase")[1],
    TxDb.Hsapiens.UCSC.hg19.knownGene = citation("TxDb.Hsapiens.UCSC.hg19.knownGene")[1],
    derfinderPlot = citation("derfinderPlot")[1],
    grid = citation("grid")[1],
    gridExtra = citation("gridExtra")[1],
    mgcv = citation("mgcv")[1],
    RColorBrewer = citation("RColorBrewer")[1],
    whisker = citation("whisker")[1],
    bumphunter = citation("bumphunter")[1],
    pheatmap = citation("pheatmap")[1],
    DESeq2 = citation("DESeq2")[1],
    edgeR1 = citation("edgeR")[1],
    edgeR2 = citation("edgeR")[2],
    DEFormats = citation("DEFormats")[1]
)

## ----overviewNotRun, eval = FALSE-------------------------------------------------------------------------------------
# ## Load derfinder
# library("derfinder")
# regions <- genomeRegions$regions
# 
# ## Assign chr length
# library("GenomicRanges")
# seqlengths(regions) <- c("chr21" = 48129895)
# 
# ## The output will be saved in the 'derfinderReport-example' directory
# dir.create("renderReport-example", showWarnings = FALSE, recursive = TRUE)
# 
# ## Generate the HTML report
# report <- renderReport(regions, "Example run",
#     pvalueVars = c(
#         "Q-values" = "qvalues", "P-values" = "pvalues"
#     ), densityVars = c(
#         "Area" = "area", "Mean coverage" = "meanCoverage"
#     ),
#     significantVar = regions$qvalues <= 0.05, nBestRegions = 20,
#     outdir = "renderReport-example"
# )

## ----loadDerfinder----------------------------------------------------------------------------------------------------
## Load derfinder
library("derfinder")

## The output will be saved in the "derfinderReport-example" directory
dir.create("derfinderReport-example", showWarnings = FALSE, recursive = TRUE)

## ----runDerfinderFake, eval=FALSE-------------------------------------------------------------------------------------
# ## Save the current path
# initialPath <- getwd()
# setwd(file.path(initialPath, "derfinderReport-example"))
# 
# ## Generate output from derfinder
# 
# ## Collapse the coverage information
# collapsedFull <- collapseFullCoverage(list(genomeData$coverage),
#     verbose = TRUE
# )
# 
# ## Calculate library size adjustments
# sampleDepths <- sampleDepth(collapsedFull,
#     probs = c(0.5), nonzero = TRUE,
#     verbose = TRUE
# )
# 
# ## Build the models
# group <- genomeInfo$pop
# adjustvars <- data.frame(genomeInfo$gender)
# models <- makeModels(sampleDepths, testvars = group, adjustvars = adjustvars)
# 
# ## Analyze chromosome 21
# analysis <- analyzeChr(
#     chr = "21", coverageInfo = genomeData, models = models,
#     cutoffFstat = 1, cutoffType = "manual", seeds = 20140330, groupInfo = group,
#     mc.cores = 1, writeOutput = TRUE, returnOutput = TRUE
# )
# 
# ## Save the stats options for later
# optionsStats <- analysis$optionsStats
# 
# ## Change the directory back to the original one
# setwd(initialPath)

## ----runDerfinderReal-------------------------------------------------------------------------------------------------
## Copy previous results
file.copy(system.file(file.path("extdata", "chr21"),
    package = "derfinder",
    mustWork = TRUE
), "derfinderReport-example", recursive = TRUE)

## ----mergeResults-----------------------------------------------------------------------------------------------------
## Merge the results from the different chromosomes. In this case, there's
## only one: chr21
mergeResults(
    chrs = "chr21", prefix = "derfinderReport-example",
    genomicState = genomicState$fullGenome
)

## Load optionsStats
load(file.path("derfinderReport-example", "chr21", "optionsStats.Rdata"), verbose = TRUE)

## ----loadLib, message=FALSE-------------------------------------------------------------------------------------------
## Load derfindeReport
library("regionReport")

## ----createReport, eval = FALSE---------------------------------------------------------------------------------------
# ## Generate the HTML report
# report <- derfinderReport(
#     prefix = "derfinderReport-example", browse = FALSE,
#     nBestRegions = 15, makeBestClusters = TRUE,
#     fullCov = list("21" = genomeDataRaw$coverage), optionsStats = optionsStats
# )

## ----vignetteBrowse, eval=FALSE---------------------------------------------------------------------------------------
# ## Browse the report
# browseURL(report)

## ----createVignette, eval=FALSE---------------------------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("regionReport.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("regionReport.Rmd", tangle = TRUE)

## ----createVignette2--------------------------------------------------------------------------------------------------
## Clean up
unlink("derfinderReport-example", recursive = TRUE)

## ----vignetteReproducibility1, echo=FALSE-----------------------------------------------------------------------------
## Date the report was generated
Sys.time()

## ----vignetteReproducibility2, echo=FALSE-----------------------------------------------------------------------------
## Processing time in seconds
totalTimeVignette <- diff(c(startTimeVignette, Sys.time()))
round(totalTimeVignette, digits = 3)

## ----vignetteReproducibility3, echo=FALSE-----------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results='asis', echo=FALSE, warning = FALSE, message = FALSE-------------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

