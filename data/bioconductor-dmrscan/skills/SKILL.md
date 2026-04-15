---
name: bioconductor-dmrscan
description: bioconductor-dmrscan identifies differentially methylated regions by applying a sliding window scan statistic to CpG-wise test statistics. Use when user asks to detect genomic regions with significant methylation changes, analyze bisulfite sequencing or array data, or estimate significance thresholds for sliding windows.
homepage: https://bioconductor.org/packages/release/bioc/html/DMRScan.html
---

# bioconductor-dmrscan

name: bioconductor-dmrscan
description: Identification of differentially methylated regions (DMRs) using a scan statistic. Use this skill when analyzing DNA methylation data (bisulfite sequencing or arrays) to detect genomic regions with significant methylation changes. It is particularly useful for addressing multiple testing issues in genome-wide studies by applying sliding window statistics and estimating significance thresholds via MCMC, importance sampling, or analytical solutions.

## Overview
DMRScan identifies differentially methylated regions by applying a sliding window scan statistic to CpG-wise test statistics. Unlike methods that require raw data, DMRScan operates on pre-calculated test statistics (e.g., t-statistics from linear models or Z-scores from meta-analyses), providing flexibility in the underlying statistical model.

## Workflow

### 1. Prepare Test Statistics
DMRScan requires a vector of test statistics with genomic coordinates.
```r
library(DMRScan)

# Example: Generate t-statistics from a linear model
# methylation_data: matrix (CpGs x Samples)
# phenotype: vector of outcomes
observations <- apply(methylation_data, 1, function(x, y) {
  summary(lm(x ~ y))$coefficients[2, 3]
}, y = phenotype)

# Extract coordinates (Chromosome and Position)
# Ensure 'pos' is a matrix or data frame with two columns: [Chr, BP]
pos <- matrix(as.integer(unlist(strsplit(names(observations), split="chr|[.]"))), 
              ncol = 3, byrow = TRUE)[, -1]
```

### 2. Cluster CpGs into Regions
Group CpGs into "chunks" based on genomic proximity to define the search space for the scan statistic.
```r
# maxGap: max distance between probes in a cluster
# minCpG: minimum probes to form a cluster
regions <- makeCpGregions(observations = observations, 
                          chr = pos[, 1], 
                          pos = pos[, 2], 
                          maxGap = 750, 
                          minCpG = 3)
```

### 3. Estimate Window Thresholds
Calculate the significance threshold for the sliding windows. You must specify the window sizes (number of CpGs) to test.
```r
window.sizes <- 3:10
n.CpG <- sum(sapply(regions, length))

# Option A: Importance Sampling (Fast, recommended)
thresholds <- estimateWindowThreshold(nProbe = n.CpG, 
                                       windowSize = window.sizes, 
                                       method = "sampling", 
                                       mcmc = 10000)

# Option B: Siegmund (Analytical, conservative, fastest)
thresholds_sieg <- estimateWindowThreshold(nProbe = n.CpG, 
                                            windowSize = window.sizes, 
                                            method = "siegmund")

# Option C: MCMC (For complex correlation structures)
thresholds_mcmc <- estimateWindowThreshold(nProbe = n.CpG, 
                                            windowSize = window.sizes, 
                                            method = "mcmc", 
                                            submethod = "arima", 
                                            model = list(ar = c(0.1, 0.03)))
```

### 4. Run DMRScan
Apply the scan statistic to the clustered regions using the calculated thresholds.
```r
results <- dmrscan(observations = regions, 
                   windowSize = window.sizes, 
                   windowThreshold = thresholds)

# Results are returned as a GRanges object
print(results)
```

## Tips and Best Practices
- **Window Sizes**: Testing a range of window sizes (e.g., 3:10) allows the algorithm to detect regions of varying lengths. The threshold calculation automatically adjusts for multiple testing across these sizes.
- **Method Selection**: Use `method = "sampling"` for a good balance between speed and power. Use `method = "siegmund"` if you require a very conservative threshold with minimal false positives.
- **Input Flexibility**: Since DMRScan takes test statistics, you can use it for meta-analysis by providing Z-scores from multiple studies.
- **Data Ordering**: Ensure your test statistics and coordinates are ordered sequentially by genomic position before clustering.

## Reference documentation
- [Using the DMR Scan Package](./references/DMRScan_vignette.Rmd)
- [DMRScan Vignette (Markdown)](./references/DMRScan_vignette.md)