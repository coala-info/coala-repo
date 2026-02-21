---
name: bioconductor-cexor
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CexoR.html
---

# bioconductor-cexor

name: bioconductor-cexor
description: Analyze ChIP-exo data to identify high-resolution protein-DNA binding sites. Use this skill when processing ChIP-exo BAM files to call reproducible peak-pairs across replicates using the Skellam distribution and Irreproducible Discovery Rate (IDR) estimation.

# bioconductor-cexor

## Overview
CexoR is a Bioconductor package designed for high-resolution mapping of protein-DNA interactions from ChIP-exo data. It leverages the strand-specificity of ChIP-exo by modeling the discrete signed difference between forward and reverse strand counts using a Skellam distribution. By detecting nearby significant count differences of opposite signs (peak-pairs), it delimits the flanks of protein binding events at base-pair resolution. The package integrates multiple replicates by calculating the Irreproducible Discovery Rate (IDR) to ensure high-confidence, reproducible binding event calls.

## Installation
To install the package, use BiocManager:
```r
if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("CexoR")
```

## Core Workflow

### 1. Data Preparation
CexoR requires aligned reads in BAM format. It is recommended to use uniquely mapped reads.

### 2. Peak-Pair Calling and IDR Estimation
The primary function `cexor` performs the entire analysis pipeline:
- Calculates lambda exonuclease stop site counts (5' ends) for both strands.
- Normalizes counts to the smallest dataset depth.
- Models strand differences using the Skellam distribution.
- Combines p-values across replicates (Stouffer’s and Fisher’s methods).
- Estimates IDR to identify reproducible events.

```r
library(CexoR)

# Define paths to BAM files for replicates
bam_files <- c("sample_rep1.bam", "sample_rep2.bam", "sample_rep3.bam")

# Run the main analysis
# chrN: Chromosome name
# chrL: Chromosome length (bp)
# idr: IDR threshold for reproducibility
# p: P-value threshold for peak-pair calling
peak_pairs <- cexor(bam = bam_files, 
                    chrN = "chr1", 
                    chrL = 249250621, 
                    idr = 0.01, 
                    p = 1e-12)
```

### 3. Interpreting Results
The output of `cexor` is a list containing two primary `GRanges` objects:
- `bindingEvents`: The genomic ranges representing the flanks of the binding sites.
- `bindingCentres`: The midpoints (1-2 bp) of the binding events.

```r
# View reproducible binding events
print(peak_pairs$bindingEvents)

# View midpoints of binding events
print(peak_pairs$bindingCentres)
```

### 4. Visualization
Use `plotcexor` to generate a mean profile of lambda exonuclease stop sites and reads around the central positions of the identified peak-pairs.

```r
# EXT: Number of base pairs to extend around the center for the plot
plotcexor(bam = bam_files, peaks = peak_pairs, EXT = 500)
```

## Important Considerations
- **IDR Sensitivity**: For effective IDR estimation, the initial peak-pair calling should be somewhat relaxed (e.g., `p = 1e-3`). This allows the algorithm to distinguish between the "signal" (reproducible) and "noise" (irreproducible) components.
- **Parameter Tuning**: IDR calculation can be sensitive to initial estimates. If results seem inconsistent, consider adjusting the IDR parameters or the p-value threshold based on sequencing depth.
- **Memory/Time**: Processing large chromosomes or many replicates may require significant resources; ensure `chrL` is correctly specified for the region of interest.

## Reference documentation
- [CexoR: An R package to uncover high-resolution protein-DNA interactions in ChIP-exo replicates](./references/CexoR.md)