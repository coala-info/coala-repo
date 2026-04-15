---
name: bioconductor-hdcytodata
description: This package provides programmatic access to high-dimensional cytometry benchmark datasets formatted as SummarizedExperiment or flowSet objects. Use when user asks to load standardized flow or mass cytometry data, benchmark clustering or differential analysis algorithms, or access ground-truth cell population labels for single-cell proteomics.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HDCytoData.html
---

# bioconductor-hdcytodata

name: bioconductor-hdcytodata
description: Access and use high-dimensional cytometry benchmark datasets (flow and mass cytometry/CyTOF) from the HDCytoData Bioconductor package. Use this skill when you need to load standardized SummarizedExperiment or flowSet objects for benchmarking clustering, dimension reduction, or differential analysis algorithms.

# bioconductor-hdcytodata

## Overview
HDCytoData provides programmatic access to a collection of publicly available high-dimensional cytometry benchmark datasets. These datasets are hosted on Bioconductor's ExperimentHub and are formatted into standard R/Bioconductor objects (`SummarizedExperiment` and `flowSet`). They include essential metadata such as sample IDs, group IDs, and ground-truth cell population labels, making them ideal for evaluating computational methods in single-cell proteomics.

## Loading Datasets
Datasets can be loaded using specific named functions or via ExperimentHub IDs.

### Using Named Functions (Recommended)
Each dataset has a dedicated function ending in `_SE()` for SummarizedExperiment or `_flowSet()` for flowSet objects.

```r
library(HDCytoData)

# Load a clustering benchmark dataset
se <- Levine_32dim_SE()
fs <- Levine_32dim_flowSet()

# Load a differential analysis benchmark dataset
se_da <- Bodenmiller_BCR_XL_SE()
```

### Programmatic Discovery
To list all available datasets and their metadata:

```r
library(ExperimentHub)
ehub <- ExperimentHub()
query(ehub, "HDCytoData")
```

## Typical Workflow

### 1. Data Preprocessing
Raw expression values in these datasets must be transformed before analysis. The standard transformation is `asinh` with a cofactor (5 for CyTOF, 150 for flow cytometry).

```r
# Extract expression matrix
d_sub <- assay(se)

# Apply asinh transformation (cofactor 5 for CyTOF)
cofactor <- 5
d_sub <- asinh(d_sub / cofactor)
```

### 2. Accessing Metadata
Metadata is stored in the `rowData` (cell-level), `colData` (marker-level), and `metadata` (experiment-level) slots of the SummarizedExperiment.

```r
# Cell population labels (ground truth)
labels <- rowData(se)$population_id

# Marker classes (e.g., 'type' for clustering, 'state' for signaling)
marker_info <- colData(se)
type_markers <- marker_info$marker_name[marker_info$marker_class == "type"]

# Sample/Group information
sample_info <- metadata(se)$experiment_info
```

### 3. Dimension Reduction and Clustering
Use the transformed data for downstream tasks.

```r
# Example: PCA on 'type' markers
d_type <- d_sub[, colData(se)$marker_class == "type"]
pca_res <- prcomp(d_type, center = TRUE, scale. = FALSE)
```

## Available Datasets
- **Clustering:** `Levine_32dim`, `Levine_13dim`, `Samusik_01`, `Samusik_all`, `Nilsson_rare`, `Mosmann_rare`.
- **Differential Analysis:** `Krieg_Anti_PD_1`, `Bodenmiller_BCR_XL`, `Weber_AML_sim`, `Weber_BCR_XL_sim`.

## Tips
- **Memory Management:** Some datasets (e.g., `Samusik_all`) are large. Use `ExperimentHub::removeCache()` if you need to clear local storage.
- **Marker Selection:** Always check `colData(se)$marker_class` to distinguish between biological markers and non-protein columns (like `Time` or `Event_length`).
- **Object Choice:** Use `SummarizedExperiment` for most Bioconductor-native workflows (e.g., `diffcyt`, `iSEE`) and `flowSet` for legacy `flowCore` based tools.

## Reference documentation
- [Contribution guidelines](./references/Contribution_guidelines.md)
- [Examples and use cases](./references/Examples_and_use_cases.md)
- [HDCytoData package](./references/HDCytoData_package.md)