---
name: sctagger
description: The `sctagger` tool facilitates the integration of multi-modal single-cell sequencing data.
homepage: https://github.com/vpc-ccg/sctagger
---

# sctagger

## Overview
The `sctagger` tool facilitates the integration of multi-modal single-cell sequencing data. It specifically addresses the challenge of identifying cellular barcodes in long-read data (which often has higher error rates) by using high-confidence barcodes derived from short-read data (e.g., Cell Ranger output) or a known whitelist. Use this skill to guide users through the three-step pipeline: extracting potential barcode segments from long-reads, identifying a set of valid short-read barcodes, and performing the final matching using a trie-based approach.

## Installation
The tool is primarily distributed via Bioconda.
```bash
conda create -n sctagger-env -c bioconda sctagger
conda activate sctagger-env
```

## Core Workflow

### 1. Extract Long-Read Barcode Segments
Identify the region in long-reads where the barcode is likely located by searching for the short-read adapter sequence.
```bash
scTagger.py extract_lr_bc -r "reads.fastq" -o "segments.tsv" -p "plots_dir" -t 8
```
*   **Key Argument**: `-sa` (Short-read adapter). Default is `CTACACGACGCTCTTCCGATCT`. Change this if using a non-standard 10x library prep.
*   **Tip**: Use `-p` to generate plots to verify if the adapter alignment locations are consistent across reads.

### 2. Define the Barcode Whitelist
You have two options to generate the reference barcodes for matching:

**Option A: From Short-Read BAM (Recommended)**
Use this if you have corresponding short-read data (e.g., from Illumina).
```bash
scTagger.py extract_sr_bc -i "possorted_genome_bam.bam" -o "sr_barcodes.tsv"
```
*   **Optimization**: Adjust `--max-barcode-cnt` (default 25,000) based on the expected cell count of your experiment.

**Option B: Directly from Long-Reads (Standalone)**
Use this if you only have long-read data and a 10x whitelist.
```bash
scTagger.py extract_sr_bc_from_lr -i "segments.tsv" -wl "3M-february-2018.txt.gz" -o "sr_barcodes.tsv"
```

### 3. Match Barcodes
Perform the final assignment of short-read barcodes to long-read segments.
```bash
scTagger.py match_trie -lr "segments.tsv" -sr "sr_barcodes.tsv" -o "matched_barcodes.tsv.gz" -t 16
```
*   **Memory Management**: Use `-m` to set the maximum RAM (default 16.0 GB). For large datasets, increase this to speed up trie construction.
*   **Sensitivity**: Adjust `-mr` (Maximum errors, default 2) if the long-read quality is particularly low, though increasing this may increase false positives.

## Best Practices
*   **Thread Allocation**: Both `extract_lr_bc` and `match_trie` support multi-threading via `-t`. Always match this to the available CPU cores for significant speedups.
*   **Input Format**: The tool assumes gzipped input if the file ends in `.gz`. If your files are gzipped but lack the extension, use the `-z` flag in the extraction step.
*   **Barcode Length**: If using a non-standard 10x kit where the barcode is not 16bp, you must specify the length using `-bl` in the `match_trie` step.

## Reference documentation
- [scTagger GitHub Repository](./references/github_com_vpc-ccg_scTagger.md)
- [scTagger Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sctagger_overview.md)