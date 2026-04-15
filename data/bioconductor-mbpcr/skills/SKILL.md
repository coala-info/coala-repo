---
name: bioconductor-mbpcr
description: This tool estimates DNA copy number profiles from SNP array data using Bayesian piecewise constant regression. Use when user asks to estimate DNA copy number profiles, identify genomic breakpoints, detect copy number alterations, or perform piecewise constant regression on log2ratio data.
homepage: https://bioconductor.org/packages/release/bioc/html/mBPCR.html
---

# bioconductor-mbpcr

name: bioconductor-mbpcr
description: Bayesian DNA copy number profile estimation using the mBPCR package. Use this skill to perform piecewise constant regression on log2ratio data from SNP arrays (e.g., Affymetrix 10K, 250K) to identify genomic breakpoints and copy number alterations.

## Overview
The `mBPCR` (modified Bayesian Piecewise Constant Regression) package provides tools for estimating the profile of DNA copy number data. It uses a Bayesian approach to model the log2ratio as a piecewise constant function, allowing for the detection of segments with different copy levels. It is particularly effective for high-density SNP array data.

## Core Workflow

### 1. Data Preparation
Data should ideally be in log2ratio format with probe names, chromosome identifiers (1-22, X, Y), and physical positions.

```r
library(mBPCR)

# Import from a tab-delimited file
# NRowSkip: rows to skip before data; ifLogRatio=0 if data is not yet log-transformed
path <- "path/to/data.txt"
my_data <- importCNData(path, NRowSkip=1)

# Or load example data
data(rec10k)
```

### 2. Parameter Estimation
Global parameters ($\nu$, $\rho^2$, $\sigma^2$) should be estimated on the entire genome for better accuracy, even if only analyzing one chromosome.

```r
# Estimate global parameters from raw log2ratio values
params <- estGlobParam(rec10k$log2ratio)
# params$nu, params$rhoSquare, params$sigmaSquare
```

### 3. Profile Estimation
The primary function is `estProfileWithMBPCR`. 

**Memory Management Tip:** Before running on large datasets, verify RAM for a vector of size `(maxProbeNumber+1)*(maxProbeNumber+2)/2`.
```r
maxProbeNumber <- 1000 
# Test allocation
A <- array(1, dim=(maxProbeNumber+1)*(maxProbeNumber+2)/2)
remove(A)
```

**Running the estimation:**
```r
results <- estProfileWithMBPCR(
  rec10k$SNPname, 
  rec10k$Chromosome, 
  rec10k$PhysicalPosition, 
  rec10k$log2ratio, 
  chrToBeAnalyzed = c(3, 5), 
  maxProbeNumber = 1000,
  regr = 'mBPCR' # Options: 'mBPCR' or 'BRC' (Bayesian Regression Curve)
)
```

### 4. Exporting and Visualizing Results
Use `writeEstProfile` to generate tables of estimated values and breakpoints.

```r
# Write results to files
writeEstProfile(
  path = '', 
  sampleName = 'rec10k',
  rec10k$SNPname, 
  rec10k$Chromosome, 
  rec10k$PhysicalPosition, 
  rec10k$log2ratio, 
  chrToBeWritten = c(3, 5), 
  results$estPC, 
  results$estBoundaries
)

# Plot the profile
plotEstProfile(
  sampleName = 'rec10k', 
  rec10k$Chromosome, 
  rec10k$PhysicalPosition, 
  rec10k$log2ratio, 
  chrToBePlotted = 3, 
  results$estPC, 
  maxProbeNumber = 1000
)
```

## Advanced Usage

### Working with oligoSnpSet
If using `oligoClasses` objects:
```r
r <- estProfileWithMBPCRforOligoSnpSet(
  oligoSet, 
  sampleToBeAnalyzed = 1, 
  chrToBeAnalyzed = 2, 
  maxProbeNumber = 1000, 
  ifLogRatio = 0
)
```

### Direct Computation
For simulated data or specific segments without genomic metadata, use `computeMBPCR`:
```r
# y is a vector of log2ratios
results <- computeMBPCR(y, nu=-0.02, rhoSquare=0.08, sigmaSquare=0.5)
```

## Best Practices
- **$\rho^2$ Estimation:** For patient samples with few aberrations, estimate $\rho^2$ (variance of segment levels) on a cell line or a highly aberrant sample first, then provide that fixed value to the patient analysis.
- **Chromosome Names:** Ensure chromosomes are named as integers 1-22 or "X"/"Y".
- **Whole Genome Context:** Always estimate global parameters on the full dataset to ensure the noise model ($\sigma^2$) is robust.

## Reference documentation
- [mBPCR](./references/mBPCR.md)