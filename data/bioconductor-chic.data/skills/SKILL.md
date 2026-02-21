---
name: bioconductor-chic.data
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/ChIC.data.html
---

# bioconductor-chic.data

## Overview
The `ChIC.data` package serves as the data companion to the `ChIC` (ChIP-seq Quality Control) package. It provides essential reference datasets, including quality control metrics from thousands of ENCODE and Roadmap Epigenomics samples, averaged metagene profiles for various histone marks and transcription factors, and pre-trained Random Forest models for automated experiment classification.

## Loading Data
To use the datasets, first load the library and then use the `data()` function to load specific objects into the R environment.

```r
library(ChIC.data)

# Load the histone mark compendium
data(compendium_db)

# Load pre-trained RF models
data(rf_models)
```

## Key Datasets

### Reference Compendia
These datasets contain QC metrics and metadata for thousands of analyzed samples, used as a baseline for comparison.
- `compendium_db`: Metrics for 2,329 histone mark samples (ENCODE/Roadmap).
- `compendium_db_tf`: Metrics for 1,427 transcription factor samples (ENCODE).

### Metagene Profiles
Averaged signal intensity profiles used to visualize expected enrichment patterns.
- `compendium_profiles`: Profiles for chromatin marks (e.g., H3K4me3, H3K27ac).
- `compendium_profiles_TF`: Profiles for transcription factors (e.g., CTCF, MYC).

### Classification Models
Pre-trained Random Forest models (`rf_models`) used by the `ChIC` package to classify ChIP-seq experiments into categories:
- `broadEncode`: For broad binding marks.
- `sharpEncode`: For sharp binding marks.
- `TFmodel`: For transcription factors.
- Specific models for `H3K9me3`, `H3K27me3`, `H3K36me3`, and `RNAPol2`.

### Annotation and Genomic Info
- `hg19_chrom_info` / `mm9_chrom_info`: Chromosome start/end positions.
- `hg19_refseq_genes_filtered_granges` / `mm9_refseq_genes_filtered_granges`: Filtered gene annotations in GRanges format.
- `classesDefList`: Definitions for chromatin marks and TFs, categorizing them into "sharp" or "broad" binding classes.

## Typical Workflow
1. **Initialize Analysis**: Load `classesDefList` to identify the binding characteristics (sharp vs. broad) of your target protein.
2. **QC Comparison**: Use `compendium_db` or `compendium_db_tf` as the reference population when running `ChIC` functions like `qualityControl_ChIC()`.
3. **Profile Validation**: Compare local metagene profiles against the "gold standard" averages in `compendium_profiles`.
4. **Automated Scoring**: Apply the `rf_models` to calculate a probability score for the quality of a new ChIP-seq experiment.

## Reference documentation
- [ChIC.data Reference Manual](./references/reference_manual.md)