---
name: ymp
description: YMP is a flexible omics pipeline engine for processing large-scale NGS data. Use when user asks to initialize projects, run NGS pipelines, manage project environments, list available stages, provision reference databases, submit jobs to a cluster, or resume interrupted jobs.
homepage: https://ymp.readthedocs.io
---


# ymp

## Overview

YMP is a flexible omics pipeline engine designed to simplify the processing of large-scale NGS data. It abstracts complex bioinformatics tools into modular "stages" (such as QC, trimming, assembly, and mapping), handling the underlying Snakemake logic and Conda environment management automatically. Use this skill to guide the creation of reproducible pipelines, manage project environments, and execute multi-step genomic analyses with concise command-line statements.

## Common CLI Patterns

### Project Initialization
Before running pipelines, a project workspace must be established.
- **Initialize a new project**: `ymp init project [NAME]`
- **Load tutorial data**: `ymp init demo` (Copies tutorial data into the current directory)
- **Set up cluster execution**: `ymp init cluster`

### Executing Pipelines
YMP uses a dot-notation to stack stages. The syntax generally follows `ymp make [project].[stage1].[stage2]...`.
- **Run a basic QC**: `ymp make myproject.qc_fastqc`
- **Stack multiple stages**: `ymp make myproject.trim_bbmap.assemble_megahit`
- **Dry run**: Add `-n` to see what would be executed without running the tools: `ymp make -n myproject.assemble_megahit`
- **Parallel execution**: Use `-j` to specify CPU cores: `ymp make -j 8 myproject.map_bowtie2`

### Stage Discovery and Inspection
- **List all available stages**: `ymp stage list`
- **Show details for a specific stage**: `ymp stage list [STAGE_NAME]`
- **Show configuration properties**: `ymp show [PROPERTY]`

### Environment Management
YMP manages tool-specific Conda environments automatically, but they can be manipulated manually.
- **Activate a tool environment**: `ymp env activate [ENVNAME]`
- **Run a command within an environment**: `ymp env run [ENVNAME] -- [COMMAND]`
- **Clean up unused environments**: `ymp env clean`
- **Force install environments**: `ymp env install [ENVNAME]`

## Expert Tips and Best Practices

- **Stage Stacking**: Order matters. YMP creates directory structures based on the stack (e.g., `.../trim_bbmap/assemble_megahit/`). This allows you to compare different parameters or tools by simply changing the stack string.
- **Reference Management**: Use the `references` virtual stage to handle database provisioning. YMP will download and index required databases (like phiX or SSU) on the fly when a stage requires them.
- **Handling SRA Data**: If your project configuration points to SRA Run IDs (SRR/ERR/DRR), YMP uses `fastq-dump` or `prefetch` automatically. You can trigger this via `ymp make [project].fastq_dump`.
- **Cluster Submission**: For large-scale jobs, use `ymp submit` instead of `ymp make`. It supports DRMAA, Slurm, and LSF.
- **Resuming Jobs**: If a pipeline is interrupted, YMP (via Snakemake) will resume from the last successful checkpoint. Use `--rerun-incomplete` or `--ri` if a previous run left corrupted files.

## Reference documentation
- [YMP Command Line](./references/ymp_readthedocs_io_en_stable_commandline.html.md)
- [YMP Stages Reference](./references/ymp_readthedocs_io_en_stable_stages.html.md)
- [Installing and Updating YMP](./references/ymp_readthedocs_io_en_stable_install.html.md)