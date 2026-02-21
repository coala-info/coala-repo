---
name: isoseq3
description: The `isoseq3` (or `isoseq`) suite is the standard toolset for analyzing PacBio long-read RNA sequencing data.
homepage: https://github.com/PacificBiosciences/IsoSeq3
---

# isoseq3

## Overview

The `isoseq3` (or `isoseq`) suite is the standard toolset for analyzing PacBio long-read RNA sequencing data. It is designed to transform high-accuracy HiFi reads into high-quality, full-length (FL) transcript sequences. This skill provides guidance on the modular workflow required to move from raw reads to polished isoforms, including primer removal, clustering, and deduplication for single-cell applications.

## Core Workflow and CLI Patterns

The Iso-Seq workflow is modular. Each step typically produces a BAM file that serves as the input for the next stage.

### 1. Primer Removal and Demultiplexing (refine)
The `refine` tool removes cDNA primers and poly(A) tails, producing Full-Length Non-Concatemer (FLNC) reads.

```bash
isoseq3 refine input.consensusreadset.xml primers.fasta output.flnc.bam --require-polya
```
*   **Best Practice**: Always use `--require-polya` to ensure you are only processing high-quality transcripts.
*   **Tip**: If working with multiplexed samples, ensure your `primers.fasta` contains the correct barcode-primer combinations.

### 2. Isoform Clustering (cluster / cluster2)
Clustering groups FLNC reads into transcripts. Use `cluster` for standard datasets and `cluster2` for very large datasets (hundreds of millions of reads).

**Standard Clustering:**
```bash
isoseq3 cluster output.flnc.bam unpolished.bam --verbose
```

**High-Throughput Clustering (v4.0+):**
```bash
isoseq3 cluster2 output.flnc.bam unpolished.bam
```
*   **Expert Tip**: `cluster2` is significantly more scalable and is the preferred choice for modern HiFi datasets.

### 3. Polishing (polish)
For older data or when maximum per-base accuracy is required, `polish` uses the original subreads to improve the consensus. Note: With high-quality HiFi input, this step is often optional or integrated.

```bash
isoseq3 polish unpolished.bam subreads.bam polished.bam
```

### 4. Single-Cell Deduplication (dedup)
For Single-Cell Iso-Seq, use `dedup` to handle Cell Barcodes (BC) and Unique Molecular Identifiers (UMI).

```bash
isoseq3 dedup input.bam output.dedup.bam
```

## Expert Tips and Best Practices

*   **Binary Naming**: In newer versions (v4.0+), the primary binary is named `isoseq`. Bioconda installations typically provide an `isoseq3` softlink for backward compatibility.
*   **Input Format**: While BAM is the standard, `isoseq3` tools often accept PacBio `.xml` dataset files (e.g., `consensusreadset.xml`) which point to the underlying BAM files.
*   **Resource Management**: Clustering is computationally intensive. Use the `-j` (or `--num-threads`) flag to specify the number of CPU cores.
*   **Hierarchical Genome-level Analysis**: After obtaining polished isoforms, the next logical step outside of `isoseq3` is usually mapping to a reference genome using `pbmm2` (a PacBio-optimized wrapper for minimap2).

## Reference documentation

- [Iso-Seq - Scalable De Novo Isoform Discovery](./references/github_com_PacificBiosciences_IsoSeq.md)
- [isoseq3 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_isoseq3_overview.md)