---
name: exome-alignment
description: This CWL workflow processes raw exome sequencing reads using Cutadapt, BWA-MEM, and Picard to perform adapter trimming, sequence alignment, and duplicate marking. Use this skill when you need to identify genetic variants or characterize the mutational profiles of pediatric cancer patients.
homepage: https://ipc-project.eu/
metadata:
  docker_image: "N/A"
---

# exome-alignment

## Overview

The [exome-alignment](https://workflowhub.eu/workflows/239) workflow is a Common Workflow Language (CWL) pipeline designed for processing exome sequencing data, specifically optimized for cancer and pediatric research. It provides a standardized, reproducible path from raw sequence reads to analysis-ready alignments under the Apache-2.0 license.

The pipeline begins with data preparation and reference indexing. Raw input files are decompressed and processed through `cutadapt` for adapter trimming. Simultaneously, the reference genome is prepared using `bwa_index`, `samtools_faidx`, and `picard_dictionary` to generate the necessary indices and metadata required for accurate mapping.

Core alignment is executed using `bwa_mem`, followed by a series of post-processing steps to ensure data integrity. The workflow employs `samtools_sort` to organize the resulting alignments and `picard_markduplicates` to identify and flag PCR duplicates, producing a refined BAM file suitable for downstream variant calling.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| fastq_files |  | File[] | List of paired-end input FASTQ files |
| reference_fasta |  | File | Compress FASTA files with the reference genome chromosomes |
| readgroup |  | string | Parsing header which should correlate to FASTQ files |
| sample_name |  | string | Sample name |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| gunzip | gunzip |  |
| picard_dictionary | picard_dictionary |  |
| cutadapt | cutadapt |  |
| bwa_index | bwa_index |  |
| samtools_faidx | samtools_faidx |  |
| bwa_mem | bwa_mem |  |
| samtools_sort | samtools_sort |  |
| picard_markduplicates | picard_markduplicates |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| sorted_bam |  | File | Sorted aligned BAM file |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/239
- `workflow.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata