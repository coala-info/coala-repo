---
name: bioconductor-ggseqalign
description: The ggseqalign package visualizes pairwise sequence alignments by mapping structural differences like mismatches and gaps onto a coordinate system using ggplot2. Use when user asks to visualize pairwise alignments, plot genomic or proteomic structural differences, or create customizable alignment plots in R.
homepage: https://bioconductor.org/packages/release/bioc/html/ggseqalign.html
---

# bioconductor-ggseqalign

## Overview

The `ggseqalign` package provides a specialized framework for visualizing pairwise alignments in R. Unlike traditional alignment viewers that display every character (which becomes unreadable for long sequences), `ggseqalign` focuses on structural differences. It maps mismatches, insertions, and deletions onto a coordinate system, producing `ggplot2` objects that are highly customizable and suitable for comparing long genomic or proteomic sequences.

## Core Workflow

The package follows a simple two-step process:

1.  **Generate Alignment Data**: Use `alignment_table()` to perform the alignment and extract difference coordinates.
2.  **Visualize**: Use `plot_sequence_alignment()` to render the results.

### 1. Basic Usage

```r
library(ggseqalign)
library(ggplot2)

# Define query and subject (can be character vectors or Biostrings objects)
query_strings <- c("variant_A", "variant_B")
subject_string <- "reference_sequence"

# Create the alignment table
alignment <- alignment_table(query_strings, subject_string)

# Plot the results
plot_sequence_alignment(alignment)
```

### 2. Working with Biostrings

The package is fully compatible with `DNAStringSet` and `AAStringSet` objects from the `Biostrings` package.

```r
library(Biostrings)

# Load sequences from FASTA
query_seqs <- readDNAStringSet("queries.fasta")
ref_seq <- readDNAStringSet("reference.fasta")

# Align and plot
aln_data <- alignment_table(query_seqs, ref_seq)
plot_sequence_alignment(aln_data)
```

### 3. Handling High-Noise Alignments

If sequences are highly divergent, the plot may become cluttered with mismatch indicators. You can suppress character-level mismatches to focus purely on structural gaps (insertions/deletions).

```r
plot_sequence_alignment(alignment, hide_mismatches = TRUE)
```

### 4. Customizing Alignment Parameters

`alignment_table()` passes additional arguments to `pwalign::pairwiseAlignment()`. You can adjust gap penalties or substitution matrices directly.

```r
# Increase gap opening penalty to discourage small gaps
alignment <- alignment_table(query_strings, subject_string, gapOpening = 20)
```

### 5. Styling with ggplot2

Because the output is a `ggplot` object, you can extend it using standard `ggplot2` functions.

```r
p <- plot_sequence_alignment(alignment)

p + 
  ylab("Sample ID") + 
  xlab("Position (bp)") +
  scale_color_viridis_d() +
  theme_minimal()
```

## Advanced Layer Modification

The plot object contains specific layers that can be modified for fine-tuned control:
- **Layer 2**: Usually the white bars representing deletions.
- **Layer 8**: Usually the points representing mismatches.

To change the mismatch point shape or size:
```r
pl <- plot_sequence_alignment(alignment)
pl$layers[[8]]$aes_params$size <- 2
pl$layers[[8]]$aes_params$shape <- 4 # Crosses instead of dots
pl
```

## Reference documentation

- [Quickstart Guide to ggseqalign](./references/ggseqalign.Rmd)
- [ggseqalign Vignette](./references/ggseqalign.md)