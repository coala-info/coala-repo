---
name: minimod
description: minimod extracts and aggregates base modification information from long-read sequencing data by parsing MM and ML tags in BAM files. Use when user asks to summarize modification codes, calculate genomic modification frequencies, generate bedMethyl files, or view individual read modifications.
homepage: https://github.com/warp9seq/minimod
---


# minimod

## Overview
minimod is a high-performance bioinformatics tool designed to extract and aggregate base modification information from long-read sequencing data (e.g., Oxford Nanopore or PacBio). It parses the standardized MM (base modification) and ML (probability) tags in BAM files to produce site-specific modification calls or genomic frequency maps. It is particularly useful for epigenetic studies where researchers need to convert raw signal-called data into standard formats like TSV or bedMethyl for downstream analysis.

## Installation
The recommended way to install minimod is via Bioconda:
```bash
conda install minimod -c bioconda -c conda-forge
```

## Core Commands and Workflows

### 1. Summarizing BAM Content
Before processing, use the `summary` command to identify which modification codes are present and their respective counts.
```bash
minimod summary reads.bam > summary.tsv
```

### 2. Calculating Modification Frequencies
The `freq` command aggregates modification calls across all reads at specific genomic positions.

*   **Standard TSV output (5mC in CG context):**
    ```bash
    minimod freq ref.fa reads.bam > modfreqs.tsv
    ```
*   **BedMethyl output (standard for genome browsers):**
    ```bash
    minimod freq -b ref.fa reads.bam > modfreqs.bedmethyl
    ```
*   **Multiple modifications with custom thresholds:**
    Use `-c` to specify codes and contexts, and `-m` for the probability thresholds (0.0 to 1.0).
    ```bash
    # m (5mC) at 0.8 threshold and h (5hmC) at 0.7 threshold
    minimod freq -c m[CG],h[CG] -m 0.8,0.7 ref.fa reads.bam > mods.tsv
    ```

### 3. Viewing Individual Read Modifications
The `view` command outputs a row for every modified base found in every read, which is useful for single-molecule analysis.
```bash
minimod view ref.fa reads.bam > individual_mods.tsv
```

## Expert Tips and Best Practices

*   **Context Filtering**: You can restrict analysis to specific sequence contexts using brackets, such as `m[CG]` for CpG methylation or `m[CHG]` for non-CpG methylation.
*   **Handling Insertions**: By default, modifications in inserted sequences (relative to the reference) are ignored. Use the `--insertions` flag to include them in the output.
*   **Haplotype Awareness**: If your BAM file has been phased (e.g., using Whatshap), use the `--haplotypes` flag to include haplotype information in the output, allowing for allele-specific methylation analysis.
*   **Performance**: Use the `-t` flag to specify the number of threads. For large datasets, increasing the batch size (`-K`) or base limit (`-B`) can improve throughput if memory allows.
*   **Thresholding**: The default threshold for `freq` is 0.8. Adjust this based on the confidence of your basecaller; lower thresholds increase sensitivity but may introduce noise.

## Reference documentation
- [github_com_warp9seq_minimod.md](./references/github_com_warp9seq_minimod.md)
- [anaconda_org_channels_bioconda_packages_minimod_overview.md](./references/anaconda_org_channels_bioconda_packages_minimod_overview.md)