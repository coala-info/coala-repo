---
name: bioconductor-methylseqdata
description: This package provides a streamlined way to load publicly available DNA methylation datasets as formatted SummarizedExperiment objects in R. Use when user asks to list available methylation datasets, download specific DNA methylation studies, or load pre-processed methylation count matrices for downstream analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MethylSeqData.html
---

# bioconductor-methylseqdata

## Overview
The `MethylSeqData` package provides a streamlined way to load publicly available DNA methylation datasets into R. Instead of manual data munging of raw count matrices, this package delivers well-formed `SummarizedExperiment` (or `RangedSummarizedExperiment`) objects. These objects typically contain methylation counts (`M`) and coverage (`Cov`) assays, along with comprehensive sample metadata (`colData`).

## Typical Workflow

### 1. List Available Datasets
To see which datasets are currently available in the package, use the `listDatasets()` function. This returns a data frame containing the reference, taxonomy, tissue type, and the specific R function call needed to load the data.

```r
library(MethylSeqData)
available_data <- listDatasets()
print(available_data)
```

### 2. Loading Specific Datasets
Each dataset is retrieved via a dedicated wrapper function. These functions download the data from ExperimentHub and assemble the object.

*   **Human Brain Data (Rizzardi et al., 2019):**
    Focuses on neuronal brain-region-specific DNA methylation.
    ```r
    brain_se <- RizzardiHickeyBrain()
    ```

*   **Mouse Mammary Gland Data (Chen et al., 2018):**
    RRBS data used for differential methylation analysis.
    ```r
    mammary_se <- ChenMammaryData()
    ```

### 3. Inspecting the Data
Once loaded, the data is stored as a `SummarizedExperiment`. You can interact with it using standard Bioconductor methods:

```r
# View assays (typically 'M' for Methylated counts and 'Cov' for Total Coverage)
assayNames(brain_se)

# Access methylation counts
m_counts <- assay(brain_se, "M")

# Access sample metadata
sample_info <- colData(brain_se)

# Check genomic coordinates (if RangedSummarizedExperiment)
rowRanges(brain_se)
```

## Usage Tips
*   **ExperimentHub Dependency:** This package relies on `ExperimentHub`. The first time you call a data-loading function, it will download the data and cache it locally. Subsequent calls will be much faster.
*   **Downstream Analysis:** The objects returned are compatible with major methylation analysis packages such as `bsseq`, `edgeR` (for RRBS), and `minfi` (if converted).
*   **Memory Management:** Some datasets (like the Rizzardi Brain data) are quite large. Ensure your R session has sufficient RAM or consider subsetting the object immediately after loading if you only need specific chromosomes or cell types.

## Reference documentation
- [Overview of the MethylSeqData dataset collection](./references/MethylSeqData.md)