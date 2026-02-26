---
name: metagem
description: metaGEM is an integrated workflow that automates the process of converting raw metagenomic reads into functional metabolic models and community-scale simulations. Use when user asks to process metagenomic reads, assemble and bin genomes, refine metagenome-assembled genomes, reconstruct metabolic models, or predict metabolic interactions and cross-feeding.
homepage: https://github.com/franciscozorrilla/metaGEM
---


# metagem

## Overview

metaGEM is an integrated Snakemake-based workflow that automates the transition from raw metagenomic reads to functional metabolic simulations. It bridges bioinformatics (assembly and binning) with systems biology (metabolic modeling), allowing for the prediction of species-specific growth rates and metabolic cross-feeding within complex microbiomes. Use this skill to navigate the multi-step pipeline, from initial read processing to community-scale interaction modeling.

## Usage Patterns

The metaGEM workflow is controlled via a wrapper script (`metaGEM.sh`) that manages task execution and resource allocation.

### Initial Setup
Before running the core workflow, initialize the directory structure and verify the environment:
- Create required folders: `bash metaGEM.sh -t createFolders`
- Organize input data: `bash metaGEM.sh -t organizeData`
- Verify dependencies: `bash metaGEM.sh -t check`

### Core Workflow Execution
The pipeline is modular. Execute tasks sequentially or in logical blocks:
- **Read Processing & Assembly**: Run `fastp` for quality filtering and `megahit` for assembly.
- **Binning**: Generate draft bins using `concoct`, `metabat`, and `maxbin`.
- **Refinement**: Use `binRefine` and `binReassemble` to improve MAG quality (highly recommended for better GEM reconstruction).
- **Metabolic Modeling**: Run `carveme` to generate models and `memote` for quality assessment.
- **Interaction Analysis**: Use `smetana` to predict metabolic exchanges between community members.

### Command Line Arguments
- `-t, --task`: Specify the specific step to run (e.g., `megahit`, `carveme`).
- `-j, --nJobs`: Set the number of parallel jobs.
- `-c, --nCores`: Set CPU cores per job.
- `-m, --mem`: Specify memory in GB.
- `-l, --local`: Use this flag to run on a local machine instead of an HPC cluster.

## Best Practices

- **Prioritize Bin Refinement**: Always run the `binRefine` task. High-quality metabolic models depend on the completeness and low contamination of the underlying MAGs.
- **Resource Management**: For assembly (`megahit`) and taxonomic assignment (`gtdbtk`), ensure high memory allocation (e.g., `-m 128` or higher depending on dataset size).
- **Local vs. Cluster**: Use the `-l` flag for testing on small datasets or "toy" data, but utilize a cluster environment for production-scale metagenomes due to the high computational cost of assembly and binning.
- **Taxonomic Context**: Run `gtdbtk` before `carveme` to ensure models are reconstructed using the most appropriate taxonomic templates.

## Reference documentation
- [metaGEM GitHub Repository](./references/github_com_franciscozorrilla_metaGEM.md)
- [metaGEM Wiki](./references/github_com_franciscozorrilla_metaGEM_wiki.md)
- [metaGEM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metagem_overview.md)