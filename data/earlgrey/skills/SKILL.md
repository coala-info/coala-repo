---
name: earlgrey
description: Earl Grey is a fully automated pipeline for the comprehensive annotation and discovery of transposable elements in genome assemblies. Use when user asks to annotate transposable elements, build consensus libraries, or perform repeat masking on a genome.
homepage: https://github.com/TobyBaril/EarlGrey
---

# earlgrey

## Overview

Earl Grey is a fully automated pipeline designed for the comprehensive annotation of transposable elements (TEs) in genome assemblies. It integrates widely-used TE discovery tools with a specialized consensus elongation process to better define de novo consensus sequences. This skill should be used to guide the execution of TE annotation workflows, manage resource-intensive genomic computations, and troubleshoot common issues related to repeat masking and library construction.

## Core Workflows

### 1. Full TE Annotation Pipeline
The primary `earlGrey` script performs the full suite of discovery, elongation, and annotation.

*   **Standard Run**: Provide the input genome, a name for the run, and the number of CPU threads.
*   **Library Integration**: Use the `-l` flag to provide an existing TE library to supplement de novo discovery.
*   **Search Term**: Use `-r` to specify a search term (e.g., "Arthropoda") for Dfam/RepBase filtering.

### 2. Annotation Only
Use `earlGreyAnnotationOnly` when a curated TE library is already available and you only need to mask and annotate the genome without performing new discovery.

### 3. Library Construction
Use `earlGreyLibConstruct` to focus specifically on building and elongating the TE consensus library for a given assembly.

## Expert Tips and Best Practices

### Resource Management
TE annotation is extremely RAM-intensive. Follow these hardware guidelines to avoid Out-of-Memory (OOM) errors:
*   **RAM Ratio**: Allocate at least **3GB of RAM per thread**. For example, a 16-thread run requires a minimum of 48GB of RAM.
*   **Thread Throttling**: If you encounter `OpenBLAS` or `pthread_create` errors ("Resource temporarily unavailable"), reduce the number of threads.
*   **Runtime Expectations**: Small genomes (40Mb) take ~1 day; large genomes (3Gb+) typically take a week or more.

### Configuration and Setup
*   **Dfam Partitions**: After installation, you must configure Dfam partitions. Earl Grey provides a script for this during the first run. Results are highly dependent on choosing the correct partitions for your target taxa.
*   **Checkpointing**: The pipeline uses checkpoints for each step. If a run is interrupted by server limits or crashes, resubmit the exact same command to resume from the last completed step.

### Troubleshooting
*   **OOM Kills**: Check logs specifically for `TEstrainer` and the `divergence calculator`, as these are the most memory-hungry components.
*   **Empty Directories**: Ensure the output directory is writable. Version 7.2.1+ automatically handles directory creation for curated libraries, but manual verification is recommended if using older versions.

## Common CLI Patterns

**Full Pipeline Execution:**
```bash
earlGrey -g genome.fasta -s species_name -o output_dir -t 16 -r "Taxa_Name"
```

**Annotation with Existing Library:**
```bash
earlGreyAnnotationOnly -g genome.fasta -l curated_te_library.fasta -s species_name -o output_dir -t 8
```

**Resuming a Failed Run:**
Simply repeat the original command. Earl Grey will detect existing files in the output directory and skip finished modules.



## Subcommands

| Command | Description |
|---------|-------------|
| earlGreyAnnotationOnly | earlGrey version 7.0.2 (AnnotationOnly) |
| earlgrey_earlGrey | A script for modification and automation of RepeatMasker configuration with Dfam 3.9. |
| earlgrey_earlGreyLibConstruct | A script for modification and automation of Dfam configuration steps for RepeatMasker. |

## Reference documentation
- [Main README and Usage Guide](./references/github_com_TobyBaril_EarlGrey_blob_main_README.md)
- [Main Pipeline Script Details](./references/github_com_TobyBaril_EarlGrey_blob_main_earlGrey.md)
- [Annotation-Only Workflow](./references/github_com_TobyBaril_EarlGrey_blob_main_earlGreyAnnotationOnly.md)
- [Library Construction Module](./references/github_com_TobyBaril_EarlGrey_blob_main_earlGreyLibConstruct.md)