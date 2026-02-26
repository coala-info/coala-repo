---
name: r-tfmpvalue
description: This tool calculates P-values and score thresholds for Position Weight Matrices to assess the statistical significance of transcription factor binding site matches. Use when user asks to calculate the P-value for a match score, determine the score threshold for a specific significance level, or convert between scores and P-values for PWMs.
homepage: https://cloud.r-project.org/web/packages/TFMPvalue/index.html
---


# r-tfmpvalue

name: r-tfmpvalue
description: Efficient and accurate P-value computation for Position Weight Matrices (PWMs). Use this skill when you need to calculate the statistical significance (P-value) of a transcription factor binding site match score, or conversely, to determine the score threshold required to achieve a specific P-value.

# r-tfmpvalue

## Overview
The `TFMPvalue` package provides an R interface to highly efficient algorithms for computing the relationship between scores and P-values in Position Weight Matrices (PWMs). It is particularly useful for identifying putative Transcription Factor Binding Sites (TFBSs) by providing accurate P-values for match scores or finding the necessary score threshold for a given significance level.

## Installation
```R
install.packages("TFMPvalue")
```

## Core Functions

### TFMpvalue
Calculates the P-value for a given score threshold.
```R
library(TFMPvalue)
# Example matrix (4 rows for A, C, G, T)
pwm <- matrix(c(0.1, 0.2, 0.3, 0.4, 0.5, 0.1, 0.1, 0.3), nrow = 4)
score <- 5.5
# Calculate P-value
p_value <- TFMpvalue(pwm, score)
```

### TFMgetThreshold
Calculates the score threshold for a given P-value.
```R
# Find score threshold for P-value 1e-5
threshold <- TFMgetThreshold(pwm, pvalue = 1e-5)
```

### TFMpv2sc and TFMsc2pv
Convenience wrappers for score-to-pvalue and pvalue-to-score conversions.
```R
# P-value to Score
sc <- TFMpv2sc(pwm, pvalue = 1e-9, type = "PFM")

# Score to P-value
pv <- TFMsc2pv(pwm, score = 10, type = "PFM")
```

## Workflow: Working with PWMs
1.  **Input Matrix**: Ensure your matrix has 4 rows (representing A, C, G, T in order).
2.  **Background Probabilities**: By default, the package assumes a uniform background (0.25 for each nucleotide). You can provide custom background probabilities using the `bg` argument.
3.  **Matrix Types**: The package handles different matrix scales. If using a Position Frequency Matrix (PFM), specify `type = "PFM"`.

## Tips
- **Efficiency**: The underlying C++ implementation is optimized for speed, making it suitable for genome-wide scans where many thresholds need to be calculated.
- **Precision**: This package is more accurate than simple sampling methods, especially for very small P-values (e.g., < 1e-6).
- **Log-likelihood**: Most functions expect log-likelihood ratios. If your matrix is in a different format, ensure it is converted appropriately before computation.

## Reference documentation
- [TFMPvalue README](./references/README.md)