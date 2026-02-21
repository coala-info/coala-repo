---
name: bioconductor-dmrseq
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/dmrseq.html
---

# bioconductor-dmrseq

name: bioconductor-dmrseq
description: Statistical analysis of Bisulfite-sequencing data to detect Differentially Methylated Regions (DMRs). Use this skill when analyzing Whole Genome Bisulfite-Sequencing (WGBS) count data in R to identify genomic regions with systematic methylation differences between conditions, especially when dealing with small sample sizes (at least 2 per group) or requiring rigorous False Discovery Rate (FDR) control.

# bioconductor-dmrseq

## Overview
The `dmrseq` package provides a permutation-based approach to detect and perform inference on Differentially Methylated Regions (DMRs). Unlike methods that aggregate significant single CpGs, `dmrseq` uses generalized least squares models to account for inter-individual and inter-CpG variability, generating region-level statistics. It is designed to work with `BSseq` objects from the `bsseq` package.

## Core Workflow

### 1. Data Preparation
Data must be in a `BSseq` object containing Methylation (M) and Coverage (Cov) matrices.

```r
library(dmrseq)
library(bsseq)

# Construct BSseq object from matrices
bs <- BSseq(chr = chr_vector, 
            pos = pos_vector,
            M = methylation_matrix, 
            Cov = coverage_matrix,
            sampleNames = sample_names)

# Add metadata (required for testing)
pData(bs)$Condition <- condition_vector 
```

### 2. Detecting DMRs
The `dmrseq` function performs smoothing, candidate region detection, and permutation testing in one step.

```r
# Basic DMR detection
regions <- dmrseq(bs = bs, 
                  testCovariate = "Condition",
                  cutoff = 0.05)

# Adjusting for covariates (e.g., Sex or Batch)
# Use adjustCovariate for continuous/multi-group or matchCovariate for balanced permutations
regions <- dmrseq(bs = bs, 
                  testCovariate = "Condition",
                  adjustCovariate = "Batch")
```

### 3. Detecting Large-Scale Blocks
To find large-scale methylation blocks (e.g., in cancer studies), use the `block = TRUE` argument and increase smoothing parameters.

```r
blocks <- dmrseq(bs = bs, 
                 testCovariate = "Condition",
                 block = TRUE,
                 minInSpan = 500, 
                 bpSpan = 5e4, 
                 maxGapSmooth = 1e6,
                 maxGap = 5e3)
```

## Interpreting Results
The output is a `GRanges` object. Key metadata columns include:
- `beta`: Coefficient for the condition difference.
- `stat`: Region-level test statistic.
- `pval` / `qval`: Permutation p-value and FDR-adjusted q-value.
- `L`: Number of CpGs in the region.

**Directionality:** By default, `dmrseq` uses alphabetical order for categorical covariates. If conditions are "Control" vs "Treatment", "Control" is the reference. A positive `stat` means "Treatment" is hyper-methylated relative to "Control".

## Visualization and Utilities

### Plotting Regions
Visualize specific DMRs with methylation levels and optional genomic annotations.
```r
# Plot the top DMR
plotDMRs(bs, regions = regions[1,], testCovariate = "Condition")

# Plot empirical distribution of methylation or coverage
plotEmpiricalDistribution(bs, testCovariate = "Condition", type = "M")
```

### Helper Functions
- `meanDiff(bs, dmrs, testCovariate)`: Extracts raw mean methylation differences for specified regions.
- `simDMRs(bs, num.dmrs)`: Simulates DMRs by spiking differences into null data for benchmarking.

## Tips for Success
- **Sample Size:** You must have at least 2 replicates per condition.
- **Filtering:** Filter out CpGs with zero coverage across all samples in a group before running `dmrseq` to improve speed and power.
- **Parallelization:** Use `BiocParallel` to speed up execution, as `dmrseq` processes by chromosome.
  ```r
  library(BiocParallel)
  register(MulticoreParam(4))
  ```
- **Memory:** WGBS data is large. Processing one chromosome at a time is the default to manage RAM.

## Reference documentation
- [Analyzing Bisulfite-seq data with dmrseq](./references/dmrseq.md)