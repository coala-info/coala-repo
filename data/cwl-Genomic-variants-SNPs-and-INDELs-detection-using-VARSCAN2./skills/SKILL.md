---
name: genomic-variants-snps-and-indels-detection-using-varscan2
description: "This CWL workflow identifies SNPs and INDELs from Illumina RNA-seq reads by aligning sequences to a reference genome using Bowtie2 and calling variants with VarScan2. Use this skill when you need to characterize genetic diversity, identify mutations in viral genomes like SARS-CoV-2, or detect small insertions and deletions within genomic sequences."
homepage: https://workflowhub.eu/workflows/31
---
# Genomic variants - SNPs and INDELs detection using VARSCAN2.

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/31) workflow provides a standardized pipeline for detecting genomic variants, specifically Single Nucleotide Polymorphisms (SNPs) and Insertions/Deletions (INDELs). While designed as a general-purpose tool for Illumina RNA-seq data, it is optimized for identifying variants within the SARS-CoV-2 genome.

The process begins with reference genome preparation and read alignment. The workflow uses Bowtie2 for genome indexing and sequence alignment, followed by a suite of Samtools utilities to convert, sort, and index the resulting BAM files. These steps ensure the alignment data is properly formatted for high-sensitivity variant detection.

The final stage of the pipeline generates a pileup format using `samtools mpileup`, which serves as the input for VARSCAN2. The workflow then executes two specialized calling steps—`mpileup2snp` and `mpileup2indel`—to produce a comprehensive set of genomic variants. This modular approach allows for precise identification of genetic changes relative to the provided reference sequence.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| sars_cov_2_reference_genome |  | File |  |
| rnaseq_left_reads |  | File |  |
| rnaseq_right_reads |  | File |  |
| sample_name |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| index_reference_genome_with_bowtie2 | index_reference_genome_with_bowtie2 |  |
| align_rnaseq_reads_to_genome | align_rnaseq_reads_to_genome |  |
| index_reference_genome_with_samtools | index_reference_genome_with_samtools |  |
| sam_to_bam_conversion_using_samtools_view | sam_to_bam_conversion_using_samtools_view |  |
| sort_alignment_files_using_samtools_sort | sort_alignment_files_using_samtools_sort |  |
| index_bam_files_using_samtools_index | index_bam_files_using_samtools_index |  |
| mpileup_generation_using_samtools_mpileup | mpileup_generation_using_samtools_mpileup |  |
| snp_calling_using_mpileup2snp | snp_calling_using_mpileup2snp |  |
| indel_calling_using_mpileup2indel | indel_calling_using_mpileup2indel |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| snps |  | File |  |
| indels |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/31
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
