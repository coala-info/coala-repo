---
name: bioconductor-chromstardata
description: This package provides curated ChIP-seq and expression datasets from the EURATRANS project for demonstrating chromstaR package functionality. Use when user asks to access example ChIP-seq BED files, load rat genomic information, or retrieve experiment tables and expression data for chromatin state analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/chromstaRData.html
---


# bioconductor-chromstardata

## Overview
The `chromstaRData` package provides a collection of ChIP-seq and expression datasets specifically curated for demonstrating the functionality of the `chromstaR` package. The data is derived from the EURATRANS project, focusing on left-ventricle (lv) heart tissue in Brown Norway (BN) and Spontaneous Hypertensive Rat (SHR) strains. To keep file sizes manageable, ChIP-seq data is downsampled to chromosome 12 (chr12).

## Data Access and Usage

### Loading the Package
```r
library(chromstaRData)
```

### Experiment Tables
These tables are pre-formatted data frames used to define the relationship between files, histone marks, and conditions for `chromstaR` workflows.

*   **`experiment_table`**: General experiment data table for EURATRANS examples.
*   **`experiment_table_H4K20me1`**: Specific table for H4K20me1 histone mark examples.
*   **`experiment_table_SHR`**: Specific table for SHR strain examples.

**Structure:**
Columns include `file`, `mark`, `condition`, `replicate`, and `pairedEndReads`.

```r
data(experiment_table)
head(experiment_table)
```

### Genomic Information
*   **`rn4_chrominfo`**: Contains chromosome names and lengths for the rat assembly `rn4`. This is essential for binning and genome-wide analysis.

```r
data(rn4_chrominfo)
```

### Expression Data
*   **`expression_lv`**: A data frame containing expression values for left-ventricle heart tissue.
*   **Columns**: `ensembl_gene_id`, `expression_BN`, and `expression_SHR`.
*   **Usage**: Often used to correlate chromatin states with gene expression levels.

```r
data(expression_lv)
```

### Locating Raw BED Files
The package includes actual BED files containing aligned reads. Since these are stored in the package installation directory, use `system.file` to retrieve their paths.

```r
# Get the path to the directory containing the BED files
datafolder <- system.file("extdata", "multivariate", package = "chromstaRData")

# List available BED files
list.files(datafolder, pattern = "\\.bed.gz$")
```

## Typical Workflow Example
This data is typically used as input for `chromstaR` functions:

1.  **Load the experiment table**: `data(experiment_table)`
2.  **Update file paths**: The `file` column in the experiment table usually needs the full system path.
    ```r
    datafolder <- system.file("extdata", "multivariate", package = "chromstaRData")
    experiment_table$file <- file.path(datafolder, experiment_table$file)
    ```
3.  **Run chromstaR**: Use the prepared table and `rn4_chrominfo` to perform peak calling or chromatin state induction.

## Reference documentation
- [chromstaRData Reference Manual](./references/reference_manual.md)