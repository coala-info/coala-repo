---
name: quick-variants
description: quick-variants is a high-performance tool designed to extract variant information from sequence alignments.
homepage: https://github.com/caozhichongchong/QuickVariants
---

# quick-variants

## Overview

quick-variants is a high-performance tool designed to extract variant information from sequence alignments. It is particularly useful for bioinformatics workflows requiring rapid conversion of SAM data into VCF or tabular mutation formats. The tool excels at processing large-scale sequencing studies by providing flexible input handling (ordered vs. unordered SAM) and multi-threaded execution. Use this skill to determine the correct CLI parameters for filtering mutations, managing memory usage during alignment processing, and generating specific output formats like VCF or reference map counts.

## Installation

The tool is available via Bioconda:
```bash
conda install bioconda::quick-variants
```
Alternatively, it can be run as a standalone Java executable:
```bash
java -jar quick-variants.jar [options]
```

## Core Workflows

### Basic Variant Calling
To generate a VCF file from a reference and a SAM file:
```bash
quick-variants --reference ref.fasta --in-sam input.sam --out-vcf output.vcf
```

### Memory and Performance Optimization
*   **Ordered SAM**: If your SAM file has paired-end reads listed in adjacent lines, use `--in-ordered-sam`. This is significantly faster and uses less memory than the default unordered mode.
*   **Unordered SAM**: Use `--in-unordered-sam` (or the alias `--in-sam`) for files where read pairs are scattered.
*   **Parallelization**: Use `--num-threads <count>` to utilize multiple CPU cores.

### Output Customization
You can specify multiple output formats in a single run:
*   **VCF**: `--out-vcf <file>` (Mutation counts by position).
*   **Mutation List**: `--out-mutations <file>` (Detailed list of mutations per query).
*   **Reference Summary**: `--out-refs-map-count <file>` (Summary of reads mapped per reference).
*   **Clean VCFs**: Use `--vcf-exclude-non-mutations` to omit positions without detected variants and `--vcf-omit-support-reads` to hide supporting read IDs for smaller file sizes.

## Threshold and Filtering Best Practices

quick-variants uses two-part thresholds: `<minimum total depth>` and `<minimum supporting depth fraction>`.

### SNP Filtering
*   **Default for VCF**: 0 depth, 0 fraction (reports everything).
*   **Default for Mutation List**: 5 depth, 0.9 fraction.
*   **Customizing**: `--snp-threshold 10 0.95` (Requires 10x coverage and 95% agreement).

### Indel Filtering
Indels can be filtered at the start or during continuation:
*   **Combined**: `--indel-threshold <depth> <fraction>` sets both start and continue.
*   **Granular**: Use `--indel-start-threshold` and `--indel-continue-threshold` for specific control over gap extensions.

### Query End Filtering
To avoid false positives from low-quality alignment ends, use `--distinguish-query-ends <fraction>`. By default (0.1), the tool separately tracks variants found in the first/last 10% of a read versus the middle 80%.

## Reference documentation
- [QuickVariants GitHub Main](./references/github_com_caozhichongchong_QuickVariants.md)
- [Bioconda Quick-Variants Overview](./references/anaconda_org_channels_bioconda_packages_quick-variants_overview.md)