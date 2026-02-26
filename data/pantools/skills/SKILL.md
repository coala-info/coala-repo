---
name: pantools
description: Pantools is a pangenomic toolkit for comparative analysis of large numbers of genomes. Use when user asks to perform comparative genomic analyses, construct pangenomes, or analyze genomic variations across multiple genomes.
homepage: https://git.wur.nl/bioinformatics/pantools
---


# pantools

yaml
name: pantools
description: A pangenomic toolkit for comparative analysis of large numbers of genomes. Use when Claude needs to perform comparative genomic analyses, construct pangenomes, or analyze genomic variations across multiple genomes.
```
## Overview
PanTools is a powerful command-line utility designed for the comparative analysis of multiple genomes. It enables researchers to construct pangenomes, identify core and accessory genes, and analyze genomic variations. This tool is essential for understanding the evolutionary relationships and genetic diversity within a set of related organisms.

## Usage Instructions

PanTools operates through a series of commands to build and analyze pangenomes. The general workflow involves preparing input data, building the pangenome, and then performing various analyses.

### Core Commands and Workflow

1.  **Input Preparation**:
    *   PanTools typically works with genome sequences in FASTA format. Ensure your input genomes are correctly formatted.
    *   You may need to generate gene presence/absence tables or other intermediate files depending on your specific analysis.

2.  **Pangenome Construction**:
    *   The primary command for building a pangenome is `pantools build`.
    *   This command requires specifying input genome files and output directories.
    *   Key parameters often include:
        *   `--sequences`: Path to input FASTA files or a directory containing them.
        *   `--output_dir`: Directory to store the pangenome data.
        *   `--kmer_size`: The size of k-mers to use for sequence comparison (e.g., 31).
        *   `--threads`: Number of threads to use for parallel processing.

    *   **Example**:
        ```bash
        pantools build --sequences /path/to/genomes/ --output_dir ./pangenome_output --kmer_size 31 --threads 8
        ```

3.  **Pangenome Analysis**:
    *   Once the pangenome is built, you can perform various analyses using commands like `pantools analyze`.
    *   Common analyses include:
        *   **Core genome identification**: Identifying genes present in all or a high percentage of genomes.
        *   **Accessory genome identification**: Identifying genes present in a subset of genomes.
        *   **Phylogenetic tree construction**: Inferring evolutionary relationships based on the pangenome.

    *   **Example for analyzing gene presence/absence**:
        ```bash
        pantools analyze --input_dir ./pangenome_output --output_dir ./analysis_output --analysis gene_presence
        ```

4.  **Specific Analysis Modules**:
    *   PanTools may have specialized modules for specific tasks. Refer to the documentation for details on modules like `optimal_grouping`, `core_phylogeny`, or `panproteome`.

### Expert Tips and Best Practices

*   **K-mer Size Selection**: The choice of `kmer_size` is crucial. Smaller k-mers capture more variation but can be computationally intensive and prone to spurious matches. Larger k-mers are more specific but might miss smaller variations. Experiment with different sizes (e.g., 21, 31, 51) based on your data and research question.
*   **Resource Management**: Pangenome construction can be memory and CPU intensive. Utilize the `--threads` option to leverage multi-core processors. Monitor resource usage and adjust thread counts accordingly.
*   **Output Directory Structure**: PanTools often creates a structured output directory. Familiarize yourself with the generated files (e.g., gene presence/absence matrices, phylogenetic trees) to interpret the results effectively.
*   **Documentation Reference**: For detailed command options, specific analysis types, and advanced features, always consult the official PanTools documentation. The `CHANGELOG.md` and `README.md` files provide valuable insights into recent updates and core functionalities.
*   **Version Control**: Be mindful of the PanTools version you are using, as functionalities and command-line arguments can change between releases. Check the `CHANGELOG.md` for version-specific details.

## Reference documentation
- [PanTools README](./references/git_wur_nl_bioinformatics_pantools_-_blob_pantools_v4_README.md)
- [PanTools Changelog](./references/git_wur_nl_bioinformatics_pantools_-_blob_pantools_v4_CHANGELOG.md)