---
name: short-read-quality-control-trimming-and-contamination-filter
description: This CWL workflow processes short paired-end Illumina reads through quality control, trimming, and multi-stage contamination filtering using fastp, BBduk, and Hostile. Use this skill when you need to prepare clean, high-quality genomic or transcriptomic datasets by removing sequencing artifacts and unwanted biological contaminants like human, phiX, or ribosomal RNA sequences.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# short-read-quality-control-trimming-and-contamination-filter

## Overview

This CWL workflow provides a comprehensive pipeline for the quality control, trimming, and contamination filtering of short paired-end reads. It begins by merging multiple paired datasets into a single pair and performing an initial quality assessment using Sequali to establish a baseline for the raw data.

Read quality trimming is executed via fastp, followed by a series of optional filtering steps to remove unwanted sequences. These include rRNA and PhiX removal using BBduk, as well as human and custom reference filtering powered by Hostile. The process concludes with a final Sequali QC assessment on the filtered data to verify sequence integrity and tool performance.

The complete collection of tool definitions and related pipelines can be found in the [UNLOCK GitLab repository](https://gitlab.com/m-unlock/cwl). For detailed implementation instructions, refer to the [UNLOCK setup documentation](https://docs.m-unlock.nl/docs/workflows/setup.html) or browse additional [UNLOCK workflows](https://workflowhub.eu/projects/16/workflows?view=default) on WorkflowHub.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| identifier | Identifier | string | Identifier for this dataset used in this workflow. |
| threads | Number of threads | int | Number of threads to use for computational processes. (default 2) |
| memory | Maximum memory in MB | int | Maximum memory usage in MegaBytes. (default 8000) |
| forward_reads | Forward reads | File[] | Forward sequence fastq file(s) locally |
| reverse_reads | Reverse reads | File[] | Reverse sequence fastq file(s) locally |
| do_not_output_filtered_reads | Don't output reads. | boolean | Do not output filtered reads. (default false) |
| skip_qc_unfiltered | Skip QC unfiltered | boolean | Skip FastQC analyses of raw input reads (default false) |
| skip_qc_filtered | Skip QC filtered | boolean | Skip FastQC analyses of filtered input reads (default false) |
| filter_rrna | filter rRNA | boolean | Optionally remove rRNA sequences from the reads (default false) |
| deduplicate | Deduplicate reads | boolean | Remove exact duplicate reads with fastp. (default false) |
| humandb | Filter human reads | Directory? | Bowtie2 index folder. Provide the folder in which the in index files are located. |
| reference_filter_db | Filter reference file(s) | Directory? | Custom reference database for filtering with Hostile.  Provide the folder in which the bowtie2 index files are located. (default false)  |
| keep_reference_mapped_reads | Keep mapped reads | boolean | Discard unmapped and keep reads mapped to the given reference. Default false (discard mapped) |
| destination | Output Destination | string? | Optional output destination only used for cwl-prov reporting. |
| source | Input URLs used for this run | string[]? | A provenance element to capture the original source of the input data |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| workflow_merge_pe_reads | Merge paired reads | Merge multiple forward and reverse fastq reads to single file objects |
| sequali_illumina_before | Sequali before | Quality assessment and report of reads before filtering |
| fastp | fastp | Read quality filtering and (barcode) trimming. |
| rrna_filter | rRNA filter (bbduk) | Filters rRNA sequences from reads using bbduk |
| human_filter | Human filter | Filter human reads from the dataset using Hostile |
| reference_filter | Custom reference filter | Filter reads using custom references with Hostile |
| phix_filter | PhiX filter (bbduk) | Filters illumina spike-in PhiX sequences from reads using bbduk |
| sequali_illumina_after | Sequali after | Quality assessment and report of reads after filtering |
| reports_files_to_folder | Reports to folder | Preparation of QC output files to a specific output folder |
| out_fwd_reads | Output fwd reads | Step needed to output filtered reads because there is an option to not to. |
| out_rev_reads | Output rev reads | Step needed to output filtered reads because there is an option to not to. |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| reports_folder | Filtering reports folder | Directory | Folder containing all reports of filtering and quality control |
| QC_forward_reads | Filtered forward read | File? | Filtered forward read |
| QC_reverse_reads | Filtered reverse read | File? | Filtered reverse read |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/336
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata