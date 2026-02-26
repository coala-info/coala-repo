---
name: cadd-scripts
description: "cadd-scripts integrates diverse genomic annotations into a single C-score to predict the effect of genetic variants. Use when user asks to install the CADD scoring environment, manage large-scale genomic annotation data, or execute the Snakemake-based pipeline to score novel or known variants."
homepage: https://github.com/kircherlab/CADD-scripts
---


# cadd-scripts

## Overview

CADD (Combined Annotation Dependent Depletion) is a framework for integrating diverse genomic annotations into a single measure (C-score) for variant effect prediction. This skill facilitates the offline deployment and execution of CADD scripts, which is essential for large-scale genomic analysis where web-based scoring is impractical. It covers the installation of the scoring environment, management of large-scale genomic annotation data, and the execution of the Snakemake-based pipeline to generate scores for novel or known variants.

## Installation and Setup

### Environment Initialization
The easiest way to manage dependencies is via Conda or Mamba.
- **Conda Install**: `conda install bioconda::cadd-scripts`
- **Manual Setup**: If downloading the repository directly, use the provided installation script:
  - US-based: `cadd-install.sh`
  - Europe-based: `cadd-install.sh -b` (uses German mirrors for faster downloads)

### Data Requirements
CADD requires significant disk space (100 GB to 1 TB) and at least 12 GB of RAM.
- **Annotations**: Download the specific build needed (GRCh37/hg19 or GRCh38/hg38) into `data/annotations/`.
- **Prescored Files**: Optional but recommended to speed up scoring for known variants. Place these in `data/prescored/`.
- **Verification**: Always verify large downloads using MD5 hashes provided on the CADD website to prevent pipeline failures due to corrupted files.

## CLI Usage Patterns

### Primary Execution
The main entry point for scoring is the `cadd.sh` script (or `CADD.sh` in older versions).

### Snakemake Integration
CADD uses Snakemake to manage the complex annotation and scoring workflow.
- **Basic Scoring Command**:
  ```bash
  snakemake <output_path/filename.tsv.gz> --use-conda --cores <number_of_cores>
  ```
- **Environment Isolation**: Use `--conda-prefix envs/conda` to keep environments within the CADD directory rather than the global conda path.
- **Containerization**: For maximum stability, run with Apptainer/Singularity:
  ```bash
  snakemake --use-singularity ...
  ```

### Handling Input Files
- Input files should be in VCF or compressed TSV format.
- Ensure the input file matches the genome build specified in your configuration.

## Expert Tips and Best Practices

- **Resume Interrupted Downloads**: When fetching the ~300GB annotation files, use `wget -c` to allow resuming if the connection drops.
- **Parallelization**: While Snakemake handles task parallelism, ensure your system has sufficient RAM (12GB+ per process) when increasing core counts, as some annotation steps are memory-intensive.
- **Software Deployment**: Always use `--software-deployment-method conda` (or `--use-conda`) to ensure the correct Python 2 and Python 3 environments are used for specific legacy annotation tools within the pipeline.
- **Storage Performance**: Given the massive size of the annotation database, running CADD from an SSD significantly reduces I/O wait times during the feature extraction phase.

## Reference documentation
- [CADD-scripts Overview](./references/anaconda_org_channels_bioconda_packages_cadd-scripts_overview.md)
- [CADD-scripts GitHub Repository](./references/github_com_kircherlab_CADD-scripts.md)