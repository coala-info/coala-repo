---
name: genomic-variants-snps-and-indels-detection-using-gatk4-spark
description: This CWL workflow identifies SNPs and INDELs from Illumina RNA-seq reads by aligning sequences to a reference genome using Bowtie2 and performing variant calling with GATK4 Spark-based tools. Use this skill when you need to characterize the genetic diversity of SARS-CoV-2 samples or identify specific mutations that may influence viral pathogenicity and transmission.
homepage: https://github.com/fjrmoreews/cwl-workflow-SARS-CoV-2
metadata:
  docker_image: "N/A"
---

# genomic-variants-snps-and-indels-detection-using-gatk4-spark

## Overview

This CWL workflow implements a standard operating procedure for detecting Single Nucleotide Polymorphisms (SNPs) and Small Insertions/Deletions (INDELs) using GATK4 Spark-based tools. While applicable to various genomic datasets, it is specifically optimized for identifying variants in SARS-CoV-2 genomes using Illumina RNA-seq data.

The pipeline begins with reference genome indexing and read alignment using Bowtie2. Subsequent preprocessing steps include updating read groups, SAM sorting, and duplicate marking. To prepare the data for high-sensitivity discovery, the workflow performs alignment splitting and indexing before utilizing GATK4's HaplotypeCaller logic to identify plausible haplotypes and call variants.

The workflow is available on [WorkflowHub](https://workflowhub.eu/workflows/33) and is licensed under Apache-2.0. It leverages Spark-based implementations of GATK4 tools to improve computational efficiency during the variant discovery process.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| sars_cov_2_reference_genome |  | File |  |
| sars_cov_2_reference_2bit_genome |  | File |  |
| rnaseq_left_reads |  | File |  |
| rnaseq_right_reads |  | File |  |
| sampleName |  | string |  |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| index_reference_genome_with_bowtie2 | index_reference_genome_with_bowtie2 |  |
| align_rnaseq_reads_to_genome | align_rnaseq_reads_to_genome |  |
| index_reference_genome_with_samtools | index_reference_genome_with_samtools |  |
| create_sequence_dictionary | create_sequence_dictionary |  |
| update_read_group | update_read_group |  |
| sort_sam | sort_sam |  |
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

- WorkflowHub: https://workflowhub.eu/workflows/33
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata