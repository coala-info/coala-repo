---
name: kallisto-rnaseq-workflow
description: This Common Workflow Language pipeline performs quality filtering of Illumina RNA-seq reads followed by transcript quantification using the kallisto pseudoalignment tool. Use this skill when you need to quantify gene expression levels, estimate transcript abundance, or characterize the transcriptomic profile of biological samples.
homepage: https://m-unlock.com
metadata:
  docker_image: "N/A"
---

# kallisto-rnaseq-workflow

## Overview

This CWL workflow performs RNA-seq quantification via pseudoalignment on transcriptomic data. It integrates the [Illumina Quality workflow](https://workflowhub.eu/workflows/336?version=1) for initial read filtering and quality control before processing samples with the kallisto engine to estimate transcript abundance.

The pipeline is organized into three primary stages:
*   **Quality and Filtering:** Pre-processing of raw Illumina reads to ensure data integrity.
*   **Kallisto Pseudoalignment:** Mapping reads to a reference transcriptome to quantify expression levels.
*   **Output Generation:** Collection and formatting of kallisto results for downstream analysis.

The underlying CWL tool definitions and sub-workflows are maintained in the [UNLOCK repository](https://git.wur.nl/unlock/cwl/-/tree/master/cwl/workflows). For detailed instructions on environment configuration and execution, refer to the [UNLOCK setup documentation](https://m-unlock.gitlab.io/docs/setup/setup.html).

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| identifier | Identifier | string | Identifier for this dataset used in this workflow |
| threads | Threads | int? | Number of threads to use for computational processes |
| memory | Maximum memory in MB | int? | Maximum memory usage in megabytes |
| filter_rrna | Filter rRNA | boolean | Optionally remove rRNA sequences from the reads. |
| forward_reads | Forward reads | string[] | Forward sequence file locally |
| reverse_reads | Reverse reads | string[] | Reverse sequence file locally |
| kallisto_index | kallisto index file | string | kallisto index file location |
| contamination_references | Reference filters files | string[]? | Reference fasta file(s) for filtering (optional) |
| destination | Output Destination | string? | Optional Output destination used for cwl-prov reporting. |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| workflow_quality | Quality and filtering workflow | Quality assessment of illumina reads with rRNA filtering option |
| kallisto | kallisto | Calculates transcript abundances |
| kallisto_files_to_folder | kallisto output | Preparation of kallisto output files to a specific output folder |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| illumina_quality_stats | Filtered statistics | Directory | Statistics on quality and preprocessing of the reads |
| kallisto_output | kallisto output | Directory | kallisto results folder. Contains transcript abundances, run info and summary. |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/344
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata