---
name: gatk
description: The Genome Analysis Toolkit identifies variants in high-throughput sequencing data using industry-standard workflows. Use when user asks to identify germline or somatic variants, preprocess sequencing data, or construct command-line calls for GATK4 tools.
homepage: https://www.broadinstitute.org/gatk/
---


# gatk

## Overview
The Genome Analysis Toolkit (GATK) is the industry-standard software package for identifying variants in high-throughput sequencing data. This skill assists in constructing command-line calls for GATK's wide array of tools, focusing on the Best Practices workflows for germline short variant discovery, somatic mutation calling (Mutect2), and data preprocessing. It helps navigate the transition between GATK3 (legacy) and GATK4 (current) syntax and ensures proper parameter selection for different sequencing technologies.

## Common CLI Patterns

### GATK4 Standard Syntax
GATK4 uses a unified executable. The general structure is:
`gatk ToolName -I input.bam -R reference.fasta -O output.vcf [tool-specific arguments]`

### Data Preprocessing
Before variant calling, data must be cleaned.
*   **MarkDuplicates**: `gatk MarkDuplicates -I input.bam -O marked_duplicates.bam -M metrics.txt`
*   **BaseRecalibrator (BQSR)**:
    1. Generate table: `gatk BaseRecalibrator -I input.bam -R ref.fasta --known-sites sites.vcf -O recal_data.table`
    2. Apply recalibration: `gatk ApplyBQSR -I input.bam -R ref.fasta --bqsr-recal-file recal_data.table -O recalibrated.bam`

### Germline Variant Discovery
*   **HaplotypeCaller (GVCF mode)**: Recommended for cohort analysis.
    `gatk HaplotypeCaller -R ref.fasta -I input.bam -O output.g.vcf.gz -ERC GVCF`
*   **GenotypeGVCFs**: Perform joint genotyping on one or more GVCFs.
    `gatk GenotypeGVCFs -R ref.fasta -V input.g.vcf.gz -O final_variants.vcf`

### Somatic Variant Discovery (Mutect2)
*   **Tumor-only**: `gatk Mutect2 -R ref.fasta -I tumor.bam -O somatic.vcf.gz`
*   **Tumor-Normal pair**: `gatk Mutect2 -R ref.fasta -I tumor.bam -I normal.bam -normal normal_sample_name -O somatic.vcf.gz`

## Expert Tips
*   **Memory Management**: Use the `--java-options` flag to control heap size, e.g., `gatk --java-options "-Xmx4G" ToolName ...`.
*   **Intervals**: Use `-L` to restrict analysis to specific chromosomes or regions (BED or interval list format) to significantly speed up processing.
*   **Index Files**: Ensure all input BAMs are indexed (.bai) and the reference FASTA has a dictionary (.dict) and index (.fai) in the same directory.
*   **Read Filters**: GATK applies default filters (e.g., mapping quality). Use `--disable-read-filter` only if you have a specific reason to include low-quality data.

## Reference documentation
- [GATK Overview](./references/anaconda_org_channels_bioconda_packages_gatk_overview.md)