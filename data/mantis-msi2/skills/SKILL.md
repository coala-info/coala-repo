---
name: mantis-msi2
description: MANTIS2 (Microsatellite Analysis for Normal-Tumor InStability) is a bioinformatics tool designed to identify MSI by comparing a tumor BAM file against a matched normal BAM file.
homepage: https://github.com/nh13/MANTIS2/
---

# mantis-msi2

## Overview

MANTIS2 (Microsatellite Analysis for Normal-Tumor InStability) is a bioinformatics tool designed to identify MSI by comparing a tumor BAM file against a matched normal BAM file. It calculates an instability score based on the differences in repeat lengths at specific microsatellite loci. This skill provides guidance on executing the tool via the command line, configuring quality filters, and preparing the required input files.

## Core Usage

The basic execution requires a reference genome, a BED file of target loci, and the paired BAM files.

```bash
python mantis.py \
  --bedfile /path/to/loci.bed \
  --genome /path/to/genome.fasta \
  -n /path/to/normal.bam \
  -t /path/to/tumor.bam \
  -o /path/to/output_results.txt
```

### Input Requirements

*   **BAM Files**: Must be paired-end and produced using the same alignment pipeline to ensure consistency in the instability score.
*   **Reference Genome**: FASTA format (e.g., HG19 or HG38).
*   **BED File**: Must be in a specific 6-column format. The 4th column (name) is critical and must contain the targeted k-mer and the reference repeat count in the format `(KMER)COUNT`.
    *   *Example*: `chr15 33256217 33256249 (AC)16 0 +`

## Optimization and Best Practices

### Read Length and Quality
*   **Ideal Read Length**: Use reads of 100 bp or longer. Shorter reads often fail to cover the entire microsatellite locus and are discarded by quality control filters.
*   **Quality Filtering**: Adjust the minimum read quality (`-mrq`, default 25.0) and minimum locus quality (`-mlq`, default 30.0) if working with lower-quality samples, though defaults are optimized for standard Illumina data.

### Performance
*   **Multithreading**: Use the `--threads` parameter to speed up analysis. Note that performance is often I/O bound by disk reading speeds, so diminishing returns occur at high thread counts.
*   **Coverage**: By default, a locus requires 30x coverage (`-mlc`) in both samples to be considered. For low-pass sequencing, you may need to lower this threshold.

### Configuration Management
To simplify repetitive runs, use a `mantis_config.cfg` file in the program root or specify one with `-cfg`.
*   **Format**: `parameter = value` (e.g., `genome = /data/ref/hg19.fasta`)
*   **Priority**: Command line arguments override configuration file settings, which override default values.

## Common CLI Parameters

| Flag | Description | Default |
| :--- | :--- | :--- |
| `-mrq` | Minimum average per-base read quality | 25.0 |
| `-mlq` | Minimum average quality for bases within the locus | 30.0 |
| `-mrl` | Minimum read length (excluding clipped bases) | 35 |
| `-mlc` | Minimum coverage required per sample per locus | 30 |
| `--threads` | Number of threads for multiprocessing | 1 |

## Reference documentation
- [MANTIS2 GitHub Repository](./references/github_com_nh13_MANTIS2.md)
- [Bioconda mantis-msi2 Overview](./references/anaconda_org_channels_bioconda_packages_mantis-msi2_overview.md)