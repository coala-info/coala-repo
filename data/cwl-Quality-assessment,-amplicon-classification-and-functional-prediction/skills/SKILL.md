---
name: quality-assessment-amplicon-classification-and-functional-pr
description: "This CWL workflow performs quality assessment of paired-end amplicon sequencing reads, taxonomic classification using NG-Tax 2.0, and functional potential prediction via PICRUSt2. Use this skill when you need to characterize microbial community diversity and infer the metabolic capabilities of environmental or clinical samples based on marker gene profiles."
homepage: https://workflowhub.eu/workflows/154
---
# Quality assessment, amplicon classification and functional prediction

## Overview

This Common Workflow Language (CWL) pipeline provides an automated solution for the quality assessment, taxonomic classification, and functional prediction of paired-end amplicon sequencing data. It integrates standardized bioinformatics tools to transform raw reads into annotated tables and functional profiles suitable for downstream microbiome analysis.

The workflow executes three primary analytical stages:
*   **Quality Control:** [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) generates comprehensive quality plots to evaluate the integrity of the input reads.
*   **Classification:** [NG-TAX 2.0](https://github.com/NG-Tax/NG-Tax) performs high-throughput amplicon analysis, including denoising and taxonomic assignment.
*   **Functional Prediction:** [PICRUSt2](https://github.com/picrust/picrust2) predicts functional abundances based on the marker gene sequences identified during the classification step.

To streamline data management, the workflow includes dedicated export modules that organize outputs into structured subfolders. These modules handle file conversions (such as NG-TAX to TSV/FASTA), folder compression, and the preparation of files for tools like Phyloseq. The complete implementation and version history can be accessed on [WorkflowHub](https://workflowhub.eu/workflows/154).

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
| fragment | Subfragment name | string | Subfragment that is being analysed (e.g. V1-V3 or V5-region) |
| primersRemoved | Primers are removed | boolean? | Wether the primers are removed or not from the input files |
| threads | number of threads | int? | number of threads to use for computational processes |
| metadata | Metadata file | File? | UNLOCK assay metadata file |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| fastqc | fastqc |  |
| reads_to_folder | reads_to_folder |  |
| ngtax | ngtax |  |
| ngtax_to_tsv-fasta | ngtax_to_tsv-fasta |  |
| picrust2 | picrust2 |  |
| folder_compression | folder_compression |  |
| fastqc_files_to_folder | fastqc_files_to_folder |  |
| ngtax_files_to_folder | ngtax_files_to_folder |  |
| picrust_files_to_folder | picrust_files_to_folder |  |
| phyloseq_files_to_folder | phyloseq_files_to_folder |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| turtle |  | File | Used for other workflows |
| files_to_folder_fastqc |  | Directory |  |
| files_to_folder_ngtax |  | Directory |  |
| files_to_folder_picrust2 |  | Directory |  |
| files_to_folder_phyloseq |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/154
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
