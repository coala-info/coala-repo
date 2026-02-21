---
name: demuxlet
description: demuxlet is a specialized tool for deconvoluting sample identities in barcoded single-cell RNA-seq experiments where multiple donors have been pooled.
homepage: https://github.com/statgen/demuxlet
---

# demuxlet

## Overview
demuxlet is a specialized tool for deconvoluting sample identities in barcoded single-cell RNA-seq experiments where multiple donors have been pooled. It leverages the natural genetic variation (SNPs) present in the RNA-seq reads and compares them against known genotypes of the pooled individuals. This allows for accurate donor assignment and the identification of cross-genotype doublets without the need for additional laboratory protocols like cell hashing.

## Command Line Usage

### Basic Execution
The core command requires a coordinate-sorted and indexed BAM/CRAM file and a VCF/BCF file containing the genotypes of the individuals in the pool.

```bash
demuxlet --sam input_sorted.bam --vcf genotypes.vcf --out output_prefix
```

### Common Parameters
- **Cell Barcode & UMI Tags**: For 10x Genomics data, ensure the correct tags are specified (usually defaults).
  - `--tag-group CB`: Specifies the cell barcode tag.
  - `--tag-UMI UB`: Specifies the UMI tag.
- **Genotype Fields**: Specify which VCF field to use for the assignment.
  - `--field GP`: Use posterior probabilities (recommended if available).
  - `--field PL`: Use genotype likelihoods.
  - `--field GT`: Use hard genotypes (requires setting `--geno-error`).

### Performance Optimization
- **Barcode Whitelisting**: To significantly speed up processing, provide a list of valid barcodes (e.g., the `barcodes.tsv` from CellRanger).
  ```bash
  demuxlet --sam input.bam --vcf genotypes.vcf --group-list barcodes.tsv --out output_prefix
  ```
- **Filtering**: Use `--min-MQ` (default 20) and `--min-BQ` (default 13) to ensure only high-quality reads and bases are used for SNP calling.

## Expert Tips and Best Practices

- **Doublet Estimation**: To improve the accuracy of doublet estimates, it is recommended to set `--alpha 0 --alpha 0.5`. This assumes an expected proportion of 50% genetic mixture from two individuals.
- **Genotype Error**: If using hard genotypes (`--field GT`), always consider the `--geno-error` rate (default is 0.01). Adjust this if you suspect higher sequencing error or lower genotype quality.
- **Input Preparation**: The SAM/BAM/CRAM file **must** be sorted by coordinates and indexed (`samtools index`). The VCF file should also be indexed (`tabix`).
- **Sample Selection**: If the VCF contains more samples than are present in the pool, use `--sm-list` to provide a text file of the specific sample IDs to compare against.

## Output Interpretation
The tool generates several files, the most important being:
- **[prefix].best**: The primary output. Contains the best guess for sample identity (SNG for singlet, DBL for doublet, AMB for ambiguous).
- **[prefix].sing**: Statistics for matching each cell against every possible individual singlet.
- **[prefix].pair**: (Optional, requires `--write-pair`) Detailed statistics for every possible doublet combination. Note: This file can be extremely large.

## Reference documentation
- [demuxlet GitHub Repository](./references/github_com_statgen_demuxlet.md)
- [demuxlet Wiki and Usage Guide](./references/github_com_statgen_demuxlet_wiki.md)