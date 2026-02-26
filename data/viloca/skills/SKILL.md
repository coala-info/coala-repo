---
name: viloca
description: VILOCA analyzes next-generation sequencing data from viral populations to call mutations and reconstruct local haplotypes. Use when user asks to analyze viral NGS data, call mutations, reconstruct local haplotypes, estimate variant frequencies, or call insertions.
homepage: https://github.com/cbg-ethz/VILOCA
---


# viloca

## Overview

VILOCA (VIral LOcal haplotype reconstruction and mutation CAlling) is a bioinformatics tool designed to analyze next-generation sequencing (NGS) data from viral populations. It excels at processing genetically diverse samples to provide high-resolution mutation calls and local haplotype reconstructions. By taking aligned reads and a reference genome, VILOCA estimates the frequency of different genetic variants and applies error correction models to distinguish true biological variation from sequencing artifacts.

## Installation

The recommended way to install VILOCA is via Conda:

```bash
conda create --name env_viloca --channel conda-forge --channel bioconda viloca
conda activate env_viloca
```

## Core CLI Usage

The primary command is `viloca run`. It requires a sorted BAM file and a reference FASTA file.

### Standard Execution
For most datasets where sequencing quality scores are reliable:
```bash
viloca run -b alignments.bam -f reference.fasta --mode use_quality_scores
```

### Amplicon Sequencing
If the sequencing strategy used amplicons, provide the insert BED file to define local regions:
```bash
viloca run -b reads.bam -f reference.fasta -z scheme.insert.bed --mode use_quality_scores
```

### Shotgun Sequencing with Custom Windowing
When no amplicon scheme is available, VILOCA tiles the genome into uniform regions. The window size should roughly match the read length:
```bash
viloca run -b reads.bam -f reference.fasta -w 150 --mode use_quality_scores
```

## Expert Tips and Best Practices

### Input Preparation
*   **Primary Alignments Only**: VILOCA requires the input BAM file to contain only primary alignments. Filter your BAM file to remove secondary and supplementary alignments before running the tool to avoid errors or biased results.
*   **Sorted BAM**: Ensure the BAM file is indexed and sorted by coordinate.

### Mode Selection
*   **use_quality_scores**: The recommended default. It incorporates the quality scores provided in the BAM file into the model.
*   **learn_error_params**: Use this if you suspect the sequencing quality scores are untrustworthy or if you are working with a platform where error profiles are not well-captured by standard quality strings.
*   **shorah**: Invokes the ShoRAH tool logic for haplotype reconstruction.

### Parameter Tuning
*   **Calling Insertions**: By default, insertion calling is disabled. Use the `--extended_window_mode` flag to enable it.
*   **Variant Thresholds**: 
    *   Use `-p` to set the posterior threshold for calling variants from haplotypes (default is 0.9).
    *   Use `--exclude_non_var_pos_threshold` to ignore positions where the variation frequency is below a specific percentage, treating them as reference bases.
*   **Overlap Requirements**: The `--win_min_ext` parameter (default 0.85) controls the minimum percentage of a read that must overlap a local region to be included. Reads failing this are excluded or padded with Ns.

## Output Files

VILOCA generates several key output files in the working directory:
*   **haplotypes/**: A directory containing reconstructed local haplotypes as separate FASTA files for each genomic region.
*   **coverage.txt**: A summary of each local region, including start/end positions and the number of reads processed.
*   **cooccurring_mutations.csv**: A detailed mapping of mutations found within specific haplotypes. Note that the posterior threshold (`-p`) is typically not applied to this specific file.

## Reference documentation
- [VILOCA GitHub Repository](./references/github_com_cbg-ethz_VILOCA.md)
- [VILOCA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_viloca_overview.md)