---
name: rbpbench
description: RBPBench is a toolkit for mapping RNA-binding protein motifs onto genomic regions and analyzing their functional context. Use when user asks to search for RBP motifs in CLIP-seq data, perform motif enrichment analysis, or analyze the co-occurrence of multiple binding proteins.
homepage: https://github.com/michauhl/RBPBench
metadata:
  docker_image: "quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0"
---

# rbpbench

## Overview

RBPBench is a versatile toolkit designed for the functional analysis of RNA-protein interaction data. It enables users to map known RBP motifs (both sequence and structure-based) onto genomic regions, typically derived from CLIP-seq experiments. Beyond simple motif matching, the tool provides deep insights into the genomic context of binding sites—such as distribution across UTRs, introns, and exons—and offers statistical frameworks to compare different datasets, cell types, or experimental protocols.

## Core CLI Usage

### 1. Exploration and Setup
Before running analyses, use the `info` mode to check available resources.
- **List available RBPs:** `rbpbench info`
- **Check specific RBP motifs:** `rbpbench info --rbps PUM2 AGO2`

### 2. Motif Search (`search` mode)
The primary mode for identifying binding sites within genomic regions.
- **Basic Search:**
  ```bash
  rbpbench search --in peaks.bed --genome hg38.fa --gtf annotations.gtf --out output_dir --rbps PUM2
  ```
- **Extended Search:** Use `--ext` to expand input regions (e.g., 10nt up/downstream) to capture motifs near peak boundaries.
  ```bash
  rbpbench search --in peaks.bed --genome hg38.fa --gtf annotations.gtf --out output_dir --rbps PUM2 --ext 10
  ```
- **Regular Expression Search:** Search for specific sequences like the polyadenylation signal.
  ```bash
  rbpbench search --in peaks.bed --genome hg38.fa --gtf annotations.gtf --out output_dir --regex AATAAA
  ```

### 3. Enrichment and Co-occurrence
- **Enrichment (`enmo`):** Determine if a motif is statistically overrepresented in your regions compared to a background.
- **Co-occurrence (`nemo`):** Analyze if multiple RBPs tend to bind in close proximity within the same genomic regions.

## Expert Tips and Best Practices

- **Genomic Annotations:** Always provide a GTF file (`--gtf`) to enable RBPBench to generate mRNA region coverage profiles and exon-intron overlap statistics. This is critical for understanding the biological context of the binding.
- **Input Preparation:** Ensure your BED files are sorted and follow standard formatting. RBPBench relies on `bedtools` internally for many operations.
- **Output Interpretation:** RBPBench generates comprehensive HTML reports (`report.rbpbench_search.html`). Use these for high-level visualization, but refer to the generated table files for downstream custom statistical analysis.
- **Structure Motifs:** If your RBP is known to recognize structural elements, ensure you are using the structure-aware search capabilities (requires `infernal` to be in the environment).
- **Memory Management:** When processing large eCLIP datasets (e.g., ENCODE IDR peaks), consider running searches on a per-RBP basis or using the `batch` mode if available to manage computational load.



## Subcommands

| Command | Description |
|---------|-------------|
| rbpbench batch | Batch job for RBP motif analysis |
| rbpbench compare | Compare motif search results from rbpbench. |
| rbpbench con | Compares conservation scores between two sets of genomic sites. |
| rbpbench dist | Distribution plot results output folder |
| rbpbench enmo | Performs motif enrichment analysis on specified regions. |
| rbpbench goa | GO enrichment analysis (GOA) |
| rbpbench isocomp | Check for differences in regex hit occurrences between transcript isoforms. |
| rbpbench nemo | Nemo subcommand for rbpbench |
| rbpbench optex | rbpbench optex |
| rbpbench search | Search for RBP motifs in genomic regions. |
| rbpbench searchlong | Search for RBP motifs in genomic regions. |
| rbpbench searchlongrna | Search for RBP motifs in long RNA sequences. |
| rbpbench searchregex | Search for DNA/RNA motifs using regular expressions in FASTA or BED files. |
| rbpbench searchseq | Search for sequence motifs in DNA/RNA sequences. |
| rbpbench sponge | Identify sponge transcripts based on regex matches. |
| rbpbench streme | Run STREME on RBP-bound sequences |
| rbpbench tomtom | Search for motifs similar to --in in a database. |
| rbpbench_info | Show information about RBPBench motif databases. |
| rbpbench_searchrna | Search for RNA-binding protein (RBP) motifs in transcript sites. |

## Reference documentation
- [RBPBench README](./references/github_com_michauhl_RBPBench_blob_main_README.md)
- [RBPBench Overview](./references/anaconda_org_channels_bioconda_packages_rbpbench_overview.md)