---
name: bioconductor-logolas
description: Logolas is an R package for creating flexible sequence logos that visualize both enrichment and depletion of biological or alphanumeric symbols. Use when user asks to visualize sequence logos, create enrichment depletion logos, plot positional frequency matrices, or generate consensus sequences from genomic data.
homepage: https://bioconductor.org/packages/3.8/bioc/html/Logolas.html
---


# bioconductor-logolas

## Overview

Logolas (Logo Lasso) is a flexible R package for visualizing sequence logos. Unlike traditional tools that only show enrichment, Logolas introduces **Enrichment Depletion Logos (EDLogos)** to highlight both over-represented and under-represented symbols. It supports standard biological characters (DNA/RNA/AA) as well as arbitrary alphanumeric strings, making it suitable for mutation signatures, histone marks, and other genomic data.

## Installation

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("Logolas")
library(Logolas)
```

## Core Workflows

### 1. Data Input Types
Logolas accepts two primary input formats:
*   **Character Sequences:** A vector of aligned strings of equal length.
*   **PFM/PWM:** A Positional Frequency (or Weight) Matrix where rows are symbols and columns are positions.

### 2. Creating Logos with `logomaker()`
The primary function is `logomaker()`.

*   **Standard Logo:**
    ```r
    logomaker(sequence_data, type = "Logo")
    ```
*   **Enrichment Depletion Logo (EDLogo):**
    ```r
    logomaker(sequence_data, type = "EDLogo")
    ```
*   **Amino Acid Sequences:**
    ```r
    logomaker(aa_sequences, type = "EDLogo")
    ```

### 3. Customization Options
*   **Coloring:** Use `color_type` ("per_row", "per_column", "per_symbol") and `color_seed` to vary the palette.
*   **Fill Styles:** Control borders vs. filled shapes using `logo_control`.
    ```r
    # Example: Transparent fill (borders only)
    logomaker(data, logo_control = list(control = list(tofill = FALSE)))
    ```
*   **Background Probabilities:** Use the `bg` argument to provide a vector or matrix of background frequencies to adjust for composition bias.
*   **Adaptive Scaling:** Set `use_dash = TRUE` to apply Dirichlet Adaptive Shrinkage, which scales stack heights based on the sample size (number of sequences).

### 4. Specialized Logos
*   **String Symbols:** Logolas can plot multi-character strings (e.g., "H3K4me3").
    ```r
    data("mutation_sig")
    logomaker(mutation_sig, type = "Logo", color_type = "per_symbol")
    ```
*   **PSSM Logos:** Use `logo_pssm()` for pre-calculated Position Specific Scoring Matrices.
    ```r
    logo_pssm(pssm_matrix, control = list(round_off = 0))
    ```

### 5. Consensus Sequences
Generate a string representation of the logo, where parentheses indicate depletion.
```r
# Returns a string like "C T (Ag) T" (Enriched A, Depleted G at pos 3)
GetConsensusSeq(sequence_vector)
```

### 6. Multi-panel Plots
Use `get_viewport_logo()` to arrange multiple logos in one device.
```r
Logolas::get_viewport_logo(1, 2) # 1 row, 2 columns
grid::seekViewport("plotlogo1")
logomaker(seq1, logo_control = list(newpage = FALSE))
grid::seekViewport("plotlogo2")
logomaker(seq2, logo_control = list(newpage = FALSE))
```

## Reference documentation

- [Guided Logolas Tutorial](./references/Logolas.Rmd)
- [Logolas Vignette](./references/Logolas.md)