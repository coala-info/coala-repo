---
name: bioconductor-ramr
description: This tool detects rare aberrantly methylated regions or epimutations in DNA methylation data from arrays or sequencing. Use when user asks to identify low-frequency methylation outliers, visualize individual sample deviations from a cohort, or simulate methylation data for benchmarking.
homepage: https://bioconductor.org/packages/release/bioc/html/ramr.html
---

# bioconductor-ramr

name: bioconductor-ramr
description: Detection of rare aberrantly methylated regions (AMRs/epimutations) in DNA methylation data (array or sequencing). Use this skill to identify low-frequency methylation outliers, visualize AMRs, simulate methylation data for benchmarking, and prepare data for enrichment analysis.

# bioconductor-ramr

## Overview
The `ramr` package is designed to identify rare aberrantly methylated regions (AMRs), often referred to as epimutations, within large methylation datasets. Unlike standard Differential Methylation Region (DMR) analysis which compares groups, `ramr` identifies regions where an individual sample deviates significantly from the distribution of the rest of the cohort. It supports data from Illumina arrays (450k/EPIC) and high-throughput sequencing (Bismark/methylKit).

## Core Workflow

### 1. Data Preparation
The primary input is a `GRanges` object where metadata columns contain beta values (0 to 1) for each sample.

```r
library(ramr)
library(GenomicRanges)

# Example: Accessing built-in data
data(ramr)
# ramr.data is a GRanges object with beta values for 100 samples
```

For external data:
- **Minfi/GEO**: Extract beta values from a `GenomicRatioSet` and attach to `granges()`.
- **Bismark/methylKit**: Use `methRead` and `unite`, then convert to `GRanges`. Ensure beta values are bounded (e.g., 0.001 to 0.999) if using beta distribution fitting.

### 2. Identifying AMRs
The `getAMR` function is the main engine for detection.

```r
amrs <- getAMR(
  data.ranges = ramr.data,
  data.samples = ramr.samples,
  compute = "beta+binom",      # Recommended method
  combine.min.cpgs = 5,        # Minimum number of CpGs in a region
  combine.threshold = 0.01,    # P-value threshold for individual CpGs
  combine.window = 1000        # Max distance between CpGs in a region
)
```

**Key Parameters:**
- `compute`: Method for outlier detection. `"beta+binom"` is robust for sequencing and array data.
- `compute.estimate`: Use `"amle"` for faster, more robust parameter estimation.
- `combine.min.cpgs`: Filters for regions with a minimum density of aberrant probes.

### 3. Visualization
Visualize identified regions against the cohort distribution.

```r
# Plot a specific AMR
plotAMR(data.ranges = ramr.data, amr.ranges = amrs[1])

# Plot multiple AMRs in a grid
library(gridExtra)
plots <- plotAMR(data.ranges = ramr.data, amr.ranges = amrs[1:4])
do.call("grid.arrange", c(plots, ncol=2))
```

### 4. Simulation and Benchmarking
`ramr` can generate synthetic data to test AMR/DMR detection algorithms.

```r
# 1. Simulate specific AMR locations
sim_amrs <- simulateAMR(ramr.data, nsamples=10, regions.per.sample=5, dbeta=0.3)

# 2. Generate beta values based on a template and the simulated AMRs
sim_data <- simulateData(ramr.data, nsamples=10, amr.ranges=sim_amrs)
```

### 5. Enrichment Analysis Preparation
To perform enrichment analysis (e.g., with `LOLA`), you must define the "universe" of all possible regions based on your filtering criteria.

```r
universe <- getUniverse(ramr.data, min.cpgs=5, merge.window=1000)
# Use 'amrs' as the user set and 'universe' as the background in runLOLA
```

## Tips for Success
- **Sample Size**: `ramr` relies on the distribution of the cohort to identify outliers; larger cohorts generally provide more stable background distributions.
- **Sequencing Data**: For sequencing data containing many 0s and 1s, ensure you are using the updated `getAMR` (v1.16+) which uses C++/OpenMP for speed and handles boundary values correctly.
- **Metadata**: The output of `getAMR` includes `sample` (which sample carries the epimutation), `dbeta` (effect size), and `pval` (significance).

## Reference documentation
- [The ramr User's Guide](./references/ramr.md)