---
name: bioconductor-triplex
description: This tool searches for and visualizes intramolecular DNA triplexes (H-DNA) within genomic sequences. Use when user asks to identify triplex-forming sequences, calculate stability scores and P-values, or generate 2D and 3D visualizations of triple-helical structures.
homepage: https://bioconductor.org/packages/release/bioc/html/triplex.html
---


# bioconductor-triplex

name: bioconductor-triplex
description: Search and visualize intramolecular DNA triplexes (H-DNA) in genomic sequences. Use this skill when you need to identify potential triplex-forming sequences, calculate their stability scores and P-values, or generate 2D/3D visualizations of triple-helical structures from DNAString or BSgenome objects.

## Overview

The `triplex` package provides an R interface to a dynamic-programming search strategy for detecting intramolecular triplexes. It identifies subsequences likely to fold into H-DNA based on canonical nucleotide triplets. Beyond detection, it supports calculating base-pairing alignments and generating graphical representations in 2D and 3D.

## Core Workflow

### 1. Detection

Use `triplex.search()` to find potential triplexes in a `DNAString` object.

```R
library(triplex)
seq <- DNAString("TTGGGGAAAGCAATGCCAGGCAGGGGGTTCCTTTCGTTACGGTCCGTCCC")

# Search for all 8 types of triplexes
t <- triplex.search(seq)

# Search with specific constraints
t_filtered <- triplex.search(seq, 
                             min_len=10,      # Min length of triplex stems
                             max_len=20,      # Max length of triplex stems
                             min_score=14,    # Filter by quality score
                             p_value=0.05,    # Filter by P-value
                             type=1)          # Search only specific triplex type (0-7)
```

### 2. Inspecting Results

Results are returned as a `TriplexViews` object (extending `XStringViews`).

- **Columns**: `start`, `width`, `score`, `pvalue`, `ins` (insertions), `type`, `s` (strand), `lstart` (loop start), `lend` (loop end).
- **Sorting**: `ts <- t[order(score(t), decreasing=TRUE)]`

### 3. Visualization

The package supports three levels of visualization:

- **Text Alignment**: Shows the alignment of the three strands and the loop.
  ```R
  triplex.alignment(t[1])
  ```
- **2D Diagram**: Generates a graphical plot of Watson-Crick and Hoogsteen base pairing.
  ```R
  triplex.diagram(t[1])
  ```
- **3D Model**: Opens an interactive 3D model using the `rgl` package.
  ```R
  triplex.3D(t[1])
  ```

### 4. Exporting and Conversion

Convert `TriplexViews` to standard Bioconductor objects for downstream analysis.

- **To GRanges**: Useful for genomic overlaps or exporting to GFF3.
  ```R
  library(rtracklayer)
  gr <- as(t, "GRanges")
  export(gr, "results.gff", version="3")
  ```
- **To DNAStringSet**: Useful for sequence analysis or exporting to FASTA.
  ```R
  dss <- as(t, "DNAStringSet")
  writeXStringSet(dss, file="results.fa", format="fasta")
  ```

## Working with BSgenome

For real-world genomic analysis, extract sequences from `BSgenome` packages.

```R
library(BSgenome.Celegans.UCSC.ce10)
# Search first 100kb of chromosome X
t <- triplex.search(Celegans[["chrX"]][1:100000], min_score=17, min_len=8)
```

## Parameters and Scoring

- **Triplex Types**: 8 types are distinguished based on strand orientation (parallel/antiparallel) and which strand is the third strand.
- **Scoring**: Quality is decreased by mismatches, insertions, and deletions.
- **Penalties**: Parameters like `mis_pen`, `ins_pen`, and `iso_pen` (isomorphic group change) can be adjusted to tune the search sensitivity.
- **P-values**: Calculated based on Extreme Value Distribution (EVD) parameters ($\lambda$ and $\mu$).

## Reference documentation

- [Triplex: User Guide](./references/triplex.md)