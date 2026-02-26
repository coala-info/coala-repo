---
name: dagchainer
description: DAGchainer identifies chains of gene pairs that share a conserved order between genomic regions to find syntenic blocks. Use when user asks to identify large-scale duplications, find orthologous regions between species, or visualize syntenic chains.
homepage: https://github.com/kullrich/dagchainer
---


# dagchainer

## Overview
DAGchainer is a specialized bioinformatics tool used to find chains of gene pairs that share a conserved order between genomic regions. By representing gene matches as nodes in a directed acyclic graph, the tool identifies the most significant syntenic blocks. It is a standard utility for comparative genomics, particularly for identifying large-scale duplications or orthologous regions between different species.

## Installation
The most reliable way to install dagchainer is via Bioconda:

```bash
conda install -c bioconda dagchainer
```

## Common CLI Patterns

### Running the Main Pipeline
The primary script for identifying syntenic blocks is `run_DAG_chainer.pl`. It requires a filtered match list of gene pairs as input.

**Basic execution:**
```bash
run_DAG_chainer.pl -i <input_match_list>
```

**Standard execution with common flags:**
```bash
run_DAG_chainer.pl -i <input_match_list> -s -I
```
*   `-i`: Path to the input match list file.
*   `-s`: Typically used to enable specific scoring or sorting heuristics.
*   `-I`: Often used to handle identity or specific filtering parameters.

### Output Files
The tool produces an `.aligncoords` file (e.g., `input_file.aligncoords`). This file contains the coordinates and gene pairs for the identified syntenic chains.

### Visualization
DAGchainer includes a Java-based plotter to visualize the syntenic regions identified in the `.aligncoords` file.

**Generate an XY plot:**
```bash
run_XYplot.pl <aligncoords_file>
```

## Best Practices
*   **Input Preparation**: Ensure your match list is pre-filtered for significance (e.g., BLAST E-values) before running DAGchainer to reduce noise in the graph.
*   **Path Configuration**: If running from a source installation, ensure the `bin` and `src` directories are in your PATH, or execute using the full path to the Perl scripts.
*   **Memory Management**: For very large genomes or dense match lists, ensure the environment has sufficient memory as the DAG construction can be resource-intensive.

## Reference documentation
- [DAGchainer GitHub Repository](./references/github_com_kullrich_dagchainer.md)
- [Bioconda DAGchainer Overview](./references/anaconda_org_channels_bioconda_packages_dagchainer_overview.md)