---
name: bioconductor-tidytof
description: The tidytof package provides a tidy data interface for analyzing high-dimensional cytometry data within the R ecosystem. Use when user asks to read or write FCS files, preprocess CyTOF data, perform dimensionality reduction, cluster cell populations, or conduct differential discovery analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/tidytof.html
---

# bioconductor-tidytof

name: bioconductor-tidytof
description: Expert guidance for using the tidytof R package for high-dimensional cytometry (CyTOF) data analysis. Use this skill when you need to perform tasks such as reading/writing FCS files, preprocessing (arcsinh transformation), downsampling, dimensionality reduction (PCA, UMAP, tSNE), clustering (FlowSOM, PhenoGraph), differential discovery analysis (DAA/DEA), and building predictive models using a tidy data interface.

# bioconductor-tidytof

## Overview

`tidytof` is a Bioconductor package designed for the analysis of high-dimensional cytometry data (CyTOF) using a "tidy" interface. It organizes data into `tof_tbl` objects (extended tibbles) where each row is a cell and each column is a protein measurement or metadata. The package follows a consistent verb-based syntax: `tof_verb(data, column_spec, method_spec)`.

## Core Workflows

### 1. Data Input and Preprocessing
Read FCS or CSV files into a `tof_tbl` and apply variance-stabilizing transformations.

```r
library(tidytof)

# Read data from a directory or single file
my_data <- tof_read_data("path/to/fcs_files")

# Standard preprocessing: arcsinh transformation (default cofactor = 5)
# and removal of Fluidigm Gaussian noise
preprocessed_data <- my_data |>
    tof_preprocess(channel_cols = where(is.numeric), undo_noise = TRUE)
```

### 2. Cell-Level Operations
Downsample large datasets for tractability and perform dimensionality reduction for visualization.

```r
# Downsample to 1000 cells per sample
downsampled_data <- preprocessed_data |>
    tof_downsample(group_cols = file_name, method = "constant", num_cells = 1000)

# Dimensionality Reduction (tSNE, UMAP, or PCA)
dr_data <- downsampled_data |>
    tof_reduce_dimensions(method = "tsne", cluster_cols = starts_with("cd"))

# Visualization helper
dr_data |>
    tof_plot_cells_embedding(embedding_cols = contains("tsne"), color_col = sample_id)
```

### 3. Clustering and Metaclustering
Identify cell populations using algorithms like PhenoGraph or FlowSOM.

```r
clustered_data <- preprocessed_data |>
    tof_cluster(
        cluster_cols = contains("cd"),
        method = "phenograph",
        num_neighbors = 30
    ) |>
    tof_metacluster(
        cluster_col = .phenograph_cluster,
        method = "kmeans",
        num_metaclusters = 5
    )
```

### 4. Differential Discovery Analysis
Compare cluster abundance (DAA) or marker expression (DEA) across experimental conditions.

```r
# Differential Abundance (e.g., Basal vs Stimulated)
daa_results <- clustered_data |>
    tof_analyze_abundance(
        cluster_col = .phenograph_cluster,
        effect_col = stimulation_status,
        group_cols = patient_id,
        method = "ttest",
        test_type = "paired"
    )

# Differential Expression
dea_results <- clustered_data |>
    tof_analyze_expression(
        cluster_col = .phenograph_cluster,
        marker_cols = c(pStat5, pAkt),
        effect_col = stimulation_status,
        group_cols = patient_id,
        method = "ttest"
    )
```

### 5. Feature Extraction and Modeling
Aggregate single-cell data into sample-level features for predictive machine learning.

```r
# Extract features (proportions and central tendencies)
sample_features <- clustered_data |>
    tof_extract_features(
        cluster_col = .phenograph_cluster,
        group_cols = sample_id,
        lineage_cols = starts_with("cd"),
        signaling_cols = c(pStat5, pS6)
    )

# Train a model (e.g., two-class elastic net)
trained_model <- sample_features |>
    tof_train_model(
        response_col = clinical_outcome,
        predictor_cols = contains("prop"),
        model_type = "two-class"
    )
```

## Key Design Principles
- **Verb Syntax**: Almost all functions take a `tof_tbl` as the first argument, followed by column specifications (using `tidyselect` helpers), then method-specific parameters.
- **Column Naming**: Columns added by `tidytof` (like clusters or embeddings) always start with a dot (e.g., `.phenograph_cluster`) to avoid overwriting raw data.
- **Panel Metadata**: Use `tof_get_panel(my_tof_tbl)` to retrieve metal/antigen mappings stored in the object attributes.

## Reference documentation
- [Clustering and metaclustering](./references/clustering.Rmd)
- [How to contribute code](./references/contributing-to-tidytof.Rmd)
- [Differential discovery analysis](./references/differential-discovery-analysis.Rmd)
- [Dimensionality reduction](./references/dimensionality-reduction.Rmd)
- [Downsampling](./references/downsampling.Rmd)
- [Feature extraction](./references/feature-extraction.Rmd)
- [Building predictive models](./references/modeling.Rmd)
- [Preprocessing](./references/preprocessing.Rmd)
- [Quality control](./references/quality-control.Rmd)
- [Reading and writing data](./references/reading-and-writing-data.Rmd)
- [Getting started with tidytof](./references/tidytof.Rmd)