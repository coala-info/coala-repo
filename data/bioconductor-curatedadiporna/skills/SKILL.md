---
name: bioconductor-curatedadiporna
description: This package provides a curated, multi-study RNA-Seq dataset of 3T3-L1 adipocyte differentiation in a RangedSummarizedExperiment object. Use when user asks to access gene expression data for adipocytes, analyze RNA-Seq time-course studies, or perform differential expression analysis on curated 3T3-L1 datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedAdipoRNA.html
---

# bioconductor-curatedadiporna

## Overview
The `curatedAdipoRNA` package provides a curated, multi-study RNA-Seq dataset of 3T3-L1 pre-adipocytes induced with MDI (Methylisobutylxanthine, Dexamethasone, Insulin). It consolidates 98 samples from 16 different studies into a single `RangedSummarizedExperiment` object. This skill enables the exploration of gene expression changes across various time points and stages of adipocyte differentiation.

## Loading the Dataset
The primary data object is `adipo_counts`. It contains gene counts, sample metadata (phenotype data), genomic ranges for features, and study-level metadata.

```r
library(curatedAdipoRNA)
library(SummarizedExperiment)

# Load the curated dataset
data("adipo_counts")

# Inspect the object
adipo_counts
```

## Data Structure and Access
The `adipo_counts` object follows the standard `SummarizedExperiment` structure:

*   **Assays**: Use `assay(adipo_counts)` to access the raw gene count matrix.
*   **Column Data (Metadata)**: Use `colData(adipo_counts)` to access sample information. Key columns include:
    *   `time`: Time point in hours (from -96 to 240).
    *   `stage`: Differentiation stage (0: non-differentiated, 1: differentiating, 2/3: maturating).
    *   `study_name`: GEO series identifier.
    *   `qc`: A list containing `fastqc` quality metrics for each run.
*   **Row Data**: Use `rowRanges(adipo_counts)` to get genomic coordinates (mm10) for the genes.
*   **Metadata**: Use `metadata(adipo_counts)$studies` to access bibliographic information for the source studies.

## Typical Workflow: Differential Expression
A common use case is comparing different time points using `DESeq2`.

### 1. Subset and Filter
It is recommended to filter low-count genes and potentially low-quality samples identified in the `qc` metadata.

```r
# Subset to specific time points (e.g., 0 vs 24 hours)
se <- adipo_counts[, adipo_counts$time %in% c(0, 24)]

# Filter genes with low counts (e.g., at least 10 reads in 2+ samples)
keep <- rowSums(assay(se) > 10) >= 2
se <- se[keep, ]
```

### 2. Run DESeq2
Since the data comes from multiple studies, consider including `study_name` or `library_layout` in the design formula to account for batch effects.

```r
library(DESeq2)

# Create DESeqDataSet
se$time <- factor(se$time)
dds <- DESeqDataSet(se, design = ~time)

# Run analysis
dds <- DESeq(dds)
res <- results(dds)
```

## Quality Control
The `qc` column in `colData` contains `qc_read` objects. You can extract specific metrics like per-base sequence quality using the `fastqcr` package or standard list manipulation.

```r
# Access QC for the first sample
sample_qc <- adipo_counts$qc[[1]]
```

## Tips
*   **Batch Effects**: Always check for study-specific clustering using PCA (`plotPCA`). The dataset is highly heterogeneous due to different sequencing platforms and protocols.
*   **Time Course**: While often treated as categorical, the `time` variable allows for continuous time-course modeling.
*   **Gene IDs**: The rownames are gene symbols, but `gene_id` is also available in the `rowData`.

## Reference documentation
- [Using curatedAdipoRNA](./references/curatedadiporna_vignette.Rmd)
- [Using curatedAdipoRNA (Markdown)](./references/curatedadiporna_vignette.md)