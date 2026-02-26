---
name: bioconductor-hmp2data
description: The HMP2Data package provides streamlined access to processed longitudinal data from the second phase of the Human Microbiome Project in standard Bioconductor containers. Use when user asks to access 16S rRNA sequencing or host cytokine data from MOMS-PI, IBD, or T2D studies, load microbiome data into phyloseq or MultiAssayExperiment objects, or generate summary tables for HMP2 datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/HMP2Data.html
---


# bioconductor-hmp2data

## Overview
The `HMP2Data` package provides streamlined access to processed data from the second phase of the Human Microbiome Project (HMP2). It organizes complex longitudinal data—including 16S rRNA sequencing and host cytokine profiles—into standard Bioconductor containers. This allows for immediate integration with analysis tools like `phyloseq` and `MultiAssayExperiment`.

## Installation
```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("HMP2Data")
```

## Core Workflows

### Loading Study Data
The package provides helper functions to instantiate complex objects (phyloseq or SummarizedExperiment) directly.

**MOMS-PI (Pregnancy & Preterm Birth)**
*   **16S Data:** `momspi16S()` returns a `phyloseq` object (Greengenes taxonomy).
*   **Cytokines:** `momspiCytokines()` returns a `SummarizedExperiment`.
*   **Integrated:** `momspiMultiAssay()` returns a `MultiAssayExperiment` combining both.

**IBD (Inflammatory Bowel Disease)**
*   **16S Data:** `IBD16S()` returns a `phyloseq` object (SILVA taxonomy).

**T2D (Type 2 Diabetes)**
*   **16S Data:** `T2D16S()` returns a `phyloseq` object (Greengenes taxonomy).

### Accessing Raw Matrices
If you prefer working with base R matrices instead of S4 objects, use the `data()` command:
```r
# MOMS-PI 16S
data("momspi16S_mtx")  # Abundance matrix
data("momspi16S_tax")  # Taxonomy matrix
data("momspi16S_samp") # Sample metadata

# IBD 16S
data("IBD16S_mtx")
data("IBD16S_tax")
data("IBD16S_samp")

# T2D 16S
data("T2D16S_mtx")
data("T2D16S_tax")
data("T2D16S_samp")
```

### Data Summarization
The package includes utility functions to generate summary tables across the different studies:
*   `table_two(list_of_objects)`: Summarizes sample-level annotations (Body Site, Sex, Race).
*   `visit_table(list_of_objects)`: Summarizes sample distribution by visit number quantiles.
*   `patient_table(list_of_objects)`: Summarizes patient-level characteristics.

### Working with MultiAssayExperiment
For MOMS-PI data, use `MultiAssayExperiment` to manage multi-omics samples:
```r
mae <- momspiMultiAssay()

# Extract specific assays
rRNA <- mae[[1L]]
cyto <- mae[[2L]]

# Keep only samples present in both 16S and Cytokine assays
complete_mae <- MultiAssayExperiment::intersectColumns(mae)
```

## Data Export
To export data for use outside of R (e.g., Python or STATA):
```r
library(readr)
# For SummarizedExperiment (Cytokines)
write_csv(as.data.frame(assay(momspiCyto)), "cytokines.csv")
write_csv(as.data.frame(colData(momspiCyto)), "metadata.csv")

# For phyloseq (16S)
write_csv(as.data.frame(otu_table(momspi16S_phyloseq)), "otu_counts.csv")
```

## Reference documentation
- [HMP2Data Vignette (Rmd)](./references/hmp2data.Rmd)
- [HMP2Data Vignette (Markdown)](./references/hmp2data.md)