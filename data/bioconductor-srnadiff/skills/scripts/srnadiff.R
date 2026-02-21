# Code example from 'srnadiff' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide", warning=FALSE-------------------------
suppressPackageStartupMessages({
    library("srnadiff")
    library("BiocManager")
    library("BiocStyle")
    library("knitr")
    library("rmarkdown")
    library("grid")
})

knitr::opts_chunk$set(
    error=FALSE,
    fig.height=5,
    fig.width=8,
    message=FALSE,
    warning=FALSE,
    tidy=FALSE
)

## ----echo=FALSE---------------------------------------------------------------
basedir    <- system.file("extdata", package="srnadiff", mustWork=TRUE)
sampleInfo <- read.csv(file.path(basedir, "dataInfo.csv"))
bamFiles   <- file.path(basedir, sampleInfo$FileName)
gtfFile    <- file.path(basedir, "Homo_sapiens.GRCh38.76.gtf.gz")
annotReg   <- readAnnotation(gtfFile, feature="gene", source="miRNA")

## ----eval=TRUE, echo=FALSE----------------------------------------------------
x <- citation("srnadiff")

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# help("srnadiff")

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# ?srnadiff

## ----message=FALSE, warning=FALSE, include=FALSE, results="hide"--------------
#-- Data preparation
srnaExp <- srnadiffExp(bamFiles, sampleInfo)

#-- Performing srnadiff
srnaExp <- srnadiff(srnaExp)

#-- Visualization of the results
plotRegions(srnaExp, regions(srnaExp)[1])

## ----bioconductor, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")

## ----install, eval=FALSE------------------------------------------------------
# BiocManager::install("srnadiff")

## ----loadLibrary, eval=FALSE--------------------------------------------------
# library(srnadiff)

## ----helpSearch, eval=FALSE---------------------------------------------------
# help.search("srnadiff")

## ----message=FALSE, warning=FALSE---------------------------------------------
## Specifiy path to data files
basedir <- system.file("extdata", package="srnadiff", mustWork=TRUE)

## Read sample information file, and create a data frame
sampleInfo <- read.csv(file.path(basedir, "dataInfo.csv"))

## Vector with the full paths to the BAM files to use
bamFiles <- file.path(basedir, sampleInfo$FileName)

## Creates an srnadiffExp object
srnaExp <- srnadiffExp(bamFiles, sampleInfo)

## ----eval=FALSE---------------------------------------------------------------
# srnaExp <- srnadiffExp(bamFiles, sampleInfo, annotReg)

## ----message=FALSE, warning=FALSE---------------------------------------------
srnaExp <- srnadiffExp(bamFiles, sampleInfo)
annotReg(srnaExp) <- annotReg

## ----message=FALSE, warning=FALSE---------------------------------------------
sampleInfo$Condition <- factor(sampleInfo$Condition,
                               levels = c("control", "infected"))

## -----------------------------------------------------------------------------
srnaExp

## -----------------------------------------------------------------------------
srnaExp <- srnadiffExample()

## ----message=FALSE, warning=FALSE---------------------------------------------
basedir    <- system.file("extdata", package="srnadiff", mustWork=TRUE)
sampleInfo <- read.csv(file.path(basedir, "dataInfo.csv"))
gtfFile    <- file.path(basedir, "Homo_sapiens.GRCh38.76.gtf.gz")
annotReg   <- readAnnotation(gtfFile, feature="gene", source="miRNA")
bamFiles   <- file.path(basedir, sampleInfo$FileName)
srnaExp    <- srnadiffExp(bamFiles, sampleInfo, annotReg)

## ----message=FALSE, warning=FALSE---------------------------------------------
gtfFile  <- file.path(basedir, "Homo_sapiens.GRCh38.76.gtf.gz")
annotReg <- readAnnotation(gtfFile, feature="gene", source="miRNA")

## ----message=FALSE, warning=FALSE---------------------------------------------
gffFile  <- file.path(basedir, "mirbase21_GRCh38.gff3")
annotReg <- readAnnotation(gffFile, feature="miRNA_primary_transcript")

## ----message=FALSE, warning=FALSE---------------------------------------------
gffFile  <- file.path(basedir, "mirbase21_GRCh38.gff3")
annotReg <- readAnnotation(gffFile, feature="miRNA")

## ----message=FALSE, warning=FALSE---------------------------------------------
annotation <- readAnnotation(gtfFile, source="miRNA", feature="gene")

## -----------------------------------------------------------------------------
srnaExp <- srnadiff(srnaExp)

## -----------------------------------------------------------------------------
sampleInfo(srnaExp)

## -----------------------------------------------------------------------------
chromosomeSizes(srnaExp)

## -----------------------------------------------------------------------------
parameters(srnaExp)

## ----message=FALSE, warning=FALSE---------------------------------------------
regions <- regions(srnaExp, pvalue=0.5)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(rtracklayer)
export(regions, "file.bed")

## ----fig.height=3.5, fig.width=4, fig.align='center', out.width='450pt'-------
plotRegions(srnaExp, regions(srnaExp)[1])

## ----eval=FALSE---------------------------------------------------------------
# parameters(srnaExp) <- list(noDiffToDiff=0.01, emissionThreshold=0.2)

## ----eval=FALSE---------------------------------------------------------------
# parameters(srnaExp) <- list(minLogFC=1)

## ----eval=FALSE---------------------------------------------------------------
# parameters(srnaExp) <- list(cutoff=1.5)

## ----general_parameter--------------------------------------------------------
parameters(srnaExp) <- list(minDepth=1)
parameters(srnaExp) <- list(minSize=15, maxSize=1000)

## ----strategies---------------------------------------------------------------
srnaExp <- srnadiffExample()
srnaExp <- srnadiff(srnaExp, segMethod=c("hmm", "IR"))

## ----minOverlap---------------------------------------------------------------
parameters(srnaExp) <- list(minOverlap=1000)

## ----pvalue_edger-------------------------------------------------------------
srnaExp <- srnadiffExample()
srnaExp <- srnadiff(srnaExp, diffMethod="edgeR")

## ----threads, eval=FALSE------------------------------------------------------
# exp <- setNThreads(exp, nThreads=4)

## ----session_info-------------------------------------------------------------
sessionInfo()

