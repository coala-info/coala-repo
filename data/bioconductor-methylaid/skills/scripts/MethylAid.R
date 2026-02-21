# Code example from 'MethylAid' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----include=FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(
concordance=TRUE
)

## ----minfiDatatargets, cache=TRUE, message=FALSE---------------------------
library(MethylAid)
library(minfiData)
baseDir <- system.file("extdata", package = "minfiData")
targets <- read.metharray.sheet(baseDir)

## ----minfiDataMethylAid, cache=TRUE, eval=FALSE----------------------------
# data <- summarize(targets)
# visualize(data)

## ----minfiDataEPIC, cache=TRUE, message=FALSE, eval=FALSE------------------
# library(MethylAid)
# library(minfiDataEPIC)
# baseDir <- system.file("extdata", package = "minfiDataEPIC")
# targets <- read.metharray.sheet(baseDir)
# data <- summarize(targets)
# visualize(data)

## ----presummarized, message=FALSE, eval=FALSE------------------------------
# library(MethylAid)
# data(exampleData)
# visualize(exampleData)

## ----tcgatargets, eval=FALSE-----------------------------------------------
# sdrfFile <- list.files(pattern="sdrf", full.name=TRUE)
# targets <- read.table(sdrfFile, header=TRUE, sep="\t")
# path <- "path_to_idat_files"
# targets <- targets[file.exists(file.path(path, targets$Array.Data.File)),]
# targets <- targets[grepl("Red", targets$Array.Data.File),]
# targets$Basename <- gsub("_Red.*$", "", file.path(path, targets$Array.Data.File))
# rownames(targets) <- basename(targets$Basename)
# head(targets)

## ----tcgaMethylAid, eval=FALSE---------------------------------------------
# summarize(targets, batchSize = 15, file = "tcgaBRCA")
# load("tcgaBRCA.RData")
# visualize(tcgaBRCA)

## ----geotargets, eval=FALSE, tidy=FALSE------------------------------------
# library(GEOquery)
# gse <- getGEO("GSE42861")
# targets <- pData(phenoData(gse[[1]]))
# path <- "path_to_idat_files"
# targets$Basename <- file.path(path,
# gsub("_Grn.*$", "", basename(targets$supplementary_file)))
# rownames(targets) <- basename(targets$Basename)

## ----geoMethylAid, eval=FALSE----------------------------------------------
# summarize(targets, batchSize = 15, file="RA")
# load("RA.RData")
# visualize(RA)

## ----tcgaMethylAidmc, eval=FALSE-------------------------------------------
# library(BiocParallel)
# tcga <- summarize(targets, batchSize = 15, BPPARAM = MulticoreParam(workers = 8))

## ----tcgaMethylAidsge, eval=FALSE, tidy=FALSE------------------------------
# library(BiocParallel)
# conffile <- system.file("scripts/config.R", package="MethylAid")
# BPPARAM <- BatchJobsParam(workers = 10,
# progressbar = FALSE,
# conffile = conffile)
# summarize(targets, batchSize = 50, BPPARAM = BPPARAM)

## ----thresholds, eval=FALSE------------------------------------------------
# visualize(exampleData,
#           thresholds = list(MU = 10.5, OP = 11.75,
#               BS = 12.75, HC = 13.25, DP = 0.95))

## ----reference, eval=FALSE-------------------------------------------------
# library(MethylAid)
# data(exampleData) ##500 samples
# library(MethylAidData)
# data(exampleDataLarge) ##2800 samples
# outliers <- visualize(exampleData, background=exampleDataLarge)
# head(outliers)

## ----combine---------------------------------------------------------------
library(MethylAid)
data(exampleData)
exampleData
combine(exampleData, exampleData)

## ----sessionInfo, results='asis', echo=FALSE-------------------------------
toLatex(sessionInfo())

