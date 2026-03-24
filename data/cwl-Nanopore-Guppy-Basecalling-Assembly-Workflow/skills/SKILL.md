---
name: nanopore-guppy-basecalling-assembly-workflow
description: "This CWL workflow processes raw Oxford Nanopore sequencing data through basecalling, quality control, taxonomic classification, and de novo assembly using tools such as Guppy, Kraken2, and Flye. Use this skill when you need to reconstruct high-quality genomes from raw signal data and characterize the taxonomic composition of environmental or clinical samples."
homepage: https://workflowhub.eu/workflows/253
---
# Nanopore Guppy Basecalling Assembly Workflow

## Overview

This Common Workflow Language (CWL) pipeline provides an end-to-end solution for processing Oxford Nanopore Technologies (ONT) sequencing data, moving from raw signal data to a polished *de novo* assembly. It integrates standard bioinformatics tools to ensure data quality, taxonomic transparency, and high-quality genomic outputs.

The workflow initiates with basecalling via Guppy (CPU) and quality control using MinIONQC. Subsequent steps include taxonomic classification with Kraken2 and visualization through Krona, followed by *de novo* assembly using Flye. The pipeline concludes with assembly polishing via Medaka and comprehensive quality reporting through QUAST.

The complete source code for this workflow and its constituent tool definitions are available in the [UNLOCK CWL repository](https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows). Detailed execution history and versioning can be found on the [WorkflowHub page](https://workflowhub.eu/workflows/253).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| identifier | identifier used | string | Identifier for this dataset used in this workflow |
| threads | number of threads | int? | number of threads to use for computational processes |
| fast5_files | nanopore reads | File[] | folder with Nanopore raw reads |
| configuration_command |  | string |  |
| kraken_database |  | Directory | database location of kraken2 |
| basecall_model | basecalling model | string | basecalling model used with Guppy |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| workflow_basecalling | Guppy-CPU basecalling | Basecalling with Guppy for CPU of raw reads to FASTQ reads with summary |
| workflow_nanopore_noguppy | Nanopore workflow | The rest of the nanopore workflow without basecalling |
| guppy_files_to_folder | Guppy output folder | Preparation of Guppy output files to a specific output folder |
| workflow_minionqc | MinIONQC quality check | Plots and statistics generated with MinIONQC from basecalling with Guppy |
| minionqc_files_to_folder | MinIONQC output folder | Preparation of MinIONQC output files to a specific output folder |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| guppy_output | Guppy for CPU | Directory | Basecalling of raw reads with Guppy |
| minionqc_output | MinION-Quality-Check | Directory | Quality check of basecalling with MinIONQC |
| merge_output | FASTQ files merged | Directory | Concatenation of FASTQ files from Guppy |
| kraken2_output | Kraken2 reports | Directory | Kraken2 taxonomic classification reports |
| krona_output | Krona taxonomy visualization | Directory | Visual presentation in HTML of Kraken2 results |
| flye_output | Flye de novo assembler for single-molecule reads | Directory | Flye output directory |
| medaka_output | Medaka polisher | Directory | Polishing of Flye assembly |
| quast_output | QUAlity assessment | Directory | QUAST analysis output |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/253
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
