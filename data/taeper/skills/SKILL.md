---
name: taeper
description: taeper simulates Nanopore sequencing by copying fast5 files to a destination directory according to their original generation timestamps. Use when user asks to replicate real-time sequencing behavior, stress-test live analysis workflows, or speed up the simulation of historical sequencing data.
homepage: https://github.com/mbhall88/taeper
metadata:
  docker_image: "quay.io/biocontainers/taeper:0.1.0--py36_0"
---

# taeper

## Overview

taeper is a simulation tool that replicates the behavior of a Nanopore sequencer by copying fast5 files from a source directory to a destination in the exact order and timing they were originally generated. It allows developers to stress-test "live" analysis workflows using historical data. The tool extracts completion timestamps from fast5 metadata to calculate delays between file transfers and supports time-scaling to speed up the simulation of long-running experiments.

## Installation

Install taeper via pip or Conda:

```bash
# Using pip
pip3 install taeper

# Using Conda
conda install -c bioconda taeper
```

## Core Workflows

### Basic Simulation
To replay an experiment exactly as it occurred:
`taeper --input_dir path/to/reads --output path/to/destination`

### Accelerated Testing
Use the `--scale` flag to speed up the simulation. A scale of 100 will make a 100-minute experiment finish in 1 minute:
`taeper -i path/to/reads -o path/to/destination --scale 100`

### Managing Indexes
Indexing is the most time-consuming step. For repeated tests on the same dataset, generate and reuse an index file (`.npy`).

1. **Generate index only**:
   `taeper -i path/to/reads --dump_index experiment_index.npy`
2. **Run simulation using existing index**:
   `taeper -i path/to/reads -o path/to/destination --index experiment_index.npy --scale 10`

## Best Practices and Tips

- **Relative Paths**: Be aware that file paths stored in the index file are relative to the working directory where the index was created. Always run the simulation from the same base directory used during indexing.
- **Directory Structure**: taeper automatically recreates subdirectory structures (like `pass` or `fail` folders) in the output directory to match the source.
- **Logging**: If the tool cannot read a specific fast5 file or determine its finish time, it will trigger a warning. Use `--log_level 5` for detailed debugging if files are being skipped.
- **Performance**: If you do not want to save an index file to disk, use the `--no_index` flag, though this will require regenerating the index on every run.
- **UI**: Use `--no_progress_bar` when running in automated CI/CD environments or headless servers to keep logs clean.

## Reference documentation
- [taeper GitHub Repository](./references/github_com_mbhall88_taeper.md)
- [taeper Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_taeper_overview.md)