---
name: bioconductor-roar
description: This tool identifies differential alternative poly-adenylation usage from RNA-seq data by comparing the prevalence of short versus long 3'UTR isoforms between two biological conditions. Use when user asks to identify alternative poly-adenylation sites, detect 3'UTR shortening or lengthening, or calculate roar values from BAM files.
homepage: https://bioconductor.org/packages/release/bioc/html/roar.html
---


# bioconductor-roar

name: bioconductor-roar
description: Identify differential Alternative Poly-Adenylation (APA) usage from RNA-seq data using the roar (ratio of a ratio) method. Use this skill when you need to compare the prevalence of short vs. long 3'UTR isoforms between two biological conditions (e.g., treatment vs. control) using BAM alignment files and APA site annotations.

# bioconductor-roar

## Overview

The `roar` package detects preferential usage of shorter isoforms caused by alternative poly-adenylation. It calculates a "ratio of a ratio": the prevalence of the short isoform over the long one in two conditions, and then the ratio between those two values. It uses a Fisher test to detect significant shifts (shortening or lengthening) in 3'UTR usage.

## Core Workflow

### 1. Data Preparation
You need BAM files for two conditions and an annotation file (GTF or GRanges) defining the "PRE" (common to both isoforms) and "POST" (unique to the long isoform) regions.

```R
library(roar)

# Define annotation and BAM files
gtf_path <- "path/to/apa_annotation.gtf"
treatment_bams <- c("treat1.bam", "treat2.bam")
control_bams <- c("ctrl1.bam", "ctrl2.bam")

# Create the RoarDataset
rds <- RoarDatasetFromFiles(treatment_bams, control_bams, gtf_path)
```

### 2. Counting and Computing Roar
The analysis follows a step-by-step progression, though calling high-level result functions will trigger preceding steps automatically.

```R
# 1. Count reads in PRE/POST regions (stranded=TRUE/FALSE)
rds <- countPrePost(rds, stranded = FALSE)

# 2. Compute m/M ratios and the final roar value
# roar > 1: Shortening in treatment; roar < 1: Lengthening in treatment
rds <- computeRoars(rds)

# 3. Compute p-values via Fisher test
rds <- computePvals(rds)
```

### 3. Extracting Results
Results can be filtered by expression (FPKM) or significance.

```R
# Get all results
res <- totalResults(rds)

# Filter results: requires minimum expression and significance
# nUnderCutoff indicates how many sample-wise comparisons passed the pvalCutoff
filtered_res <- pvalueFilter(rds, fpkmCutoff = 1, pvalCutoff = 0.05)
```

## Advanced Usage

### Paired Experimental Design
If samples are paired (e.g., same patient before/after), use `computePairedPvals` to avoid exhaustive combinatorial Fisher tests.

```R
rds <- computePairedPvals(rds, treatBatches = c(1, 2), ctrlBatches = c(1, 2))
```

### Multiple APA Sites
For genes with more than two poly-adenylation sites, use the `RoarDatasetMultipleAPA` class. This requires a specific annotation format where `type` is "apa" or "gene".

```R
# rds_multi <- RoarDatasetMultipleAPAFromFiles(treatment_bams, control_bams, gtf_multi)
# Workflow remains the same: countPrePost -> computeRoars -> computePvals
```

## Key Considerations
- **Annotation Format**: GTF `gene_id` must end in `_PRE` or `_POST`. Each gene must have exactly one of each for standard analysis.
- **Memory**: For very large BAM files, process data chromosome-by-chromosome using `roarWrapper_chrBychr`.
- **Spanning Reads**: Reads overlapping the PRE/POST boundary are automatically assigned to the POST region (long isoform).
- **Length Correction**: `roar` corrects for the length of the PRE and POST regions. If transcript lengths are not provided in the GTF metadata, genomic lengths are used.

## Reference documentation
- [Identify differential APA usage from RNA-seq alignments](./references/roar.md)