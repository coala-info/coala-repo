---
name: zdb
description: zDB is an integrated platform for bacterial comparative genomics that streamlines the process of analyzing multiple genomes and visualizing the results. Use when user asks to initialize reference databases, run comparative genomic analyses, visualize results, list available runs, export results, or import results.
homepage: https://github.com/metagenlab/zDB/
---


# zdb

## Overview
zDB is an integrated platform for bacterial comparative genomics that streamlines the process of analyzing multiple genomes and visualizing the results. It handles complex workflows like orthology inference, functional profiling, and phylogenetic tree construction, storing results in a SQLite database for interactive exploration through a built-in Django web interface.

## Installation and Environment
Install zDB via Bioconda:
`conda install bioconda::zdb`

**Execution Modes:**
zDB runs tasks in isolated environments. Specify your preference using:
- `--docker`: Recommended for consistency and MacOS users.
- `--singularity`: (or Apptainer) Recommended for Linux/HPC environments.
- `--conda`: Use as a fallback; note that some environments may fail on ARM (M1/M2 Mac) architectures.

*Note: If using ete3 rendering for trees in a headless environment, ensure `Xvfb` is installed or use Apptainer containers.*

## Core Workflow

### 1. Database Setup
Before running analyses, you must initialize the reference databases. This is a one-time requirement for the base skeleton, but specific annotations require additional flags.
- **Minimal setup**: `zdb setup --setup_base_db`
- **Full annotation support**: `zdb setup --setup_base_db --pfam --cog --ko`

### 2. Running the Pipeline
Execute the comparative analysis by providing a CSV input file.
`zdb run --input=genomes.csv --name=experiment_v1 --conda --cog --pfam`

**Key Arguments:**
- `--input`: Path to a CSV file defining the genomes to compare.
- `--name`: A unique identifier for the run.
- `--cpu`: Specify the number of processors (e.g., Diamond search defaults to 8).

### 3. Visualizing Results
Launch the Django web application to browse the results of a specific run.
`zdb webapp --name=experiment_v1`

## Data Management
- **List available runs**: `zdb list_runs`
- **Export results**: `zdb export --name=experiment_v1` (creates a portable archive).
- **Import results**: `zdb import --archive=data.tar.gz` (allows viewing results from another machine).

## Expert Tips
- **RefSeq Homologs**: While supported, searching against RefSeq significantly increases computation time and requires manual database preparation for Diamond.
- **Performance**: If using Conda, ensure you have a recent version with the Libmamba solver to speed up the creation of the numerous required environments.
- **Source Installation**: For developers needing to modify the Nextflow configuration, clone the repository and add the `bin` directory to your `PATH`.

## Reference documentation
- [zDB GitHub Repository](./references/github_com_metagenlab_zDB.md)
- [Bioconda zDB Package Overview](./references/anaconda_org_channels_bioconda_packages_zdb_overview.md)