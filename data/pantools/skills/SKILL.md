---
name: pantools
description: PanTools is a bioinformatics framework that uses a Neo4j graph database to construct and analyze large-scale pangenomes. Use when user asks to build a pangenome, perform phylogenomic reconstruction, run k-mer classification, or conduct comparative genomic analyses.
homepage: https://git.wur.nl/bioinformatics/pantools
metadata:
  docker_image: "quay.io/biocontainers/pantools:4.3.4--hdfd78af_0"
---

# pantools

## Overview
PanTools is a specialized bioinformatics framework designed for the construction and analysis of large-scale pangenomes. It utilizes a Neo4j graph database backend to store genomic information, allowing for efficient comparative analysis across hundreds or thousands of genomes. This skill provides guidance on using the PanTools command-line interface (CLI) for tasks such as k-mer classification, functional annotation, and phylogenomic reconstruction.

## Core Workflows and CLI Patterns

### Pangenome Construction
PanTools v4+ features an optimized pangenome construction process.
*   **Database Backend**: Ensure Neo4j is installed and configured, as PanTools relies on it for graph storage.
*   **Phased Genomes**: Use the specific functionalities added in v4.3.0 for working with haplotype-resolved (phased) genomes to maintain allelic variation.

### Phylogenomics and Alignment
*   **Core Phylogeny**: When running the `core_phylogeny` command, it is critical to use trimmed MSA results to ensure the accuracy of the resulting phylogenetic trees.
*   **MSA Sequence Order**: For `hmGroup MSA`, PanTools requires a consistent order of sequences to ensure reproducible results.
*   **Functional Consistency**: When adding TIGRFAM or PFAM entries, ensure that 'ID' and 'AC' fields are correctly mapped to the same Neo4j node to maintain database integrity.

### Comparative Search
*   **Panproteome BLAST**: You can run BLAST searches directly against the panproteome. Ensure you are not using pangenome-specific variables when the tool is set to panproteome mode.
*   **K-mer Classification**: Use k-mer classification for phenotype-based grouping, but be aware of potential crashes if phenotype data is improperly formatted.

## Expert Tips and Best Practices

### Environment and Dependencies
*   **KMC Versioning**: Avoid using KMC version 3.2.4 due to known compatibility issues. Use a stable version recommended in the PanTools documentation (typically 3.0.0 or higher, excluding 3.2.4).
*   **Memory Management**: For large-scale pangenomes, monitor Java heap space. If you encounter integer overflows in `optimal_grouping`, increase the `-Xms` and `-Xmx` parameters.
*   **Neo4j Connectivity**: Always verify that the Neo4j service is reachable before initiating graph-heavy commands.

### Data Integrity
*   **CIGAR Strings**: Verify CIGAR string consistency when working with mapped reads or alignments to prevent downstream errors in the graph structure.
*   **BUSCO Scores**: When analyzing pangenome completeness, check the `busco_scores` file output for consistency across different genome versions.



## Subcommands

| Command | Description |
|---------|-------------|
| pantools | Path to the database root directory. |
| pantools | A comprehensive suite of tools for pangenome analysis. |
| pantools | Path to the database root directory. |
| pantools | Path to the database root directory. |
| pantools | A command-line tool for pangenome analysis. |
| pantools | A command-line tool for pangenome analysis. |
| pantools | Path to the database root directory. |
| pantools deactivate_grouping | Deactivate the currently active homology grouping. |
| pantools remove_annotations | Remove all the genomic features that belong to annotations. |
| pantools remove_functions | Remove functional annotations from the pangenome. |
| pantools remove_grouping | Remove an homology grouping from the pangenome. |
| pantools remove_nodes | Remove a selection of nodes and their relationships from the pangenome. |
| pantools remove_phenotypes | Delete phenotype nodes or remove specific phenotype information from the nodes. |

## Reference documentation
- [PanTools Project Overview](./references/git_wur_nl_bioinformatics_pantools.md)
- [PanTools Changelog](./references/git_wur_nl_bioinformatics_pantools_-_blob_pantools_v4_CHANGELOG.md)
- [PanTools Releases and Version History](./references/git_wur_nl_bioinformatics_pantools_-_releases.md)