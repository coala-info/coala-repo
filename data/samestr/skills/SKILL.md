---
name: samestr
description: SameStr is a bioinformatic pipeline designed to detect shared microbial strains between pairs of metagenomic samples.
homepage: https://github.com/danielpodlesny/samestr/
---

# samestr

## Overview
SameStr is a bioinformatic pipeline designed to detect shared microbial strains between pairs of metagenomic samples. Unlike tools that rely solely on majority variants, SameStr analyzes the full spectrum of Single Nucleotide Variants (SNVs) within clade-specific markers (from MetaPhlAn or mOTUs). This approach allows for high-resolution strain tracking and the construction of strain co-occurrence networks, making it particularly useful for longitudinal studies, clinical transmission analysis, and data quality control.

## Installation and Setup
The recommended installation method is via Conda to ensure all binary dependencies (Samtools, MUSCLE, Glibc) are correctly versioned.

```bash
conda install -c bioconda -c conda-forge samestr
```

**Database Note**: Instead of building databases from scratch with `samestr db`, download precomputed markers for mOTUs or MetaPhlAn from the Zenodo SameStr Community to save significant compute time.

## Core Workflow and CLI Patterns

### 1. Profile Generation
Convert alignment files (SAM) or reference genomes (Fasta) into SNV profiles (.npy format).

*   **From Metagenomic Alignments**:
    ```bash
    samestr convert --sam input.sam --db marker_db/ --out-dir profiles/
    ```
*   **From Reference Genomes**:
    ```bash
    samestr extract --fasta genome.fasta --db marker_db/ --out-dir profiles/
    ```

### 2. Data Management
For large-scale studies, use `merge` to consolidate profiles.
```bash
# Merge multiple sample profiles into a single matrix
samestr merge --input-dir profiles/ --out-dir merged_data/
```

### 3. Quality Control and Statistics
Before comparison, check the coverage of your profiles to ensure sufficient data for strain calling.
```bash
samestr stats --input-files merged_data/*.npy --out-dir stats_output/
```

### 4. Strain Comparison and Summarization
The final stage determines similarity between samples and generates human-readable summaries.

*   **Compare Profiles**:
    ```bash
    samestr compare --input-files merged_data/*.npy --out-dir comparison_results/
    ```
*   **Generate Summary Tables**:
    ```bash
    samestr summarize --compare-dir comparison_results/ --out-dir final_summary/
    ```

## Expert Tips
*   **Reproducibility**: Use the `--random-seed <int>` parameter in `filter`, `compare`, and `extract` modules to ensure consistent results across runs.
*   **Handling Large Datasets**: When dealing with massive sample sets that might exceed command-line argument limits (`ARG_MAX`), use the `--input-dir` option in `samestr merge` instead of listing individual files.
*   **Variant Handling**: Remember that SameStr considers all possible variants in alignments. If your downstream analysis requires specific strain composition modeling, the `.npy` outputs are compatible with various probabilistic algorithms.
*   **Marker Selection**: Ensure the database version used for `samestr convert` matches the version used during the initial alignment step (e.g., MetaPhlAn SGB-level markers).

## Reference documentation
- [GitHub Repository Overview](./references/github_com_danielpodlesny_samestr.md)
- [SameStr Tool Description and Modules](./references/github_com_danielpodlesny_samestr_1.md)