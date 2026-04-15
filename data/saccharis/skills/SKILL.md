---
name: saccharis
description: Saccharis automates phylogenetic analysis of CAZyme families from FASTA sequences. Use when user asks to create phylogenetic trees from FASTA files and CAZyme families, analyze CAZyme families for functional prediction, or streamline the prediction of Carbohydrate-Active Enzyme specificities.
homepage: https://github.com/saccharis/SACCHARIS_2
metadata:
  docker_image: "quay.io/biocontainers/saccharis:2.0.5--pyh7e72e81_0"
---

# saccharis

yaml
name: saccharis
description: |
  Automates phylogenetic analysis of CAZyme families from FASTA sequences.
  Use when you need to:
  - Create phylogenetic trees from FASTA files and CAZyme families.
  - Analyze CAZyme families for functional prediction.
  - Streamline the prediction of Carbohydrate-Active Enzyme specificities.
```
## Overview
Saccharis is a bioinformatics pipeline designed to automate the process of phylogenetic analysis for Carbohydrate-Active Enzyme (CAZyme) families. It takes FASTA files containing sequences and generates phylogenetic trees, aiding in the functional prediction of uncharacterized sequences. This tool is particularly useful for researchers working with large datasets of CAZyme families.

## Usage Instructions

Saccharis can be installed via conda and run from the command line.

### Installation

The recommended installation method is using conda:

1.  **Add bioconda channel:**
    ```bash
    conda config --add channels defaults
    conda config --add channels bioconda
    conda config --add channels conda-forge
    conda config --set channel_priority strict
    ```
2.  **Create a dedicated environment and install saccharis:**
    ```bash
    conda create -n saccharis_env saccharis
    ```
    Alternatively, activate an existing environment and install:
    ```bash
    conda activate your_env_name
    conda install saccharis
    ```

### Running Saccharis

Once installed, saccharis can be executed from the command line.

*   **To run the CLI version:**
    ```bash
    saccharis [options]
    ```
*   **To run the GUI version:**
    ```bash
    saccharis-gui
    ```

### Key Workflows and Options

Saccharis is designed to automate phylogenetic analysis of CAZyme families. While specific command-line options are not detailed in the provided documentation, the general workflow involves:

1.  **Input:** Providing FASTA files containing sequences.
2.  **Analysis:** The tool processes these sequences, identifies CAZyme families, and performs phylogenetic analysis.
3.  **Output:** Generation of phylogenetic trees and potentially functional predictions.

**Expert Tip:** For detailed usage and advanced options, refer to the official documentation and the GitHub wiki. The tool supports both command-line and graphical user interfaces, offering flexibility based on user preference and technical environment.

## Reference documentation
- [SACCHARIS 2 README](./references/github_com_saccharis_SACCHARIS_2.md)
- [Installation Guides](./references/github_com_saccharis_SACCHARIS_2_wiki.md)