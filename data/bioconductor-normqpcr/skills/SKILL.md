---
name: bioconductor-normqpcr
description: This tool provides functions for the normalization and analysis of RT-qPCR data, including reference gene selection and relative quantification. Use when user asks to normalize qPCR data, select stable reference genes using geNorm or NormFinder, combine technical replicates, or calculate delta-delta Cq values.
homepage: https://bioconductor.org/packages/release/bioc/html/NormqPCR.html
---


# bioconductor-normqpcr

name: bioconductor-normqpcr
description: Functions for normalization of RT-qPCR data, including technical replicate combination, handling undetermined values, and selecting stable reference genes using geNorm and NormFinder algorithms. Use this skill when analyzing qPCR data in R, specifically for calculating 2^-deltaCq and 2^-delta-deltaCq values.

## Overview
The `NormqPCR` package provides a comprehensive suite of tools for the normalization and analysis of real-time quantitative RT-PCR data. It extends the `ReadqPCR` package's `qPCRBatch` objects to facilitate workflows including data cleaning (handling NAs and technical replicates), reference gene selection (geNorm and NormFinder), and relative quantification (delta-delta Cq and NRQs).

## Core Workflow

### 1. Data Preprocessing
Before normalization, raw Cq values often require cleaning and aggregation.

*   **Combine Technical Replicates**: Use `combineTechReps` to average replicates (suffixed with `_TechRep.n`) into a single value per feature.
    ```r
    combinedBatch <- combineTechReps(qPCRBatch)
    ```
*   **Handle Undetermined Values**:
    *   `replaceAboveCutOff(batch, newVal = NA, cutOff = 35)`: Set high Cq values to NA.
    *   `replaceNAs(batch, newNA = 40)`: Replace NAs with a specific cycle number.
    *   `makeAllNewVal(batch, contrastM, sampleMaxM, newVal = NA)`: Filter detectors based on a maximum number of allowed NAs per sample group.

### 2. Selecting Reference Genes
The package implements two gold-standard algorithms to find the most stable housekeeping genes (HKGs).

*   **geNorm**: Ranks genes by stability measure $M$ and calculates pairwise variation $V$.
    ```r
    res <- selectHKs(qPCRBatch, method = "geNorm", Symbols = featureNames(qPCRBatch), minNrHK = 2)
    # Vand02 recommends a V cut-off of 0.15
    ```
*   **NormFinder**: Uses a model-based approach to estimate intra- and inter-group variation.
    ```r
    # Requires a group factor from phenoData
    groups <- pData(qPCRBatch)$Classification
    res <- selectHKs(qPCRBatch, method = "NormFinder", group = groups, Symbols = featureNames(qPCRBatch))
    ```

### 3. Normalization Methods

#### Delta Cq ($\Delta Cq$)
Normalizes detectors within a sample by subtracting the HKG value.
```r
# Single or multiple HKGs (uses arithmetic mean of HKGs)
hkgs <- c("Actb", "Gapdh")
normBatch <- deltaCq(qPCRBatch = batch, hkgs = hkgs, calc = "arith")
```

#### Delta-Delta Cq ($2^{-\Delta\Delta Cq}$)
Calculates relative expression between two groups (case vs. control).
```r
# Requires a contrast matrix (1 for sample presence, 0 for absence)
contM <- cbind(case = c(1,1,0,0), control = c(0,0,1,1))
rownames(contM) <- sampleNames(batch)

results <- deltaDeltaCq(qPCRBatch = batch, 
                        hkgs = "Actb", 
                        contrastM = contM, 
                        case = "case", 
                        control = "control",
                        paired = TRUE) # Use paired=FALSE for separate well methods
```

#### Normalized Relative Quantities (NRQs)
A more advanced method accounting for individual gene efficiencies.
```r
# Requires efficiency values to be set in the qPCRBatch object
effs(batch) <- efficiency_matrix
resNRQ <- ComputeNRQs(batch, hkgs = c("gene1", "gene2"))
```

## Tips for Success
*   **Object Compatibility**: `NormqPCR` relies on `qPCRBatch` objects from the `ReadqPCR` package. Ensure data is loaded via `read.qPCR` or `read.taqman` first.
*   **Log Transformation**: Most functions include a `log` parameter. If your data is already on a log scale (like raw Cq values), ensure `log = TRUE` (default) is handled correctly; if using transformed values, check the documentation for the specific function's expectation.
*   **Geometric vs. Arithmetic**: When combining multiple housekeeping genes, the geometric mean is generally preferred for $2^{-\Delta Cq}$ values, while the arithmetic mean is used for raw Cq values.

## Reference documentation
- [NormqPCR](./references/NormqPCR.md)