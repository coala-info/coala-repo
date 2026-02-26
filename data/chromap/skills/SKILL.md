---
name: chromap
description: Chromap is a high-performance alignment tool optimized for mapping and processing chromatin biology data such as ATAC-seq, ChIP-seq, and Hi-C. Use when user asks to index a reference genome, align sequencing reads, remove duplicates, or perform barcode correction for single-cell ATAC-seq.
homepage: https://github.com/haowenz/chromap
---


# chromap

## Overview
Chromap is a high-performance alignment tool specifically optimized for chromatin biology data. It replaces slower workflows by combining adapter trimming, mapping, and duplicate removal into a single, ultra-fast step. It is particularly effective for large-scale ATAC-seq, ChIP-seq, and Hi-C datasets where traditional mappers like BWA or Bowtie2 may be bottlenecked by post-processing requirements.

## Core Workflows

### 1. Indexing the Reference
Before mapping, you must create a reference index. Note that indexing parameters (k-mer size, window size) are baked into the index and cannot be changed during the mapping step.

```bash
# Basic indexing
chromap -i -r reference.fa -o reference.index

# Indexing for specific fragment lengths (e.g., short reads)
chromap -i -r reference.fa -o reference.index --min-frag-length 30
```

### 2. Mapping with Presets
Always use the `--preset` flag to ensure optimal parameters for your specific assay type.

*   **ATAC-seq / scATAC-seq**: Trims adapters, sets max insert size to 2000bp, removes duplicates, and applies Tn5 shift (+4bp forward, -5bp reverse).
    ```bash
    # Bulk ATAC-seq
    chromap --preset atac -x reference.index -r reference.fa -1 read1.fq.gz -2 read2.fq.gz -o output.bed

    # scATAC-seq with barcode correction
    chromap --preset atac -x reference.index -r reference.fa -1 r1.fq -2 r2.fq -b bc.fq -o out.bed --barcode-whitelist white.txt
    ```

*   **ChIP-seq**: Optimized for paired-end mapping with duplicate removal.
    ```bash
    chromap --preset chip -x reference.index -r reference.fa -1 r1.fq -2 r2.fq -o output.bed
    ```

*   **Hi-C**: Supports split alignment and specialized output formats.
    ```bash
    # Output in .pairs format
    chromap --preset hic -x reference.index -r reference.fa -1 r1.fq -2 r2.fq -o output.pairs
    ```

## Expert Tips & Best Practices

### Output Formats
*   **BED (Default)**: Preferred for speed and downstream compatibility with peak callers.
*   **TagAlign**: Use `--TagAlign` to output individual read coordinates instead of fragment coordinates.
*   **SAM**: Use `--SAM` only if strictly necessary for legacy pipelines, as SAM generation is significantly slower and not fully optimized in Chromap.

### Handling Multiple Inputs
Chromap supports multiple files or wildcards. When using wildcards, ensure the path is wrapped in quotation marks to prevent shell expansion.
```bash
chromap -x index -r ref.fa -1 "data/lane*_R1.fq.gz" -2 "data/lane*_R2.fq.gz" -o merged.bed
```

### Memory Management
*   **Low Memory Mode**: The presets include `--low-mem` by default. This is critical for deduplication on machines with limited RAM.
*   **Temporary Files**: Chromap uses temporary files for sorting. If you encounter disk space issues, monitor the directory where the output is being written.

### Barcode Correction (scATAC-seq)
*   **Hamming Distance**: Default correction allows 1 mismatch. Increase to 2 using `--bc-error-threshold 2`.
*   **Probability Threshold**: Fine-tune correction confidence using `--bc-prob`.

## Reference documentation
- [Chromap GitHub Repository](./references/github_com_haowenz_chromap.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_chromap_overview.md)