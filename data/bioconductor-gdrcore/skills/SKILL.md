---
name: bioconductor-gdrcore
description: The package provides tools for normalizing, averaging, and calculation of gDR metrics data. All core functions are wrapped into the pipeline function allowing analyzing the data in a straightforward way.
homepage: https://bioconductor.org/packages/release/bioc/html/gDRcore.html
---

# bioconductor-gdrcore

name: bioconductor-gdrcore
description: Tools for normalizing, averaging, and calculating drug response metrics (gDR). Use when you need to process drug sensitivity data, perform dose-response curve fitting, calculate synergy scores for drug combinations, or manage MultiAssayExperiment (MAE) objects containing drug response assays.

# bioconductor-gdrcore

## Overview

The `gDRcore` package is the central processing engine of the gDR suite. It transforms raw drug response data into standardized `MultiAssayExperiment` (MAE) objects. It handles data normalization (Relative Viability and GR values), replicate averaging, and curve fitting for both single-agent and combination experiments.

## Core Workflow

### 1. Data Preparation and Annotation
Before running the pipeline, data must be merged into a long `data.table` and annotated with drug and cell line metadata.

```r
library(gDRcore)
library(gDRimport)

# Load raw data components (Manifest, Template, Results)
# Usually handled via gDRimport::load_data()
loaded_data <- gDRimport::load_data(manifest_path, template_path, result_path)

# Merge into a single data.table
input_df <- merge_data(loaded_data$manifest, loaded_data$treatments, loaded_data$data)

# Optional: Cleanup and annotate metadata if reference databases are set
# annotated_df <- cleanup_metadata(input_df)
```

### 2. Running the Processing Pipeline
The `runDrugResponseProcessingPipeline` function is the primary wrapper that executes the full suite of processing steps.

```r
# Execute full pipeline: create SE -> normalize -> average -> fit
mae <- runDrugResponseProcessingPipeline(input_df)

# Inspect the resulting MultiAssayExperiment
print(mae)
experiments(mae)
```

### 3. Accessing Results
The pipeline produces `SummarizedExperiment` (SE) objects within the MAE, typically split by experiment type (e.g., "single-agent", "combination").

```r
# Extract a specific experiment
se <- mae[["single-agent"]]

# List available assays
# Common: RawTreated, Controls, Normalized, Averaged, Metrics
SummarizedExperiment::assayNames(se)

# Convert an assay to a data.table for analysis
dt_metrics <- gDRutils::convert_se_assay_to_dt(se, "Metrics")
```

## Key Functions

- `runDrugResponseProcessingPipeline()`: The all-in-one wrapper for data processing.
- `create_SE()`: Initializes the SE structure and dispatches raw/control data.
- `normalize_SE()`: Calculates Relative Viability and GR values.
- `average_SE()`: Averages technical replicates.
- `fit_SE()`: Fits dose-response curves and calculates metrics (IC50, GR50, etc.).
- `cleanup_metadata()`: Standardizes column names and adds drug/cell-line annotations.

## Data Model Details

- **MAE Structure**: Columns represent cell lines (colData); Rows represent treatments (rowData).
- **Assays**: Stored as `BumpyMatrix` objects where each cell contains a nested table of dose-response data.
- **Normalization Types**: By default, the package calculates both `RelativeViability` and `GRValues`.

## Annotation Requirements

If providing custom annotation files, ensure the following fields are present:
- **Drugs**: `Gnumber`, `DrugName`, `drug_moa`.
- **Cell Lines**: `clid`, `CellLineName`, `Tissue`, `ReferenceDivisionTime`.

Set paths via environment variables if not using default `gDRtestData`:
```r
Sys.setenv(GDR_CELLLINE_ANNOTATION = "path/to/cell_lines.csv")
Sys.setenv(GDR_DRUG_ANNOTATION = "path/to/drugs.csv")
```

## Reference documentation

- [gDR annotation](./references/gDR-annotation.md)
- [gDR data model](./references/gDR-data-model.md)
- [gDRcore pipeline overview](./references/gDRcore.md)