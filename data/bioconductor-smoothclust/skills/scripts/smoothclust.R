# Code example from 'smoothclust' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("smoothclust")

## ----message=FALSE------------------------------------------------------------
library(smoothclust)
library(STexampleData)
library(scuttle)
library(scran)
library(scater)
library(ggspavis)

## -----------------------------------------------------------------------------
# load data
spe <- Visium_humanDLPFC()

# keep spots over tissue
spe <- spe[, colData(spe)$in_tissue == 1]

dim(spe)
assayNames(spe)

## ----results="hide"-----------------------------------------------------------
# run smoothclust using default parameters
spe <- smoothclust(spe)

## -----------------------------------------------------------------------------
# check output object
assayNames(spe)

## -----------------------------------------------------------------------------
# calculate logcounts
spe <- logNormCounts(spe, assay.type = "counts_smooth")

assayNames(spe)

## -----------------------------------------------------------------------------
# preprocessing steps for clustering

# remove mitochondrial genes
is_mito <- grepl("(^mt-)", rowData(spe)$gene_name, ignore.case = TRUE)
table(is_mito)
spe <- spe[!is_mito, ]
dim(spe)

# select top highly variable genes (HVGs)
dec <- modelGeneVar(spe)
top_hvgs <- getTopHVGs(dec, prop = 0.1)
length(top_hvgs)
spe <- spe[top_hvgs, ]
dim(spe)

## -----------------------------------------------------------------------------
# dimensionality reduction

# compute PCA on top HVGs
set.seed(123)
spe <- runPCA(spe)

## -----------------------------------------------------------------------------
# run k-means clustering
set.seed(123)
k <- 5
clust <- kmeans(reducedDim(spe, "PCA"), centers = k)$cluster
table(clust)
colLabels(spe) <- factor(clust)

## -----------------------------------------------------------------------------
# color palettes
pal8 <- "libd_layer_colors"
pal36 <- unname(palette.colors(36, "Polychrome 36"))

# plot clusters / spatial domains
plotCoords(spe, annotate = "label", pal = pal8)

## -----------------------------------------------------------------------------
# plot reference labels
plotCoords(spe, annotate = "ground_truth", pal = pal8)

## -----------------------------------------------------------------------------
sessionInfo()

