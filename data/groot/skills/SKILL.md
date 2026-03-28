---
name: groot
description: groot identifies and quantifies antibiotic resistance genes in metagenomic samples using variation graphs. Use when user asks to download ARG databases, index reference sequences into variation graphs, or align reads to generate resistome reports.
homepage: https://github.com/will-rowe/groot
---


# groot

## Overview
groot (Graphing Resistance Out Of meTagenomes) is a bioinformatics tool specifically designed to identify and quantify antibiotic resistance genes within metagenomic samples. It distinguishes itself from traditional alignment tools by using variation graphs to represent gene sets, which allows for more accurate typing of genetic variants. By combining Locality-Sensitive Hashing (LSH) for fast read seeding with hierarchical local alignment, groot can efficiently reconstruct full-length ARG sequences from short-read data.

## Core Workflow

The standard groot pipeline consists of three primary stages: database preparation, indexing, and alignment/reporting.

### 1. Database Acquisition
Before indexing, you must obtain a clustered ARG database. groot provides a built-in command to fetch common datasets.

```bash
# Download a pre-clustered ARG database (e.g., arg-annot)
groot get -d arg-annot
```

### 2. Indexing the Variation Graphs
The indexing step converts the gene sequences into variation graphs and builds an LSH index for fast lookup.

```bash
# Create graphs and index
# -m: the clustered database file
# -i: the name for the output index directory
# -w: window size (crucial parameter)
groot index -m arg-annot.90 -i grootIndex -w 100
```

**Expert Tip:** Always set the window size (`-w`) to be approximately equal to your maximum expected read length. For 100bp Illumina reads, use `-w 100`.

### 3. Alignment and Resistome Reporting
The alignment process classifies reads against the index and generates a BAM file. This is typically piped directly into the report command to produce the final resistome profile.

```bash
# Align reads and generate a report
groot align -i grootIndex -f reads.fq | groot report
```

## Advanced Usage and Best Practices

### Visualizing Alignments
Since version 0.4, groot outputs variation graphs in GFA format for graphs that had reads aligned.
- Use the GFA output to visualize alignments in tools like **Bandage**.
- This helps determine which specific variants of an ARG type are dominant in your sample.

### Handling Different Read Formats
groot supports standard FASTQ inputs. Ensure your input files are quality-trimmed before alignment to improve the accuracy of the LSH seeding.

### Performance Optimization
- **Memory Usage:** groot is written in Go and is generally efficient, but indexing very large, highly diverse databases may require significant RAM.
- **Containment Search:** Version 1.0.0+ uses the LSH Ensemble library, which improves the sensitivity of read seeding through containment search.



## Subcommands

| Command | Description |
|---------|-------------|
| groot align | Sketch sequences, align to references and weight variation graphs |
| groot get | Download a pre-clustered ARG database |
| groot index | Convert a set of clustered reference sequences to variation graphs and then index them |
| groot report | Generate a report from the output of groot align. |

## Reference documentation
- [github_com_will-rowe_groot_blob_master_README.md](./references/github_com_will-rowe_groot_blob_master_README.md)
- [github_com_will-rowe_groot.md](./references/github_com_will-rowe_groot.md)