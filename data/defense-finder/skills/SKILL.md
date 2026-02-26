---
name: defense-finder
description: Defense-finder automates the detection of known anti-phage systems in genomic sequences using HMM profiles and MacSyFinder. Use when user asks to identify defense systems in genomes, update defense system models, or analyze protein sequences for anti-phage mechanisms.
homepage: https://github.com/mdmparis/defense-finder
---


# defense-finder

## Overview
Defense-finder is a specialized bioinformatic tool that automates the detection of known anti-phage systems in genomic sequences. It utilizes MacSyFinder and a curated library of Hidden Markov Model (HMM) profiles to identify gene clusters that constitute functional defense mechanisms. This skill provides the necessary command-line patterns and best practices to effectively run the tool, manage its models, and interpret the resulting data.

## Installation and Setup
Defense-finder requires HMMER (v3.1+) and MacSyFinder. It is best installed via a virtual environment.

```bash
# Installation via pip
pip install mdmparis-defense-finder

# Installation via Conda
conda install bioconda::defense-finder
```

## Model Management
The tool relies on external models that must be downloaded and updated regularly to ensure the detection of the most recently discovered defense systems.

- **Initial Download/Update**: Always run this before a new analysis if you haven't used the tool recently.
  ```bash
  defense-finder update
  ```
- **Custom Model Directory**: If you maintain models in a specific location:
  ```bash
  defense-finder update --models-dir /path/to/your/models
  ```

## Running the Search
The `run` command is the primary interface for analysis.

### Basic Usage
Defense-finder automatically detects whether the input is a protein (.faa) or nucleotide fasta file.
```bash
defense-finder run genome.faa
```

### Critical Input Requirements
- **Protein Order**: If providing a protein fasta file, proteins **must** be in their natural genomic order. Defense-finder uses the spatial proximity of genes to determine if they form a valid defense system.
- **Dataset Size**: For small sets (< 30,000 proteins), a standard run is sufficient. For larger datasets, consider formatting the data into Gembase format (refer to MacSyFinder documentation).
- **Execution Time**: A typical bacterial genome should take less than two minutes on standard hardware.

## Interpreting Results
The tool generates three primary tab-separated value (TSV) files:

1.  **defense_finder_systems.tsv**: The high-level summary. Each line represents a detected system (e.g., a specific Type I-E CRISPR system).
    - `sys_id`: Unique identifier for the system.
    - `type` / `subtype`: The classification of the defense mechanism.
    - `protein_in_syst`: List of genes included in the cluster.
2.  **defense_finder_genes.tsv**: Detailed information for every gene identified as part of a system, including its position and MacSyFinder score.
3.  **defense_finder_hmmer.tsv**: Raw HMMER hits for the protein profiles.

## Expert Tips
- **Model Versioning**: Ensure your models are version 2.0.0 or higher to be compatible with Defense-finder v2.x.
- **Updating the Tool**: If the models update but the tool is outdated, use:
  ```bash
  pip install -U mdmparis-defense-finder
  ```
- **System IDs**: Use the `sys_id` in the systems file to cross-reference specific genes in the genes file for detailed genomic context analysis.

## Reference documentation
- [Defense-finder GitHub Repository](./references/github_com_mdmparis_defense-finder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_defense-finder_overview.md)