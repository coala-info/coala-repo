---
name: harpy
description: Align sequences to a reference genome. Provide an additional subcommand bwa or strobe to get more information on using those aligners. Both have comparable performance, but strobe is typically faster. The aligners are not linked-read aware, but the workflows ensure linked-read information is carried over to the alignment records.
homepage: https://github.com/pdimens/harpy/
---

# harpy

## Overview
Harpy is a streamlined bioinformatics pipeline that automates the transition from raw sequencing reads to phased haplotypes. While it leverages Snakemake for workflow management under the hood, users interact with it through a simplified command-line interface. It is ideal for researchers working with linked-read technologies who need a reproducible, parallelized path for data processing without manual workflow orchestration.

## Installation
The preferred method for installation is via Conda or Pixi to manage the complex bioinformatics dependencies:

```bash
# Conda installation
conda create -n harpy -c bioconda -c conda-forge harpy
conda activate harpy

# Pixi installation
pixi global install -c conda-forge -c bioconda harpy
```

## Common CLI Patterns
Harpy uses a modular command structure: `harpy <module> [options]`.

### Core Modules
- **qc**: Performs quality control on raw data.
- **preprocess**: Handles initial data preparation (replaces the older `demux` command).
- **diagnose**: Runs diagnostic checks on the pipeline and data environment.
- **HACk**: Simulates genomic variants from an existing genome.
- **Mimick**: Generates synthetic linked-read data from a reference genome.

### Basic Usage
To see all available modules:
```bash
harpy --help
```

To see options for a specific module (e.g., quality control):
```bash
harpy qc --help
```

## Expert Tips and Best Practices
- **Platform Flexibility**: While optimized for haplotagging, use the `--lr-type` flag to specify other linked-read technologies like TELLseq or stLFR.
- **HPC Environments**: If running on a cluster where software installation is restricted, use the official Apptainer/Singularity containers.
- **Simulation for Benchmarking**: Before running expensive real-world samples, use `HACk` and `Mimick` to create a "ground truth" dataset to validate your downstream analysis parameters.
- **Resource Management**: Since Harpy is built on Snakemake, it natively supports parallelization. Ensure you provide appropriate thread/core limits in your environment to maximize throughput.

## Reference documentation
- [Harpy GitHub Repository](./references/github_com_pdimens_harpy.md)
- [Harpy Overview and Installation](./references/anaconda_org_channels_bioconda_packages_harpy_overview.md)