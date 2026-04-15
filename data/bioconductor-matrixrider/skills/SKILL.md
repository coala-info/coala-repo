---
name: bioconductor-matrixrider
description: This tool calculates total binding affinity and occupancy for transcription factor binding site matrices on DNA sequences using a thermodynamic-based approach. Use when user asks to calculate total binding affinity, determine sequence occupancy for transcription factors, or evaluate binding potential without using arbitrary score cutoffs.
homepage: https://bioconductor.org/packages/release/bioc/html/MatrixRider.html
---

# bioconductor-matrixrider

name: bioconductor-matrixrider
description: Calculate total binding affinity (TBA) and occupancy for transcription factor binding site (TFBS) matrices on DNA sequences. Use this skill when you need to evaluate the binding potential of one or more Position Frequency Matrices (PFMs) across a sequence without relying solely on arbitrary score cutoffs, or when comparing total affinity versus occupancy-based models.

## Overview

MatrixRider provides a thermodynamic-based approach to DNA-protein interaction analysis. Instead of identifying discrete binding sites using a threshold, it sums the affinity contributions of all subsequences (including low-affinity sites) to calculate a Total Binding Affinity (TBA). It integrates with Bioconductor's `TFBSTools` and `JASPAR` data packages to streamline the workflow of obtaining matrices and scoring sequences.

## Core Workflow

### 1. Prepare Input Data
You need a DNA sequence (as a `DNAString` or `DNAStringSet`) and one or more Position Frequency Matrices (PFMs).

```r
library(MatrixRider)
library(JASPAR2014)
library(TFBSTools)
library(Biostrings)

# Get a PFM from JASPAR
pfm <- getMatrixByID(JASPAR2014, "MA0004.1")

# Define a sequence
sequence <- DNAString("CACGTG")
```

### 2. Calculate Occupancy or Total Affinity
The primary function is `getSeqOccupancy(sequence, matrix, cutoff)`.

*   **Total Affinity:** Set `cutoff = 0`. This sums all affinity values across the sequence.
*   **Perfect Match Only:** Set `cutoff = 1`. This only considers sites that perfectly match the matrix.
*   **Occupancy:** Set a `cutoff` between 0 and 1 (e.g., 0.8). This sums only the affinities that are greater than or equal to the specified fraction of the maximum possible score for that matrix.

```r
# Calculate Total Affinity (cutoff = 0)
total_affinity <- getSeqOccupancy(sequence, pfm, 0)

# Calculate Occupancy with a 0.9 cutoff
occupancy <- getSeqOccupancy(sequence, pfm, 0.9)
```

### 3. Working with Multiple Matrices
You can pass a `PFMatrixList` to `getSeqOccupancy` to process multiple transcription factors simultaneously. The result is a named numeric vector.

```r
pfm2 <- getMatrixByID(JASPAR2014, "MA0005.1")
pfms <- PFMatrixList(pfm, pfm2)
names(pfms) <- c(name(pfm), name(pfm2))

# Returns a vector of affinities for both matrices
results <- getSeqOccupancy(sequence, pfms, 0)
```

## Implementation Details

*   **Background Frequencies:** The calculation uses the background information stored within the `PFMMatrix` object. Ensure your PFM has appropriate background frequencies set if you are using custom matrices.
*   **Pseudocounts:** The package automatically adds a pseudocount of 1 to any zero counts in the PFM to avoid infinite values during likelihood ratio calculations.
*   **Strand Handling:** The algorithm automatically considers both the plus and minus strands, taking the maximum affinity between the two at each position.

## Tips for Success

*   **Custom Matrices:** If using matrices from sources other than JASPAR, manually construct a `PFMatrix` object ensuring the `ID`, `name`, `matrix` (integer counts), and `bg` (background frequencies) slots are correctly populated.
*   **Memory Efficiency:** When working with very large sequences or thousands of matrices, consider iterating over the `PFMatrixList` or chunking the DNA sequence if memory limits are reached.
*   **Interpretation:** Total affinity (cutoff 0) is often more predictive of actual binding in vivo than single-site cutoff methods because it accounts for the cumulative effect of multiple weak binding sites.

## Reference documentation

- [MatrixRider](./references/MatrixRider.md)