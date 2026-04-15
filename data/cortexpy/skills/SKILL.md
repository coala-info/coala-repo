---
name: cortexpy
description: Cortexpy is a Python-based suite for inspecting, traversing, and converting colored De Bruijn graphs produced by Cortex and McCortex. Use when user asks to traverse assembly graphs, resolve branches using link information, or export graph data to JSON and GFA formats.
homepage: https://github.com/winni2k/cortexpy
metadata:
  docker_image: "quay.io/biocontainers/cortexpy:0.46.5--py38h9948957_6"
---

# cortexpy

## Overview

Cortexpy is a Python-based suite designed for bioinformaticians working with colored De Bruijn graphs produced by Cortex and McCortex. It mirrors many features of CortexJDK, providing a command-line interface to inspect graph headers, traverse paths using link information, and export graph data into interoperable formats like JSON and GFA. It is particularly useful for resolving assembly ambiguities and extracting specific subgraphs or paths for downstream analysis.

## Common CLI Patterns

### Graph Traversal
The primary utility of cortexpy is navigating the assembly graph.

*   **Basic Traversal**: Use the `traverse` command to follow paths in the graph.
*   **JSON Export**: To capture traversal data for custom analysis or visualization, use the `--to-json` flag:
    ```bash
    cortexpy traverse --to-json <graph_file>
    ```
*   **Link-Informed Traversal**: Leverage McCortex link files to guide the traversal through repetitive regions or to resolve branches in the De Bruijn graph.

### Visualization and Conversion
*   **Viewing Traversals**: Use the `view traversal` command to inspect or convert existing traversal files.
*   **GFA Support**: The tool supports GFA1.0. You can provide GFA files as input to the viewing commands to integrate with other graph-based assembly tools.

## Expert Tips

*   **Memory Management**: When working with large McCortex graphs, ensure your environment has sufficient memory, as graph manipulation can be resource-intensive.
*   **Format Interoperability**: Use the JSON output from `traverse` to bridge cortexpy with custom Python scripts or web-based visualizations.
*   **Feature Parity**: If you are familiar with CortexJDK, look for analogous commands in cortexpy, as it is designed to provide a similar functional experience within a Python ecosystem.

## Reference documentation
- [Cortexpy GitHub Repository](./references/github_com_winni2k_cortexpy.md)
- [Cortexpy Issues and Feature Requests](./references/github_com_winni2k_cortexpy_issues.md)
- [Bioconda Cortexpy Overview](./references/anaconda_org_channels_bioconda_packages_cortexpy_overview.md)