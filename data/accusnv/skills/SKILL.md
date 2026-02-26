---
name: accusnv
description: AccuSNV identifies and classifies high-precision single nucleotide variants in bacterial genomes using a combination of sequence alignment and deep learning. Use when user asks to align reads to a reference, identify candidate SNVs, or perform downstream evolutionary analysis on bacterial isolates.
homepage: https://github.com/liaoherui/AccuSNV
---


# accusnv

## Overview

AccuSNV is a specialized tool for bacterial genomics that combines traditional sequence alignment with deep learning classification to distinguish true SNVs from false positives (often caused by low coverage or sequencing artifacts). It is particularly effective for researchers working with bacterial isolates who require high-precision mutation tables for downstream evolutionary analysis, such as constructing parsimony trees or calculating nonsynonymous/synonymous mutation ratios.

## Installation and Environment Setup

The recommended way to use AccuSNV is via Bioconda. Note that the command names differ slightly when installed through Conda compared to a manual Git clone.

```bash
# Installation via Bioconda
mamba create -n accusnv -c conda-forge -c bioconda accusnv
conda activate accusnv
```

## Core CLI Usage

The workflow is divided into two main phases: the Snakemake-based alignment/candidate identification and the downstream analysis.

### 1. Snakemake Pipeline (Alignment & Candidate Discovery)
This phase aligns raw reads to a reference and identifies potential SNV sites.

**Bioconda Command:**
```bash
accusnv_snakemake -i <input_sample_info.csv> -r <reference_directory> -o <output_directory>
```

*   **Input CSV**: Should contain sample metadata and paths to sequencing files.
*   **Reference Directory**: Contains the annotated reference genome.
*   **Output Directory**: Where results and configuration files will be stored.

**Workflow Execution:**
After generating the configuration, navigate to your output directory to run the pipeline:
1.  **Dry Run**: `sh scripts/dry-run.sh` (Verify the steps without executing).
2.  **Execution**: `sbatch scripts/run_snakemake.slurm` (Submit to a SLURM cluster).

### 2. Downstream Analysis
Once candidates are identified, use the downstream module to classify variants and perform evolutionary analysis.

**Bioconda Command:**
```bash
accusnv_downstream -h
```

## Expert Tips and Best Practices

*   **Working Directory Safety**: Ensure your working directory is clean. Avoid having existing files named `config.yaml`, `experiment_info.yaml`, or `Snakefile` unless they are intended for the current run, as `accusnv_snakemake` may overwrite or conflict with them.
*   **Bioconda Command Mapping**: If you are following older documentation or scripts, remember the mapping:
    *   `python new_snv_script.py` -> `accusnv`
    *   `python accusnv_snakemake.py` -> `accusnv_snakemake`
    *   `python accusnv_downstream.py` -> `accusnv_downstream`
*   **Handling Interruptions**: If a SLURM job fails or times out, use `sh scripts/dry-run.sh` to check the status. You can safely re-submit using `sbatch scripts/run_snakemake.slurm`; Snakemake will resume from the last successful checkpoint.
*   **Permissions**: If running on a Linux/HPC environment, ensure the status script has execution permissions: `chmod 777 slurm_status_script.py`.
*   **Configuration Tweaks**: To adjust cluster resources (memory, CPU, job limits), edit the generated file at `<output_dir>/conf/config.yaml`.

## Reference documentation
- [AccuSNV GitHub Repository](./references/github_com_liao_herui_AccuSNV.md)
- [AccuSNV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_accusnv_overview.md)