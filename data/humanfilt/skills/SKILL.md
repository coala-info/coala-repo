---
name: humanfilt
description: humanfilt removes human DNA and RNA contaminants from sequencing datasets through a multi-step taxonomic and alignment pipeline. Use when user asks to remove human reads from metagenomic data, decontaminate pathogen sequences, or filter human DNA from non-human model organism datasets.
homepage: https://github.com/jprehn-lab/humanfilt
---


# humanfilt

## Overview

The `humanfilt` tool is a specialized bioinformatics utility designed to remove human DNA/RNA contaminants from sequencing datasets. It is particularly useful for researchers working on metagenomics, pathogen sequencing, or non-human model organisms where human read carryover can bias results. The tool automates a complex seven-step pipeline—including taxonomic classification, quality trimming, de-duplication, and multiple rounds of alignment against various human reference genomes—to ensure maximum decontamination efficiency.

## Installation and Setup

Before running the pipeline, the environment must be configured and reference databases must be cached locally.

1.  **Environment Creation**: Use Conda to install the tool and its dependencies.
    ```bash
    conda create -n hf -y -c conda-forge -c bioconda humanfilt=1.0.0
    conda activate hf
    ```

2.  **Database Initialization**: Run the setup command once to download and index approximately 5 human references and the Kraken2 database.
    ```bash
    humanfilt setup
    ```
    *Note: By default, data is stored in `~/.local/share/humanfilt`. Use `--data-dir <PATH>` to change this location.*

## Core Usage Patterns

### Standard WGS Decontamination
For paired-end WGS data, use the `run` command with the `wgs` mode.
```bash
humanfilt run \
  --mode wgs \
  --input /path/to/fastqs \
  --output /path/to/clean_output \
  --report /path/to/decon_report.csv \
  --threads 16
```

### Customizing Quality Control
You can adjust the stringency of the initial trimming step (Trim Galore) to suit specific library qualities.
```bash
humanfilt run --mode wgs \
  --input ./raw_data \
  --output ./filtered_data \
  --trim-quality 25 \
  --trim-length 30
```

### High-Performance Execution
The tool auto-detects CPU counts, but for shared HPC environments, explicitly define thread usage and skip the auto-setup check to save time.
```bash
humanfilt run --mode wgs \
  --input ./input \
  --output ./output \
  --threads 24 \
  --no-auto-setup
```

## Pipeline Steps Reference
When interpreting reports or troubleshooting, remember the internal execution order:
1.  **Kraken2**: Initial taxonomic filtering (keeps unclassified).
2.  **Trim Galore**: Quality and adapter trimming.
3.  **FastUniq**: De-duplication of reads.
4.  **BBDuk**: UniVec contaminant screening.
5.  **BWA**: Alignment against GRCh38 (keeps unmapped).
6.  **Bowtie2**: Alignment against T2T-CHM13 (keeps unmapped).
7.  **Minimap2**: Alignment against HPRC (keeps unmapped) to produce final FASTQs.

## Expert Tips
*   **Disk Space**: Ensure the partition containing the cache directory has sufficient space (several dozen GBs) for the indexed human pangenomes and Kraken2 databases.
*   **Debugging**: If a run fails, use the `--keep-temp` flag to inspect per-sample logs and intermediate files within the temporary directories.
*   **Reports**: Always specify a `--report` path. This CSV is the primary way to track how many reads were lost at each specific decontamination step (e.g., how many reads were specifically caught by the T2T vs. GRCh38 alignment).



## Subcommands

| Command | Description |
|---------|-------------|
| humanfilt run | Run humanfilt |
| humanfilt setup | Setup humanfilt references. |

## Reference documentation
- [Humanfilt GitHub README](./references/github_com_jprehn-lab_humanfilt_blob_main_README.md)
- [Project Metadata](./references/github_com_jprehn-lab_humanfilt_blob_main_pyproject.toml.md)