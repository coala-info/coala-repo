---
name: sistem
description: SISTEM is an agent-based bioinformatics tool that simulates tumor evolution and metastasis to generate ground truth genomic datasets and cell lineages. Use when user asks to install the software via Bioconda, run end-to-end tumor growth simulations, generate clonal lineage trees, or produce simulated sequencing data for single-cell and bulk DNA-seq.
homepage: https://github.com/samsonweiner/sistem
---


# sistem

## Overview
SISTEM (SImulation of Single-cell Tumor Evolution and Metastasis) is a specialized bioinformatics tool used to model the life cycle of a tumor. It employs an agent-based approach to simulate somatic clonal selection, allowing researchers to generate "ground truth" datasets for cell lineages and migration patterns. This skill helps you navigate the installation and execution of simulations to produce realistic genomic data, including copy number alterations (CNA) and single-nucleotide variants (SNV).

## Installation and Setup
The tool is primarily distributed via Bioconda. Ensure your environment is configured to use the bioconda and conda-forge channels.

```bash
conda install bioconda::sistem
```

## Core Functionality
SISTEM is designed to handle complex evolutionary scenarios. When using the tool, focus on these primary outputs:
- **Lineage Tracking**: Generates clonal lineages and migration graphs.
- **Genomic Profiles**: Produces CNA and SNV profiles based on the simulated evolution.
- **Sequencing Data**: Generates read counts for both bulk-seq and single-cell DNA-seq (scDNA-seq), including allele-specific reads.

## Usage Best Practices
- **End-to-End Simulations**: For most standard workflows, utilize the `wrapper` module. This is designed to handle the simulation from initial tumor growth through to the generation of final sequencing reads.
- **Agent-Based Parameters**: Since the model is agent-based, results are driven by genotype-driven selection. Pay close attention to parameters defining cell lifespans (which use exponential distributions in recent versions) and mutation rates.
- **Ground Truth Validation**: Use the generated migration graphs and lineage trees to validate external phylogenetic or metastatic inference tools.

## Expert Tips
- **Version Consistency**: Ensure you are using version 1.0.4 or later to take advantage of the exponentially-distributed cell lifespan features, which provide more biological realism than fixed-time steps.
- **Resource Management**: Agent-based simulations of large tumor populations can be memory-intensive. Start with smaller cell populations to calibrate your parameters before scaling to full-size simulations.
- **Scripting**: Check the `scripts/` directory within the source for utility scripts that assist in processing the raw simulation output into specific formats for downstream analysis.

## Reference documentation
- [github_com_samsonweiner_sistem.md](./references/github_com_samsonweiner_sistem.md)
- [anaconda_org_channels_bioconda_packages_sistem_overview.md](./references/anaconda_org_channels_bioconda_packages_sistem_overview.md)