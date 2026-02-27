---
name: bioconductor-scp
description: The bioconductor-scp package provides a standardized framework for processing and analyzing single-cell proteomics data within the QFeatures and SingleCellExperiment ecosystems. Use when user asks to ingest quantitative proteomics tables, normalize peptide intensities, aggregate features from PSMs to proteins, or filter missing values in single-cell proteomics assays.
homepage: https://bioconductor.org/packages/release/bioc/html/scp.html
---


# bioconductor-scp

## Overview

The `scp` package is a Bioconductor extension of `QFeatures` designed specifically for single-cell proteomics. It provides a standardized framework for handling the hierarchical nature of proteomics data (PSMs -> Peptides -> Proteins) while integrating with the `SingleCellExperiment` ecosystem. It is optimized for handling data acquired across multiple MS batches, supporting both multiplexed (TMT) and label-free workflows.

## Core Workflows

### 1. Data Ingestion
The primary entry point is `readSCP()`. It requires two inputs: a quantitative table (e.g., MaxQuant `evidence.txt`) and a sample annotation table.

```r
library(scp)

# Load raw data and annotations
data("mqScpData")
data("sampleAnnotation")

# Create QFeatures object
# runCol: column in mqScpData identifying the MS run
# quantCols: column in sampleAnnotation identifying the intensity columns
scp <- readSCP(assayData = mqScpData,
               colData = sampleAnnotation,
               runCol = "Raw.file",
               removeEmptyCols = TRUE)
```

### 2. Data Access and Subsetting
`scp` objects (QFeatures) support three-index subsetting: `[features, samples, assays]`.

*   **Access Assays:** `names(scp)` to list, `assay(scp, "assay_name")` to extract matrix.
*   **Metadata:** `colData(scp)` for sample info, `rowData(scp[["assay"]])` for feature info.
*   **Subsetting:**
    ```r
    # Subset by sample type in colData
    macrophages <- scp[, scp$SampleType == "Macrophage", ]
    
    # Subset by feature (automatically includes linked peptides/PSMs)
    protein_x <- scp["Protein_ID", , ]
    ```

### 3. Processing Steps
Common processing functions usually require the `i` argument to specify which assay(s) to process.

*   **Missing Values:** Convert zeros to NA using `zeroIsNa(scp, i = "peptides")`.
*   **Filtering:** Use `filterFeatures(scp, ~ Reverse != "+")` to remove contaminants or `filterNA(scp, i = "proteins", pNA = 0.7)` to filter by missingness.
*   **Normalization:** `normalize(scp, i = "peptides", method = "center.median", name = "peptides_norm")`.
*   **Log Transformation:** `logTransform(scp, i = "peptides", name = "peptides_log")`.
*   **Aggregation:** Combine PSMs into peptides or peptides into proteins.
    ```r
    scp <- aggregateFeatures(scp, i = "peptides", fcol = "protein", 
                             name = "proteins", fun = MsCoreUtils::robustSummary)
    ```

### 4. Advanced Manipulation
For custom operations not covered by wrappers, extract the assay as a `SingleCellExperiment` with its associated `colData`.

```r
# Extract with sample metadata
sce <- getWithColData(scp, "proteins")

# Perform custom calculation on assay(sce)
# ...

# Add back as a new assay
scp <- addAssay(scp, sce, name = "custom_assay")
scp <- addAssayLinkOneToOne(scp, from = "proteins", to = "custom_assay")
```

## Tips for Success
*   **Regex Selection:** When dealing with hundreds of MS runs, use regex for the `i` argument (e.g., `i = grep("Batch_A", names(scp))`).
*   **Validity Checks:** After manual modifications, always run `validObject(scp)` to ensure the hierarchical links between assays remain intact.
*   **Long Form:** Use `longForm(scp)` to flatten the data for visualization with `ggplot2`.

## Reference documentation

- [QFeatures in a nutshell](./references/QFeatures_nutshell.md)
- [Advanced usage of scp](./references/advanced.md)
- [Load data using readSCP](./references/read_scp.md)
- [Reporting missing values](./references/reporting_missing_values.md)
- [scp package overview](./references/scp.md)
- [Single-cell proteomics data modelling](./references/scp_data_modelling.md)