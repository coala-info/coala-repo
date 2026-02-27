---
name: bioconductor-curatedadipochip
description: This package provides access to a curated ChIP-Seq dataset of differentiated adipocytes stored as RangedSummarizedExperiment objects. Use when user asks to retrieve peak counts, access sample metadata for 3T3-L1 cells, or perform differential binding analysis on adipocyte transcription factors and histone modifications.
homepage: https://bioconductor.org/packages/release/data/experiment/html/curatedAdipoChIP.html
---


# bioconductor-curatedadipochip

name: bioconductor-curatedadipochip
description: Access and analyze a curated ChIP-Seq dataset of MDI-induced differentiated adipocytes (3T3-L1). Use this skill to retrieve RangedSummarizedExperiment objects containing peak counts, sample metadata, and genomic annotations for transcription factors, chromatin remodelers, and histone modifications across various differentiation stages.

# bioconductor-curatedadipochip

## Overview
The `curatedAdipoChIP` package provides a curated collection of ChIP-Seq data from 3T3-L1 pre-adipocytes at various stages of differentiation. It includes data for transcription factors, chromatin remodelers, and histone modifications. The data is distributed as a `RangedSummarizedExperiment` object via `ExperimentHub`, facilitating differential binding and gene set enrichment analyses.

## Installation
Install the package using `BiocManager`:

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("curatedAdipoChIP")

## Data Retrieval
Access the dataset through `ExperimentHub`. The package acts as a portal to the hosted data.

library(ExperimentHub)
library(SummarizedExperiment)

eh <- ExperimentHub()
query(eh, "curatedAdipoChIP")
# Retrieve the RangedSummarizedExperiment object
peak_counts <- query(eh, "curatedAdipoChIP")[[1]]

## Data Exploration
The retrieved object contains counts, sample metadata, and genomic ranges.

# Access count matrix
counts <- assay(peak_counts)

# Access sample metadata (phenotype data)
sample_info <- colData(peak_counts)
# Key columns: factor (antibody), time (hours), stage (0-3), study (SRA ID)

# Access genomic features and annotations
peaks <- rowRanges(peak_counts)
# Includes annotations like geneId, distanceToTSS, and genomic feature (Promoter, Exon, etc.)

## Typical Workflow: Differential Binding Analysis
Follow these steps to perform a differential binding analysis using `DESeq2`.

1. **Subset the Data**
Filter the object for specific factors (e.g., CEBPB) and stages of interest.

# Select CEBPB samples at stage 0 and 1
idx <- peak_counts$factor == 'CEBPB' & peak_counts$stage %in% c(0, 1)
se_subset <- peak_counts[, idx]

2. **Filter Low Counts**
Remove peaks with low read counts to improve statistical power.

keep <- rowSums(assay(se_subset) > 10) >= 2
se_filtered <- se_subset[keep, ]

3. **Run DESeq2**
Convert the object for `DESeq2` and run the analysis.

library(DESeq2)
# Ensure stage is a factor
se_filtered$stage <- factor(se_filtered$stage)
dds <- DESeqDataSet(se_filtered, design = ~stage)
dds <- DESeq(dds)
res <- results(dds)

## Quality Control
The `colData` contains a `qc` column with `fastqc` results. Use the `fastqcr` package to inspect these metrics if detailed run-level quality assessment is required.

# Example: Extracting QC list
qc_data <- peak_counts$qc

## Tips for Analysis
- **Batch Effects**: Since data is aggregated from multiple studies, use the `study`, `library_layout`, or `instrument_model` columns in `colData` to account for batch effects using tools like `SVA` or `RUV`.
- **Control Samples**: Use the `control_id` column to identify which samples served as inputs/controls for specific ChIP runs.
- **Annotations**: Genomic annotations (nearest gene, distance to TSS) are pre-computed using `ChIPSeeker` and available in the `rowRanges`.

## Reference documentation
- [Using curatedAdipoChIP](./references/curatedAdipoChIP.Rmd)
- [curatedAdipoChIP Vignette](./references/curatedAdipoChIP.md)