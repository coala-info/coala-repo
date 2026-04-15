---
name: bioconductor-crisprseekplus
description: This tool provides a graphical interface for gRNA design, off-target scoring, and GUIDE-seq data analysis. Use when user asks to design target-specific gRNAs, score potential off-target effects, process GUIDE-seq sequencing data, or compare two sequences for allele-specific targeting.
homepage: https://bioconductor.org/packages/3.6/bioc/html/crisprseekplus.html
---

# bioconductor-crisprseekplus

## Overview

The `crisprseekplus` package provides a graphical user interface (Shiny-based) and functional wrappers for the `CRISPRseek` and `GUIDEseq` packages. It streamlines the design of target-specific gRNAs, scores potential off-target effects, and processes GUIDE-seq sequencing data to identify double-stranded oligonucleotide (dsODN) insertion sites. It is particularly useful for researchers needing to validate gRNA specificity and efficiency in genomic editing experiments.

## Core Workflows

### 1. Off-Target Analysis
This workflow automates the identification of gRNAs for a target sequence, searches for off-target hits in a reference genome, and calculates cleavage scores.

*   **Key Steps:**
    *   Identify potential gRNAs in the input sequence.
    *   Score off-targets based on mismatch positions and types.
    *   Filter results to identify gRNAs with high on-target efficiency and low off-target risk.
*   **Outputs:**
    *   `OfftargetAnalysis.xls`: Detailed off-target site information.
    *   `Summary.xls`: Summary of identified gRNAs.
    *   `REcutDetails.xls`: Restriction enzyme cut sites for experimental validation.
    *   `pairedgRNAs.xls`: Potential paired gRNA configurations (e.g., for nickases).

### 2. Compare 2 Sequences
Used to identify gRNAs that can distinguish between two similar sequences (e.g., wild-type vs. mutant alleles) or find gRNAs that target both.

*   **Logic:** It generates gRNAs for both sequences and cross-scores them against the other.
*   **Application:** Useful for allele-specific CRISPR interference or activation.
*   **Output:** `scoresFor2InputSequences.xls`, sorted by the score difference between the two targets.

### 3. GUIDE-seq Analysis
Processes raw GUIDE-seq data to map actual double-strand breaks (DSBs) captured by dsODNs.

*   **Process:**
    *   Filters reads by Unique Molecular Identifiers (UMIs).
    *   Identifies peak locations (cleavage sites).
    *   Merges plus and minus strand peaks.
    *   Performs off-target searching around identified insertion sites using `CRISPRseek`.
*   **Output:** `gRNA Peaks` data table and genomic coordinates of validated cleavage sites.

## Usage Tips

*   **Input Formats:** Supports FASTA and GenBank formats for sequence inputs.
*   **Genome Selection:** Ensure the correct BSgenome object is loaded in R to match your experimental organism for accurate off-target scoring.
*   **Memory Management:** For large genomes or high-throughput GUIDE-seq data, ensure sufficient RAM is allocated, as off-target searching is computationally intensive.
*   **Shiny Interface:** While the package provides functions, it is often invoked via its Shiny app for interactive parameter tuning. Use `runCrisprSeek()` (or the package's equivalent launcher) to start the UI.

## Reference documentation

- [crisprseekplus](./references/crisprseekplus.Rmd)