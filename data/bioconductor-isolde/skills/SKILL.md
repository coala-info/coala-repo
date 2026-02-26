---
name: bioconductor-isolde
description: This tool identifies genes with allelic bias or genomic imprinting from RNA-seq data using robust variability estimation and bootstrap resampling. Use when user asks to identify imprinted genes, detect parental or strain-specific expression imbalance, or analyze allele-specific read counts.
homepage: https://bioconductor.org/packages/release/bioc/html/ISoLDE.html
---


# bioconductor-isolde

name: bioconductor-isolde
description: Statistical identification of genes with allelic bias (imprinted genes) from RNA-seq data. Use this skill when analyzing Allele Specific Read (ASR) counts to detect parental or strain-specific expression imbalance using robust variability estimation and bootstrap resampling.

## Overview

ISoLDE (Integrative Statistics of alleLe Dependent Expression) is designed to identify imprinted genes or genes with allelic bias from RNA-sequencing data. It is particularly robust because it estimates data variability to determine the significance of expression differences between alleles. The package supports two main statistical approaches:
1. **Bootstrap Resampling**: The preferred method, requiring at least three biological replicates per reciprocal cross.
2. **Empirical Threshold**: A fallback method for experiments with only two replicates.

## Typical Workflow

### 1. Data Input
ISoLDE requires three types of input: raw ASR counts, normalized ASR counts, and a target metadata file.

```r
library(ISoLDE)

# Read raw counts (required for filtering)
raw_counts <- readRawInput(raw_file = "raw_counts.txt", del = "\t")

# Read normalized counts (RLE method recommended)
norm_counts <- readNormInput(norm_file = "norm_counts.txt", del = "\t")

# Read target metadata (defines samples, parents, and strains)
# Note: target file must match the column order of the count data
target_data <- readTarget(target_file = "target.txt", asr_counts = raw_counts)
```

### 2. Filtering
Filtering removes lowly expressed genes that lack sufficient information for statistical testing, reducing the multiple testing burden.

```r
# Filter genes based on a data-driven threshold
res_filter <- filterT(rawASRcounts = raw_counts, 
                      normASRcounts = norm_counts, 
                      target = target_data, 
                      bias = "parental")

filtered_counts <- res_filter$filteredASRcounts
```

### 3. Statistical Testing
The `isolde_test` function is the core of the package. It automatically selects the bootstrap method if $\ge 3$ replicates are present, otherwise it uses the threshold method.

```r
# Run the main test
results <- isolde_test(bias = "parental", 
                       method = "default", 
                       asr_counts = filtered_counts, 
                       target = target_data,
                       nboot = 5000,
                       graph = TRUE,
                       prefix = "my_experiment")
```

## Key Functions and Parameters

- `isolde_test()`:
    - `bias`: Set to `"parental"` (imprinting) or `"strain"` (genetic bias).
    - `method`: `"default"` (auto-selects based on replicates) or `"threshold"` (forces empirical method).
    - `nboot`: Number of bootstrap iterations (default 5000).
    - `pcore`: Percentage of CPU cores to use for parallel processing.
- `filterT()`:
    - `tol_filter`: Tolerance rate (0-100). 0 means all counts from at least one origin must be above threshold.

## Interpreting Results

The output of `isolde_test` is a list containing:
- `listASE`: Genes identified with Allele Specific Expression (bias). Includes the `criterion` value and `origin` (P/M or strain name).
- `listBA`: Genes identified as Biallelically expressed.
- `listUN`: Undetermined genes. Look for `FLAG_consistency` (consistent direction but not significant) or `FLAG_significance` (significant but inconsistent direction).
- `listFILT`: Genes that failed the internal minimal filtering.

## Reference documentation

- [ISoLDE Reference Manual](./references/reference_manual.md)