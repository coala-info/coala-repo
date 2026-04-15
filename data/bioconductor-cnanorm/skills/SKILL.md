---
name: bioconductor-cnanorm
description: CNAnorm analyzes copy number alterations in tumour samples using low-coverage sequencing data by estimating ploidy and cell content. Use when user asks to analyze copy number alterations, estimate tumour ploidy and purity, normalize sequencing read counts, or visualize genomic copy number profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/CNAnorm.html
---

# bioconductor-cnanorm

## Overview

CNAnorm is designed for the analysis of Copy Number Alterations (CNA) in tumour samples using low-coverage sequencing (0.01 - 0.5X). Its primary strength is performing meaningful normalization by estimating the underlying tumour ploidy and cell content. It supports both automated workflows and interactive manual corrections based on external evidence (e.g., FISH or pathology reports).

## Core Workflow

### 1. Data Input and Object Creation
The input requires read counts for test (tumour) and control (normal) samples across constant width windows, including chromosome names and start positions.

```r
library(CNAnorm)
data(LS041) # Example dataset

# Create CNAnorm object from a dataframe
# Columns expected: Chr, Pos, Test, Norm, GC (optional)
CN <- dataFrame2object(LS041)
```

### 2. Normalization and Smoothing
GC correction is recommended to reduce sequencing bias. Smoothing helps decrease noise without losing resolution.

```r
# Flag chromosomes to exclude from normalization (e.g., sex chromosomes)
toSkip <- c("chrY", "chrM")

# GC Correction
CN <- gcNorm(CN, exclude = toSkip)

# Smooth the signal
CN <- addSmooth(CN, lambda = 7)
```

### 3. Ploidy Estimation
CNAnorm provides different methods to detect copy number states:
- `method = 'closest'`: Robust; finds the peak closest to the median. Does not estimate ploidy/content.
- `method = 'density'` or `'mixture'`: Advanced; estimates absolute ploidy and tumour content (best for monoclonal samples).

```r
# Basic normalization
CN <- peakPloidy(CN, exclude = toSkip, method = 'closest')

# Visualize peaks to verify normalization
plotPeaks(CN)
```

### 4. Segmentation and Discrete Normalization
CNAnorm integrates with `DNAcopy` for segmentation.

```r
CN <- validation(CN)
CN <- addDNACopy(CN)
CN <- discreteNorm(CN)
```

### 5. Automated Workflow
The `CNAnormWorkflow` function wraps the above steps into a single call with robust defaults.

```r
CNauto <- CNAnormWorkflow(LS041, gc.do = TRUE, gc.exclude = toSkip, peak.exclude = toSkip)
```

## Visualization and Export

### Genome Plots
Visualize the copy number profile across the genome or specific chromosomes.

```r
# Plot whole genome
plotGenome(CN, superimpose = 'DNACopy', show.centromeres = FALSE)

# Plot specific chromosomes (e.g., 10, 11, 12)
subSet <- chrs(CN) %in% c('chr10', 'chr11', 'chr12')
plotGenome(CN[subSet], superimpose = 'DNACopy')
```

### Customizing Plots
Use the `gPar` object to modify colors and sizes.

```r
data(gPar)
gPar$genome$colors$gain.dot <- 'darkorange'
gPar$genome$cex$gain.dot <- 0.4
plotGenome(CN[subSet], superimpose = 'DNACopy', gPar = gPar, colorful = TRUE)
```

### Exporting Results
Export the normalized data to a table for downstream analysis.

```r
exportTable(CN, file = "CNAnorm_results.tab", show = 'center')
```

## Advanced Manual Correction
If automated ploidy detection fails or external evidence suggests a different state, you can manually shift the ploidy.

```r
# Shift ploidy down by 1 state
CN <- validation(CN, ploidy = (sugg.ploidy(CN) - 1))

# Re-normalize and plot
CN <- discreteNorm(CN)
plotPeaks(CN, show = 'validated')
```

## Reference documentation

- [CNAnorm](./references/CNAnorm.md)