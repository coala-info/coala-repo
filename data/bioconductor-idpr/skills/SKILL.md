---
name: bioconductor-idpr
description: This tool analyzes intrinsically disordered proteins and regions by calculating physicochemical properties and performing sequence alignments. Use when user asks to calculate protein charge and hydropathy, generate Uversky plots, identify disordered regions using sliding windows, or align sequences using specialized disorder-specific substitution matrices.
homepage: https://bioconductor.org/packages/release/bioc/html/idpr.html
---


# bioconductor-idpr

name: bioconductor-idpr
description: Analysis of Intrinsically Disordered Proteins (IDPs) and Regions (IDRs) using the idpr package. Use this skill to calculate protein charge, hydropathy, and structural tendencies, or to perform sequence alignments using specialized substitution matrices for disordered proteins.

## Overview

The `idpr` package provides tools for the computational analysis of Intrinsically Disordered Proteins (IDPs). It facilitates the calculation of physicochemical properties (charge and hydropathy) that distinguish disordered from ordered proteins and provides specialized substitution matrices for more accurate sequence alignments of IDRs.

## Core Workflows

### 1. Charge and Hydropathy Analysis
IDPs are characterized by high net charge and low mean hydropathy.

```r
library(idpr)

# Example sequence (Human P53)
seq <- TP53Sequences[2]

# Calculate Mean Scaled Hydropathy (X-axis value)
msh <- meanScaledHydropathy(seq)

# Calculate Net Charge (Y-axis value)
nc <- netCharge(seq, averaged = TRUE)

# Generate a Charge-Hydropathy Plot (Uversky Plot)
# This identifies if a protein falls into the "Extended IDP" or "Collapsed" region
chargeHydropathyPlot(seq)
```

### 2. Local Property Profiling
Use sliding windows to identify specific disordered regions within a sequence.

```r
# Predict folded/unfolded regions using FoldIndex
foldIndexR(seq, plotResults = TRUE)

# Local Hydropathy (sliding window)
scaledHydropathyLocal(seq, window = 21, plotResults = TRUE)

# Local Charge (sliding window)
chargeCalculationLocal(seq, window = 21, plotResults = TRUE)
```

### 3. Sequence Visualization
Map properties directly onto the amino acid sequence.

```r
# Calculate global charge per residue
charge_data <- chargeCalculationGlobal(seq)

# Map charge to sequence with custom colors
sequenceMap(sequence = charge_data$AA,
            property = charge_data$Charge,
            customColors = c("red", "blue", "grey65"))
```

### 4. Disordered Substitution Matrices
Standard matrices (BLOSUM/PAM) often penalize IDR mutations incorrectly. Use `idpr` matrices for alignments involving disordered proteins.

**Available Matrices:**
*   **EDSSMat62:** Best performing for general IDP alignments.
*   **Disorder40 / Disorder85:** Optimized for highly disordered proteins.
*   **DUNMat:** Early disorder-specific matrix.

**Alignment Example:**
```r
library(pwalign) # or Biostrings

# Pairwise alignment using EDSSMat62
# Note: Higher gap penalties are often recommended for these matrices
alignment <- pairwiseAlignment(seq1, seq2,
                               substitutionMatrix = EDSSMat62,
                               gapOpening = 19,
                               gapExtension = 2)
```

## Tips and Parameters

*   **pKa Sets:** `netCharge()` supports multiple pKa sets (e.g., "IPC_protein", "EMBOSS", "Lehninger"). "IPC_protein" is the default and generally recommended.
*   **Window Sizes:** Functions like `scaledHydropathyLocal` and `chargeCalculationLocal` require an **odd integer** for the window size.
*   **Termini:** `chargeCalculationGlobal` includes termini by default. Use `includeTermini = FALSE` to ignore them or `sumTermini = FALSE` to treat them as separate residues ("NH3" and "COO").
*   **ggplot2 Integration:** Most plotting functions return `ggplot` objects, allowing for further customization (labels, themes, facets).

## Reference documentation

- [Charge and Hydropathy Vignette](./references/chargeHydropathy-vignette.md)
- [Disordered Matrices Vignette](./references/disorderedMatrices-vignette.md)
- [idpr Vignette](./references/idpr-vignette.md)
- [IUPred Vignette](./references/iupred-vignette.md)
- [Sequence Map Vignette](./references/sequenceMAP-vignette.md)
- [Structural Tendency Vignette](./references/structuralTendency-vignette.md)