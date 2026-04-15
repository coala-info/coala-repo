---
name: nonspliced-rnaseq-workflow
description: This Common Workflow Language pipeline processes non-spliced RNA-seq data through quality control, trimming, and quantification using tools such as fastp, Bowtie2, FeatureCounts, and Kallisto. Use this skill when you need to quantify gene expression levels or characterize the transcriptomic profile of organisms with non-spliced genes, such as bacteria or specific eukaryotic datasets.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# nonspliced-rnaseq-workflow

## Overview

This [NonSpliced RNAseq workflow](https://workflowhub.eu/workflows/77) is a Common Workflow Language (CWL) pipeline designed for the analysis of RNA-seq data where splicing is not a primary factor. It integrates multiple alignment and quantification strategies to provide a comprehensive view of transcript abundance.

The process begins with a quality control and filtering sub-workflow, utilizing **FastQC** for assessment and **fastp** for read trimming. Once processed, reads are mapped to the reference genome using **bowtie2**. The pipeline automatically handles the conversion of SAM outputs into sorted BAM files to ensure compatibility with downstream tools.

For transcript quantification, the workflow employs two complementary methods:
*   **FeatureCounts**: Generates traditional read counts based on genomic features.
*   **kallisto**: Performs rapid pseudo-alignment to provide transcript-level abundance estimates.

This dual-quantification approach allows users to compare results between standard alignment-based counting and alignment-free pseudo-mapping within a single execution.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| threads | number of threads | int? | number of threads to use for computational processes |
| memory | Max memory | int? | maximum memory usage in megabytes |
| filter_rrna | Filer rRNA | boolean | Filter rRNA from reads if true |
| prefix_id | Filename prefix | string | Prefix of the output filenames. |
| forward_reads | forward reads | File | forward sequence file locally |
| reverse_reads | reverse reads | File | reverse sequence file locally |
| bowtie2-indexfolder | bowtie2 index | Directory | Folder location of the bowtie2 index files. |
| kallisto-indexfolder | kallisto index | Directory? | Folder location of the kallisto index file. |
| gtf | GTF file | File? | GTF file location |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| quality | Quality and filtering workflow | Quality assessment of illumina reads with rRNA filtering option |
| bowtie2 | bowtie2 | runs bowtie2 alignment on the genome with the quality filtered reads. |
| sam_to_sorted-bam | sam to sorted bam | Converts a SAM file to a sorted BAM file |
| featurecounts | FeatureCounts | Calculates gene counts with bowtie2 mapped data and input GTF file with FeatureCounts. |
| kallisto | kallisto | Calculates transcript abundances |
| bowtie2_files_to_folder | bowtie2 output | Preparation of bowtie2 output files to a specific output folder |
| featurecounts_files_to_folder | FeatureCounts output | Preparation of FeatureCounts output files to a specific output folder |
| kallisto_files_to_folder | FeatureCounts output | Preparation of kallisto output files to a specific output folder |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| files_to_folder_fastqc | FASTQC | Directory | Quality reporting by FASTQC |
| files_to_folder_filtered | Filtered reads folder | Directory | Output folder with filtered reads. |
| files_to_folder_bowtie2 | bowtie2 output | Directory | bowtie2 mapping results folder. Contains sorted bam file, metrics file and mapping statistics (stdout). |
| files_to_folder_featurecounts | FeatureCounts output | Directory | FeatureCounts results folder. Contains readcounts, summary and mapping statistics (stdout). |
| files_to_folder_kallisto | kallisto output | Directory | kallisto results folder. Contains transcript abundances, run info and summary. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/77
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata