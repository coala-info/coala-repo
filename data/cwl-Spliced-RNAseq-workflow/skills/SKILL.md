---
name: spliced-rnaseq-workflow
description: "This Common Workflow Language pipeline processes spliced RNA-seq data through quality control with FastQC and fastp, read mapping with STAR, and transcript quantification using featureCounts and kallisto. Use this skill when you need to quantify gene expression levels and generate transcript counts from raw sequencing reads to characterize the transcriptomic profile of biological samples."
homepage: https://workflowhub.eu/workflows/95
---
# Spliced RNAseq workflow

## Overview

This [Common Workflow Language (CWL) pipeline](https://workflowhub.eu/workflows/95) provides a comprehensive solution for processing spliced RNA-seq data, covering the entire path from raw reads to transcript quantification. It integrates standard bioinformatics tools to ensure high-quality mapping and expression analysis.

The process begins with a quality control and filtering sub-workflow. Raw reads are assessed using FastQC and subsequently trimmed and filtered via fastp to remove low-quality bases and adapter sequences. This ensures that only high-quality data proceeds to the alignment stage.

Following pre-processing, the workflow performs read mapping and quantification through two parallel approaches. Reads are aligned to a reference genome using the STAR (Spliced Transcripts Alignment to a Reference) mapper, with results quantified by FeatureCounts. Simultaneously, the workflow utilizes kallisto for alignment-free pseudo-quantification, providing users with both genomic and transcriptomic expression outputs.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| threads | number of threads | int? | number of threads to use for computational processes |
| memory | maximum memory usage in megabytes | int? | maximum memory usage in megabytes |
| filter_rrna |  | boolean |  |
| prefix_id |  | string | prefix of the filename outputs |
| forward_reads | forward reads | File | forward sequence file locally |
| reverse_reads | reverse reads | File | reverse sequence file locally |
| STAR-indexfolder | folder where the STAR indices are | Directory |  |
| kallisto-indexfolder | folder where the kallisto indices are | Directory? |  |
| gtf |  | File | gtf file |
| quantMode |  | null, enum | Run with get gene quantification |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| quality | Quality and filtering workflow | Quality assessment of illumina reads with rRNA filtering option |
| STAR | STAR | runs STAR alignment on the genome with the quality filtered reads. |
| featurecounts | FeatureCounts | Calculates gene counts with bowtie2 mapped data and input GTF file with FeatureCounts. |
| kallisto | kallisto | Calculates transcript abundances |
| STAR_files_to_folder | STAR output | Preparation of STAR output files to a specific output folder |
| featurecounts_files_to_folder | FeatureCounts output | Preparation of FeatureCounts output files to a specific output folder |
| kallisto_files_to_folder | kallisto output | Preparation of kallisto output files to a specific output folder |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| files_to_folder_fastqc | FASTQC | Directory | Quality reporting by FASTQC |
| files_to_folder_filtered | Filtered reads folder | Directory | Output folder with filtered reads. |
| files_to_folder_STAR | STAR output folder | Directory | STAR results folder. Contains logs, bam file, readcounts per gene and splice_junctions. |
| files_to_folder_featurecounts | FeatureCounts output | Directory | FeatureCounts results folder. Contains readcounts, summary and mapping statistics (stdout). |
| files_to_folder_kallisto | kallisto output | Directory | kallisto results folder. Contains transcript abundances, run info and summary. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/95
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
