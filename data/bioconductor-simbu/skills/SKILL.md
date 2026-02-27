---
name: bioconductor-simbu
description: SimBu simulates realistic pseudo-bulk RNA-seq samples by aggregating single-cell RNA-seq profiles with controlled cell-type proportions and mRNA bias. Use when user asks to simulate pseudo-bulk data from single-cell profiles, evaluate deconvolution methods, model cell-type-specific mRNA bias, or generate bulk samples with custom cell-type fractions.
homepage: https://bioconductor.org/packages/release/bioc/html/SimBu.html
---


# bioconductor-simbu

## Overview

SimBu is an R package designed to simulate realistic pseudo-bulk RNA-seq samples by aggregating single-cell RNA-seq (scRNA-seq) profiles. It is specifically built to support the evaluation of deconvolution methods by providing fine-grained control over cell-type fractions and modeling cell-type-specific mRNA bias. SimBu supports various simulation scenarios (random, even, weighted, etc.) and integrates with public data repositories like sfaira.

## Core Workflow

### 1. Data Preparation

SimBu requires a `SummarizedExperiment` object containing at least a raw count matrix and cell-type annotations.

```r
library(SimBu)

# Create a SimBu dataset from matrices
ds <- SimBu::dataset(
  annotation = annotation_df, # Must have 'ID' and 'cell_type' columns
  count_matrix = counts,      # Mandatory: genes in rows, cells in columns
  tpm_matrix = tpm,           # Optional: recommended for TPM-based simulations
  name = "my_dataset"
)

# Create from Seurat
ds_seurat <- SimBu::dataset_seurat(
  seurat_obj = seurat_obj,
  count_assay = "counts",
  cell_id_col = "ID",
  cell_type_col = "cell_type",
  name = "seurat_ds"
)
```

### 2. Simulation Scenarios

The `simulate_bulk()` function is the primary interface for generating pseudo-bulk data.

*   **random**: Random cell-type fractions based on uniform distribution.
*   **even**: All cell types appear in equal proportions.
*   **mirror_db**: Matches the cell-type proportions found in the input dataset.
*   **weighted**: Over-represents a specific cell type (use `weighted_cell_type` and `weighted_amount`).
*   **pure**: 100% of a single cell type.
*   **custom**: User-defined fractions via a dataframe.

```r
simulation <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  ncells = 1000,    # Cells per sample
  nsamples = 10,    # Total samples
  run_parallel = TRUE
)
```

### 3. Modeling mRNA Bias (Scaling Factors)

SimBu can adjust for the fact that different cell types contain different amounts of mRNA.

*   **Pre-defined**: Use `"epic"` or `"quantiseq"` to apply literature-derived scaling factors.
*   **Data-driven**: Use `"read_number"`, `"expressed_genes"`, or `"census"`.
*   **Custom**: Provide a named vector via `custom_scaling_vector`.

```r
sim_bias <- SimBu::simulate_bulk(
  data = ds,
  scenario = "random",
  scaling_factor = "epic"
)
```

### 4. Accessing Results

The simulation output is a list containing:
*   `bulk`: A `SummarizedExperiment` with `bulk_counts` and/or `bulk_tpm` assays.
*   `cell_fractions`: The ground truth proportions for each sample.
*   `scaling_vector`: The specific scaling values applied to each cell.

```r
# Extract bulk counts
bulk_counts <- SummarizedExperiment::assays(simulation$bulk)[["bulk_counts"]]

# Visualize proportions
SimBu::plot_simulation(simulation)
```

## Advanced Features

### Public Data Integration (sfaira)
SimBu can automatically download and format data from the sfaira repository.

```r
# Initial setup (creates conda env)
setup_list <- SimBu::setup_sfaira(basedir = tempdir())

# Download specific tissue data
ds_pancreas <- SimBu::dataset_sfaira_multiple(
  sfaira_setup = setup_list,
  organisms = "Homo sapiens",
  tissues = "pancreas",
  name = "pancreas_ds"
)
```

### Filtering and Merging
*   **Filtering**: Use `filter_genes = TRUE`, `variance_cutoff`, or `type_abundance_cutoff` within the `dataset()` function.
*   **Merging**: Combine multiple datasets using `SimBu::dataset_merge(list(ds1, ds2))`.
*   **Whitelisting**: Use the `whitelist` or `blacklist` parameters in `simulate_bulk()` to restrict which cell types are included in the pseudo-bulk.

## Reference documentation

- [Getting started with SimBu](./references/SimBu.md)
- [Public Data Integration using Sfaira](./references/sfaira_vignette.md)
- [Inputs and Outputs](./references/simulator_input_output.md)
- [Introducing mRNA bias into simulations with scaling factors](./references/simulator_scaling_factors.md)