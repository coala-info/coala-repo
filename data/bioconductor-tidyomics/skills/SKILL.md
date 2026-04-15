---
name: bioconductor-tidyomics
description: The tidyomics package provides a unified interface for omics data analysis by bridging Bioconductor data structures with the tidy data philosophy. Use when user asks to manipulate biological objects using tidy verbs, perform genomic range operations, or integrate Bioconductor data with the tidyverse ecosystem.
homepage: https://bioconductor.org/packages/release/bioc/html/tidyomics.html
---

# bioconductor-tidyomics

## Overview

The **tidyomics** package is a metapackage for the Bioconductor ecosystem, similar to how the `tidyverse` package works for CRAN. It provides a unified interface for omics data analysis by bridging Bioconductor's robust data structures (like `SummarizedExperiment` or `SingleCellExperiment`) with the tidy data philosophy. By loading `tidyomics`, users gain access to a suite of tools that allow for data manipulation using familiar verbs like `filter`, `select`, `mutate`, and `inner_join` directly on biological objects.

## Installation and Loading

To install the core ecosystem:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("tidyomics")
```

To load the core packages and check versions:

```r
library(tidyomics)

# List all packages included in the ecosystem
tidyomics_packages()
```

## Core Ecosystem Components

The following packages are automatically attached when loading `tidyomics`:

*   **tidySummarizedExperiment**: Tidy verbs for bulk RNA-seq and other SummarizedExperiment objects.
*   **tidySingleCellExperiment**: Tidy manipulation of SingleCellExperiment objects.
*   **tidySeurat**: Tidy manipulation of Seurat objects.
*   **tidySpatialExperiment**: Tidy manipulation of SpatialExperiment objects.
*   **plyranges**: A tidy DSL for manipulating genomic ranges (GRanges).

## Typical Workflow

1.  **Data Loading**: Load your standard Bioconductor object (e.g., a `.rds` file containing a Seurat or SingleCellExperiment object).
2.  **Tidy Manipulation**: Use `dplyr` verbs directly. The object remains a valid Bioconductor class but behaves like a tibble during manipulation.
    ```r
    # Example: Filtering a SingleCellExperiment object
    sce_filtered <- sce_object %>%
      filter(nFeature_RNA > 500) %>%
      mutate(sample_group = if_else(batch == 1, "Control", "Treatment"))
    ```
3.  **Genomic Operations**: Use `plyranges` for overlap joins or range-based filtering.
    ```r
    # Example: Overlapping genomic ranges
    hits <- peaks %>%
      join_overlap_inner(promoters)
    ```
4.  **Analysis**: Use specialized analysis packages within the ecosystem like `tidybulk` for differential expression or `nullranges` for generating null sets.

## Tips for Success

*   **Conflicts**: Loading `tidyomics` may result in function conflicts (e.g., `filter` from `dplyr` vs `stats`). The package summary upon loading will highlight these. Use `package::function()` syntax if behavior is unexpected.
*   **Object Integrity**: Even though you use tidy verbs, the underlying object retains its biological slots (assays, rowData, colData). You do not need to convert back and forth between tibbles and Bioconductor objects.
*   **Additional Packages**: Some specialized tools like `tidybulk`, `nullranges`, and `plyinteractions` are part of the ecosystem but may need to be installed and loaded separately if not included in the current core version.

## Reference documentation

- [Loading the tidyomics ecosystem (Rmd)](./references/loading-tidyomics.Rmd)
- [Loading the tidyomics ecosystem (Markdown)](./references/loading-tidyomics.md)