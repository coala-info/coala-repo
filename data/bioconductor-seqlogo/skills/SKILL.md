---
name: bioconductor-seqlogo
description: This tool creates and customizes sequence logos for DNA and RNA sequence alignments using position weight matrices. Use when user asks to visualize motif conservation, calculate information content in bits, or generate sequence logos from frequency matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/seqLogo.html
---


# bioconductor-seqlogo

name: bioconductor-seqlogo
description: Create and customize sequence logos for DNA and RNA sequence alignments using position weight matrices (PWMs). Use this skill when you need to visualize motif conservation, calculate information content (bits), or generate publication-quality sequence logos from frequency matrices.

# bioconductor-seqlogo

## Overview
The `seqLogo` package is a Bioconductor tool for visualizing DNA or RNA sequence alignments as sequence logos. It represents the information content (IC) at each position of a motif. The height of a stack represents the total information content (measured in bits, max 2 for DNA/RNA), while the height of individual letters within the stack represents their relative frequency.

## Core Workflow

### 1. Prepare the Input Matrix
The input must be a $4 \times W$ matrix or data frame where rows represent nucleotides (A, C, G, T/U) and columns represent positions. Each column must sum to 1.0.

```r
# Example: Manual matrix creation
m <- matrix(c(0.8, 0.1, 0.1, 0.0,  # Pos 1
              0.1, 0.8, 0.0, 0.1,  # Pos 2
              0.0, 0.0, 0.5, 0.5), # Pos 3
            nrow = 4, 
            dimnames = list(c("A", "C", "G", "T"), 1:3))
```

### 2. Create a PWM Object
Use `makePWM()` to convert a raw matrix into a `pwm` class object. This function validates the input and calculates the information content profile and consensus sequence.

```r
library(seqLogo)
p <- makePWM(m)

# Accessing slots
pwm(p)       # The normalized matrix
ic(p)        # Information content per position
consensus(p) # Consensus sequence
```

### 3. Generate the Sequence Logo
Use the `seqLogo()` function to plot the visualization.

```r
# Standard logo (height proportional to Information Content)
seqLogo(p)

# Probability logo (all columns same height, showing relative frequency)
seqLogo(p, ic.scale = FALSE)
```

## Customization and RNA Support

### Custom Colors
You can override default colors by providing a named character vector to the `fill` argument.

```r
custom_cols <- c(A = "#4daf4a", C = "#377eb8", G = "#ffd92f", T = "#e41a1c")
seqLogo(p, fill = custom_cols)
```

### RNA Logos
To create RNA logos, specify the alphabet during PWM construction. The plotting function will automatically handle "U" (using the color assigned to "T" if not explicitly provided).

```r
r_mat <- makePWM(m, alphabet = "RNA")
seqLogo(r_mat)
```

## Tips and Troubleshooting
- **Column Sums**: `makePWM()` will error if columns do not sum to 1. Ensure your input data is normalized.
- **Object Classes**: While `seqLogo()` can accept a raw matrix or data frame, using `makePWM()` first is recommended to ensure data integrity and access IC values.
- **Graphics Device**: `seqLogo` uses the `grid` graphics system. If you are capturing the output to a file (e.g., `pdf()` or `png()`), ensure you call `dev.off()` to finalize the plot.

## Reference documentation
- [Sequence logos for DNA sequence alignments](./references/seqLogo.md)