---
name: trnanalysis
description: The trnanalysis tool maps and analyzes tRNA reads from small RNA sequencing data. Use when user asks to map tRNA reads, analyze tRNA reads, perform differential expression analysis, or generate reports.
homepage: https://trnanalysis.readthedocs.io/en/latest/
---


# trnanalysis

## Overview

The `trnanalysis` tool is a specialized bioinformatics pipeline designed to accurately map and qualitatively analyze tRNA reads from small RNA sequencing data. It specifically addresses the challenges of profiling nuclear and mitochondrial tRNA fragments. Built on the CGAT-core workflow engine, it automates the path from raw FASTQ files to differential expression results and interactive HTML reports.

## Core CLI Patterns

### Initialization and Setup
Before running a pipeline, you must generate a configuration file and prepare your environment.

- **Generate default config**: `trnanalysis config` (creates `pipeline.ini`)
- **Clone an existing pipeline**: `trnanalysis clone <srcdir>`
- **Local execution**: Use the `--no-cluster` flag to run on a local machine instead of a cluster (SGE/SLURM/PBS).

### Running the Pipeline
The pipeline uses a `make`-style syntax to execute specific tasks.

- **Execute full pipeline**: `trnanalysis make full -v5 --no-cluster`
- **Dry run**: `trnanalysis --dry-run make full` (checks steps without executing)
- **Check tasks**: `trnanalysis show <task>` (lists dependencies for a specific task)
- **Validation**: `trnanalysis --input-validation make full` (checks `pipeline.ini` for missing values)

### Reporting
Reports are generated after the main pipeline tasks are complete.

- **Build HTML report**: `trnanalysis make build_report`
- **Accessing output**: Open `FinalReport.html` in the execution directory.

## Input Requirements and Best Practices

### File Naming Convention
The tool expects a specific naming format for FASTQ files to ensure regular expressions parse samples correctly:
- Format: `sample-condition-R1.fastq.1.gz`
- Note: The read number (1 or 2) is inserted between `.fastq` and `.gz`.

### Required Assets
1. **FASTQ**: Single-end reads are preferred. If using paired-end data, flash reads together or use only R1.
2. **Genome Index**: A Bowtie indexed genome.
3. **GTF**: Use sanitized Ensembl GTF files where chromosomes are named `chr1`, `chr2`, etc.
4. **Design File**: For differential expression, create a CSV following the pattern: `design_<test>_<control>_<test>_<column>.csv`.

### Performance Tip
Running `tRNAscan-SE` is the most time-consuming step. To speed up execution, provide a pre-calculated `tScan-SE` output file and specify its path in the `pipeline.ini` configuration.

## Troubleshooting

- **DRMAA Errors**: If you see `NameError: name 'drmaa' is not defined`, the tool is trying to find a cluster. Use `--no-cluster` to run locally.
- **Empty Files**: If a task fails, it may leave behind an empty file. Delete the empty output file before restarting the pipeline, or the engine may incorrectly skip the task as "completed."
- **Cluster Config**: To override default SGE settings for SLURM or PBSPro, create a `.cgat.yml` file in your home directory.

## Reference documentation
- [Running a pipeline](./references/trnanalysis_readthedocs_io_en_latest_getting_started_Tutorial.html.md)
- [The tRNAnalysis report](./references/trnanalysis_readthedocs_io_en_latest_getting_started_Output.html.md)
- [Cluster configuration](./references/trnanalysis_readthedocs_io_en_latest_getting_started_Cluster_config.html.md)
- [Installation](./references/trnanalysis_readthedocs_io_en_latest_getting_started_Installation.html.md)