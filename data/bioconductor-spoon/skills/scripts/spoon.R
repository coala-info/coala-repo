# Code example from 'spoon' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("spoon")

## -----------------------------------------------------------------------------
library(nnSVG)
library(STexampleData)
library(SpatialExperiment)
library(BRISC)
library(BiocParallel)
library(scuttle)
library(Matrix)
library(spoon)

spe <- Visium_mouseCoronal()

## -----------------------------------------------------------------------------

# keep spots over tissue
spe <- spe[, colData(spe)$in_tissue == 1]

# filter out low quality genes
spe <- filter_genes(spe)

# calculate logcounts (log-transformed normalized counts) using scran package
spe <- computeLibraryFactors(spe)
spe <- logNormCounts(spe)

# choose a small number of genes for this example to run quickly
set.seed(3)
ix_random <- sample(seq_len(nrow(spe)), 10)
spe <- spe[ix_random, ]

# remove spots with zero counts
spe <- spe[, colSums(logcounts(spe)) > 0]

## -----------------------------------------------------------------------------
weights <- generate_weights(input = spe,
                            stabilize = TRUE,
                            BPPARAM = MulticoreParam(workers = 1,
                                                     RNGseed = 4))

## -----------------------------------------------------------------------------
spe <- weighted_nnSVG(input = spe,
                      w = weights,
                      BPPARAM = MulticoreParam(workers = 1, RNGseed = 5))

## -----------------------------------------------------------------------------
# display results
rowData(spe)

## ----eval=FALSE---------------------------------------------------------------
# assay_name <- "logcounts"
# weighted_logcounts <- t(weights)*assays(spe)[[assay_name]]
# assay(spe, "weighted_logcounts") <- weighted_logcounts

## -----------------------------------------------------------------------------
sessionInfo()

