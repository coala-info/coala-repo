---
name: rapgreen
description: Manages, manipulates, and annotates phylogenetic trees. Use when user asks to reconcile gene and species trees, or to search for orthologs and paralogs using tree patterns.
homepage: https://github.com/SouthGreenPlatform/rap-green
metadata:
  docker_image: "quay.io/biocontainers/rapgreen:1.0--hdfd78af_0"
---

# rapgreen

Manages, manipulates, and annotates phylogenetic trees. Use when Claude needs to perform operations on phylogenetic trees, such as reconciliation, pattern matching, or visualization.
---
## Overview

RapGreen is a powerful Java-based package designed for comprehensive management, manipulation, and annotation of phylogenetic trees. It offers functionalities for tree reconciliation (identifying duplications and losses), tree pattern matching (searching for orthologs or paralogs), and tree visualization. This tool is particularly useful for evolutionary biology and comparative genomics research.

## Usage Instructions

RapGreen can be installed and used via several methods, including Conda, Docker, Singularity, or directly from its Java package.

### Installation

**Using Bioconda (Recommended for most users):**

```bash
conda install -c bioconda rapgreen
```

To update:
```bash
conda update -c bioconda rapgreen
```

To uninstall:
```bash
conda uninstall rapgreen
```

**Using Docker:**

1.  Pull the desired RapGreen container version:
    ```bash
    docker pull quay.io/biocontainers/rapgreen:1.0--hdfd78af_0
    ```
2.  Run RapGreen within the container:
    ```bash
    docker run quay.io/biocontainers/rapgreen:1.0--hdfd78af_0 rapgreen --help
    ```

**Using Singularity:**

1.  Pull the desired RapGreen container version:
    ```bash
    singularity pull docker://quay.io/biocontainers/rapgreen:1.0--hdfd78af_0
    ```
2.  Run the container:
    ```bash
    singularity run rapgreen:1.0--hdfd78af_0
    ```
    You will then be inside the container and can execute RapGreen commands.

### Core Functionalities and CLI Patterns

RapGreen has two main entry points for command-line usage: tree reconciliation and tree pattern matching.

**1. Tree Reconciliation:**

This functionality is used to annotate duplications and losses on a phylogenetic tree.

*   **General Command Structure:**
    ```bash
    rapgreen reconciler --gene_tree <gene_tree.nwk> --species_tree <species_tree.nwk> --output <output_file.nwk> [options]
    ```
*   **Key Options:**
    *   `--gene_tree`: Path to the gene phylogenetic tree file (e.g., Newick format).
    *   `--species_tree`: Path to the species phylogenetic tree file (e.g., Newick format).
    *   `--output`: Path for the output reconciled tree file.
    *   `--stats`: To get statistics for each pair of genes.
    *   Refer to the documentation for detailed options related to specific reconciliation algorithms or parameters.

**2. Tree Pattern Matching:**

This service allows for automatic searching for orthologs or paralogs within homologous gene sequence databases by matching patterns in phylogenetic trees.

*   **General Command Structure:**
    ```bash
    rapgreen pattern_matcher --tree <tree.nwk> --pattern <pattern_file.txt> --output <output_file.txt> [options]
    ```
*   **Key Options:**
    *   `--tree`: Path to the phylogenetic tree file.
    *   `--pattern`: Path to a file defining the tree patterns to search for.
    *   `--output`: Path for the output file containing matching results.
    *   `--daemon`: To run the tree pattern matching service as a daemon.
    *   Consult the documentation for the specific format of the `pattern_file.txt` and available search parameters.

**3. Tree Visualization (InTreeGreat):**

RapGreen also supports tree visualization through the InTreeGreat service. Installation and usage details are available in the documentation.

### Expert Tips

*   **File Formats:** RapGreen primarily uses the Newick format (`.nwk`) for phylogenetic trees. Ensure your input files are correctly formatted.
*   **Documentation:** For detailed command-line documentation, tutorials, and API references, always refer to the official RapGreen wiki.
*   **Gene Pair Statistics:** When performing reconciliation, utilize the `--stats` option to obtain valuable statistics about gene duplication and loss events.
*   **Daemon Mode:** For the tree pattern matching service, running in daemon mode (`--daemon`) can be efficient for repeated queries or integration into larger workflows.

## Reference documentation

*   [RapGreen Wiki](https://github.com/SouthGreenPlatform/rap-green/wiki)
*   [RapGreen Overview](./references/anaconda_org_channels_bioconda_packages_rapgreen_overview.md)
*   [RapGreen GitHub Repository](./references/github_com_SouthGreenPlatform_rap-green.md)