---
name: phylofisher
description: PhyloFisher is a Python-based software suite for managing eukaryotic phylogenomic workflows and ortholog identification. Use when user asks to identify orthologs in new proteomes, refine datasets by removing fast-evolving sites or taxa, construct supermatrices, or perform phylogenomic tree reconstructions.
homepage: https://github.com/TheBrownLab/PhyloFisher
metadata:
  docker_image: "quay.io/biocontainers/phylofisher:1.2.14--pyhdfd78af_0"
---

# phylofisher

## Overview

PhyloFisher is a specialized Python-based suite designed to streamline the phylogenomic workflow for eukaryotic organisms. It bridges the gap between raw protein sequences and sophisticated phylogenomic analyses. The tool provides a comprehensive environment for managing ortholog databases, "fishing" for sequences in new proteomes, and performing rigorous data cleaning—such as removing fast-evolving sites or heterotactic sequences—to improve the signal-to-noise ratio in large-scale tree reconstructions.

## Core Workflow and CLI Usage

PhyloFisher operates through a series of modular scripts. Most commands require a configuration file or a pre-built database.

### 1. Initialization and Configuration
Before running analyses, you must configure the environment and build the starting database.
- `config.py`: Run this first to set up paths to external dependencies (e.g., MAFFT, IQ-TREE, RAxML-NG).
- `build_database.py`: Used to initialize the local database from provided eukaryotic ortholog sets.
- `working_dataset_constructor.py`: Creates the directory structure and metadata files for a new project.

### 2. Ortholog Identification ("Fishing")
- `fisher.py`: The primary tool for identifying orthologs in new proteomes. It uses the existing database as a reference to "fish" for homologous sequences in your input data.
- `informant.py`: Provides summary statistics and information about the sequences currently in your database or project.

### 3. Dataset Refinement
Refining the dataset is critical for reducing systematic errors in eukaryotic phylogenetics.
- `select_taxa.py` / `select_orthologs.py`: Subsets your data based on occupancy or specific research questions.
- `fast_site_remover.py`: Removes the fastest-evolving sites which often contribute to long-branch attraction.
- `fast_taxa_remover.py`: Identifies and removes unstable or fast-evolving taxa.
- `aa_recoder.py`: Recodes amino acids (e.g., Dayhoff-6) to mitigate the effects of compositional bias.
- `heterotachy.py`: Identifies and removes heterotactic sites.

### 4. Matrix and Tree Construction
- `matrix_constructor.py`: Concatenates single-gene alignments into a supermatrix.
- `nucl_matrix_constructor.py`: Specifically for constructing nucleotide-based matrices if required.
- `sgt_constructor.py`: Automates the construction of single-gene trees for orthology validation.
- `astral_runner.py`: Utility for running ASTRAL on a set of single-gene trees to perform species tree estimation.

### 5. Database Management and Utilities
- `explore_database.py`: Queries the SQLite database to check for taxon/ortholog presence.
- `apply_to_db.py`: Updates the master database with newly identified sequences or manual corrections.
- `purge.py`: Removes specific taxa or orthologs from the working dataset.
- `backup_restoration.py`: Manages project backups to prevent data loss during iterative filtering.

## Expert Tips

- **Database Exploration**: Use `explore_database.py` frequently to verify the state of your SQLite database, especially after running `fisher.py` or `apply_to_db.py`.
- **Model Selection**: When running tree reconstructions, use `mammal_modeler.py` for specialized protein model selection tailored to eukaryotic datasets.
- **Compositional Analysis**: Run `aa_comp_calculator.py` before and after `aa_recoder.py` to quantify how much compositional heterogeneity has been reduced.
- **Taxon Collapsing**: If your dataset has high redundancy (e.g., multiple strains of the same species), use `taxon_collapser.py` to create a single representative sequence per clade.



## Subcommands

| Command | Description |
|---------|-------------|
| aa_recoder.py | Recodes input matrix based on SR4 amino acid classification. |
| apply_to_db.py | Apply parsing decisions and add new data to the database. |
| heterotachy.py | Removes the most heterotachous sites within a phylogenomic supermatrix in a stepwise fashion, leading to a user defined set of new matrices with these sites removed. |
| matrix_constructor.py | To trim align and concatenate orthologs into a super-matrix run: |
| nucl_matrix_constructor.py | To get nucleotides trim align and concatenate orthologs into a nucleotide super-matrix: |
| select_taxa.py | Selects taxa to be included in super matrix construction |
| sgt_constructor.py | Aligns, trims, and builds single gene trees from unaligned gene files. |
| taxon_collapser.py | Collapses dataset entries into a single taxon |

## Reference documentation
- [PhyloFisher Repository Overview](./references/github_com_TheBrownLab_PhyloFisher.md)
- [PhyloFisher Setup and Script List](./references/github_com_TheBrownLab_PhyloFisher_blob_master_setup.py.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phylofisher_overview.md)