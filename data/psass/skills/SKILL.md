---
name: psass
description: "PSASS detects genomic signatures of sex determination and calculates population genetic metrics from pooled sequencing datasets. Use when user asks to generate nucleotide counts from alignment files, identify sex-specific SNPs, or calculate Fst and depth metrics across sliding windows or genes."
homepage: https://github.com/RomainFeron/PSASS
---


# psass

## Overview

PSASS (Pooled Sequencing Analysis for Sex Signal) is a specialized bioinformatics tool designed to detect genomic signatures of sex determination from pooled sequencing datasets. It streamlines the comparative analysis of two pools by calculating population genetic metrics and identifying SNPs that are heterozygous in one pool while being homozygous in the other. This is particularly useful for identifying sex-determining regions or sex-specific markers in non-model organisms where individual sequencing is not feasible.

## Core Workflow

The standard PSASS workflow consists of two primary steps: generating a nucleotide count file and then analyzing that file for genetic signals.

### 1. Generate Nucleotide Counts (pileup)
Use the `pileup` command to process alignment files (BAM or CRAM) into a nucleotide composition file.

```bash
psass pileup --reference genome.fa --output-file counts.tsv pool1.bam pool2.bam
```

*   **Input Requirements**: Alignment files must be sorted by genomic coordinates.
*   **CRAM Files**: If using CRAM input, the `--reference` (or `-r`) flag is mandatory.
*   **Filtering**: Use `--min-map-quality` (default 0) to exclude low-quality alignments from the counts.

### 2. Statistical Analysis (analyze)
Use the `analyze` command to compute Fst, SNPs, and depth metrics from the pileup output.

```bash
psass analyze --window-size 10000 --output-resolution 1000 --snp-file snps.tsv counts.tsv results_window.tsv
```

*   **Sliding Windows**: Control the granularity of the analysis using `--window-size` (the span of the calculation) and `--output-resolution` (the step size between windows).
*   **Pool Naming**: Use `--pool1` and `--pool2` to provide descriptive names for the groups in the output headers.
*   **Specific SNP Detection**: The `--snp-file` flag generates a separate TSV containing the exact genomic positions of pool-specific SNPs.
*   **High Fst Positions**: Use `--fst-file` to output the positions of individual bases with high between-pool differentiation.

## Advanced Features

### Gene-Level Analysis
PSASS can aggregate metrics at the gene level if provided with a GFF3 annotation file.

```bash
psass analyze --gff-file annotation.gff --genes-file gene_metrics.tsv counts.tsv results_window.tsv
```
This calculates pool-specific SNPs and depth for both coding and non-coding regions of every gene defined in the GFF.

### Output Format
*   **Window File**: Contains Fst, pool-specific SNP counts, and depth (absolute and relative) for each window.
*   **SNP File**: Lists chromosome, position, and the specific nucleotide states for the identified pool-specific markers.

## Expert Tips and Best Practices

*   **Coordinate Sorting**: Always verify that your BAM/CRAM files are coordinate-sorted and indexed before running `pileup`.
*   **Window Selection**: For fragmented assemblies (scaffolds), ensure the `--window-size` is appropriate for the average scaffold length to avoid losing data on smaller contigs.
*   **Depth Normalization**: PSASS calculates relative depth, which is critical for comparing pools with different total sequencing throughput.
*   **Visualization**: The output TSV files are designed for easy integration with the `sgtr` R package for Manhattan plots and depth visualization.



## Subcommands

| Command | Description |
|---------|-------------|
| analyze | Analyze sliding window metrics and sex-biased SNPs from sync files |
| convert | Convert samtools pileup output to PSASS format |
| pileup | Alignment files to include in pileup, in bam or cram format and indexed |

## Reference documentation
- [PSASS README](./references/github_com_SexGenomicsToolkit_PSASS_blob_master_README.md)
- [Bioconda PSASS Overview](./references/anaconda_org_channels_bioconda_packages_psass_overview.md)