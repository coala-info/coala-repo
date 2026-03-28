---
name: defense-finder
description: DefenseFinder identifies anti-phage defense systems in genomic or protein sequences using specialized HMM models. Use when user asks to search for defense systems in a genome, update defense system models, or interpret defense-finder output files.
homepage: https://github.com/mdmparis/defense-finder
---


# defense-finder

## Overview
DefenseFinder is a specialized bioinformatic tool that leverages MacSyFinder and HMMer to identify anti-phage systems within genomic data. It is designed to scan protein sequences (in genomic order) or nucleotide sequences to find complete molecular systems rather than isolated genes. This skill provides the necessary command-line patterns to install, update, and execute defense-finder, as well as guidance on interpreting its multi-file output.

## Installation and Setup
Before running a search, ensure the environment is prepared and the latest HMM models are downloaded.

```bash
# Install via pip
pip install mdmparis-defense-finder

# CRITICAL: Download/Update the defense system models
defense-finder update
```

## Core Workflows

### Running a Search
The `run` command is the primary entry point. It automatically detects whether the input is nucleotide or protein.

```bash
# Standard run on a genome file
defense-finder run genome.faa

# Specify an output directory
defense-finder run genome.faa --outdir ./results
```

### Input Requirements
- **Protein FASTA (.faa)**: Proteins must be in their natural genomic order. DefenseFinder relies on spatial proximity to determine if genes form a functional system.
- **Nucleotide FASTA (.fna/.fasta)**: The tool will handle translation/prediction internally.
- **Scale**: For small sets (< 30,000 proteins), the standard `run` command is sufficient. For larger datasets, consider the Gembase format (refer to full documentation).

## Output Interpretation
DefenseFinder generates three primary TSV files in the output directory:

1.  **defense_finder_systems.tsv**: The most important file. Lists complete, validated systems.
    - `type` / `subtype`: The classification of the defense system (e.g., RM_type_I, CAS_Class1-Subtype-I-E).
    - `protein_in_syst`: The specific genes identified as part of that cluster.
2.  **defense_finder_genes.tsv**: Detailed breakdown of every gene found within a system, including MacSyFinder scores and positions.
3.  **defense_finder_hmmer.tsv**: Raw HMMer hits. 
    - **Expert Tip**: Use this file for deep inspection of "orphan" genes. Note that biologically, isolated genes often do not provide anti-phage immunity; only full systems in the `systems.tsv` file are considered high-confidence.

## Maintenance
Models are updated frequently as new defense systems are discovered.
```bash
# Check for and fetch latest models
defense-finder update

# Check version of the CLI tool
defense-finder --version
```



## Subcommands

| Command | Description |
|---------|-------------|
| run | Search for all known anti-phage defense systems in the target fasta file. |
| update | Fetches the latest defense finder models. |

## Reference documentation
- [Main README](./references/github_com_mdmparis_defense-finder_blob_master_README.md)
- [List of detectable systems](./references/github_com_mdmparis_defense-finder_blob_master_List_system_article.md)
- [CLI Structure and Logic](./references/github_com_mdmparis_defense-finder_blob_master_CONTRIBUTING.md)