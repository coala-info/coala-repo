---
name: humanfilt
description: `humanfilt` is a specialized bioinformatics utility designed to streamline the removal of human "contaminant" reads from sequencing data.
homepage: https://github.com/jprehn-lab/humanfilt
---

# humanfilt

## Overview

`humanfilt` is a specialized bioinformatics utility designed to streamline the removal of human "contaminant" reads from sequencing data. It automates the complex process of downloading and indexing multiple human reference genomes and running a sequential pipeline of tools—including Kraken2, Trim Galore, FastUniq, BBDuk, BWA, Bowtie2, and Minimap2—to ensure maximum decontamination. This tool is essential for researchers working on metagenomics, pathogen sequencing, or non-human model organisms where human DNA interference must be minimized.

## Installation and Initial Setup

Before running the pipeline, the environment must be configured and reference databases must be cached.

1.  **Install via Conda**:
    ```bash
    conda create -n hf -y -c conda-forge -c bioconda humanfilt=1.0.0
    conda activate hf
    ```

2.  **Initialize Databases**:
    Run the setup command once to download and index GRCh38, T2T, HPRC, UniVec, and Kraken2 human databases.
    ```bash
    humanfilt setup
    ```
    *Note: By default, data is stored in `~/.local/share/humanfilt`. Use `--data-dir <path>` to change this location.*

## Core Usage Patterns

### Standard WGS Decontamination
For paired-end WGS data, use the following pattern:
```bash
humanfilt run \
  --mode wgs \
  --input /path/to/paired_fastqs \
  --output /path/to/output_dir \
  --report /path/to/summary_report.csv \
  --threads 16
```

### Customizing Quality Control
If the default trimming parameters (Phred 20, length 20) are too lenient or strict for your specific library prep:
```bash
humanfilt run --mode wgs \
  --input <input> --output <output> \
  --trim-quality 25 \
  --trim-length 35
```

## Expert Tips and Best Practices

*   **HPC and Cluster Environments**: When running on compute nodes without internet access, ensure `humanfilt setup` is run on a login node first. Use the `--no-auto-setup` flag in your batch scripts to prevent the tool from attempting to check for updates or downloads during the run.
*   **Thread Management**: The tool auto-detects CPU counts. However, in shared environments or SLURM jobs, explicitly set `--threads` to match your allocated resources to avoid over-subscription.
*   **Disk Space**: The pipeline generates several intermediate files. If you are low on space, do NOT use `--keep-temp`. If you need to debug a failed run, `--keep-temp` will preserve per-sample logs and intermediate BAMs.
*   **Custom Kraken2 Databases**: If you have a pre-existing Kraken2 human database, you can bypass the default one using `--kraken2-db /path/to/db`.
*   **Environment Variables**: You can set `HUMANFILT_ZENODO_RECORD` to point to specific versions of the reference data if your study requires strict version pinning for reproducibility.

## Reference documentation
- [humanfilt Overview](./references/anaconda_org_channels_bioconda_packages_humanfilt_overview.md)
- [humanfilt GitHub Repository](./references/github_com_jprehn-lab_humanfilt.md)