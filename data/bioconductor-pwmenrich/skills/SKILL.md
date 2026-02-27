---
name: bioconductor-pwmenrich
description: This tool performs DNA motif enrichment analysis using Position Weight Matrices to identify over-represented transcription factor binding sites in sequences. Use when user asks to scan DNA sequences for motifs, calculate motif enrichment against genomic backgrounds, visualize binding sites, or create custom motif background distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/PWMEnrich.html
---


# bioconductor-pwmenrich

name: bioconductor-pwmenrich
description: Perform DNA motif enrichment analysis using Position Weight Matrices (PWMs). Use this skill to scan DNA sequences for known motifs, calculate enrichment against genomic backgrounds (lognormal or threshold-based), visualize binding sites, and create custom motif background distributions.

## Overview
PWMEnrich is a Bioconductor package designed for Position Weight Matrix (PWM) enrichment analysis. It allows researchers to scan a single sequence (like an enhancer) or multiple sequences (like ChIP-seq peaks) to identify over-represented transcription factor binding sites. It utilizes a threshold-free lognormal affinity approach by default, which compares average affinity to a genomic background, though it also supports traditional threshold-based binomial tests.

## Typical Workflow

1. **Load Background Data**: Load the package and the appropriate pre-compiled background for your organism (e.g., `PWMEnrich.Dmelanogaster.background`, `PWMEnrich.Hsapiens.background`).
2. **Prepare Sequences**: Load DNA sequences using `Biostrings::readDNAStringSet()`.
3. **Run Enrichment**: Use `motifEnrichment()` to calculate scores.
4. **Generate Reports**: Use `sequenceReport()` for individual sequences or `groupReport()` for a collection of sequences.
5. **Visualize**: Use `plot()` on report objects or `plotMotifScores()` to map hits to specific sequence coordinates.

## Key Functions and Usage

### Motif Enrichment Analysis
```r
library(PWMEnrich)
library(PWMEnrich.Dmelanogaster.background)

# Load pre-compiled background (e.g., D. mel MotifDb)
data(PWMLogn.dm3.MotifDb.Dmel)

# Perform enrichment on a DNAStringSet
res = motifEnrichment(my_sequences, PWMLogn.dm3.MotifDb.Dmel)

# Get a ranked report for the whole group
report = groupReport(res)

# Get a report for the first sequence only
seq_report = sequenceReport(res, 1)

# Plot top enriched motifs
plot(report[1:10])
```

### Examining Specific Binding Sites
To find where motifs actually bind within a sequence:
```r
# Get raw scores for specific PWMs
scores = motifScores(my_sequences, my_pwms, raw.scores = TRUE)

# Plot scores along the sequence (forward and reverse strands)
plotMotifScores(scores, cols = c("red", "blue"))
```

### Custom Backgrounds and Motifs
If using motifs not in the standard background packages:
```r
# Read custom motifs (JASPAR/TRANSFAC)
motifs = readMotifs("my_motifs.transfac")

# Convert to PWM using genomic frequencies
pwms = toPWM(motifs, prior = getBackgroundFrequencies("dm3"))

# Create a custom background (use quick=FALSE for production)
bg = makeBackground(pwms, organism = "dm3", type = "logn")
```

## Performance and Optimization
*   **Parallelization**: Use `registerCoresPWMEnrich(N)` to enable multi-core processing (not supported on Windows).
*   **Memory**: Use `useBigMemoryPWMEnrich(TRUE)` to enable a high-performance memory backend for large-scale scans.
*   **Human Sequences**: When creating backgrounds for human data, set `algorithm = "human"` in `makeBackground()` to account for varying sequence lengths.

## Reference documentation
- [PWMEnrich Overview](./references/PWMEnrich.md)