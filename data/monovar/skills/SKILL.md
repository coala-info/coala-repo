---
name: monovar
description: Monovar is a specialized genomic tool designed specifically for the nuances of single-cell DNA sequencing.
homepage: https://bitbucket.org/hamimzafar/monovar
---

# monovar

## Overview

Monovar is a specialized genomic tool designed specifically for the nuances of single-cell DNA sequencing. Unlike bulk sequencers, single-cell data is plagued by high false-positive rates and allelic dropout. This skill provides the procedural knowledge to execute Monovar's Bayesian framework, which leverages data across multiple cells to improve the accuracy of SNV detection and genotype calling in sparse, noisy single-cell datasets.

## Core Workflow

Monovar typically requires a reference genome and a set of coordinate-sorted, indexed BAM files.

### 1. Input Preparation
Ensure all single-cell BAM files are indexed (`.bai` files present). It is recommended to provide a list of BAM file paths in a text file to manage large cell counts.

### 2. Basic Execution Pattern
The standard command structure for joint genotyping:

```bash
samtools mpileup -bq 20 -d 10000 -f reference.fa -b bam_list.txt | monovar.py -f reference.fa -b bam_list.txt -o output.vcf
```

### 3. Key Parameters
- `-f`: Path to the reference genome (FASTA).
- `-b`: A text file containing paths to input BAM files (one per line).
- `-o`: Output filename (VCF format).
- `-t`: Threshold for variant calling (default is usually sufficient, but can be tuned for sensitivity).
- `-m`: Number of threads for parallel processing.

## Best Practices and Expert Tips

- **Quality Filtering**: Always use `samtools mpileup` with a base quality filter (e.g., `-q 20`) before piping to Monovar. This reduces the impact of sequencing errors on the Bayesian model.
- **Memory Management**: For experiments with hundreds of cells, ensure the system has sufficient RAM, as Monovar builds a joint probability matrix across all cells.
- **Reference Consistency**: The reference genome used in the `mpileup` step must be identical to the one provided to Monovar via the `-f` flag.
- **Post-Processing**: After generating the VCF, filter results based on the "PASS" filter and consensus genotypes to remove low-confidence calls that may still persist despite the joint genotyping model.

## Reference documentation

- [Monovar Overview](./references/anaconda_org_channels_bioconda_packages_monovar_overview.md)
- [Monovar Source and Documentation](./references/bitbucket_org_hamimzafar_monovar.md)