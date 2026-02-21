# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----knitr-options, echo = FALSE, message = FALSE, warning = FALSE------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>")
options(max.print = 30)

## ----install-bioc, eval = FALSE, include=TRUE---------------------------------
# BiocManager::install("simPIC")

## ----install-dev, eval = FALSE, include=TRUE----------------------------------
# BiocManager::install(
#     "sagrikachugh/simPIC",
#     dependencies = TRUE,
#     build_vignettes = TRUE
# )

## ----quickstart---------------------------------------------------------------
# Load package
suppressPackageStartupMessages({
    library(simPIC)
})

# Load test data
set.seed(567)
counts <- readRDS(system.file("extdata", "test.rds", package = "simPIC"))

# Estimate parameters
est <- simPICestimate(counts)

# Simulate data using estimated parameters
sim <- simPICsimulate(est)

## ----pic, eval=FALSE, include=TRUE--------------------------------------------
# pic_mat <- PIC_counting(
#     cells = cells,
#     fragment_tsv_gz_file_location = fragment_tsv_gz_file_location,
#     peak_sets = peak_sets
# )

## ----simPICparams-------------------------------------------------------------
sim.params <- newsimPICcount()

## ----params-------------------------------------------------------------------
sim.params

## ----getParam-----------------------------------------------------------------
simPICget(sim.params, "nPeaks")

## ----setParam-----------------------------------------------------------------
sim.params <- setsimPICparameters(sim.params, nPeaks = 2000)
simPICget(sim.params, "nPeaks")

## ----getParams-setParams------------------------------------------------------
# Set multiple parameters at once (using a list)
sim.params <- setsimPICparameters(sim.params,
    update = list(nPeaks = 8000, nCells = 500)
)
# Extract multiple parameters as a list
params <- simPICgetparameters(
    sim.params,
    c("nPeaks", "nCells", "peak.mean.shape")
)
# Set multiple parameters at once (using additional arguments)
params <- setsimPICparameters(sim.params,
    lib.size.sdlog = 3.5, lib.size.meanlog = 9.07
)
params

## ----simPICestimate-----------------------------------------------------------
# Get the counts from test data
#counts <- readRDS(system.file("extdata", "test.rds", package = "simPIC"))

# Check that counts is a dgCMatrix
class(counts)
typeof(counts)

# Check the dimensions, each row is a peak, each column is a cell
dim(counts)

# Show the first few entries
counts[1:5, 1:5]

new <- newsimPICcount()
new <- simPICestimate(counts)

## estimating using gamma distribution
## new <- simPICestimate(counts, pm.distr = "gamma")

## ----simPICsimulate-----------------------------------------------------------
sim <- simPICsimulate(new, nCells = 500)
sim

## simulating using gamma distribution
## sim <- simPICsimulate(new, nCells =500, pm.distr = "gamma")

## ----SCE----------------------------------------------------------------------
# Access the counts
counts(sim)[1:5, 1:5]
# Information about peaks
head(rowData(sim))
# Information about cells
head(colData(sim))
# Peak by cell matrices
names(assays(sim))

## ----comparison, warning=FALSE------------------------------------------------
sim1 <- simPICsimulate(nPeaks = 2000, nCells = 500)
sim2 <- simPICsimulate(nPeaks = 2000, nCells = 500)
comparison <- simPICcompare(list(real = sim1, simPIC = sim2))

names(comparison)
names(comparison$Plots)

## ----comparison-means---------------------------------------------------------
comparison$Plots$Means

## ----multi-celltype-----------------------------------------------------------
#counts <- readRDS(system.file("extdata", "test.rds", package = "simPIC"))

sim <- simPICsimulate(new, method = "groups", 
                nGroups = 2, group.prob = c(0.5, 0.5))

## ----plot---------------------------------------------------------------------
library(SingleCellExperiment)
library(scater)

sim <- logNormCounts(sim)
sim <- scater::runPCA(sim)
plotPCASCE(sim,color_by="Group")

## ----multi-celltype-v---------------------------------------------------------
sim_multi <- simPICsimulate(new, method ="groups", 
                            nGroups = 2, 
                            group.prob = c(0.7, 0.3))

sim_multi <- logNormCounts(sim_multi)
sim_multi <- runPCA(sim_multi)
plotPCASCE(sim_multi, color_by="Group")

## ----multi-celltype-batch-----------------------------------------------------
set.seed(567)
sim_batch <- simPICsimulate(new, method="groups",
                            nGroups=2, nBatches=2,
                            group.prob=c(0.5, 0.5),
                            batchCells=c(250,250))

sim_batch <- logNormCounts(sim_batch)
sim_batch <- runPCA(sim_batch)
plotPCASCE(sim_batch, color_by="Batch", shape_by="Group")


## ----citation-----------------------------------------------------------------
citation("simPIC")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

