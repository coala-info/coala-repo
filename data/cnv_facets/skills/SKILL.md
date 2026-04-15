---
name: cnv_facets
description: cnv_facets performs somatic copy number analysis by comparing tumor and normal sequencing samples using the facets R package. Use when user asks to identify somatic copy number variants, estimate tumor purity and ploidy, or process BAM files to determine total and minor copy numbers.
homepage: https://github.com/wwcrc/cnv_facets
metadata:
  docker_image: "quay.io/biocontainers/cnv-phenopacket:1.0.2"
---

# cnv_facets

## Overview

The `cnv_facets` skill provides a streamlined interface for the `facets` R package, automating the complex multi-step process of somatic copy number analysis. It identifies variants private to a tumor sample by comparing it against a matched or unmatched normal sample. This tool is highly effective for researchers needing to determine total and minor copy numbers, cellular fraction, and overall genomic landscape (purity/ploidy) in a single command-line execution.

## Core Workflows

### 1. Standard BAM-to-VCF Pipeline
This is the primary workflow for processing raw alignment files. It requires sorted and indexed BAM files and a VCF of known polymorphic SNPs (e.g., dbSNP).

```bash
cnv_facets.R \
  -t tumor.bam \
  -n normal.bam \
  -vcf common_snps.vcf.gz \
  -o output_prefix
```

### 2. Rapid Iteration via Pileup
If you need to adjust downstream detection parameters (like cval or snp.nth), use the pileup file generated from a previous run to save significant computation time.

```bash
cnv_facets.R \
  -p output_prefix.pileup.csv.gz \
  -o refined_output
```

## Expert Tips and Best Practices

### Input Preparation
*   **SNP Selection**: For human samples, use the "common" subset of dbSNP (e.g., `common_all.vcf.gz`). Using the full dbSNP file can be computationally prohibitive and introduce noise.
*   **Indexing**: Ensure all BAM and VCF files are indexed (`samtools index` and `tabix -p vcf`).

### Interpreting Key VCF Tags
The output VCF contains critical somatic information in the INFO field:
*   **TCN_EM**: Total copy number (2 = diploid).
*   **LCN_EM**: Lesser (minor) copy number (1 = heterozygous).
*   **CF_EM**: Cellular fraction (fraction of DNA associated with the aberrant genotype).
*   **Purity/Ploidy**: These estimates are located in the **VCF header** rather than the individual records.

### Filtering for Relevant CNVs
To focus on high-confidence or significant alterations, filter the output VCF based on:
*   **NHET**: Number of heterozygous SNPs in the segment. Higher numbers increase confidence in the segment's copy number call.
*   **CNLR_MEDIAN**: The log-ratio of tumor vs. normal depth. Values significantly different from 0 indicate gains or losses.

### Visual Diagnostics
Always review the generated `.cnv.png` plot. It provides a genome-wide view of the log-ratio and log-odds-ratio, which is essential for validating the purity and ploidy estimates provided in the VCF header.

## Reference documentation
- [Somatic copy variant caller (CNV) for next generation sequencing](./references/github_com_dariober_cnv_facets.md)
- [cnv_facets - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_cnv_facets_overview.md)