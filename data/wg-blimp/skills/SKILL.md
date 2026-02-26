---
name: wg-blimp
description: `wg-blimp` processes Whole Genome Bisulfite Sequencing (WGBS) data to produce annotated methylation profiles. Use when user asks to process WGBS data, run the analysis pipeline, create or execute from a configuration, run on a cluster, or visualize results.
homepage: https://github.com/MarWoes/wg-blimp
---


# wg-blimp

## Overview
`wg-blimp` is a comprehensive bioinformatics pipeline designed to streamline the processing of Whole Genome Bisulfite Sequencing (WGBS) data. It functions as a command-line wrapper for a Snakemake workflow, integrating a suite of specialized tools to transform raw FASTQ files into annotated methylation profiles. The tool is essential for researchers needing a reproducible, automated path through alignment, QC, and downstream epigenetic analysis.

## Installation and Setup
The recommended installation method is via Bioconda into a dedicated environment to avoid dependency conflicts.

- **Standard Installation**: `conda create -n wg-blimp wg-blimp r-base==4.1.1`
- **Cluster Support**: If using SLURM or other clusters, `mamba` is required within the environment: `conda create -n wg-blimp wg-blimp r-base==4.1.1 mamba`

## Primary Command Line Operations

### Running the Pipeline
The most direct way to execute the analysis is using the `run-snakemake` command.

`wg-blimp run-snakemake [fastq_folder] [reference_fasta] [group1_samples] [group2_samples] [output_folder] --cores [N] --genome-build [build]`

- **Arguments**:
  - `group1_samples` / `group2_samples`: Comma-separated lists of sample names (e.g., `control1,control2`).
  - `--cores`: Total CPU cores available to Snakemake.
  - `--aligner`: Specify `gemBS` (default) or `bwa-meth`.

### Configuration Management
For complex runs, use the configuration utilities to prepare and execute the workflow.

- **Generate Configuration**: `wg-blimp create-config`
- **Run from Configuration**: `wg-blimp run-snakemake-from-config [options] config.yaml`

### High-Performance Computing (HPC)
To run on a cluster (e.g., SLURM), use the `--cluster` and `--nodes` flags.

`wg-blimp run-snakemake-from-config --cores 32 --nodes 2 --cluster "sbatch --partition normal --nodes=1 --ntasks-per-node 32 --time 01:00:00" config.yaml`

### Interactive Visualization
Launch the Shiny-based graphical interface to inspect results and configurations.

`wg-blimp run-shiny`

## Expert Tips and Best Practices

### File Naming Conventions
By default, `wg-blimp` expects Illumina naming patterns to automatically associate FASTQ files with samples:
`[SampleName]_L[Lane]_R[Read]_[Chunk].fastq.gz`
Example: `test1_L001_R1_001.fastq.gz`

If your files use a different naming scheme, you must provide an explicit mapping using a CSV file with the `--use-sample-files` flag. The CSV must contain columns: `sample`, `forward`, and `reverse`.

### Resource Allocation
- **Java Memory**: For large samples, increase the memory allocation for Java-based tools using the `java_memory_gb` parameter in your configuration to prevent crashes during methylation calling.
- **IO Threads**: Use the `io_threads` setting to limit the number of concurrent IO-intensive tasks, which prevents file system bottlenecks on shared infrastructure.

### Aligner Selection
- **gemBS**: Generally faster and highly integrated for bisulfite data.
- **bwa-meth**: A robust alternative that maps reads to a "bisulfite-converted" reference genome.

### Output Verification
Always check the `raw/` directory in the output folder. This directory contains text files describing exactly which FASTQ files were associated with each sample. If the associations are incorrect, the downstream DMR calling will be invalid.

## Reference documentation
- [Main Repository Documentation](./references/github_com_MarWoes_wg-blimp.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_wg-blimp_overview.md)