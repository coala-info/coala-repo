---
name: bioconductor-difflogo
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DiffLogo.html
---

# bioconductor-difflogo

name: bioconductor-difflogo
description: Visualization of differences between multiple motifs (DNA, RNA, or Amino Acid) using difference logos. Use this skill to compare two or more Position Weight Matrices (PWMs), align motifs of different lengths, and generate publication-quality difference logo tables.

## Overview
DiffLogo is an R package designed to visualize the differences between motifs represented as Position Weight Matrices (PWMs). While traditional sequence logos show the information content of a single motif, DiffLogo highlights the specific positions and characters that differ between two motifs or across a set of motifs. It supports DNA, RNA, and protein alphabets and includes built-in alignment functions for motifs of unequal length.

## Core Workflows

### 1. Data Preparation
DiffLogo accepts PWMs as `matrix`, `data.frame`, or `pwm` objects. Rows must represent the alphabet (e.g., A, C, G, T) and columns represent positions.

```r
library(DiffLogo)

# Example: Creating a simple DNA PWM
pwm1 <- matrix(c(0.1, 0.8, 0.05, 0.05, 
                 0.1, 0.1, 0.1, 0.7), 
               nrow = 4, dimnames = list(c("A", "C", "G", "T"), NULL))
```

### 2. Pairwise Comparison
To compare two motifs, use `diffLogoFromPwm`. If motifs have different lengths, set `align_pwms = TRUE`.

```r
# Basic comparison
diffLogoFromPwm(pwm1 = pwm1, pwm2 = pwm2)

# Comparison with alignment for different lengths
diffLogoFromPwm(pwm1 = pwm_long, pwm2 = pwm_short, align_pwms = TRUE)

# Adding significance (p-values)
diffLogoObj = createDiffLogoObject(pwm1 = pwm1, pwm2 = pwm2)
diffLogoObj = enrichDiffLogoObjectWithPvalues(diffLogoObj, n1 = 100, n2 = 100)
diffLogo(diffLogoObj)
```

### 3. Multiple Motif Comparison (Tables)
To compare a set of motifs, provide a list of PWMs to `diffLogoTable`. This generates a grid where each cell $(i, j)$ is a difference logo between motif $i$ and motif $j$.

```r
motifs <- list(M1 = pwm1, M2 = pwm2, M3 = pwm3)

# Generate a table of difference logos
diffLogoTable(PWMs = motifs)

# For protein sequences, specify the alphabet
diffLogoTable(PWMs = motifs_protein, alphabet = FULL_ALPHABET)
```

### 4. Motif Alignment
If you need to align motifs manually before plotting:

```r
# Align a list of PWMs
alignment_results <- multipleLocalPwmsAlignment(pwms_list)

# Extend PWMs based on the alignment to make them equal length
aligned_pwms <- extendPwmsFromAlignmentVector(pwms_list, alignment_results$alignment$vector)
```

## Customization Tips
- **Stack Height**: Change how stack heights are calculated using the `stackHeight` parameter (e.g., `sumProbabilities` or `informationContent`).
- **Base Distribution**: Customize how characters are distributed within a stack using the `baseDistribution` parameter.
- **Exporting**: Use standard R devices (`pdf()`, `png()`) to save outputs. For `diffLogoTable`, calculate the dimensions based on the number of motifs (e.g., `width = length(motifs) * 2`).

## Reference documentation
- [DiffLogo User Guide](./references/DiffLogoBasics.md)