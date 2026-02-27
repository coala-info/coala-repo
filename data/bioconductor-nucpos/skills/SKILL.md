---
name: bioconductor-nucpos
description: This tool calculates Histone Binding Affinity scores and predicts nucleosome positions using chemical map-based models for multiple species. Use when user asks to calculate HBA scores for 147-bp DNA sequences, evaluate local histone-DNA binding preferences, or analyze nucleosomal suitability using high-resolution chemical mapping data.
homepage: https://bioconductor.org/packages/release/bioc/html/nuCpos.html
---


# bioconductor-nucpos

name: bioconductor-nucpos
description: Predicts nucleosome positions and calculates Histone Binding Affinity (HBA) scores using chemical map-based models for S. cerevisiae, S. pombe, and M. musculus. Use this skill when you need to analyze 147-bp DNA sequences for nucleosomal suitability, calculate local HBA scores for subnucleosomal segments, or evaluate histone-DNA binding preferences based on high-resolution chemical mapping data.

# bioconductor-nucpos

## Overview

The `nuCpos` package is an R-based tool derived from NuPoP, specifically designed to calculate Histone Binding Affinity (HBA) scores. Unlike traditional MNase-seq based models, `nuCpos` utilizes chemical map-based models which provide base-pair resolution for nucleosome positioning. It is primarily used to evaluate how well a specific 147-bp DNA sequence can wrap around a histone octamer, providing both a global score and localized scores for 13 subnucleosomal segments (A through M).

## Core Functions

### HBA Calculation

The `HBA()` function calculates a single affinity score for a 147-bp sequence.

```r
library(nuCpos)

# Input can be a character string or a Biostrings::DNAString object
# Sequence MUST be exactly 147 bp
sequence <- "ATCG..." # 147 bp string

# Species options: 
# "sc" (S. cerevisiae)
# "sp" (S. pombe)
# "mm" (M. musculus)
result <- HBA(inseq = sequence, species = "sc")
print(result)
```

### Local HBA Calculation

The `localHBA()` function breaks the 147-bp sequence into 13 overlapping subsegments (A-M) to identify which specific regions of the DNA contribute most to binding affinity.

```r
# Returns a named vector of 13 scores
lHBA_scores <- localHBA(inseq = sequence, species = "sc")

# Segment G corresponds to the central 21 bp (dyad axis)
# Visualization is often helpful for interpreting local HBA
barplot(lHBA_scores, names.arg = LETTERS[1:13], 
        main = "Local HBA Scores", xlab = "Subsegments", ylab = "Score")
```

## Workflow and Interpretation

1.  **Input Preparation**: Ensure your DNA sequence is exactly 147 bp. If working with genomic ranges, use `Biostrings::getSeq()` to extract the sequences first.
2.  **Species Selection**: Choose the model closest to your organism of interest. The chemical maps for budding yeast ("sc"), fission yeast ("sp"), and mouse ESCs ("mm") capture different structural preferences.
3.  **Score Interpretation**:
    *   **HBA Score**: Represents the overall favorability of the 147-bp wrap.
    *   **Local HBA**: Helps identify rotational settings or specific motifs that favor/disfavor positioning. For example, high scores in specific segments indicate regions suitable for nucleosome formation.
4.  **Integration with NuPoP**: While `nuCpos` focuses on HBA calculation for specific sequences, for whole-genome dHMM-based nucleosome prediction using chemical maps, it is recommended to use the `NuPoP` package functions.

## Tips

*   **Dependencies**: `nuCpos` requires the `Biostrings` package for handling `DNAString` objects.
*   **Data Loading**: You can find example 147-bp sequences within the package using `system.file("extdata", "inseq.RData", package = "nuCpos")`.
*   **Sequence Length**: The functions are strict about the 147-bp requirement; passing sequences of other lengths will result in errors.

## Reference documentation

- [An introduction to the nuCpos package](./references/nuCpos-intro.md)