---
name: arcs
description: The arcs tool organizes and orients contigs into larger scaffolds using shared barcodes from linked or long reads. Use when user asks to scaffold a draft assembly, run the ARKS alignment-free pipeline, or link contigs using PacBio or Oxford Nanopore reads.
homepage: https://github.com/bcgsc/arcs
---


# arcs

## Overview
The `arcs` (Assembly Rounding out of Contig Scaffolding) tool is designed to organize and orient contigs into larger scaffolds. It works by identifying barcodes shared between the ends of contigs, which indicates physical proximity in the original genome. It supports four primary modes: the original alignment-based ARCS for linked reads, a k-mer based alignment-free version (ARKS), and specialized modes for long reads that simulate linked-read behavior.

## Core Workflows

### 1. Using the arcs-make Pipeline
The most efficient way to run the full pipeline (ARCS + LINKS) is via the `arcs-make` wrapper. This handles the generation of the Graphviz (.gv) file, the conversion to a TSV checkpoint, and the final scaffolding with LINKS.

**Standard Linked Reads (Alignment-based):**
```bash
arcs-make arcs draft=<assembly.fa> reads=<interleaved_barcoded_reads.fq.gz> z=1000
```

**ARKS (Alignment-free, Faster):**
```bash
arcs-make arks draft=<assembly.fa> reads=<interleaved_barcoded_reads.fq.gz> k=60
```

**Long Reads (PacBio/ONT):**
```bash
arcs-make arcs-long draft=<assembly.fa> reads=<long_reads.fa.gz>
```

### 2. Manual Execution Steps
If not using the Makefile, the process follows three distinct stages:

1.  **Generate Graph:** Run `arcs` to produce a `.gv` file.
    *   `arcs -f draft.fa -a alignments.sam -b output_name`
2.  **Create Checkpoint:** Convert the graph to a LINKS-compatible format.
    *   `python bin/makeTSVfile.py output_name.gv > output_name.tigpair_checkpoint`
3.  **Scaffold:** Run `LINKS` using the checkpoint.
    *   `links -f draft.fa -s empty.fofn -b output_name -k 1 -l 1`

## Parameter Optimization

### Long Read Scaffolding
Long reads have higher error rates. When using `arcs-long` or `arks-long`, adjust the following parameters to maintain sensitivity:
- `-m 8-10000`: Range of barcode occurrences.
- `-s 70`: Minimum identity/k-mer threshold.
- `-c 4`: Minimum number of links to create an edge.
- `-a 0.3`: Maximum link ratio (lower is more stringent).

### General Tuning
- **Contig Length (`-z` or `z`):** Set this to the minimum contig size to consider. Excluding very small, repetitive contigs often improves scaffold accuracy.
- **End Length (`-e`):** Defines the "head" and "tail" regions of contigs (default 30,000bp). Only reads mapping within these regions are used for scaffolding.
- **Distance Estimation (`-D`):** Use this flag to estimate gap sizes based on shared barcode density. Requires LINKS v1.8.6+.

## Input Requirements
- **Draft Assembly:** FASTA format.
- **Linked Reads:** Must be interleaved. Barcodes must be in the `BX` tag of the header or appended to the read name (e.g., `@readname_BARCODE`).
- **Long Reads:** FASTA or FASTQ (can be gzipped).

## Reference documentation
- [github_com_BirolLab_arcs_blob_master_README.md](./references/github_com_BirolLab_arcs_blob_master_README.md)
- [github_com_BirolLab_arcs_blob_master_ChangeLog.md](./references/github_com_BirolLab_arcs_blob_master_ChangeLog.md)