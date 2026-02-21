# Code example from 'scMultiome' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("SingleCellMultiModal")

## ----include=TRUE, results="hide", message=FALSE, warning=FALSE---------------
library(SingleCellMultiModal)
library(MultiAssayExperiment)
library(scran)
library(scater)

## -----------------------------------------------------------------------------
mae <- scMultiome("pbmc_10x", modes = "*", dry.run = FALSE, format = "MTX")

## ----echo=FALSE---------------------------------------------------------------
gg_color_hue <- function(n) {
  hues = seq(15, 375, length = n + 1)
  hcl(h = hues, l = 65, c = 100)[1:n]
}
colors <- gg_color_hue(length(unique(mae$celltype)))
names(colors) <- unique(mae$celltype)

## -----------------------------------------------------------------------------
mae

## -----------------------------------------------------------------------------
upsetSamples(mae)

## -----------------------------------------------------------------------------
head(colData(mae))

## -----------------------------------------------------------------------------
dim(experiments(mae)[["rna"]])

## -----------------------------------------------------------------------------
names(experiments(mae))

## -----------------------------------------------------------------------------
sce.rna <- experiments(mae)[["rna"]]

# Normalisation
sce.rna <- logNormCounts(sce.rna)

# Feature selection
decomp <- modelGeneVar(sce.rna)
hvgs <- rownames(decomp)[decomp$mean>0.01 & decomp$p.value <= 0.05]
sce.rna <- sce.rna[hvgs,]

# PCA
sce.rna <- runPCA(sce.rna, ncomponents = 25)

# UMAP
set.seed(42)
sce.rna <- runUMAP(sce.rna, dimred="PCA", n_neighbors = 25, min_dist = 0.3)
plotUMAP(sce.rna, colour_by="celltype", point_size=0.5, point_alpha=1)

## -----------------------------------------------------------------------------
dim(experiments(mae)[["atac"]])

## -----------------------------------------------------------------------------
sce.atac <- experiments(mae)[["atac"]]

# Normalisation
sce.atac <- logNormCounts(sce.atac)

# Feature selection
decomp <- modelGeneVar(sce.atac)
hvgs <- rownames(decomp)[decomp$mean>0.25]
sce.atac <- sce.atac[hvgs,]

# PCA
sce.atac <- runPCA(sce.atac, ncomponents = 25)

# UMAP
set.seed(42)
sce.atac <- runUMAP(sce.atac, dimred="PCA", n_neighbors = 25, min_dist = 0.3)
plotUMAP(sce.atac, colour_by="celltype", point_size=0.5, point_alpha=1)

## -----------------------------------------------------------------------------
sessionInfo()

