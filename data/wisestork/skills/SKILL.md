---
name: wisestork
description: Wisestork detects Copy Number Variations (CNVs) by normalizing genomic data against a reference dictionary. Use when user asks to detect CNVs, generate read counts, correct GC bias, create a reference dictionary, or calculate Z-scores.
homepage: https://github.com/sndrtj/wisestork
---


# wisestork

## Overview
Wisestork is a Python-based re-implementation of the Wisecondor algorithm designed for detecting CNVs. It improves upon its predecessor by supporting smaller bin sizes, providing faster reference set generation, and using standard BED formats compatible with downstream tools like Bedtools. Use this skill to guide users through the multi-step process of normalizing genomic data against a reference dictionary to identify significant deviations in read depth.

## Core Workflow

A standard Wisestork analysis follows a linear progression of four primary commands.

### 1. Generate Read Counts
Extract read counts from indexed BAM files into a BED format.
```bash
wisestork count -I input.bam -R reference.fa -O output.bed -B 50000
```
*   **Tip**: The default bin size (`-B`) is 50kb. For WGS, adjust this based on your coverage depth.

### 2. GC Bias Correction
Correct the raw counts for GC content bias using the reference FASTA.
```bash
wisestork gc-correct -I output.bed -R reference.fa -O output.gc.bed -B 50000
```
*   **Requirement**: After this step, you must compress and index the output for subsequent steps:
    `bgzip output.gc.bed && tabix -p bed output.gc.bed.gz`

### 3. Create Reference Dictionary (One-time Setup)
Before calculating Z-scores, you must build a reference dictionary from a set of "normal" samples.
```bash
wisestork newref -I sample1.gc.bed.gz -I sample2.gc.bed.gz -O reference_dict.bed -R reference.fa -B 50000
```
*   **Best Practice**: The output must be sorted, compressed, and indexed:
    `bedtools sort -i reference_dict.bed > sorted_ref.bed`
    `bgzip sorted_ref.bed && tabix -p bed sorted_ref.bed.gz`

### 4. Calculate Z-Scores
The final step identifies CNVs by comparing the query sample against the reference dictionary.
```bash
wisestork zscore -I output.gc.bed.gz -D sorted_ref.bed.gz -R reference.fa -O final_zscores.bed -B 50000
```

## Expert Usage and Best Practices

### Working with Exome Data (WES)
For Exome sequencing, fixed bin sizes are inappropriate. Instead of using the `-B` flag, provide a target/bait BED file using the `-L` flag.
*   **Command**: `wisestork count -I input.bam -R reference.fa -O output.bed -L targets.bed`
*   **Note**: Ensure the contig names in your BED file exactly match those in your BAM header.

### Reference Selection Logic
Wisestork uses a log-linear method (median-based) to find similar bins across samples. This is significantly faster than the original Wisecondor's exponential approach, making it feasible to use very small bin sizes (e.g., 1kb - 5kb) if coverage allows.

### Input Requirements
*   **BAMs**: Must be sorted and indexed (`samtools index`).
*   **FASTA**: Must be indexed (`samtools faidx`).
*   **Dependencies**: Ensure `bgzip`, `tabix`, and `bedtools` are available in your PATH for intermediate file processing.

## Reference documentation
- [Wisestork GitHub Repository](./references/github_com_sndrtj_wisestork.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_wisestork_overview.md)