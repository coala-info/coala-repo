---
name: bioconductor-gdr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/gDR.html
---

# bioconductor-gdr

name: bioconductor-gdr
description: Specialized workflow for processing drug response screening data using the gDR suite. Use this skill when you need to import raw drug screening data (manifests, templates, and results), normalize it, and perform dose-response curve fitting to generate metrics like IC50 and GR50. It is particularly useful for handling SummarizedExperiment and MultiAssayExperiment objects containing BumpyMatrix assays for multi-dimensional drug response data.

# bioconductor-gdr

## Overview

The `gDR` (Genentech Drug Response) suite is a modular R package ecosystem designed to standardize the processing of drug response data. It transforms raw plate reader data and experimental metadata into structured `SummarizedExperiment` or `MultiAssayExperiment` objects. The pipeline handles data aggregation, normalization against controls, averaging of replicates, and curve fitting to calculate standard metrics (e.g., IC50, AOC, GR values).

## Core Workflow

### 1. Data Import and Aggregation
The first step is merging the experimental manifest (metadata), templates (plate layouts), and raw data files into a single long table.

```r
library(gDR)

# Load paths to your files
manifest <- "path/to/manifest.xlsx"
templates <- c("path/to/template1.xlsx", "path/to/template2.xlsx")
results <- c("path/to/raw_data1.xlsx", "path/to/raw_data2.xlsx")

# Create the long merged table
imported_data <- import_data(manifest, templates, results)
```

### 2. Setting Identifiers
`gDR` relies on specific column names (identifiers) to map data correctly. If your column names differ from defaults, use `set_env_identifier`.

```r
# Example: Setting a custom tag for untreated control wells
set_env_identifier("untreated_tag", c("untreated", "control"))

# Check current identifiers
# ?identifiers
```

### 3. Automated Pipeline Execution
The most efficient way to process data is using the wrapper function `runDrugResponseProcessingPipeline`, which handles normalization, averaging, and fitting for all detected data types (single-agent, combination, etc.).

```r
# Returns a MultiAssayExperiment (MAE)
mae <- runDrugResponseProcessingPipeline(imported_data)

# Inspect results
names(mae) # e.g., "single-agent", "combination"
```

### 4. Manual Step-by-Step Processing
For more control, you can run the pipeline stages individually:

```r
# Prepare input and detect data types
inl <- prepare_input(imported_data)

# Create and normalize SummarizedExperiment for a specific data type
se <- create_and_normalize_SE(
  inl$df_list[["single-agent"]],
  data_type = "single-agent",
  nested_confounders = inl$nested_confounders
)

# Average replicates and fit curves
se <- average_SE(se, data_type = "single-agent")
se <- fit_SE(se, data_type = "single-agent")
```

### 5. Extracting Results
To export metrics (like IC50, GR50) into a flat table format for analysis:

```r
# Convert a specific assay (e.g., "Metrics") to a data.table
dt_metrics <- convert_se_assay_to_dt(mae[["single-agent"]], "Metrics")
head(dt_metrics)
```

## Key Data Structures
- **SummarizedExperiment (SE)**: The primary container for a single data type.
- **BumpyMatrix**: Used within SE assays to store multi-dimensional data (e.g., multiple concentration-response points) in a single matrix cell.
- **MultiAssayExperiment (MAE)**: A container that holds multiple SE objects, typically one for each experimental design (e.g., one for single-agent and one for matrix/combination).

## Tips for Success
- **Control Tags**: Ensure your "untreated" or "control" labels in the template match the identifiers set in the environment; otherwise, normalization will fail.
- **Data Types**: `gDR` automatically categorizes data into 'single-agent', 'cotreatment', 'codilution', or 'matrix'. Use `names(mae)` to see what was detected.
- **Visualization**: While this skill focuses on processing, the resulting MAE objects are compatible with the `gDRviz` Shiny app for interactive plotting.

## Reference documentation
- [gDR suite](./references/gDR.Rmd)
- [Running the drug response processing pipeline](./references/gDR.md)