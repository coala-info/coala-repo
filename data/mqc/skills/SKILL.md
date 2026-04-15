---
name: mqc
description: The mqc tool assesses the quality of ribosome profiling experiments by analyzing triplet periodicity and P-site offsets in aligned reads. Use when user asks to evaluate Ribo-seq data quality, determine P-site offsets, or generate diagnostic reports for ribosome protected fragments.
homepage: https://github.com/Biobix/mQC
metadata:
  docker_image: "quay.io/biocontainers/mqc:1.10--py27pl5.22.0r3.4.1_0"
---

# mqc

## Overview

The `mqc` (Mapping Quality Control) tool is a specialized utility for assessing the quality of ribosome profiling experiments. It focuses on the unique characteristics of Ribo-seq data, such as triplet periodicity and P-site offsets. Use this skill to process aligned reads (SAM/BAM) to determine if the experiment successfully captured Ribosome Protected Fragments (RPFs) and to visualize the distribution of these fragments across genomic features. The tool generates a comprehensive HTML report and a compressed ZIP file containing all diagnostic plots.

## Installation and Environment

`mqc` is available via Bioconda but requires a specific environment setup due to its dependency on Python 2.7.

1.  **Create a Python 2.7 environment**:
    ```bash
    conda create -n mqc_env python=2.7
    conda activate mqc_env
    ```
2.  **Configure channels and install**:
    ```bash
    conda config --add channels r
    conda config --add channels defaults
    conda config --add channels conda-forge
    conda config --add channels bioconda
    conda install mqc
    ```

## Core CLI Usage

The main execution script is `mQC.pl`.

### Basic Command Pattern
```bash
mQC.pl --experiment_name <name> --samfile <input.sam> --species <species> --ens_db get --ens_v <version>
```

### Mandatory Parameters
- `--experiment_name`: A custom string used for naming output files.
- `--samfile`: Path to the input SAM or BAM file.
- `--species`: The organism studied. Supported values include: `human`, `mouse`, `fruitfly`, `zebrafish`, `yeast`, `c.elegans`, and `Salmonella`.
- `--ens_db`: Path to the Ensembl SQLite database. Set to `get` to have the tool download the appropriate database automatically.

### P-Site Offset Methods
The `--offset` parameter determines how the P-site is calculated:
- `plastid` (Default): Uses the Plastid algorithm to calculate offsets. Requires `--plastid_bam`. If set to `convert`, the tool will generate the BAM from your SAM file.
- `standard`: Uses standard offsets based on Ingolia et al. (2012).
- `cst_3prime`: Uses a constant 3' offset, often beneficial for prokaryotic species. Requires `--cst_3prime_offset` (default 15).
- `from_file`: Loads offsets from a tab-separated file (`RPFlength\toffset`). Requires `--offset_file`.

## Expert Tips and Best Practices

- **RPF Length Filtering**: Use `--min_length_gd` and `--max_length_gd` (default 26-34) to restrict gene distribution analysis to the expected size of ribosome-protected fragments. Check your FastQC results first to determine the actual peak length of your library.
- **Multimapping**: By default, `mqc` uses only unique alignments (`--unique Y`). If you need to include multimappers, set `--unique N` and adjust `--maxmultimap` (default 16).
- **Performance**: Increase the number of CPU cores using `--cores` (default 5) to speed up the periodicity analysis, which is the most computationally intensive step.
- **Database Management**: If you have already downloaded the Ensembl SQLite database for a specific version, provide the local path to `--ens_db` to avoid redundant downloads in every run.
- **Visualization**: If the default 2D bar charts are insufficient, change `--plotrpftool` to `pyplot3D` for a three-dimensional representation of the RPF-phase distribution, though note this requires a functional Matplotlib 3D backend.

## Reference documentation
- [mQC GitHub Repository](./references/github_com_Biobix_mQC.md)
- [mqc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mqc_overview.md)