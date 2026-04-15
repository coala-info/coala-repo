---
name: bioconductor-beat
description: This tool performs statistical modeling and quantification of DNA methylation and epimutations from bisulfite sequencing data. Use when user asks to model methylation states, adjust for bisulfite conversion biases, or identify epimutation rates between single-cell samples and a reference.
homepage: https://bioconductor.org/packages/release/bioc/html/BEAT.html
---

# bioconductor-beat

name: bioconductor-beat
description: Statistical modeling and quantification of DNA methylation and epimutations from Bisulfite Sequencing (BS-Seq) data. Use this skill when analyzing methylated and unmethylated counts at CG positions to determine regional methylation status and epimutation rates (changes between a reference and single-cell samples).

# bioconductor-beat

## Overview

The `BEAT` (Bisulfite Epimutation Analysis Tool) package is designed to process count data from Bisulfite sequencing. It groups single CG positions into genomic regions to handle low-coverage data (common in single-cell experiments) and applies a binomial mixture model to adjust for experimental biases like incomplete bisulfite conversion (false positives) and sequencing errors (false negatives).

## Workflow and Core Functions

### 1. Data Preparation
Input data must be a CSV file per sample with columns: `chr`, `pos`, `meth`, and `unmeth`.
Files should be named `<samplename>.positions.csv`.

```r
library(BEAT)
# Example of reading raw position data
localpath <- system.file('extdata', package = 'BEAT')
positions <- read.csv(file.path(localpath, "sample.positions.csv"))
```

### 2. Configuration with `makeParams`
Define the experimental parameters and sample metadata.

*   **sampNames**: Vector of sample names.
*   **convrates**: Bisulfite conversion rates (e.g., 1 - non-CpG methylation rate).
*   **is.reference**: Logical vector identifying the reference sample (usually a multi-cell population).
*   **pminus**: False negative rate (default ~0.2).
*   **regionSize**: Size of genomic windows for pooling (e.g., 10000).
*   **minCounts**: Minimum reads required per region for analysis.

```r
sampNames <- c('reference', 'sample')
is.reference <- c(TRUE, FALSE)
convrates <- c(0.8, 0.5) # 1 - pplus

params <- makeParams(localpath, sampNames, convrates, is.reference, 
                     pminus = 0.2, regionSize = 10000, minCounts = 5)
```

### 3. Pooling Positions into Regions
Group individual CG sites into regions to increase statistical power.

```r
positions_to_regions(params)
# Generates <samplename>.regions.<size>.<min>.RData files
```

### 4. Statistical Modeling
Compute corrected methylation rates and states using the Bayesian model.

```r
generate_results(params)
# Generates <samplename>.results.<pminus>.<pplus>.RData files
# Results include 'methstate' (1: methylated, -1: unmethylated, 0: ambiguous)
# and 'methest' (estimated methylation level).
```

### 5. Epimutation Calling
Compare the sample against the reference to identify sites that changed status.

```r
epiCalls <- epimutation_calls(params)

# Access results
# epiCalls$methSites: Regions unmethylated in ref, methylated in sample
# epiCalls$demethSites: Regions methylated in ref, unmethylated in sample
```

## Key Parameters and Interpretation

*   **Methylation States**:
    *   `1`: Highly methylated ($P(r > 0.7) > 0.75$).
    *   `-1`: Sparsely methylated ($P(r < 0.3) > 0.75$).
    *   `0`: Ambiguous.
*   **Epimutation Rates**: Calculated as the frequency of status changes (e.g., Methylating Epimutation Rate = count of $0 \to 1$ or $-1 \to 1$ transitions relative to shared regions).
*   **Bias Correction**: The model uses `pplus` (1 - conversion rate) and `pminus` to adjust the likelihood of observed counts $k$ out of $n$ reads.

## Reference documentation

- [Quantification of DNA Methylation and Epimutations from Bisulfite Sequencing Data – the BEAT package](./references/BEAT.md)