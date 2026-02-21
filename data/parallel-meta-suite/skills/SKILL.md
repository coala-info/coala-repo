---
name: parallel-meta-suite
description: Parallel-META Suite (PMS) is a high-performance software package designed for the automated processing of microbiome data.
homepage: https://github.com/qdu-bioinfo/parallel-meta-suite
---

# parallel-meta-suite

## Overview
Parallel-META Suite (PMS) is a high-performance software package designed for the automated processing of microbiome data. It streamlines the transition from raw sequence data to publication-ready charts by utilizing parallel computing to accelerate analysis. The suite is versatile, supporting both amplicon (16S/18S/ITS) and shotgun metagenomic sequences, and provides a comprehensive workflow that includes sequence quality control, taxonomic profiling, and diversity analysis.

## Environment Setup
Before running the suite, ensure the environment variables are correctly configured to allow the system to locate the necessary binaries and R scripts.

- **Variable**: `ParallelMETA` must point to the root installation directory.
- **Path**: Add `$ParallelMETA/bin` and `$ParallelMETA/Rscript` to your system `PATH`.
- **Activation**: After manual installation or updating your profile, run `source ~/.bashrc` or `source ~/.bash_profile`.

## Command Line Interface (CLI) Patterns
The primary entry point for the automated workflow is the `PM-pipeline` command.

### Basic Usage
To view all available parameters, flags, and mandatory inputs:
```bash
PM-pipeline -h
```

### Standard Workflow
1. **Configuration**: For complex study designs, use the local GUI configuration tool located at `$ParallelMETA/PMS-Config/index.html`. Open this in a web browser to select parameters visually.
2. **Command Generation**: Click the "Generate" button in the web interface to produce a single-line CLI command tailored to your data.
3. **Execution**: Copy and paste the generated command into your terminal to start the parallelized processing.

### Testing with Example Data
To verify the installation and explore the output structure, use the provided demo dataset:
```bash
# Copy example data to your current working directory
cp -rf $ParallelMETA/example ./
cd example
# Execute the demo pipeline
sh Readme
```

## Expert Tips and Best Practices
- **Remote Server Execution**: If working on a remote server without a GUI, download the `PMS-Config` folder to your local machine. Open the `index.html` locally to generate the command, then paste that command into your remote SSH terminal.
- **Visualizing Results**: Every successful run generates an `index.html` file in the output directory. This is a standalone visualized result viewer. Transfer the output folder to a machine with a web browser to interact with the charts.
- **Resource Management**: PMS is optimized for parallel computing. For large-scale screenings (thousands of samples), ensure your environment meets the recommended 8GB+ RAM and 4+ CPU cores to prevent bottlenecks.
- **Data Mining**: Beyond the visual reports, all raw results (relative abundance tables, distance matrices, etc.) are preserved in the output folder for custom downstream statistical analysis in R or other platforms.
- **Troubleshooting**: If the pipeline stops unexpectedly, consult the `work.log` and the individual step-by-step workflow scripts created within the output directory to identify the specific failing module.

## Reference documentation
- [Parallel-Meta Suite README](./references/github_com_qdu-bioinfo_parallel-meta-suite.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_parallel-meta-suite_overview.md)