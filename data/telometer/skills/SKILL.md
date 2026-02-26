---
name: telometer
description: Telometer identifies and measures telomeric repeat sequences in long-read sequencing data to provide high-resolution, read-level length measurements. Use when user asks to identify telomeric repeats, measure telomere length from long-read BAM files, or analyze chromosome-specific telomere data.
homepage: https://github.com/santiago-es/Telometer
---


# telometer

## Overview

Telometer is a bioinformatics tool that utilizes regular expressions to identify and measure telomeric repeat sequences in long-read sequencing data. It specifically calculates the distance from the sequencing adapter to the final telomeric repeat, providing high-resolution, read-level data. While originally designed to handle noisy R9 Oxford Nanopore (ONT) data, it is now optimized for R10 chemistry and high-accuracy basecalling models. The tool is essential for researchers distinguishing between healthy aging and disease states through digital telomere measurement.

## Installation

Install telometer via Bioconda or pip:

```bash
# Using Conda
conda install bioconda::telometer

# Using pip
pip install telometer==1.1
```

## Core CLI Usage

The basic command requires a sorted and indexed BAM file and a destination for the TSV output.

```bash
telometer -b /path/to/sorted.bam -o /path/to/output.tsv
```

### Key Parameters

| Flag | Parameter | Description |
| :--- | :--- | :--- |
| `-b` | `--bam` | Path to the sorted BAM file (Required). |
| `-o` | `--output` | Path to the output TSV file (Required). |
| `-m` | `--minreadlen` | Minimum read length. Use `1000` for capture libraries; `4000` for WGS. |
| `-g` | `--maxgaplen` | Max non-telomeric gap allowed within a telomere (Default: 250). |
| `-t` | `--threads` | Number of processing threads (Default: All available). |
| `-l` | `--memlimit` | RAM allocation per batch (Default: 8 Gb). |

## Expert Workflow & Best Practices

### 1. Reference Genome Preparation
For accurate chromosome-specific mapping, align reads to a combined reference of the T2T-CHM13 assembly and Stong subtelomere assemblies.

```bash
# Combine T2T and Stong subtelomere references
cat chm13v2.0.fa stong_subtels.fa > t2t-and-subtel.fa
samtools faidx t2t-and-subtel.fa
```

### 2. Alignment Strategy
Use `minimap2` with the `map-ont` preset for Nanopore data. Telometer requires the resulting BAM to be sorted and indexed.

```bash
minimap2 -ax map-ont -t 16 t2t-and-subtel.fa reads.fastq -o output.sam
samtools sort -o output-sort.bam output.sam
samtools index output-sort.bam
```

### 3. Handling Noisy Data
*   **R10 Chemistry:** It is highly recommended to use R10 chemistry with Dorado high-accuracy basecalling. Support for R9 is deprecated as R10 significantly reduces stereotypical telomere miscalls.
*   **Gap Tolerance:** If your samples have highly variable subtelomeric boundaries or internal variants, increase the `-g` (gap) parameter to ensure these variants are counted within the total telomere length.

### 4. Output Interpretation
The output TSV includes critical columns for downstream analysis:
*   `telomere_length`: The calculated length in base pairs.
*   `arm`: Identifies if the read belongs to the `p` or `q` arm.
*   `chromosome`: The specific contig identity from your reference.

## Reference documentation
- [Telometer Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_telometer_overview.md)
- [Telometer GitHub Repository and Usage](./references/github_com_santiago-es_Telometer.md)
- [Telometer Version Tags and Improvements](./references/github_com_santiago-es_Telometer_tags.md)