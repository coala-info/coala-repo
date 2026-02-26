---
name: daisysuite
description: DaisySuite is a bioinformatics pipeline that identifies horizontal gene transfer events using a mapping-based approach. Use when user asks to identify horizontal gene transfer, process sequencing data to find genetic breakpoints, or simulate synthetic transfer events.
homepage: https://gitlab.com/eseiler/DaisySuite
---


# daisysuite

## Overview

DaisySuite is a specialized bioinformatics pipeline designed for the identification of Horizontal Gene Transfer (HGT) through a mapping-based approach. It processes sequencing data to pinpoint the exact locations where genetic material has been transferred between different species. It is particularly useful for researchers working with metagenomic data or specific donor-acceptor pairs who need to validate evolutionary transfer events.

## Installation

The tool is available via Bioconda. It is recommended to install it within a dedicated Conda environment:

```bash
conda install -c bioconda daisysuite
```

## Command Line Usage

The primary interface for DaisySuite is a single command-line wrapper. 

### Basic Execution
To run the pipeline, point the tool to your configuration file:

```bash
DaisySuite --configfile path/to/config.yaml
```

### Core Components
- **DaisyGPS**: The component responsible for the initial mapping and candidate identification.
- **Simulation Feature**: DaisySuite includes a simulation mode to test the pipeline's accuracy against synthetic HGT events.

## Best Practices and Expert Tips

### Improving Sensitivity
If the pipeline is returning breakpoints but missing known or expected HGT events, consider the following:
- **Sequencing Depth**: Sensitivity is highly dependent on coverage. At lower depths (e.g., 20x), default parameters may be too stringent.
- **Parameter Tuning**: Adjust the candidate selection thresholds if the default run is too conservative.

### Troubleshooting "Nothing to be done"
If the log file reports "Nothing to be done" immediately after starting:
- **Path Validation**: This is typically caused by the pipeline being unable to locate the input reads. Ensure that the paths provided in your configuration are either absolute paths or correctly relative to the directory where the command is executed.
- **Directory Structure**: DaisySuite creates its own internal folder structure for logs and intermediate files. Ensure the user has write permissions in the working directory.

### Resource Management
- **CPU Cores**: Mapping-based detection is computationally expensive. Ensure the environment has sufficient cores allocated, as the underlying mapping tools (like BWA or Bowtie2) will attempt to parallelize.
- **Memory**: Large reference genomes for donor/acceptor species require significant RAM during the indexing and mapping phases.

### Known Acceptor and Donor
When the donor and acceptor species are known beforehand, the pipeline's accuracy increases significantly. Ensure the reference genomes for both are high-quality assemblies to avoid false-positive breakpoints caused by assembly gaps.

## Reference documentation

- [DaisySuite Overview](./references/anaconda_org_channels_bioconda_packages_daisysuite_overview.md)
- [DaisySuite README](./references/gitlab_com_eseiler_DaisySuite_-_blob_master_README.md)
- [DaisySuite Tags and Versions](./references/gitlab_com_eseiler_DaisySuite_-_tags.md)