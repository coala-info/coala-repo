---
name: bioconductor-packfinder
description: The packFinder package performs de novo prediction of Pack-TYPE transposable elements by identifying terminal inverted repeats flanked by target site duplications. Use when user asks to search for transposable elements in a genome, cluster predicted elements by sequence identity, or export identified sequences for downstream BLAST analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/packFinder.html
---


# bioconductor-packfinder

## Overview

The `packFinder` package provides a specialized workflow for the de novo prediction of Pack-TYPE transposable elements. It identifies potential elements by searching for Terminal Inverted Repeats (TIRs) that are flanked by identical Terminal Site Duplications (TSDs) within a user-defined length range. While sensitive for detection, it does not automatically distinguish between autonomous (transposase-containing) and non-autonomous (Pack-TYPE) elements; therefore, it includes tools for clustering and alignment to facilitate downstream identification (e.g., via BLAST).

## Core Workflow

### 1. Data Preparation
Input sequences must be in `Biostrings` formats. The genome/scaffold should be a `DNAStringSet`, and the TIR query should be a `DNAString`.

```r
library(packFinder)
library(Biostrings)

# Load genome data
genome <- readDNAStringSet("path/to/genome.fasta")

# Define the TIR search query (e.g., first 8-10 bp of a known TIR)
tir_query <- DNAString("CACTACAA")
```

### 2. Searching for Elements
The primary function is `packSearch`. It requires the TIR sequence, the genome, the expected range of the transposon length, and the TSD length.

```r
packMatches <- packSearch(
    tir_query,
    genome,
    elementLength = c(300, 3500), # Min and max length
    tsdLength = 3,                # Length of TSD
    mismatch = 0                  # Allowed mismatches in TIR search
)
```

### 3. Clustering and Analysis
To group related elements (which may share sequence origin), use `packClust`. Note: This requires the `VSEARCH` command-line tool to be accessible.

```r
# Cluster elements based on sequence identity (default 60%)
packMatches <- packClust(
    packMatches,
    genome,
    saveFolder = "output_dir"
)

# Analyze TIR similarities specifically
consensusSeqs <- tirClust(
    packMatches,
    genome,
    tirLength = 25
)
```

### 4. Exporting Results
`packFinder` uses a dataframe format compatible with `GRanges`. You can convert or export results easily.

```r
# Convert to GRanges for use with GenomicRanges package
gr <- packsToGRanges(packMatches)

# Export to FASTA for BLAST analysis
packsToFasta(packMatches, "predicted_elements.fasta", genome)

# Save metadata to CSV
packsToCsv(packMatches, "results.csv")
```

## Step-wise Control
If `packSearch` is too restrictive, you can run the pipeline manually:
1. `identifyTirMatches()`: Find all instances of the TIR and its reverse complement.
2. `getTsds()`: Extract the flanking sequences for each match.
3. `identifyPotentialPackElements()`: Pair forward and reverse TIRs that have matching TSDs and valid distances.
4. `getPackSeqs()`: Extract the full DNA sequences of the predicted elements.

## Tips for Success
- **TIR Selection**: Use the most conserved part of the TIR (usually the first 8-12 bp).
- **TSD Length**: This is family-specific (e.g., 3 bp for CACTA, 8 bp for MULE).
- **Strand Orientation**: `packClust` assigns a "+" strand to the cluster representative; other members are assigned relative to that representative.
- **Filtering**: Use `GenomicRanges` after conversion to remove overlapping predictions that are biologically impossible.

## Reference documentation
- [packFinder Vignette (Rmd)](./references/packFinder.Rmd)
- [packFinder Vignette (Markdown)](./references/packFinder.md)