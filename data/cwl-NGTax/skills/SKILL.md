---
name: ngtax
description: This CWL workflow processes 16S and ITS amplicon sequencing reads to perform quality control and taxonomic classification using FastQC and the NG-Tax 2.0 pipeline. Use this skill when you need to characterize microbial community structures or identify specific taxa within environmental and clinical samples.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# ngtax

## Overview

This Common Workflow Language (CWL) workflow performs automated amplicon analysis for 16S and ITS sequencing data. It utilizes the [NG-Tax 2.0](https://doi.org/10.3389/fgene.2019.01366) framework to facilitate high-throughput Amplicon Sequence Variant (ASV) detection and taxonomic classification.

The pipeline executes the following core stages:
* **Quality Control:** Initial assessment of raw sequencing reads using FastQC.
* **Data Organization:** Sorting and preparing read files into directory structures required for downstream processing.
* **ASV Analysis:** Execution of the NGTax algorithm for denoising, ASV identification, and taxonomic assignment.
* **Result Aggregation:** Collection of quality reports and classification outputs into final delivery folders.

The workflow is accessible via [WorkflowHub](https://workflowhub.eu/workflows/45) and is provided under a CC0-1.0 license, supporting reproducible microbiome research across different computational environments.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| forward_reads | forward reads | File | forward sequence file locally |
| reverse_reads | reverse reads | File? | reverse sequence file locally |
| forward_primer | Forward primer | string | Forward primer used |
| reverse_primer | Reverse primer | string? | Reverse primer used |
| reference_db | Reference database | string? | Reference database used in FASTA format |
| rev_read_len | Reverse read length | int? | Read length of the reverse read |
| for_read_len | Reverse read length | int | Read length of the reverse read |
| sample | Sample name | string | Name of the sample being analysed |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| fastqc | fastqc |  |
| reads_to_folder | reads_to_folder |  |
| ngtax | ngtax |  |
| fastqc_files_to_folder | fastqc_files_to_folder |  |
| ngtax_files_to_folder | ngtax_files_to_folder |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| files_to_folder_fastqc |  | Directory |  |
| files_to_folder_ngtax |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/45
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata