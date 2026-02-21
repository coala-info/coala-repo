# Code example from 'RaggedExperiment' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(dev = 'svg')

## ----installation, eval = FALSE-----------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("RaggedExperiment")

## ----libs, include=TRUE,results="hide",message=FALSE,warning=FALSE------------
library(RaggedExperiment)
library(GenomicRanges)

## ----class-schematic----------------------------------------------------------
knitr::include_graphics("../man/figures/RaggedExperiment.svg")

## ----granges-objects----------------------------------------------------------
sample1 <- GRanges(
    c(A = "chr1:1-10:-", B = "chr1:8-14:+", C = "chr2:15-18:+"),
    score = 3:5)
sample2 <- GRanges(
    c(D = "chr1:1-10:-", E = "chr2:11-18:+"),
    score = 1:2)

## ----coldata------------------------------------------------------------------
colDat <- DataFrame(id = 1:2)

## ----ragexp-from-granges------------------------------------------------------
ragexp <- RaggedExperiment(
    sample1 = sample1,
    sample2 = sample2,
    colData = colDat
)
ragexp

## ----ragexp-from-grangeslist--------------------------------------------------
grl <- GRangesList(sample1 = sample1, sample2 = sample2)
RaggedExperiment(grl, colData = colDat)

## ----ragexp-from-list---------------------------------------------------------
rangeList <- list(sample1 = sample1, sample2 = sample2)
RaggedExperiment(rangeList, colData = colDat)

## ----ragexp-from-list-mcols---------------------------------------------------
grList <- List(sample1 = sample1, sample2 = sample2)
mcols(grList) <- colDat
RaggedExperiment(grList)

## ----accessor-rowranges-------------------------------------------------------
rowRanges(ragexp)

## ----accessor-dimnames--------------------------------------------------------
dimnames(ragexp)

## ----accessor-coldata---------------------------------------------------------
colData(ragexp)

## ----sparseassay-dim----------------------------------------------------------
dim(ragexp)
Reduce(`*`, dim(ragexp))
sparseAssay(ragexp)
length(sparseAssay(ragexp))

## ----sparseassay-sparse-------------------------------------------------------
sparseAssay(ragexp, sparse = TRUE)

## ----compactassay-------------------------------------------------------------
compactAssay(ragexp)

## ----compactassay-sparse------------------------------------------------------
compactAssay(ragexp, sparse = TRUE)

## ----disjoinassay-------------------------------------------------------------
disjoinAssay(ragexp, simplifyDisjoin = mean)

## ----qreduceassay-unlist------------------------------------------------------
unlist(grl, use.names = FALSE)

## ----qreduceassay-rowranges---------------------------------------------------
rowRanges(ragexp)
assay(ragexp, "score")

## ----qreduceassay-query-------------------------------------------------------
(query <- GRanges(c("chr1:1-14:-", "chr2:11-18:+")))

## ----qreduceassay-weightedmean------------------------------------------------
weightedmean <- function(scores, ranges, qranges)
{
    isects <- pintersect(ranges, qranges)
    sum(scores * width(isects)) / sum(width(isects))
}

## ----qreduceassay-call--------------------------------------------------------
qreduceAssay(ragexp, query, simplifyReduce = weightedmean)

## ----dgcmatrix-to-ragexp------------------------------------------------------
library(Matrix)

sm <- Matrix::sparseMatrix(
    i = c(2, 3, 4, 3, 4, 3, 4),
    j = c(1, 1, 1, 3, 3, 4, 4),
    x = c(2L, 4L, 2L, 2L, 2L, 4L, 2L),
    dims = c(4, 4),
    dimnames = list(
        c("chr2:1-10", "chr2:2-10", "chr2:3-10", "chr2:4-10"),
        LETTERS[1:4]
    )
)

as(sm, "RaggedExperiment")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

