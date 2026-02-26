---
name: mageck-vispr
description: "MAGeCK-VISPR is an integrated workflow for the quality control, analysis, and visualization of CRISPR/Cas9 screens. Use when user asks to initialize a CRISPR analysis project, run the MAGeCK-VISPR pipeline, or visualize screen results with VISPR."
homepage: https://bitbucket.org/liulab/mageck-vispr
---


# mageck-vispr

## Overview
MAGeCK-VISPR is an integrated workflow designed for the rigorous analysis of CRISPR/Cas9 screens. It automates the pipeline from raw sequencing reads to statistical analysis by orchestrating several tools: FastQC for quality control, cutadapt for adapter trimming, MAGeCK for guide RNA enrichment/depletion analysis, and VISPR for interactive visualization. It is particularly effective for large-scale screens with multiple conditions or replicates, providing a standardized Snakemake-based execution environment.

## Core Workflow and CLI Patterns

### 1. Project Initialization
The workflow begins by generating a template directory structure. This is essential for establishing the expected file hierarchy.

```bash
# Initialize a new MAGeCK-VISPR project
mageck-vispr init <project_name>
```

This command creates a directory containing the necessary configuration files and a `Snakefile`.

### 2. Configuration Requirements
Before running the workflow, two primary files must be configured manually:
- **Sample Definition**: A tab-separated file (usually `samples.txt`) defining sample names, FastQ file paths, and their respective conditions (e.g., control vs. treatment).
- **Workflow Configuration**: A configuration file defining parameters for MAGeCK, the library design (sgRNA sequences), and the genomic targets.

### 3. Executing the Workflow
MAGeCK-VISPR leverages Snakemake for execution. You can run the pipeline locally or on a cluster.

```bash
# Run the workflow locally using a specific number of cores
mageck-vispr run local --cores 8

# Perform a dry run to validate the configuration and steps
snakemake -n

# Run on a cluster (requires a cluster configuration file)
mageck-vispr run cluster --cluster "sbatch -p <partition>" --jobs 10
```

### 4. Visualization
Once the analysis is complete, use the VISPR component to host an interactive web-based visualization of the results.

```bash
# Start the VISPR server to explore results
vispr server <results_prefix>.vispr.yaml
```

## Expert Tips and Best Practices
- **Library File Formatting**: Ensure your library file (CSV/TSV) matches the MAGeCK format exactly: `ID`, `Sequence`, `Gene`. Any mismatch in guide IDs between the library and the configuration will cause the counting step to fail.
- **Quality Control First**: Always inspect the FastQC reports generated in the `qc/` directory before interpreting MAGeCK hits. High adapter contamination or low base quality can lead to false negatives in guide counting.
- **Resource Management**: For large screens (many samples), the `cutadapt` and `count` steps are CPU-intensive. Use the `--cores` flag to parallelize these tasks.
- **Handling Multiple Replicates**: MAGeCK-VISPR handles replicates internally. Ensure replicates are labeled with the same condition name in your sample definition file to allow the MAGeCK "MLE" or "RRA" algorithms to properly estimate variance.

## Reference documentation
- [MAGeCK-VISPR Overview](./references/anaconda_org_channels_bioconda_packages_mageck-vispr_overview.md)
- [MAGeCK-VISPR Source and Documentation](./references/bitbucket_org_liulab_mageck-vispr.md)