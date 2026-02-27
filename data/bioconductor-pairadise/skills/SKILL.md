---
name: bioconductor-pairadise
description: PAIRADISE is a statistical framework for detecting alternative splicing differences in paired-replicate RNA-seq experiments. Use when user asks to detect allele-specific alternative splicing, analyze paired-replicate RNA-seq data, or identify differential splicing events from rMATS-formatted datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/PAIRADISE.html
---


# bioconductor-pairadise

## Overview

PAIRADISE (PAIred Replicate analysis of Allelic DIfferential Splicing Events) is a statistical framework designed to detect alternative splicing differences in paired-replicate RNA-seq experiments. While originally developed for allele-specific alternative splicing (ASAS) by aggregating signals across individuals, it serves as a generic model for any RNA-seq study involving paired replicates (e.g., comparing two conditions within the same set of individuals).

## Core Workflow

### 1. Data Preparation and Object Construction

PAIRADISE uses the `PDseDataSet` class, which extends `SummarizedExperiment`. You can construct it from raw matrices or from a data frame formatted similarly to rMATS output.

**From rMATS-style Data Frame:**
The input should have 7 columns: ID, Group1_Isoform1_Counts, Group1_Isoform2_Counts, Group2_Isoform1_Counts, Group2_Isoform2_Counts, Length_Isoform1, Length_Isoform2.

```r
library(PAIRADISE)
# Load example data
data("sample_dataset")

# Create PDseDataSet from matrix-like data frame
pdat <- PDseDataSetFromMat(sample_dataset)
```

**Manual Construction:**
If you have counts and design information separately:
```r
# icount: inclusion counts, scount: skipping counts
# design: dataframe with 'sample' and 'group' columns
# lens: dataframe with 'iLen' (inclusion length) and 'sLen' (skipping length)
pdat <- PDseDataSet(acount, design, lens)
```

### 2. Running the PAIRADISE Model

The `pairadise` function performs the statistical inference. It is computationally intensive and supports parallelization via `BiocParallel`.

```r
# Run with multiple threads (e.g., 2)
pairadise_output <- pairadise(pdat, numCluster = 2)
```

### 3. Extracting Results

Use the `results` function to calculate p-values and apply multiple testing corrections.

```r
# Get significant results (FDR < 0.05)
res <- results(pairadise_output, p.adj = "BH", sig.level = 0.05)

# Get detailed statistical estimates (mu, delta, latent variables)
res_detailed <- results(pairadise_output, details = TRUE)
```

## Key Parameters and Data Structures

- **PDseDataSet**: Stores inclusion/skipping counts. Inherits from `SummarizedExperiment`, so standard subsetting and metadata accessors work.
- **numCluster**: Integer. Number of cores for parallel processing.
- **p.adj**: Method for p-value adjustment (default is "BH").
- **sig.level**: Threshold for filtering results in the `results()` function.

## Tips for Success

- **Input Formatting**: If using `PDseDataSetFromMat`, ensure your count columns contain comma-separated strings if they represent multiple replicates within a group, or ensure the column order strictly follows the rMATS convention.
- **Memory Management**: For large datasets, ensure `numCluster` does not exceed available RAM, as each worker process will load a portion of the data.
- **Missing Data**: The model can handle some `NA` values in counts, but excessive missingness in paired samples may reduce statistical power.

## Reference documentation

- [PAIRADISE](./references/pairadise.md)