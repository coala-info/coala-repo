---
name: t1k
description: T1K genotypes highly polymorphic gene families like HLA and KIR by aligning sequencing reads to an allele reference database. Use when user asks to build reference indices for target gene families, genotype alleles from FASTQ or BAM files, or identify novel variants in immune system genes.
homepage: https://github.com/mourisl/T1K
---

# t1k

## Overview
T1K (The ONE genotyper for Kir and HLA) is a specialized bioinformatic tool designed to handle the complexity of highly polymorphic gene families. It works by aligning sequencing reads to a provided allele reference database and calculating abundances to identify the most likely true alleles. It is particularly effective for researchers working with massively parallel sequencing data who require high accuracy in immune system gene characterization.

## Core Workflow

### 1. Database Preparation
Before running genotyping, you must build the reference indices for the target gene families. T1K provides a script to download and build these from IPD-IMGT/HLA and IPD-KIR.

```bash
# Build HLA index
perl t1k-build.pl -o hlaidx --download IPD-IMGT/HLA

# Build KIR index
perl t1k-build.pl -o kiridx --download IPD-KIR
```

### 2. Running Genotyping
T1K supports multiple input formats including paired-end FASTQ, single-end FASTQ, and BAM files.

**Paired-end FASTQ:**
```bash
run-t1k -1 read_1.fq -2 read_2.fq -f hlaidx/hla_herc.fa -o output_prefix
```

**BAM Input (requires gene coordinates):**
```bash
run-t1k -b input.bam -f hlaidx/hla_herc.fa -c hlaidx/hla_herc_genecoord.fa -o output_prefix
```

### 3. Common Parameters
- `-t INT`: Set the number of threads (default is 1). Increase this for faster processing.
- `-s FLOAT`: Minimum alignment similarity (default 0.8). Increase this to 0.9 or higher for more stringent allele calls.
- `--od DIR`: Specify an output directory.

## Expert Tips and Best Practices
- **Memory Management**: When working with large WGS datasets, use the BAM input method if a coordinated BAM is already available to reduce redundant processing.
- **Novel Variant Detection**: T1K can identify novel SNPs. Review the `_candidate_variants.vcf` output file to find variations not present in the reference database.
- **Single-Cell Data**: For single-cell RNA-seq (e.g., 10x Genomics), ensure you provide the barcode and UMI information if using the specialized extraction scripts found in the `scripts/` directory.
- **Coordinate Files**: When using BAM files, the `-c` coordinate file is mandatory. This file is typically generated during the `t1k-build.pl` step.



## Subcommands

| Command | Description |
|---------|-------------|
| ./run-t1k | T1K v1.0.9-r251 |
| t1k-build.pl | Builds a T1K database from EMBL-ENA dat files, plain gene sequence files, or download links. |

## Reference documentation
- [T1K Main Repository](./references/github_com_mourisl_T1K.md)
- [T1K Analyzer Implementation](./references/github_com_mourisl_T1K_blob_master_Analyzer.cpp.md)
- [Gene Coordinate Script](./references/github_com_mourisl_T1K_blob_master_AddGeneCoord.pl.md)