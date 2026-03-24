---
name: genomic-variants-snps-and-indels-detection-using-gatk4
description: "This CWL workflow identifies SNPs and INDELs from Illumina RNA-seq reads by aligning sequences to a reference genome using Bowtie2 and performing variant calling with GATK4. Use this skill when you need to characterize genetic mutations, analyze viral evolution, or identify genomic variations in pathogens such as SARS-CoV-2."
homepage: https://workflowhub.eu/workflows/30
---
# Genomic variants - SNPs and INDELs detection using GATK4.

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/30) workflow implements a standard operating procedure for detecting Single Nucleotide Polymorphisms (SNPs) and Insertions/Deletions (INDELs) using GATK4. While designed as a general-purpose pipeline for Illumina RNA-seq data, it is specifically optimized for identifying variants in SARS-CoV-2 genomes.

The pipeline begins with reference genome preparation, including indexing via Bowtie2 and Samtools and the creation of a sequence dictionary. Input reads are aligned to the reference, followed by essential post-processing steps: updating read groups, marking duplicates, and splitting alignments to ensure data quality and compatibility with GATK requirements.

In the final stages, the workflow utilizes GATK4 to call plausible haplotypes and detect variants across the processed alignments. These raw calls are then passed through a quality filter to remove low-confidence variants, resulting in a refined set of genomic variations. The complete workflow definition and version history can be found on [WorkflowHub](https://workflowhub.eu/workflows/30).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| sars_cov_2_reference_genome |  | File |  |
| rnaseq_left_reads |  | File |  |
| rnaseq_right_reads |  | File |  |
| indices_folder |  | Directory |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| index_reference_genome_with_bowtie2 | index_reference_genome_with_bowtie2 |  |
| align_rnaseq_reads_to_genome | align_rnaseq_reads_to_genome |  |
| index_reference_genome_with_samtools | index_reference_genome_with_samtools |  |
| create_sequence_dictionary | create_sequence_dictionary |  |
| update_read_group | update_read_group |  |
| mark_duplicates | mark_duplicates |  |
| split_alignments | split_alignments |  |
| index_split_alignments | index_split_alignments |  |
| call_plausible_haplotypes_and_detect_variants | call_plausible_haplotypes_and_detect_variants |  |
| filer_out_low_quality_variants | filer_out_low_quality_variants |  |
| select_indels | select_indels |  |
| select_snps | select_snps |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| indels |  | File |  |
| snps |  | File |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/30
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
