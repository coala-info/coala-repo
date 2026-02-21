# Code example from 'simulator_scaling_factors' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
# Example data
counts <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::Matrix(matrix(stats::rpois(3e5, 5), ncol = 300), sparse = TRUE)
tpm <- Matrix::t(1e6 * Matrix::t(tpm) / Matrix::colSums(tpm))
colnames(counts) <- paste0("cell_", rep(1:300))
colnames(tpm) <- paste0("cell_", rep(1:300))
rownames(counts) <- paste0("gene_", rep(1:1000))
rownames(tpm) <- paste0("gene_", rep(1:1000))
annotation <- data.frame(
  "ID" = paste0("cell_", rep(1:300)),
  "cell_type" = c(rep("T cells CD4", 150), rep("T cells CD8", 150)),
  "spikes" = stats::runif(300),
  "add_1" = stats::runif(300),
  "add_2" = stats::runif(300)
)
ds <- SimBu::dataset(
  annotation = annotation,
  count_matrix = counts,
  name = "test_dataset"
)

## ----format="markdown"--------------------------------------------------------
epic <- data.frame(
  type = c(
    "B cells",
    "Macrophages",
    "Monocytes",
    "Neutrophils",
    "NK cells",
    "T cells",
    "T cells CD4",
    "T cells CD8",
    "T helper cells",
    "T regulatory cells",
    "otherCells",
    "default"
  ),
  mRNA = c(
    0.4016,
    1.4196,
    1.4196,
    0.1300,
    0.4396,
    0.3952,
    0.3952,
    0.3952,
    0.3952,
    0.3952,
    0.4000,
    0.4000
  )
)
epic

## ----format="markdown"--------------------------------------------------------
quantiseq <- data.frame(
  type = c(
    "B cells",
    "Macrophages",
    "MacrophagesM2",
    "Monocytes",
    "Neutrophils",
    "NK cells",
    "T cells CD4",
    "T cells CD8",
    "T regulatory cells",
    "Dendritic cells",
    "T cells"
  ),
  mRNA = c(
    65.66148,
    138.11520,
    119.35447,
    130.65455,
    27.73634,
    117.71584,
    63.87200,
    70.25659,
    72.55110,
    140.76091,
    68.89323
  )
)
quantiseq

## -----------------------------------------------------------------------------
sim_epic <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "epic",
  nsamples = 10,
  ncells = 100,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE
)

## -----------------------------------------------------------------------------
sim_extreme_b <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "custom",
  custom_scaling_vector = c("T cells CD8" = 10),
  nsamples = 10,
  ncells = 100,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE
)

## -----------------------------------------------------------------------------
sim_reads <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "read_number", # use number of reads as scaling factor
  nsamples = 10,
  ncells = 100,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE
)
sim_genes <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "expressed_genes", # use number of expressed genes column as scaling factor
  nsamples = 10,
  ncells = 100,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE
)

## ----format="markdown"--------------------------------------------------------
utils::head(annotation)

## -----------------------------------------------------------------------------
ds <- SimBu::dataset(
  annotation = annotation,
  count_matrix = counts,
  name = "test_dataset",
  additional_cols = c("add_1", "add_2")
) # add columns to dataset
sim_genes <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "add_1", # use add_1 column as scaling factor
  nsamples = 10,
  ncells = 100,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE
)

## ----eval=FALSE---------------------------------------------------------------
# ds <- SimBu::dataset(
#   annotation = annotation,
#   count_matrix = counts,
#   name = "test_dataset",
#   spike_in_col = "spikes"
# ) # give the name in the annotation file, that contains spike-in information
# sim_spike <- SimBu::simulate_bulk(
#   data = ds,
#   scenario = "random",
#   scaling_factor = "spike_in", # use spike-in scaling factor
#   nsamples = 10,
#   ncells = 100,
#   BPPARAM = BiocParallel::MulticoreParam(workers = 4),
#   run_parallel = TRUE
# )

## -----------------------------------------------------------------------------
ds <- SimBu::dataset(
  annotation = annotation,
  count_matrix = counts,
  tpm_matrix = tpm,
  name = "test_dataset"
)
sim_census <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "census", # use census scaling factor
  nsamples = 10,
  ncells = 100,
  BPPARAM = BiocParallel::MulticoreParam(workers = 4),
  run_parallel = TRUE
)

## -----------------------------------------------------------------------------
utils::sessionInfo()

