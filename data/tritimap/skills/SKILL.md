---
name: tritimap
description: Triti-Map is a bioinformatics pipeline designed to identify trait-associated genomic regions and candidate genes in large-genome Triticeae species. Use when user asks to identify trait association intervals, detect mutations, or assemble genes absent from a reference genome.
homepage: https://github.com/fei0810/Triti-Map
---


# tritimap

## Overview
Triti-Map is a specialized bioinformatics pipeline built on Snakemake designed to handle the complexities of large-genome Triticeae species. It automates the transition from raw sequence data to candidate gene identification by integrating two primary workflows: an Interval Mapping Module for identifying trait-associated genomic regions and mutations, and an Assembly Module for discovering functional elements or genes absent from the reference genome.

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure a UNIX environment is available with Conda installed.

```bash
# Environment creation and installation
conda create -c conda-forge -c bioconda -n tritimap tritimap
conda activate tritimap

# Verification
tritimap --help
```

## Core Workflow
The pipeline follows a standard three-step process: initialization, configuration, and execution.

### 1. Project Initialization
Generate the required configuration templates in your working directory.
```bash
# Initialize in current directory
tritimap init

# Initialize in a specific directory
tritimap init -d /path/to/work_dir
```
This command creates three essential files: `config.yaml`, `sample.csv`, and `region.csv`.

### 2. Prerequisite Indexing
Before running the pipeline, reference genomes must be indexed using standard bioinformatics tools. Triti-Map expects these indices to be prepared:
- **GATK/Samtools**: `gatk CreateSequenceDictionary` and `samtools faidx`.
- **DNA-Seq**: `bwa-mem2 index`.
- **RNA-Seq**: `STAR --runMode genomeGenerate`.

### 3. Execution Patterns
Triti-Map supports modular execution depending on the research goal. Use the `-j` flag to specify the number of CPU cores.

```bash
# Run the full pipeline (Mapping + Assembly)
tritimap run -j 30 all

# Identify trait association intervals and mutations only
tritimap run -j 30 only_mapping

# Identify new genes/sequences only
tritimap run -j 30 only_assembly
```

## Expert Tips and Best Practices
- **Long-Running Processes**: Triticeae genomes are massive; a full run can take 1–2 days. Always execute the pipeline within a terminal multiplexer like `screen` or `tmux` to prevent session disconnection.
- **Memory Management**: For STAR index generation on wheat genomes, ensure the system has at least 100GB+ of RAM available.
- **Region Filtering**: When running the Assembly Module alone, ensure `region.csv` is accurately populated with target chromosome coordinates to focus the assembly and reduce computational overhead.
- **Result Inspection**: Outputs are organized numerically in the `results/` directory. Check `05_vcfout` for variant calls and `06_regionout` for the final association intervals.



## Subcommands

| Command | Description |
|---------|-------------|
| init | Generate snakemake configuration file and other needed file. The command will generate three configuration files(config.yaml, sample.csv and region.csv) in the running directory. |
| run | Triti-Map main command. The pipeline supports three execute modules: all, only_mapping and only_assembly. First, you need to fill in the configuration file correctly. |

## Reference documentation
- [Triti-Map Main Repository](./references/github_com_fei0810_Triti-Map.md)
- [Running Triti-Map](./references/github_com_fei0810_Triti-Map_wiki_running_tritimap.md)
- [Preparing Configuration Files](./references/github_com_fei0810_Triti-Map_wiki_preparing_config.md)
- [Genome Preparation](./references/github_com_fei0810_Triti-Map_wiki_preparing_genome.md)
- [Exploring Results](./references/github_com_fei0810_Triti-Map_wiki_results_tritimap.md)