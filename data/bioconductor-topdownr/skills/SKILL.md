---
name: bioconductor-topdownr
description: This tool investigates and optimizes protein fragmentation parameters in top-down proteomics data. Use when user asks to import deconvoluted spectra, filter fragments by injection time or coefficient of variation, aggregate technical replicates, or determine optimal fragmentation conditions to maximize sequence coverage.
homepage: https://bioconductor.org/packages/release/bioc/html/topdownr.html
---

# bioconductor-topdownr

name: bioconductor-topdownr
description: Expert guidance for the topdownr R package to investigate and optimize protein fragmentation in top-down proteomics. Use this skill when analyzing top-down mass spectrometry data, specifically for importing deconvoluted spectra, filtering fragments based on injection time or CV, aggregating technical replicates, and determining optimal fragmentation conditions to maximize sequence coverage.

# bioconductor-topdownr

## Overview
The `topdownr` package is designed for the systematic analysis of top-down proteomics fragmentation data. It allows researchers to explore how different fragmentation parameters (like ETD reaction time, CID/HCD collision energy, and AGC target) affect sequence coverage. The package provides a structured workflow to import data from Thermo Orbitrap instruments, filter out low-quality scans and fragments, and identify the best combination of conditions for protein identification and characterization.

## Core Workflow

### 1. Data Import
To begin an analysis, you need four types of files: `.fasta` (protein sequence), `.experiments.csv` (method info), `.txt` (scan headers from ScanHeadsman), and `.mzML` (deconvoluted spectra).

```r
library(topdownr)

# Define mass adducts if necessary
H <- 1.0078250321

td_set <- readTopDownFiles(
    path = "path/to/data",
    type = c("a", "b", "c", "x", "y", "z"),
    adducts = data.frame(mass=c(-H, H), to=c("c", "z"), name=c("cmH", "zpH")),
    modifications = "Met-loss", # e.g., initiator methionine removal
    tolerance = 5e-6,           # 5 ppm
    conditions = "ScanDescription" 
)
```

### 2. Data Filtering
Filtering is essential to remove noise and irreproducible fragments before aggregation.

*   **Injection Time:** Remove scans where the AGC calculation or spray was unstable.
    ```r
    td_set <- filterInjectionTime(td_set, maxDeviation = log2(3), keepTopN = 2)
    ```
*   **Coefficient of Variation (CV):** Remove fragments with high intensity variance across replicates (recommended threshold: 30%).
    ```r
    td_set <- filterCv(td_set, threshold = 30)
    ```
*   **Intensity:** Remove low-intensity fragments relative to the highest observation for that fragment.
    ```r
    td_set <- filterIntensity(td_set, threshold = 0.1)
    ```

### 3. Aggregation and Analysis
After filtering, technical replicates are aggregated into a single condition set.

```r
# Aggregate replicates
td_set <- aggregate(td_set)

# View statistics
summary(td_set)

# Plot a specific condition
plot(td_set[, "Condition_Name"])
```

### 4. Maximizing Coverage
To find the best conditions for sequence coverage, convert the `TopDownSet` to an `NCBSet` (N-terminal/C-terminal/Bidirectional).

```r
# Convert to NCBSet
ncb_set <- as(td_set, "NCBSet")

# Find the top N conditions that maximize bond coverage
best_conds <- bestConditions(ncb_set, n = 3)

# Visualize fragmentation map
fragmentationMap(ncb_set, nCombinations = 5)
```

## Creating Fragmentation Methods
`topdownr` can also generate the XML files required to create experimental methods for Thermo Tribrid instruments.

```r
# 1. Define MS1 and Target Mz
ms1 <- expandMs1Conditions(FirstMass=400, LastMass=1200)
targetMz <- cbind(mz=c(560.6, 700.5), z=rep(1, 2))

# 2. Expand fragmentation parameters
hcd <- expandTms2Conditions(MassList=targetMz, ActivationType="HCD", HCDCollisionEnergy=seq(7, 35, 7))

# 3. Create experiment objects
exps <- createExperimentsFragmentOptimisation(ms1=ms1, hcd, nMs2perMs1=10)

# 4. Write XMLs for XMLMethodChanger
writeMethodXmls(exps=exps)
```

## Tips for Success
*   **Object Structure:** A `TopDownSet` contains `rowViews` (fragment data), `colData` (condition data), and `assayData` (intensity matrix). Use standard R subsetting `[row, col]` to filter by fragment type or specific files.
*   **Feature Importance:** Use the `ranger` package on the `colData` to determine which fragmentation parameters (e.g., `EtdActivation`) have the most impact on the number of fragments produced.
*   **Deconvolution:** Ensure your `.mzML` files are already charge-state deconvoluted (e.g., using Xtract in Proteome Discoverer) before importing into `topdownr`.

## Reference documentation
- [Fragmentation Analysis with topdownr](./references/analysis.md)
- [Data Generation for topdownr](./references/data-generation.md)