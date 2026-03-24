---
name: genomic-variants-snps-and-indels-detection-using-samtools
description: "This CWL workflow aligns Illumina RNA-seq reads to a reference genome using Bowtie2 and identifies SNPs and INDELs using SAMTools and BCFtools. Use this skill when you need to identify genetic variations in viral genomes to track mutations or characterize the evolutionary dynamics of pathogens like SARS-CoV-2."
homepage: https://workflowhub.eu/workflows/34
---
# Genomic variants - SNPs and INDELs detection using SAMTools.

## Overview

This [Common Workflow Language (CWL) workflow](https://workflowhub.eu/workflows/34) provides a standardized pipeline for detecting genomic variants, specifically Single Nucleotide Polymorphisms (SNPs) and Insertions/Deletions (INDELs). While designed as a general-purpose tool for variant calling, it is specifically optimized for identifying SARS-CoV-2 variants using Illumina RNA-seq reads and a reference genome.

The process begins with reference genome indexing and read alignment using Bowtie2. The resulting alignments undergo a series of processing steps using SAMTools, including format conversion (SAM to BAM), sorting, and indexing to prepare the data for variant calling.

In the final stages, the workflow utilizes BCFtools to perform pileup and calling, generating distinct outputs for SNPs and INDELs. This modular approach ensures a reproducible path from raw sequence data to annotated variant files, following established standard operating procedures for viral genomics.

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
| snp_generation_using_bcftools | snp_generation_using_bcftools |  |
| indel_generation_using_bcftools | indel_generation_using_bcftools |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| snp |  | File |  |
| indel |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/34
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
