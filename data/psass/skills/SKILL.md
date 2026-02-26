---
name: psass
description: PSASS detects genomic signals and comparative metrics between two pooled populations to identify sex-linked regions or scaffolds. Use when user asks to identify sex-determination signals, calculate Fst and SNP distribution from pooled sequencing data, or generate nucleotide composition files from BAM or CRAM files.
homepage: https://github.com/RomainFeron/PSASS
---


# psass

## Overview

PSASS (Pooled Sequencing Analysis for Sex Signal) is a specialized toolset designed to detect genomic signals that differ between two pooled populations. It is primarily used in sex-determination research to identify sex-linked scaffolds or regions. The tool transforms raw alignment data into comparative metrics, allowing for the identification of fixed differences (SNPs) and regions of high genetic divergence (Fst) without requiring individual-level genotypes.

## Core Workflow

The standard PSASS pipeline consists of two primary stages: generating a nucleotide composition file and then analyzing that file for comparative metrics.

### 1. Generating Nucleotide Composition (pileup)
The `pileup` command creates a "wig-like" file containing nucleotide counts for every position. This is significantly faster than using `samtools mpileup` followed by a conversion script.

```bash
psass pileup --reference genome.fa --output-file counts.tsv pool1.bam pool2.bam
```

**Best Practices:**
- **Input Format**: Use BAM or CRAM files. Both must be sorted by genomic coordinates.
- **CRAM Requirements**: If using CRAM, the `--reference` (or `-r`) flag is mandatory.
- **Mapping Quality**: Use `--min-map-quality` (default 0) to filter out multi-mapping reads or low-confidence alignments, typically setting this to 20 or 30 for cleaner signals.

### 2. Computing Comparative Metrics (analyze)
The `analyze` command processes the output from the pileup stage to calculate Fst, depth, and SNP distribution.

```bash
psass analyze --window-size 10000 --output-resolution 1000 --snp-file specific_snps.tsv counts.tsv window_metrics.tsv
```

**Key Parameters:**
- **Windowing**: `--window-size` (default 100kb) and `--output-resolution` (step size, default 10kb) control the granularity of the sliding window analysis.
- **Pool Naming**: Use `--pool1` and `--pool2` to label your groups (e.g., "females" and "males") for clearer output headers.
- **SNP Identification**:
    - `--freq-het`: The expected frequency for a heterozygous site (default 0.5).
    - `--range-het`: The allowed variance around the heterozygous frequency (default 0.15).
    - `--freq-hom` / `--range-hom`: Thresholds for homozygous sites (default 1.0 and 0.05).
- **Filtering**: `--min-depth` (default 10) ensures metrics are only calculated for sites with sufficient coverage.

## Advanced Usage and Tips

### Gene-Level Analysis
To calculate metrics for specific genomic features rather than arbitrary windows, provide a GFF file:
```bash
psass analyze --gff-file annotations.gff --genes-file gene_metrics.tsv counts.tsv window_metrics.tsv
```
This produces statistics for both coding and non-coding parts of the genes defined in the GFF.

### Identifying High-Divergence Sites
To extract specific positions where Fst exceeds a certain threshold (rather than just the window average), use the `--fst-file` and `--min-fst` flags:
```bash
psass analyze --fst-file high_fst_sites.tsv --min-fst 0.8 counts.tsv window_metrics.tsv
```

### Handling Clustered SNPs
If your data contains many adjacent SNPs that likely represent a single evolutionary event (or alignment artifact), use the `--group-snps` flag. This counts consecutive SNPs as a single polymorphism, preventing a single divergent haplotype from inflating SNP counts.

### Integration with Visualization
The output files from `psass analyze` (specifically the window metrics) are designed to be compatible with the `sgtr` R package for generating Manhattan plots and depth distribution visualizations.

## Reference documentation
- [PSASS GitHub Repository](./references/github_com_SexGenomicsToolkit_PSASS.md)
- [PSASS Release Notes](./references/github_com_SexGenomicsToolkit_PSASS_releases.md)