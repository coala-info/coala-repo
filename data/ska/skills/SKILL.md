---
name: ska
description: SKA (Split Kmer Analysis) is a specialized toolkit for prokaryotic genomic epidemiology.
homepage: https://github.com/simonrharris/SKA
---

# ska

## Overview

SKA (Split Kmer Analysis) is a specialized toolkit for prokaryotic genomic epidemiology. It utilizes "split kmers"—pairs of kmers separated by a single central base—to identify genetic variation. This approach allows for rapid comparison of conserved genomes, making it ideal for outbreak investigations and surveillance where speed and memory efficiency are critical. SKA bypasses the computationally expensive steps of traditional read mapping or assembly, providing a direct path from raw data to SNP distances and alignments.

## Core Workflows

### 1. Creating Split Kmer Files (.skf)
The first step in any SKA workflow is converting sequences into the native `.skf` format.

*   **From Fastq (Raw Reads):**
    `ska fastq -o sample_name read1.fastq.gz read2.fastq.gz`
*   **From Fasta (Assemblies):**
    `ska fasta -o sample_name assembly.fasta`
*   **Batch Processing:**
    Use `ska alleles` to create a merged split kmer file for multiple sequences in a multifasta file.

### 2. Quality Control and Summary
Before downstream analysis, verify the contents of your `.skf` files.

*   **Check Statistics:**
    `ska summary sample1.skf sample2.skf`
    *Tip: Use this to ensure kmer counts and GC content are consistent with the expected species.*
*   **Inspect Metadata:**
    `ska info sample.skf`

### 3. Distance and Clustering
Calculate pairwise SNP distances and cluster isolates based on thresholds.

*   **Calculate Distances:**
    `ska distance -s 25 -i 0.95 merged.skf new_sample.skf`
    *   `-s`: SNP cutoff for clustering.
    *   `-i`: Minimum split kmer identity (e.g., 0.95 for 95%).

### 4. Alignment and Mapping
SKA provides both reference-based and reference-free alignment options.

*   **Reference-Free Alignment:**
    `ska align -v -o output_prefix sample1.skf sample2.skf sample3.skf`
    *   `-v`: Output only variant split kmers.
*   **Reference-Based Mapping:**
    `ska map -r reference.fasta -o output.aln sample1.skf sample2.skf`

### 5. Filtering and Refinement
Improve signal-to-noise ratios by removing unwanted kmers (e.g., mobile genetic elements, contaminants).

*   **Weeding:**
    `ska weed -i mge_elements.skf samples.skf`
    *Note: Create the `mge_elements.skf` first using `ska fasta` on a file of known contaminants or MGEs.*

### 6. Genomic Typing
Perform MLST or allele typing directly on split kmer files.

*   **MLST Typing:**
    `ska type -q sample.skf -p profiles.tsv locus1.fa locus2.fa ...`

## Expert Tips

*   **Human-Readable Debugging:** Use `ska humanise sample.skf` to output kmers in a text format to verify specific sequences or troubleshoot unexpected results.
*   **Unique Kmer Identification:** Use `ska unique` to find kmers present in a specific group of samples but absent in others—useful for identifying clade-specific markers.
*   **Memory Management:** While SKA is efficient, processing very large or highly diverse datasets can increase memory usage. Use `ska merge` to combine multiple `.skf` files into a single file for more efficient batch comparisons.
*   **Annotation:** After generating a reference-free alignment, use `ska annotate` with a GFF file to determine the functional impact of identified variants.

## Reference documentation
- [GitHub SKA Main Page](./references/github_com_simonrharris_SKA.md)
- [SKA Wiki and Usage Guide](./references/github_com_simonrharris_SKA_wiki.md)