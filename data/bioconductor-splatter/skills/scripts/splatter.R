# Code example from 'splatter' vignette. See references/ for full tutorial.

## ----knitr-options, echo = FALSE, message = FALSE, warning = FALSE------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")

# Use exact BSPARAM to avoid warnings
options(BiocSingularParam.default = BiocSingular::ExactParam())

## ----install-bioc, eval = FALSE-----------------------------------------------
# BiocManager::install("splatter")

## ----install-github, eval = FALSE---------------------------------------------
# BiocManager::install(
#     "Oshlack/splatter",
#     dependencies = TRUE,
#     build_vignettes = TRUE
# )

## ----quickstart---------------------------------------------------------------
# Load package
suppressPackageStartupMessages({
    library(splatter)
    library(scater)
})

# Create mock data
set.seed(1)
sce <- mockSCE()

# Estimate parameters from mock data
params <- splatEstimate(sce)
# Simulate data using estimated parameters
sim <- splatSimulate(params)

## ----SplatParams--------------------------------------------------------------
params <- newSplatParams()
params

## ----getParam-----------------------------------------------------------------
getParam(params, "nGenes")

## ----setParam-----------------------------------------------------------------
params <- setParam(params, "nGenes", 5000)
getParam(params, "nGenes")

## ----getParams-setParams------------------------------------------------------
# Set multiple parameters at once (using a list)
params <- setParams(params, update = list(nGenes = 8000, mean.rate = 0.5))
# Extract multiple parameters as a list
getParams(params, c("nGenes", "mean.rate", "mean.shape"))
# Set multiple parameters at once (using additional arguments)
params <- setParams(params, mean.shape = 0.5, de.prob = 0.2)
params

## ----newSplatParams-set-------------------------------------------------------
params <- newSplatParams(lib.loc = 12, lib.scale = 0.6)
getParams(params, c("lib.loc", "lib.scale"))

## ----splatEstimate------------------------------------------------------------
# Get the mock counts matrix
counts <- counts(sce)

# Check that counts is an integer matrix
class(counts)
typeof(counts)

# Check the dimensions, each row is a gene, each column is a cell
dim(counts)

# Show the first few entries
counts[1:5, 1:5]

params <- splatEstimate(counts)

## ----splatSimulate------------------------------------------------------------
sim <- splatSimulate(params, nGenes = 1000)
sim

## ----SCE----------------------------------------------------------------------
# Access the counts
counts(sim)[1:5, 1:5]
# Information about genes
head(rowData(sim))
# Information about cells
head(colData(sim))
# Gene by cell matrices
names(assays(sim))
# Example of cell means matrix
assays(sim)$CellMeans[1:5, 1:5]

## ----pca----------------------------------------------------------------------
# Use scater to calculate logcounts
sim <- logNormCounts(sim)
# Plot PCA
sim <- runPCA(sim)
plotPCA(sim)

## ----groups-------------------------------------------------------------------
sim.groups <- splatSimulate(
    group.prob = c(0.5, 0.5),
    method = "groups",
    verbose = FALSE
)
sim.groups <- logNormCounts(sim.groups)
sim.groups <- runPCA(sim.groups)
plotPCA(sim.groups, colour_by = "Group")

## ----paths--------------------------------------------------------------------
sim.paths <- splatSimulate(
    de.prob = 0.2,
    nGenes = 1000,
    method = "paths",
    verbose = FALSE
)
sim.paths <- logNormCounts(sim.paths)
sim.paths <- runPCA(sim.paths)
plotPCA(sim.paths, colour_by = "Step")

## ----batches------------------------------------------------------------------
sim.batches <- splatSimulate(batchCells = c(50, 50), verbose = FALSE)
sim.batches <- logNormCounts(sim.batches)
sim.batches <- runPCA(sim.batches)
plotPCA(sim.batches, colour_by = "Batch")

## ----batch-groups-------------------------------------------------------------
sim.groups <- splatSimulate(
    batchCells = c(50, 50),
    group.prob = c(0.5, 0.5),
    method = "groups",
    verbose = FALSE
)
sim.groups <- logNormCounts(sim.groups)
sim.groups <- runPCA(sim.groups)
plotPCA(sim.groups, shape_by = "Batch", colour_by = "Group")

## ----listSims-----------------------------------------------------------------
listSims()

## ----lengths------------------------------------------------------------------
sim <- simpleSimulate(verbose = FALSE)
sim <- addGeneLengths(sim)
head(rowData(sim))

## ----TPM----------------------------------------------------------------------
tpm(sim) <- calculateTPM(sim, rowData(sim)$Length)
tpm(sim)[1:5, 1:5]

## ----minimise-----------------------------------------------------------------
sim <- splatSimulate()
minimiseSCE(sim)

## ----minimise-keep------------------------------------------------------------
minimiseSCE(sim,
    rowData.keep = "Gene",
    colData.keep = c("Cell", "Batch"),
    metadata.keep = TRUE
)

## ----comparison---------------------------------------------------------------
sim1 <- splatSimulate(nGenes = 1000, batchCells = 20, verbose = FALSE)
sim2 <- simpleSimulate(nGenes = 1000, nCells = 20, verbose = FALSE)
comparison <- compareSCEs(list(Splat = sim1, Simple = sim2))

names(comparison)
names(comparison$Plots)

## ----comparison-means---------------------------------------------------------
comparison$Plots$Means

## ----comparison-libsize-features----------------------------------------------
library("ggplot2")
ggplot(comparison$ColData, aes(x = sum, y = detected, colour = Dataset)) +
    geom_point()

## ----difference---------------------------------------------------------------
difference <- diffSCEs(list(Splat = sim1, Simple = sim2), ref = "Simple")
difference$Plots$Means

## ----difference-qq------------------------------------------------------------
difference$QQPlots$Means

## ----save-panels, eval = FALSE------------------------------------------------
# # This code is just an example and is not run
# panel <- makeCompPanel(comparison)
# cowplot::save_plot("comp_panel.png", panel, nrow = 4, ncol = 3)
# 
# panel <- makeDiffPanel(difference)
# cowplot::save_plot("diff_panel.png", panel, nrow = 3, ncol = 5)
# 
# panel <- makeOverallPanel(comparison, difference)
# cowplot::save_plot("overall_panel.png", panel, ncol = 4, nrow = 7)

## ----citation-----------------------------------------------------------------
citation("splatter")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

