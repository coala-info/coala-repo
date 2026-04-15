---
name: bioconductor-easyqpcr
description: This tool analyzes low-throughput real-time quantitative PCR data to calculate amplification efficiency and normalized relative quantities. Use when user asks to calculate amplification efficiency, identify technical replicate outliers, normalize qPCR data using reference genes, calculate inter-run calibration factors, or aggregate biological replicates.
homepage: https://bioconductor.org/packages/3.9/bioc/html/EasyqpcR.html
---

# bioconductor-easyqpcr

name: bioconductor-easyqpcr
description: Analysis of low-throughput real-time quantitative PCR (qPCR) data. Use this skill to calculate amplification efficiency, normalize relative quantities (NRQ), calculate inter-run calibration factors, and aggregate biological replicates using the Hellemans et al. (2007) and Willems et al. (2008) methods.

# bioconductor-easyqpcr

## Overview
The `EasyqpcR` package provides a streamlined workflow for processing qPCR data. It handles the transition from raw Cycle threshold (Ct) values to normalized expression data, specifically addressing challenges like amplification efficiency, inter-run variability, and the aggregation of independent biological replicates.

## Core Functions
- `slope()`: Calculates amplification efficiency from a standard curve.
- `badCt()`: Identifies technical replicates that exceed a specific variation threshold (e.g., 0.5 Ct).
- `nrmData()`: Performs the core normalization, calculating relative quantities (RQ) and normalized relative quantities (NRQ) using reference genes.
- `calData()`: Calculates calibration factors from Inter-Run Calibrators (IRCs) to minimize batch effects.
- `totData()`: Aggregates multiple biological replicates, optionally applying a transformation algorithm to attenuate high variations between runs.

## Typical Workflow

### 1. Efficiency Calculation
Before normalization, determine the efficiency (E) for each gene using a dilution series.
```r
library(EasyqpcR)
# q: vector of quantities, r: number of replicates
eff_results <- slope(data = Efficiency_data, q = c(1000, 100, 10, 1, 0.1), r = 3)
efficiencies <- eff_results$Efficiency$E
```

### 2. Quality Control
Check for outliers in technical replicates.
```r
# threshold: max standard deviation allowed between replicates
qc_check <- badCt(data = qPCR_run1, r = 3, threshold = 0.5)
# View outliers
qc_check$`Bad replicates localization`
```

### 3. Normalization and Inter-Run Calibration
If samples are spread across multiple runs, use a calibrator sample to calculate Calibration Factors (CF).

```r
# Step A: Get NRQ for calibrators in each run (CF initially set to 1)
run1_cal <- nrmData(data = qPCR_run1, r = 3, E = efficiencies, nSpl = 5, 
                    nbRef = 2, Refposcol = 1:2, nCTL = 2, CF = c(1,1,1,1), CalPos = 5)[[3]]

# Step B: Calculate Calibration Factors
cf_run1 <- calData(run1_cal)

# Step C: Normalize data using the calculated CF
final_norm <- nrmData(data = qPCR_run1, r = 3, E = efficiencies, nSpl = 5, 
                      nbRef = 2, Refposcol = 1:2, nCTL = 2, CF = cf_run1, CalPos = 5)
```

### 4. Aggregating Replicates
Combine data from independent experiments into a single data frame and use `totData` for final statistics.
```r
# Combine normalized data frames (a2, b2, c2)
combined_data <- rbind(a2, b2, c2)

# Aggregate with Willems et al. transformation
final_results <- totData(data = combined_data, r = 3, transformation = TRUE, 
                         nSpl = 5, linear = TRUE)
```

## Data Organization Tips
- **Sample Order**: Place control samples at the top of your data frame; the algorithm relies on this positioning for scaling.
- **Reference Genes**: Use stable reference genes. The package supports multiple reference genes for geometric mean normalization.
- **Missing Values**: Use `na.rm = TRUE` in functions if your dataset contains empty wells or failed reactions.
- **Large Datasets**: For "Gene Maximization" strategies (where samples/genes are spread across many plates), calculate run-specific CFs for every plate and apply them individually before aggregating with `rbind`.

## Reference documentation
- [EasyqpcR: low-throughput real-time quantitative PCR data analysis](./references/vignette_EasyqpcR.md)