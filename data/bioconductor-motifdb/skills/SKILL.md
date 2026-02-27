---
name: bioconductor-motifdb
description: MotifDb provides a unified interface to query and retrieve thousands of annotated transcription factor binding motifs from multiple public databases. Use when user asks to search for transcription factor motifs, filter motifs by organism or data source, and export position frequency matrices for sequence analysis or visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/MotifDb.html
---


# bioconductor-motifdb

## Overview
MotifDb is a comprehensive, annotated collection of over ten thousand transcription factor binding motifs (represented as position frequency matrices) from multiple public sources. It provides a unified interface to query and subset motifs based on metadata such as organism, transcription factor name, and data source.

## Quick Start
To use MotifDb, load the library and use the `query` function to search the central `MotifDb` object.

```r
library(MotifDb)

# Basic case-insensitive search for a specific factor
ctcf_motifs <- query(MotifDb, "ctcf")

# View summary of results
print(ctcf_motifs)
```

## Advanced Querying
The `query` function supports complex filtering using inclusive and exclusive strings.

```r
# Refined search: Human, specific sources, excluding variants
motifs <- query(MotifDb, 
                andStrings = c("CTCF", "hsapiens"),
                orStrings = c("jaspar2018", "hocomocov11-core-A"),
                notStrings = "ctcfl")
```

## Common Workflows

### 1. Inspecting Motifs
MotifDb objects act like lists. You can extract individual matrices or get consensus sequences.

```r
# Get the consensus sequence for the first match
library(Biostrings)
consensusString(motifs[[1]])

# Apply to all matches in a subset
sapply(motifs, consensusString)
```

### 2. Visualization
MotifDb matrices are compatible with visualization packages like `seqLogo`.

```r
library(seqLogo)
# Visualize the first motif in the subset
seqLogo(motifs[[1]])
```

### 3. Exporting for External Tools
Matrices can be exported for use in the MEME Suite (e.g., FIMO or Tomtom) or other Bioconductor packages like `PWMEnrich` or `TFBSTools`.

## Usage Tips
* **Metadata Search:** The `query` function searches across all metadata columns (organism, geneSymbol, dataSource, etc.). If a search is too broad, use `andStrings` to narrow it down by organism (e.g., "Mmusculus", "Hsapiens").
* **Matrix Format:** The matrices stored are typically position frequency matrices (PFMs). If you need Position Weight Matrices (PWMs) for sequence matching, use `Biostrings::PWM(motifs[[1]])`.
* **False Precision:** Be cautious when using motif matching alone to predict binding. High motif scores do not always correlate with in vivo binding; consider integrating ATAC-seq or ChIP-seq data for better accuracy.

## Reference documentation
- [MotifDb](./references/MotifDb.md)