---
name: bioconductor-harbchip
description: This package provides yeast upstream sequences and genome-wide transcription factor binding profiles for regulatory genomics analysis. Use when user asks to retrieve yeast ORF upstream sequences, analyze transcription factor binding data, or search for DNA motifs in yeast promoter regions.
homepage: https://bioconductor.org/packages/release/data/experiment/html/harbChIP.html
---


# bioconductor-harbchip

## Overview

The `harbChIP` package provides a unified resource for exploring yeast regulatory genomics. It primarily contains the `sceUpstr` object, which stores 500bp upstream sequences for yeast ORFs, and data structures representing the genome-wide binding profiles of 203 transcription factors under various environmental conditions.

## Loading Data and Sequences

The package relies on pre-built data objects. The primary object is `sceUpstr`, an `upstreamSeqs` instance.

```r
library(harbChIP)

# Load the upstream sequence data
data(sceUpstr)
sceUpstr

# Retrieve a specific upstream sequence by ORF name (e.g., YAL001C)
seq_data <- getUpstream("YAL001C", sceUpstr)
# Returns a DNAString object
```

## Workflow: Analyzing Binding and Motifs

A common workflow involves checking the frequency of specific DNA motifs (heptamers/octamers) within the upstream regions of genes identified as targets in the Harbison et al. study.

1.  **Identify Target Sequences**: Use `getUpstream` to fetch sequences for genes of interest.
2.  **Motif Searching**: Use standard Biostrings functions (like `vcountPattern` or `matchPattern`) on the sequences retrieved from `sceUpstr`.
3.  **Correlation**: Compare the presence/count of a motif (e.g., "GGCGCTA" for Snt2) against the binding ratios provided in the package's expression sets to validate binding site assertions.

## Data Construction (Reference)

While the package provides pre-built data, the `sceUpstr` object was originally constructed from SGD FASTA files using the following pattern:

```r
# Example of how the object was built
# utr5 <- readFASTA("path/to/utr5_sc_500.fasta")
# sceUpstr <- buildUpstreamSeqs2(utr5)
```

## Tips for AI Agents
- The ORF names (e.g., "YAL001C") are the primary keys for sequence retrieval.
- The upstream sequences are consistently 500bp long, sourced from the 5' UTR/genomic archive of SGD.
- Use this package in conjunction with the `Biostrings` package for sequence manipulation and `Biobase` for handling the ChIP-chip expression data.

## Reference documentation
- [The sceUpstr support in package harbChIP](./references/yeastUpstream.md)