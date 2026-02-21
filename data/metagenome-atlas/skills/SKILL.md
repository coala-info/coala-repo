---
name: metagenome-atlas
description: Metagenome-Atlas is a comprehensive, Snakemake-powered pipeline that automates the transition from raw metagenomic sequencing reads to biological insights.
homepage: https://github.com/metagenome-atlas
---

# metagenome-atlas

## Overview
Metagenome-Atlas is a comprehensive, Snakemake-powered pipeline that automates the transition from raw metagenomic sequencing reads to biological insights. It integrates best-in-class tools for quality control, assembly (using SPAdes or MegaHit), genomic binning, and taxonomic/functional annotation. It is particularly useful for researchers who require a reproducible, "one-stop" workflow for recovering Metagenome-Assembled Genomes (MAGs) without manually chaining individual bioinformatics tools.

## Core Workflow
The standard Atlas workflow follows a three-step process: installation, initialization, and execution.

### 1. Installation
Use Mamba for faster dependency resolution and environment management.
`mamba install -c bioconda -c conda-forge metagenome-atlas`

### 2. Project Initialization
Initialize the working directory by pointing to your raw FASTQ files.
`atlas init --db-dir /path/to/databases /path/to/fastq/files`
- This command creates a `samples.tsv` and a `config.yaml` in the current directory.
- The `--db-dir` flag specifies where large reference databases (like GTDB) will be stored.

### 3. Execution
Run the full pipeline or specific modules.
`atlas run all`
- Common targets: `qc`, `assembly`, `binning`, `genecatalog`, `all`.
- To see what will be run without executing: `atlas run all --dryrun`.

## Best Practices and CLI Patterns

### Sample Management
After running `atlas init`, always inspect the generated `samples.tsv`. Ensure that:
- Sample names are correctly parsed from the filenames.
- Paths to R1 and R2 reads are accurate.
- You can manually add or remove rows to include or exclude specific samples from the run.

### Configuration Tuning
Modify the `config.yaml` file created during initialization to tune the pipeline for your specific hardware and biological questions. Key parameters to review include:
- **Assembler choice**: Use `megahit` for large datasets or limited memory; use `spades` for higher-quality assemblies if resources allow.
- **Filtering**: Adjust the minimum contig length for binning to improve MAG quality.
- **Annotation**: Enable or disable specific functional annotation databases.

### Resource Allocation
Metagenomic assembly is resource-intensive. Use the following flags to manage hardware usage:
- `--jobs N`: Run up to N tasks in parallel.
- `--mem N`: Limit total memory usage.
- For cluster environments (SLURM, SGE), use the `--cluster` flag to submit jobs to a scheduler.

### Database Handling
Atlas downloads required databases on the fly. To avoid redundant downloads across different projects, always point to a shared database directory using the `--db-dir` flag during both `init` and `run` steps.

## Reference documentation
- [Metagenome-Atlas Overview](./references/anaconda_org_channels_bioconda_packages_metagenome-atlas_overview.md)
- [Atlas GitHub Repository](./references/github_com_metagenome-atlas_atlas.md)
- [Metagenome-Atlas Tutorial](./references/github_com_metagenome-atlas_Tutorial.md)