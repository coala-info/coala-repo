---
name: phylophlan
description: PhyloPhlAn is a comprehensive pipeline for high-resolution phylogenetic analysis of microbial isolates and metagenome-assembled genomes. Use when user asks to generate phylogenetic trees, identify phylogenetic markers, or perform strain-level and tree-of-life taxonomic analyses.
homepage: https://github.com/biobakery/phylophlan
metadata:
  docker_image: "quay.io/biocontainers/phylophlan:3.2.1--pyhdfd78af_0"
---

# phylophlan

## Overview
PhyloPhlAn is a comprehensive pipeline designed for high-resolution phylogenetic analysis of microbial isolates and metagenome-assembled genomes (MAGs). It automates the identification of phylogenetic markers, multiple sequence alignment, and tree reconstruction. This skill enables the execution of the PhyloPhlAn 3.0 workflow, from initial configuration and database setup to the generation of refined phylogenetic trees.

## Core Workflow

### 1. Initialization and Configuration
Before running an analysis, you must generate the necessary configuration files and ensure the environment is ready.

*   **Generate Default Configs**: Run this script to create the four standard configuration files (supermatrix_aa.cfg, supermatrix_nt.cfg, etc.).
    ```bash
    phylophlan_write_default_configs.sh [output_folder]
    ```
*   **Check Version**: Verify the installation and version.
    ```bash
    phylophlan --version
    ```

### 2. Basic Execution Pattern
The primary command structure requires an input folder, a marker database, a diversity setting, and a configuration file.

```bash
phylophlan -i <input_folder> \
           -d <database_name> \
           --diversity <low|medium|high> \
           -f <configuration_file> \
           --nproc <number_of_cpus>
```

### 3. Parameter Selection Guide

| Parameter | Options | Use Case |
| :--- | :--- | :--- |
| `--diversity` | `low` | Species- and strain-level phylogenies. |
| | `medium` | Genus- and family-level phylogenies. |
| | `high` | Tree-of-life and higher-ranked taxonomic levels. |
| `--accurate` | (Default) | Higher precision, considers more phylogenetic positions. |
| `--fast` | | Faster execution, suitable for very large datasets where time is a constraint. |
| `-d` | `phylophlan` | Uses 400 universal marker genes for prokaryotes. |

## Expert Tips and Best Practices

*   **Input File Extensions**: PhyloPhlAn distinguishes between genomes and proteomes by extension. Use `.fna` for nucleotides (genomes) and `.faa` for amino acids (proteomes). You can override these with `--genome_extension` and `--proteome_extension`.
*   **CPU Optimization**: While `--nproc` sets the total CPUs, PhyloPhlAn caps RAxML at 20 threads because performance typically plateaus or drops beyond that point.
*   **Memory Management**: For large-scale phylogenies (>10,000 genomes), ensure the system has significant RAM, as the multiple sequence alignment (MSA) and concatenation steps are resource-intensive.
*   **Translated Space**: If markers are proteins but inputs are genomes, PhyloPhlAn defaults to translated amino acid space. To force nucleotide analysis on genomes, use the `--force_nucleotides` flag when generating the config file and running the pipeline.
*   **Output Structure**: The pipeline creates an `<input_folder>_<database>` directory. The final tree is typically named `RAxML_bestTree.<input_folder>_refined.tre`.

## Common CLI Patterns

**Strain-level analysis of a specific species (e.g., S. aureus):**
```bash
phylophlan -i input_staph -d phylophlan --diversity low -f supermatrix_aa.cfg --nproc 16
```

**Reconstructing a broad Tree of Life:**
```bash
phylophlan -i input_prokaryotes -d phylophlan --diversity high -f supermatrix_aa.cfg --nproc 20
```

## Reference documentation
- [PhyloPhlAn Wiki](./references/github_com_biobakery_phylophlan_wiki.md)
- [PhyloPhlAn GitHub Repository](./references/github_com_biobakery_phylophlan.md)