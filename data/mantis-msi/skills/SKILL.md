---
name: mantis-msi
description: MANTIS identifies microsatellite instability by comparing repeat length distributions between matched tumor and normal sequencing samples. Use when user asks to detect microsatellite instability, calculate MSI scores, or analyze microsatellite loci in paired-end sequencing data.
homepage: https://github.com/OSU-SRLab/MANTIS/
metadata:
  docker_image: "quay.io/biocontainers/mantis-msi:1.0.5--h4ac6f70_2"
---

# mantis-msi

## Overview

MANTIS (Microsatellite Analysis for Normal-Tumor InStability) is a specialized bioinformatics tool used to identify MSI by comparing microsatellite loci between a tumor sample and its matched normal control. By analyzing the distribution of repeat lengths at specific genomic locations, MANTIS calculates an instability score that helps characterize the MSI status of a sample. It is optimized for paired-end sequencing data and requires both samples to have been processed through the same alignment pipeline for accurate comparison.

## Core Command Line Usage

The basic execution of MANTIS requires a BED file of target loci, a reference genome, and the paired BAM files.

```bash
python mantis.py \
  --bedfile /path/to/loci.bed \
  --genome /path/to/genome.fasta \
  -n /path/to/normal.bam \
  -t /path/to/tumor.bam \
  -o /path/to/output_results.txt
```

### Required Input Specifications

*   **BED File Format**: Must be a 6-column BED file. The 4th column (name) is functional and must contain the targeted k-mer and the reference repeat count in the format `(KMER)Count`.
    *   *Example*: `chr15 33256217 33256249 (AC)16 0 +`
*   **BAM Files**: Must be paired-end and produced using the same pipeline.
*   **Reference Genome**: FASTA format (e.g., HG19 or HG38).

## Performance and Quality Tuning

### Multithreading
MANTIS supports multiprocessing. Use the `--threads` flag to improve speed, though gains diminish once disk I/O limits are reached.
```bash
python mantis.py [options] --threads 8
```

### Quality Control Filters
If working with low-quality or low-coverage data, adjust the following parameters:
*   **-mrq / --min-read-quality**: Minimum average per-base quality for a read (Default: 25.0).
*   **-mlq / --min-locus-quality**: Minimum average quality for bases specifically within the microsatellite locus (Default: 30.0).
*   **-mlc / --min-locus-coverage**: Minimum coverage required in *both* normal and tumor samples for a locus to be included in the final score (Default: 30).
*   **-mrl / --min-read-length**: Minimum read length. Reads shorter than this after clipping are discarded (Default: 35).

## Expert Tips and Best Practices

*   **Read Length Matters**: For optimal results, use reads of 100 bp or longer. Shorter reads often fail to span the entire microsatellite locus and are filtered out, leading to lower effective coverage.
*   **Configuration Files**: For pipeline integration, use a `mantis_config.cfg` file. Parameters in this file are overridden by command-line arguments.
    *   *Format*: `genome = /path/to/genome.fasta`
*   **Internal Realignment**: MANTIS performs minor internal realignment to handle 'chr' prefix differences and 0/1-based coordinate variations in BED files automatically.
*   **Outlier Filtering**: The `-mrr` (min-repeat-reads) parameter (Default: 3) filters out noise by discarding repeat counts supported by very few reads. Increase this for very high-depth sequencing to reduce false positives.

## Reference documentation
- [MANTIS Overview](./references/anaconda_org_channels_bioconda_packages_mantis-msi_overview.md)
- [MANTIS GitHub Documentation](./references/github_com_OSU-SRLab_MANTIS.md)