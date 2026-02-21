# Code example from 'omicsPrint' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
set.seed(22062017)
library(omicsPrint)
library(BiocStyle)
library(GEOquery)
library(SummarizedExperiment)

## ----toydata------------------------------------------------------------------
swap <- function(x, frac=0.05) {
    n <- length(x)
    k <- floor(n*frac)
    x1 <- sample(1:n,k)
    x2 <- sample(1:n,k) ##could be overlapping
    x[x2] <- x[x1]
    x
}
x1 <- 1 + rbinom(100, size=2, prob=1/3)
x2 <- swap(x1, 0.05) ##strongly related e.g. replicate
x3 <- swap(x1, 0.5) ##related e.g. parent off spring
x4 <- swap(x1, 1) ##unrelated
x <- cbind(x1, x2, x3, x4)

## ----head---------------------------------------------------------------------
head(x)

## ----alleleSharing------------------------------------------------------------
data <- alleleSharing(x, verbose=TRUE)

## ----data---------------------------------------------------------------------
data

## ----inferrelations, fig.cap = "Scatter-plot of IBS mean and variance with classification boundary for pairwise comparison between the samples without specifying sample relationships using artificially generated data."----
mismatches <- inferRelations(data)
mismatches

## ----extendedrelations--------------------------------------------------------
relations <- expand.grid(idx = colnames(x), idy= colnames(x))
relations$relation_type <- "unrelated"
relations$relation_type[relations$idx == relations$idy] <- "identical"
relations$relation_type[c(2,5)] <- "identical" ##replicate
relations$relation_type[c(3,7,9,10)] <- "parent offspring"
relations

## ----addrelations, fig.cap = "Scatter-plot of IBS mean and variance with classification boundaries for pairwise comparison between the samples with specifying sample relationships using artificially generated data."----
data <- alleleSharing(x, relations=relations)
data
mismatches <- inferRelations(data)
mismatches

## ----xyallelesharing1---------------------------------------------------------
rownames(x) <- paste0("rs", 1:100)
y <- x[sample(1:100, 80),]
data <- alleleSharing(x, y)

## ----xyallelesharing2, fig.cap = "Scatter-plot of IBS mean and variance with classification boundary for pairwise comparison between the samples without specifying sample relationships using artificial data."----
data
mismatches <- inferRelations(data)
mismatches

## ----addrelations2, fig.cap = "Scatter-plot of IBS mean and variance with classification boundaries for pairwise comparison between the samples with specifying sample relationships using artificial data."----
data <- alleleSharing(x, y, relations)
data
mismatches <- inferRelations(data)
mismatches

## ----downloadretry, include=FALSE---------------------------------------------
library(GEOquery)
library(SummarizedExperiment)
file <- tempfile(fileext = ".txt.gz")
cnt <- 0
value <- -1
while(value != 0  & cnt < 25) {
    value = download.file("ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE100nnn/GSE100940/matrix/GSE100940_series_matrix.txt.gz", file)
    cnt <- cnt + 1
}
gset <- getGEO(filename=file, getGPL=FALSE)

## ----downloaddata, eval=FALSE-------------------------------------------------
# library(GEOquery)
# library(SummarizedExperiment)
# file <- tempfile(fileext = ".txt.gz")
# download.file("ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE100nnn/GSE100940/matrix/GSE100940_series_matrix.txt.gz", file)
# gset <- getGEO(filename=file, getGPL=FALSE)

## ----geo2se-------------------------------------------------------------------
se <- makeSummarizedExperimentFromExpressionSet(gset)
se

## ----makerelationships--------------------------------------------------------
r <- expand.grid(idx=colnames(se), idy=colnames(se))
r$Xpair <- sapply(strsplit(as.character(colData(se)[r$idx, "source_name_ch1"]),
                           split = "_"), head, 1)
r$Ypair <- sapply(strsplit(as.character(colData(se)[r$idy, "source_name_ch1"]),
                           split = "_"), head, 1)
r$relation_type <- "unrelated"
r$relation_type[r$Xpair == r$Ypair] <- "twin"
r$relation_type[r$idx == r$idy] <- "identical"
head(r)

## ----selectcpgs---------------------------------------------------------------
data(hm450.manifest.pop.GoNL)
cpgs <- names(hm450.manifest.pop.GoNL[
    mcols(hm450.manifest.pop.GoNL)$MASK.snp5.EAS])
se <- se[cpgs,]

## ----genotyping---------------------------------------------------------------
dnamCalls <- beta2genotype(se, assayName = "exprs")
dim(dnamCalls)
dnamCalls[1:5, 1:5]

## ----allelesharing, dpi=72, fig.cap="Scatter-plot of IBS mean and variance with classification boundaries for pairwise comparison between samples consisting of pairs of monozygotic twins."----
data <- alleleSharing(dnamCalls, relations = r, verbose = TRUE)
mismatches <- inferRelations(data)
mismatches

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

