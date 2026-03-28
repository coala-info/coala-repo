---
name: ymp
description: ymp is a flexible omics pipeline manager that streamlines the processing of Next-Generation Sequencing data by managing software dependencies and workflow stages. Use when user asks to initialize a bioinformatics workspace, run quality control, assemble metagenomes, or manage complex NGS processing chains.
homepage: https://ymp.readthedocs.io
---

# ymp

## Overview

ymp is a flexible omics pipeline manager designed to streamline the processing of Next-Generation Sequencing (NGS) data. Built on top of Snakemake and Bioconda, it provides a "batteries included" approach to bioinformatics, offering pre-configured stages for quality control, filtering, metagenome assembly, and transcript quantification. It excels at managing multiple workflow variants in parallel, automatically handling software dependencies via Conda and managing reference database downloads.

## Command Line Usage and Best Practices

### Getting Started
ymp is designed to be pointed at a data source to auto-configure. Common input sources include:
- A local directory containing raw read files (FastQ).
- A tab-separated mapping file.
- A list of URLs.
- An SRA RunTable.

### Core Workflow Patterns
The primary way to interact with ymp is by specifying a "stack" of stages to be applied to your data.

1.  **Initialize and Configure**:
    Point ymp at your data to generate the initial configuration.
    ```bash
    ymp init <data-source>
    ```

2.  **Stage Chaining**:
    ymp uses a unique directory-based naming convention to track workflows. You request a target file or directory that represents the end of a chain of stages.
    *   **Pattern**: `.../stage1/stage2/stage3/file`
    *   **Example**: To run FastP quality control followed by Megahit assembly on a sample named `SampleA`:
        ```bash
        ymp make SampleA/fastp/megahit/contigs.fasta
        ```

3.  **Exploring Available Stages**:
    To see which processing steps are available in your current installation:
    ```bash
    ymp stages
    ```

### Expert Tips
-   **Tab Completion**: ymp heavily utilizes shell tab expansion. Use it to discover valid next steps in a processing chain.
-   **Parallel Workflows**: You can compare different tools (e.g., different assemblers) by simply requesting different terminal stages. ymp will reuse the output of common upstream stages (like QC) to save time and storage.
-   **Dry Runs**: Before committing to a large compute job, use the dry-run flag to see what ymp intends to execute:
    ```bash
    ymp make -n <target>
    ```
-   **Cluster Execution**: Since ymp is built on Snakemake, it can easily offload jobs to a cluster (SLURM, SGE, etc.) by passing the appropriate profile or cluster arguments through the ymp interface.

### Resource Management
ymp automatically manages software environments. If a stage requires a specific tool, ymp will use Conda to install it into a dedicated environment. Ensure you have a working Conda/Mamba installation and sufficient disk space for these environments and reference databases.



## Subcommands

| Command | Description |
|---------|-------------|
| ymp env | Manipulate conda software environments |
| ymp init | Initialize YMP workspace |
| ymp make | Build target(s) locally |
| ymp scan | Scan folders for YMP files |
| ymp stage | Manipulate YMP stages |
| ymp submit | Build target(s) on cluster |
| ymp_show | Show configuration properties |

## Reference documentation
- [YMP - a Flexible Omics Pipeline](./references/github_com_epruesse_ymp_README.rst.md)
- [Command Line Interface](./references/ymp_readthedocs_io_en_stable_commandline.html.md)
- [Processing Stages](./references/ymp_readthedocs_io_en_stable_stages.html.md)