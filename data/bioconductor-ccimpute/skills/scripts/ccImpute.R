# Code example from 'ccImpute' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# To install this package, start R (version "4.2") and enter:
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ccImpute")

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(scRNAseq)
library(scater)
library(ccImpute)
library(SingleCellExperiment)
library(stats)
library(mclust)

## ----message=FALSE, warning=FALSE---------------------------------------------
sce <- UsoskinBrainData()
X <- cpm(sce)
labels <- colData(sce)$"Level 1"

#Filter bad cells
filt <- !grepl("Empty well", labels) &
        !grepl("NF outlier", labels) &
        !grepl("TH outlier", labels) &
        !grepl("NoN outlier", labels) &
        !grepl("NoN", labels) &
        !grepl("Central, unsolved", labels) &
        !grepl(">1 cell", labels) &
        !grepl("Medium", labels)
        
labels <-labels[filt]
X <- as.matrix(X[,filt])

#Remove genes that are not expressed in any cells:
X <- X[rowSums(X)>0,]

#Recreate the SingleCellExperiment and add log-transformed data:
ann <- data.frame(cell_id = labels)
sce <- SingleCellExperiment(assays = list(normcounts = as.matrix(X)), 
                            colData = ann)
logcounts(sce) <- log(normcounts(sce) + 1)

## -----------------------------------------------------------------------------
# Set seed for reproducibility purposes.
set.seed(0) 
# Compute PCA reduction of the dataset
reducedDims(sce) <- list(PCA=prcomp(t(logcounts(sce)))$x)

# Get an actual number of cell types
k <- length(unique(colData(sce)$cell_id))

# Cluster the PCA reduced dataset and store the assignments
set.seed(0) 
assgmts <- kmeans(reducedDim(sce, "PCA"), centers = k, iter.max = 1e+09,
                    nstart = 1000)$cluster

# Use ARI to compare the k-means assignments to label assignments
adjustedRandIndex(assgmts, colData(sce)$cell_id)

## -----------------------------------------------------------------------------
library(BiocParallel)
BPPARAM = MulticoreParam(2)
sce <- ccImpute(sce, BPPARAM = BPPARAM)

## -----------------------------------------------------------------------------
# Recompute PCA reduction of the dataset
reducedDim(sce, "PCA_imputed") <- prcomp(t(assay(sce, "imputed")))$x

# Cluster the PCA reduced dataset and store the assignments
assgmts <- kmeans(reducedDim(sce, "PCA_imputed"), centers = k, 
                    iter.max = 1e+09, nstart = 1000)$cluster

# Use ARI to compare the k-means assignments to label assignments
adjustedRandIndex(assgmts, colData(sce)$cell_id)

## ----eval=FALSE---------------------------------------------------------------
# ccImpute(sce, dist, nCeil = 2000, svdMaxRatio = 0.08,
#             maxSets = 8, k, consMin=0.75, kmNStart, kmMax=1000,
#             fastSolver = TRUE, BPPARAM=bpparam(), verbose = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# cores <- 2
# BPPARAM = MulticoreParam(cores)
# 
# w <- rowVars_fast(logcounts(sce), cores)
# corMat <- getCorM("spearman", logcounts(sce), w, cores)
# 
# v <- doSVD(corMat, svdMaxRatio=.08, nCeil=2000, nCores=cores)
# 
# consMtx <- runKM(logX, v, maxSets = 8, k, consMin=0.75, kmNStart, kmMax=1000,
#                     BPPARAM=bpparam())
# 
# dropIds <- findDropouts(logX, consMtx)
# 
# iLogX <- computeDropouts(consMtx, logX, dropIds,
#                             fastSolver=TRUE, nCores=cores)
# assay(sce, "imputed") <- iLogX

## ----eval=FALSE---------------------------------------------------------------
# corMat <- getCorM("pearson", logcounts(sce), nCores=2)

## ----eval=FALSE---------------------------------------------------------------
# BPPARAM = MulticoreParam(4)
# sce <- ccImpute(sce, BPPARAM = BPPARAM)

## ----eval=FALSE---------------------------------------------------------------
# library(RhpcBLASctl)
# blas_set_num_threads(4)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

