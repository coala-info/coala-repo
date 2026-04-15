---
name: bioconductor-transite
description: The transite package identifies RNA-binding proteins that modulate gene expression by analyzing the distribution and enrichment of RNA-binding motifs in transcript sequences. Use when user asks to perform spectrum motif analysis, identify overrepresented RNA-binding motifs, or analyze RBP targets across ranked lists of transcripts.
homepage: https://bioconductor.org/packages/release/bioc/html/transite.html
---

# bioconductor-transite

## Overview

The `transite` package is a computational platform for identifying RBPs that modulate gene expression changes. It utilizes a comprehensive database of RNA-binding motifs and provides two primary methods for analysis:
1.  **Spectrum Motif Analysis (SPMA):** Investigates how RBP targets are distributed across a spectrum of transcripts (e.g., all genes ranked by differential expression).
2.  **Enrichment Analysis:** Identifies motifs overrepresented in a foreground set of sequences compared to a background set.

## Core Workflow: Spectrum Motif Analysis (SPMA)

SPMA is the flagship feature of `transite`, used to see if specific RBP motifs follow a non-random distribution (e.g., increasing or decreasing) across a ranked list of transcripts.

### 1. Data Preparation
Input data should be a data frame containing RefSeq IDs, a ranking value (like signal-to-noise ratio or log fold change), and the sequences.

```r
library(transite)
library(dplyr)

# Example: Load and sort by signal-to-noise ratio
df <- transite:::ge$background_df
df <- arrange(df, value)

# Convert DNA to RNA (motifs are RNA-based)
sequences <- gsub("T", "U", df$seq)

# Name sequences using format: [REFSEQ]|[SEQ_TYPE]
names(sequences) <- paste0(df$refseq, "|", df$seq_type)
```

### 2. Executing SPMA
You can run the analysis using position weight matrices (PWMs) or k-mers. PWM-based analysis is generally more sensitive.

```r
# Run for all motifs in the database (cached for efficiency)
results <- run_matrix_spma(sequences, cache = TRUE)

# Run for a specific motif by ID
motif_db <- get_motif_by_id("M178_0.6")
results_subset <- run_matrix_spma(sequences, motifs = motif_db, cache = FALSE)
```

### 3. Interpreting Results
The output is a list containing scores, data frames, and plots.

*   **`spectrum_plots`**: Visualizes motif density across the spectrum.
*   **`spectrum_info_df`**: Contains statistical classification of the distribution.
*   **Classification Criteria**: A motif is considered "non-random" if it meets thresholds for adjusted $R^2$, polynomial degree, slope, and p-value.

```r
# View the spectrum plot for the first motif
print(results$spectrum_plots[[1]])

# Check statistical classification
print(results$spectrum_info_df[1, ])
```

## Key Functions

### Motif Management
*   `get_motifs()`: Retrieves the entire motif database.
*   `get_motif_by_id(id)`: Retrieves a specific motif (e.g., "M178_0.6").
*   `get_motif_by_rbp(name)`: Retrieves motifs associated with a specific RBP.

### Analysis Functions
*   `run_matrix_spma()`: Matrix-based Spectrum Motif Analysis.
*   `run_kmer_spma()`: K-mer-based Spectrum Motif Analysis.
*   `calculate_local_consistency()`: Calculates the consistency score for a motif distribution.

## Tips for Success
*   **Sequence Types**: Ensure `seq_type` is correctly labeled (3'-UTR, 5'-UTR, or mRNA) as RBP binding behavior varies significantly between these regions.
*   **Caching**: Set `cache = TRUE` in `run_matrix_spma` when running large batches to avoid redundant calculations in iterative sessions.
*   **Ranking**: The order of `sequences` is critical. Always ensure the vector is pre-sorted by your metric of interest (e.g., fold change) before passing it to the analysis functions.

## Reference documentation
- [Spectrum Motif Analysis (SPMA)](./references/spma.md)