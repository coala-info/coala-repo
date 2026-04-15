---
name: snoscan
description: Searches for C/D box guide snoRNA genes within a given genomic sequence. Use when user asks to find snoRNAs, identify C/D box snoRNA genes, or search for non-coding RNAs.
homepage: http://lowelab.ucsc.edu/snoscan
metadata:
  docker_image: "quay.io/biocontainers/snoscan:1.0--pl5321h031d066_5"
---

# snoscan

yaml
name: snoscan
description: |
  Searches for C/D box guide snoRNA genes within a given genomic sequence.
  Use when you need to identify potential snoRNAs, specifically those with C/D box motifs, in DNA sequences.
  This tool is particularly useful for genomic analysis and the study of non-coding RNAs.
```

## Overview

The `snoscan` tool is designed to identify C/D box guide snoRNA genes within a genomic sequence. It analyzes DNA sequences to pinpoint regions that exhibit characteristics of snoRNAs, focusing on the conserved C/D box motifs essential for their function. This is a specialized bioinformatics tool for researchers interested in non-coding RNA discovery and analysis.

## Usage Instructions

`snoscan` operates on genomic sequences to find snoRNA genes. The primary input is a FASTA-formatted file containing the genomic sequence.

### Basic Usage

The most common way to run `snoscan` is by providing an input FASTA file.

```bash
snoscan <input.fasta>
```

This command will process the `input.fasta` file and output the identified snoRNA genes to standard output.

### Output Options

By default, `snoscan` outputs results in a tab-delimited format. You can redirect this output to a file:

```bash
snoscan <input.fasta> > output.txt
```

### Key Parameters and Tips

*   **Input FASTA File**: Ensure your input sequence is in a valid FASTA format. Multi-sequence FASTA files are supported.
*   **Output Interpretation**: The output typically includes information such as the chromosome/contig, start and end positions of the predicted snoRNA, strand, score, and the C/D box motif sequence. Familiarize yourself with the specific output columns to effectively interpret the results.
*   **Performance**: For very large genomic sequences, consider running `snoscan` on a system with sufficient memory and processing power.
*   **Version Specifics**: While the provided documentation mentions versions 1.0, 0.9.1, and 0.9b, always refer to the specific version you have installed for the most accurate command-line options and behavior. The core functionality of searching for C/D box snoRNAs is consistent.

## Reference documentation

- [Overview of snoscan on Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snoscan_overview.md)