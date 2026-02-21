# Code example from 'SCArray' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------------------------------------
options(width=110)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SCArray")

## -----------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(SCArray))
suppressPackageStartupMessages(library(SingleCellExperiment))

# load a SingleCellExperiment object
fn <- system.file("extdata", "example.rds", package="SCArray")
sce <- readRDS(fn)

# convert to a GDS file
scConvGDS(sce, "test.gds")

# list data structure in the GDS file
(f <- scOpen("test.gds"))
scClose(f)

## -----------------------------------------------------------------------------------------------------------
library(Matrix)

cnt <- matrix(0, nrow=4, ncol=8)
set.seed(100); cnt[sample.int(length(cnt), 8)] <- rpois(8, 4)
(cnt <- as(cnt, "sparseMatrix"))

# convert to a GDS file
scConvGDS(cnt, "test.gds")

## -----------------------------------------------------------------------------------------------------------
# a GDS file in the SCArray package
(fn <- system.file("extdata", "example.gds", package="SCArray"))
# load a SingleCellExperiment object from the file
sce <- scExperiment(fn)
sce

# it is a DelayedMatrix (the whole matrix is not loaded)
assays(sce)$counts

# column data
colData(sce)
# row data
rowData(sce)

## -----------------------------------------------------------------------------------------------------------
cnt <- assays(sce)$counts
logcnt <- log2(cnt + 1)
logcnt

## -----------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(scuttle))

sce <- logNormCounts(sce)
logcounts(sce)

## -----------------------------------------------------------------------------------------------------------
col_mean <- colMeans(logcnt)
str(col_mean)
row_mean <- rowMeans(logcnt)
str(row_mean)

# calculate the mean and variance at the same time
mvar <- scRowMeanVar(logcnt)
head(mvar)

## -----------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(scater))

# run umap analysis
sce <- runPCA(sce)

## -----------------------------------------------------------------------------------------------------------
sce <- scRunPCA(sce)

## ----fig.align="center",fig.width=4,fig.height=3------------------------------------------------------------
plotReducedDim(sce, dimred="PCA")

## -----------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(scater))

# run umap analysis
sce <- runUMAP(sce)

## ----fig.align="center",fig.width=4,fig.height=3------------------------------------------------------------
plotReducedDim(sce, dimred="UMAP")

## -----------------------------------------------------------------------------------------------------------
options(SCArray.verbose=TRUE)

m <- rowMeans(logcnt)
str(m)

## -----------------------------------------------------------------------------------------------------------
# print version information about R, the OS and attached or loaded packages
sessionInfo()

## ----echo=FALSE---------------------------------------------------------------------------------------------
unlink("test.gds", force=TRUE)

