---
name: bioconductor-gdrtestdata
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/gDRtestData.html
---

# bioconductor-gdrtestdata

## Overview

The `gDRtestData` package provides a standardized framework for generating synthetic drug response data. It is a foundational component of the `gDR` suite, allowing developers and researchers to create reproducible test datasets that mimic real-world experimental layouts, including single-agent, combination, and co-dilution studies. It also provides access to pre-processed example data stored as `MultiAssayExperiment` objects.

## Synthetic Data Generation Workflow

The generation of synthetic data follows a tiered approach, starting from basic entities and building up to full response data.

### 1. Create Base Entities
Generate the fundamental building blocks: cell lines and drugs.
```r
library(gDRtestData)

cell_lines <- create_synthetic_cell_lines()
drugs <- create_synthetic_drugs()
```

### 2. Prepare Experimental Layout
Combine entities and add experimental parameters like replicates and concentrations.
```r
# Combine both steps into a single layout data.table
df_layout <- prepareData(cell_lines, drugs)

# Optional: Add Day 0 (baseline) data
df_layout$Duration <- 72
df_layout$ReadoutValue <- 0
df_layout_with_Day0 <- add_day0_data(df_layout)
```

### 3. Generate Full Response Data
Create datasets containing simulated readout values (e.g., viability) based on different experimental designs.
```r
# Single-agent response data
response_single <- prepareMergedData(cell_lines, drugs)

# Combination therapy response data
response_combo <- prepareComboMergedData(cell_lines, drugs)

# Co-dilution response data
response_codilution <- prepareCodilutionData(cell_lines, drugs)
```

## Accessing Pre-computed Test Data

The package includes several pre-defined datasets (stored as `.qs` files in the package installation directory) that represent the `gDR` data model.

### Available Synthetic Datasets
Commonly used identifiers for pre-computed data include:
- `small`, `small_no_noise`: Basic small datasets.
- `combo_matrix`, `combo_triple`: Complex combination experiments.
- `combo_codilution`: Co-dilution specific data.
- `wLigand`: Experiments involving ligands.

### Loading Example Data
To use these in testing, you typically reference them by name within the `gDR` suite or locate them via `system.file`:
```r
yml_path <- system.file("testdata", "synthetic_list.yml", package = "gDRtestData")
datasets <- yaml::read_yaml(yml_path)
names(datasets) # List available dataset keys
```

## Summary of Key Functions

| Function | Purpose |
| :--- | :--- |
| `create_synthetic_cell_lines()` | Generates a data.table of mock cell lines. |
| `create_synthetic_drugs()` | Generates a data.table of mock drugs. |
| `prepareData()` | Merges cell lines and drugs with replicates and concentrations. |
| `prepareMergedData()` | Generates full single-agent response data. |
| `prepareComboMergedData()` | Generates full combination response data. |
| `generate_hill_coef()` | Generates synthetic Hill coefficients for metrics testing. |
| `add_day0_data()` | Appends baseline (Day 0) observations to a dataset. |

## Reference documentation

- [gDRtestData Vignette (Rmd)](./references/gDRtestData.Rmd)
- [gDRtestData Vignette (Markdown)](./references/gDRtestData.md)