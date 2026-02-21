---
name: examine
description: eXamine provides a set-oriented visualization for network modules.
homepage: https://github.com/AlBi-HHU/eXamine-stand-alone
---

# examine

## Overview
eXamine provides a set-oriented visualization for network modules. It transforms standard node-link diagrams by adding colored contours that group nodes sharing specific annotations. This is particularly useful for biological networks where nodes (e.g., proteins) belong to multiple functional categories (e.g., GO terms or KEGG pathways). The tool allows for an interactive exploration of how different annotations overlap within a network topology.

## Installation
The recommended way to install eXamine is via Conda:
```bash
conda install bioconda::examine
```

## Execution
Run the application using Java. The command must be executed from a directory that contains a `data-sets` folder.
```bash
java -jar eXamine.jar
```
To see available command-line options:
```bash
java -jar eXamine.jar --help
```

## Data Organization
eXamine automatically loads datasets from a `data-sets/` directory in the current working directory. Each dataset must have its own subfolder containing tab-separated files.

### Required File Formats
All files should be tab-separated values (TSV).

*   **Nodes (`*.nodes`)**: Defines the entities in the network.
    *   Columns: `Identifier`, `Symbol` (display name), `Score(s)` (visualized as node contours), `URL`.
*   **Links (`*.links`)**: Defines undirected edges between nodes.
    *   Columns: `NodeID1`, `NodeID2`.
*   **Annotations (`*.annotations`)**: Defines the sets or groups that nodes can belong to.
    *   Columns: `Identifier`, `Symbol`, `Category`, `Score`, `URL`.
*   **Memberships (`*.memberships`)**: Maps nodes to their respective annotations.
    *   Columns: `AnnotationID`, `NodeID`.

## Expert Tips
*   **The "Module" Requirement**: eXamine will not render any nodes unless they are associated with an annotation belonging to a category named `Module`. Ensure your `*.annotations` file includes at least one entry with `Module` as the Category.
*   **File Partitioning**: You can split data across multiple files of the same type (e.g., `part1.links` and `part2.links`) within the dataset folder to keep data organized.
*   **Global Identifiers**: Identifiers for nodes and annotations must be unique across the entire dataset. They are not scoped by individual files.
*   **Interactive Links**: The `URL` column in `.nodes` and `.annotations` enables interactive research; clicking an element in the GUI will open the specified link in the system's default web browser.
*   **Memory Management**: For very large networks, you may need to increase the Java heap size using the `-Xmx` flag (e.g., `java -Xmx4g -jar eXamine.jar`).

## Reference documentation
- [examine - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_examine_overview.md)
- [AlBi-HHU/eXamine-stand-alone GitHub Repository](./references/github_com_AlBi-HHU_eXamine-stand-alone.md)