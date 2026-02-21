# Code example from 'SimBu' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("omnideconv/SimBu")

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("SimBu")

## ----setup--------------------------------------------------------------------
library(SimBu)

## -----------------------------------------------------------------------------
counts <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::t(1e6 * Matrix::t(tpm) / Matrix::colSums(tpm))
colnames(counts) <- paste0("cell_", rep(1:300))
colnames(tpm) <- paste0("cell_", rep(1:300))
rownames(counts) <- paste0("gene_", rep(1:1000))
rownames(tpm) <- paste0("gene_", rep(1:1000))
annotation <- data.frame(
  "ID" = paste0("cell_", rep(1:300)),
  "cell_type" = c(
    rep("T cells CD4", 50),
    rep("T cells CD8", 50),
    rep("Macrophages", 100),
    rep("NK cells", 10),
    rep("B cells", 70),
    rep("Monocytes", 20)
  )
)

## -----------------------------------------------------------------------------
ds <- SimBu::dataset(
  annotation = annotation,
  count_matrix = counts,
  tpm_matrix = tpm,
  name = "test_dataset"
)

## -----------------------------------------------------------------------------
simulation <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "NONE",
  ncells = 100,
  nsamples = 10,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4), # this will use 4 threads to run the simulation
  run_parallel = TRUE
) # multi-threading to TRUE

## ----format="markdown"--------------------------------------------------------
pure_scenario_dataframe <- data.frame(
  "B cells" = c(0.2, 0.1, 0.5, 0.3),
  "T cells" = c(0.3, 0.8, 0.2, 0.5),
  "NK cells" = c(0.5, 0.1, 0.3, 0.2),
  row.names = c("sample1", "sample2", "sample3", "sample4")
)
pure_scenario_dataframe

## -----------------------------------------------------------------------------
utils::head(SummarizedExperiment::assays(simulation$bulk)[["bulk_counts"]])
utils::head(SummarizedExperiment::assays(simulation$bulk)[["bulk_tpm"]])

## -----------------------------------------------------------------------------
simulation2 <- SimBu::simulate_bulk(
  data = ds,
  scenario = "even",
  scaling_factor = "NONE",
  ncells = 1000,
  nsamples = 10,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE
)
merged_simulations <- SimBu::merge_simulations(list(simulation, simulation2))

## ----fig.width=8, fig.height=8------------------------------------------------
SimBu::plot_simulation(simulation = merged_simulations)

## ----fig.width=8, fig.height=8------------------------------------------------
simulation <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "NONE",
  ncells = 1000,
  nsamples = 20,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE,
  whitelist = c("T cells CD4", "T cells CD8")
)
SimBu::plot_simulation(simulation = simulation)

## -----------------------------------------------------------------------------
utils::sessionInfo()

