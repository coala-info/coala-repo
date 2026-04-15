---
name: bioconductor-motifcounter
description: This tool performs statistical analysis of transcription factor binding sites in DNA sequences using higher-order Markov background models. Use when user asks to estimate background models, calculate motif scores, identify hits while accounting for overlapping structures, or perform motif enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/motifcounter.html
---

# bioconductor-motifcounter

name: bioconductor-motifcounter
description: Statistical analysis of transcription factor binding sites (TFBS) in DNA sequences using higher-order Markov background models and compound Poisson or combinatorial distributions. Use this skill when you need to: (1) Estimate background models from DNA sequences, (2) Calculate motif scores and identify hits (TFBS) while accounting for self-overlapping/palindromic structures, (3) Perform motif enrichment analysis with p-values and fold-enrichment, or (4) Generate average score or hit profiles across multiple sequences.

# bioconductor-motifcounter

## Overview

The `motifcounter` package provides a robust statistical framework for analyzing Transcription Factor Binding Sites (TFBS) in DNA sequences. Unlike simpler models, it accounts for the "clumping" effect of self-overlapping and palindromic motifs using a compound Poisson distribution or a combinatorial model. It supports higher-order Markov models (order-d) for background sequences, which is essential for capturing features like CpG islands.

## Core Workflow

### 1. Prepare Background and Motif
The background model should be estimated from sequences representative of your study set. Motifs must be Position Frequency Matrices (PFM) with strictly positive entries.

```r
library(motifcounter)
library(Biostrings)

# 1. Load sequences (DNAStringSet)
seqs <- readDNAStringSet("sequences.fasta")

# 2. Estimate background (order 1 or 2 recommended for enrichment)
bg <- readBackground(seqs, order = 1)

# 3. Prepare Motif (PFM)
# Use normalizeMotif to ensure no zero entries
motif <- normalizeMotif(matrix_data)
```

### 2. Configure Global Options
Set the false positive probability ($\alpha$) which determines the score threshold for calling a "hit".

```r
# Default is 0.001
motifcounterOptions(alpha = 0.001)
```

### 3. Analyze Scores and Hits
You can analyze individual sequences or generate aggregate profiles across a set of sequences (e.g., centered on ChIP-seq peaks).

```r
# Individual sequence analysis
seq <- seqs[[1]]
scores <- scoreSequence(seq, motif, bg) # Returns per-position/strand scores
hits <- motifHits(seq, motif, bg)       # Returns binary hit indicators

# Aggregate profiles (for DNAStringSet)
avg_scores <- scoreProfile(seqs, motif, bg)
avg_hits <- motifHitProfile(seqs, motif, bg)

# Plotting example
plot(avg_hits$fhits, type = "l", col = "blue", main = "Motif Hit Profile")
lines(avg_hits$rhits, col = "red")
```

### 4. Motif Enrichment Testing
This is the primary tool for determining if a motif is significantly over-represented in a set of sequences compared to the background model.

```r
# Computes p-value and fold-enrichment
enrichment <- motifEnrichment(seqs, motif, bg)

# Access results
print(enrichment$pvalue)
print(enrichment$fold)
```

## Technical Tips

- **Model Selection**: Use the **Compound Poisson** model (default) for long sequences and stringent $\alpha$ (e.g., 0.001). Use the **Combinatorial** model for relaxed $\alpha$ (e.g., $\ge 0.01$).
- **Background Order**: Higher-order models (order 2+) are better at capturing local sequence biases but are more computationally expensive. Order 1 is usually sufficient for most enrichment tasks.
- **Strand Specificity**: By default, `motifcounter` scans both strands. For RNA analysis, you may need to configure single-strand scanning in `motifEnrichment`.
- **Clumping**: The package automatically handles overlapping hits (clumps). This prevents over-estimation of significance for repeat-like motifs (e.g., "AAAAA").

## Reference documentation

- [motifcounter](./references/motifcounter.md)