---
name: paleomix
description: PALEOMIX is a bioinformatics toolkit designed to process raw sequencing reads into analysis-ready files with a focus on ancient DNA characteristics. Use when user asks to process reads into BAM files, perform phylogenetic inference, or identify equine hybrids using the Zonkey pipeline.
homepage: https://github.com/MikkelSchubert/paleomix
---


# paleomix

## Overview

PALEOMIX is a specialized bioinformatics toolkit designed to streamline the processing of raw sequencing reads into analysis-ready files. It is particularly renowned for its robust handling of ancient DNA (aDNA) characteristics, such as post-mortem damage and short fragment lengths. The suite is organized into three primary pipelines: the BAM pipeline for alignment and quality control, the Phylogenetic pipeline for genotyping and evolutionary analysis, and the Zonkey pipeline for equine-specific hybrid identification. It integrates standard tools like BWA, Samtools, and AdapterRemoval into a cohesive, automated workflow.

## Core CLI Patterns

The PALEOMIX suite uses a consistent command structure: `paleomix <pipeline> <command> [options]`.

### 1. The BAM Pipeline
Used for processing de-multiplexed reads into validated BAM alignment files.

*   **Generate a template configuration:**
    `paleomix bam make_config > project_name.yaml`
    *(Note: While the file extension is .yaml, focus on the CLI command to generate and execute it.)*
*   **Run the pipeline:**
    `paleomix bam run project_name.yaml`
*   **Dry run (validate setup without executing):**
    `paleomix bam dryrun project_name.yaml`

### 2. The Phylogenetic Pipeline
Used for genotyping and phylogenetic inference on existing BAM files.

*   **Generate a template configuration:**
    `paleomix phylo make_config > phylo_project.yaml`
*   **Run the pipeline:**
    `paleomix phylo run phylo_project.yaml`

### 3. The Zonkey Pipeline
Specialized for detecting F1-hybrids in equine archaeological assemblages.

*   **Run the analysis:**
    `paleomix zonkey run <makefile>`

## Expert Tips and Best Practices

*   **Algorithm Selection:** For modern or high-quality data, PALEOMIX now supports and defaults to `bwa-mem2` for significantly faster alignment if the tool is detected in the environment.
*   **aDNA Specifics:** When working with ancient samples, ensure the pipeline is configured to utilize `mapDamage` (integrated) to track and quantify DNA damage patterns, which is critical for authenticity verification.
*   **Resource Management:** Use the `--max-threads` flag during a `run` command to limit CPU usage, especially on shared clusters.
*   **Validation:** Always use the `dryrun` command before starting a large-scale analysis. This checks for missing input files, software dependencies, and syntax errors in the configuration.
*   **Adapter Trimming:** PALEOMIX integrates `AdapterRemoval`. If your data has specific adapter sequences or requires merging of paired-end reads, ensure these parameters are adjusted in the generated configuration file before running.
*   **Temporary Files:** You can override the default temporary directory by setting the `TMPDIR` environment variable or using specific pipeline flags if the default `/tmp` lacks sufficient space for large HTS datasets.

## Troubleshooting Common Issues

*   **Hanging Processes:** If the pipeline hangs during the "backtrack" setting (BWA aln), verify that the input FASTQ files are not corrupted and that memory limits are not being exceeded.
*   **Empty Outputs:** If the `reads` folder is empty after a BAM pipeline run, check the logs for `AdapterRemoval` errors; often, this indicates that no reads passed the length or quality filters.
*   **Node Errors:** PALEOMIX uses a graph-based dependency tracker. If a "NodeError" occurs, it usually points to a specific file that could not be created or a command that returned a non-zero exit code. Check the specific log file for that node in the `temp` directory.

## Reference documentation
- [The PALEOMIX pipelines](./references/github_com_MikkelSchubert_paleomix.md)
- [Commit History and CLI Updates](./references/github_com_MikkelSchubert_paleomix_commits_main.md)