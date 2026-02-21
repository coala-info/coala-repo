---
name: bioconductor-fithic
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/FitHiC.html
---

# bioconductor-fithic

## Overview

FitHiC is an R package designed to identify statistically significant chromatin interactions from Hi-C and similar data. It models the relationship between genomic distance and contact probability using a spline-based approach, allowing for the detection of interactions that occur more frequently than expected by chance. It is highly recommended to use raw contact counts along with bias values (from matrix balancing methods like ICE or KR) rather than pre-normalized counts.

## Core Workflow

The primary interface is the `FitHiC()` function, which executes the entire pipeline from data parsing to significance estimation.

### 1. Data Preparation
FitHiC requires three main inputs (or HiC-Pro formatted files):
- **Fragments File**: Chromosome name, midpoint, and hit count (mappability).
- **Interactions File**: Pairs of midpoints and their raw contact counts.
- **Bias File (Optional but Recommended)**: Bias values per locus centered on 1.

### 2. Basic Execution
```R
library(FitHiC)

# Define file paths
frags <- "path/to/fragments.gz"
inters <- "path/to/interactions.gz"
out_dir <- "results_fithic"

# Run FitHiC
FitHiC(frags, inters, out_dir, 
       libname = "my_experiment",
       distUpThres = 5000000,  # Max distance to consider
       distLowThres = 50000,   # Min distance to consider
       visual = TRUE)          # Generate plots
```

### 3. Using Normalization Biases
To account for technical biases, provide a bias file. Ensure you are using **raw** counts in the interactions file.
```R
bias <- "path/to/biases.gz"

FitHiC(frags, inters, out_dir, bias,
       libname = "my_experiment_normalized",
       distUpThres = 2000000,
       distLowThres = 20000)
```

### 4. HiC-Pro Integration
If using output from the HiC-Pro pipeline, set `useHiCPro = TRUE`.
```R
FitHiC(frags, inters, out_dir, bias,
       libname = "hicpro_run",
       useHiCPro = TRUE,
       distUpThres = 5000000,
       distLowThres = 40000)
```

## Key Parameters

- `distUpThres`: Upper bound of genomic distance for interactions.
- `distLowThres`: Lower bound of genomic distance (to ignore very short-range noise).
- `noOfBins`: Number of equal-occupancy bins for spline fitting (default is 100).
- `mappabilityThreshold`: Minimum hit count for a fragment to be considered (default is 1).
- `visual`: Boolean to output PDF plots of the spline fit and contact probabilities.

## Interpreting Results

The function produces several files in the `outdir`:
- `*.fithic_pass1.txt` / `*.fithic_pass2.txt`: Contact probability estimates.
- `*.spline_pass2.significances.txt.gz`: The final results containing:
    - `contactCount`: Raw number of contacts.
    - `p_value`: Probability of observing the count by chance.
    - `q_value`: FDR-corrected p-value (use this for significance filtering, e.g., q < 0.05).

## Reference documentation

- [How to Use Fit-Hi-C R Package](./references/fithic.md)