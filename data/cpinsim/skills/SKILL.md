---
name: cpinsim
description: CPINSim models the stochastic assembly of protein complexes by accounting for domain-level constraints and competition. Use when user asks to simulate protein complex formation, model protein knockouts or overexpression, and analyze the composition of the cellular interactome.
homepage: https://github.com/BiancaStoecker/cpinsim
metadata:
  docker_image: "quay.io/biocontainers/cpinsim:0.5.2--py36_1"
---

# cpinsim

## Overview

CPINSim (Constrained Protein Interaction Networks Simulator) is a computational tool designed to model the stochastic assembly of protein complexes. Unlike simple interaction models, CPINSim accounts for specific constraints—such as domain competition and availability—that dictate how proteins bind. It provides a full pipeline from annotating interactions with domains to simulating the final distribution of complexes. This tool is particularly valuable for researchers investigating how changes in protein concentration (perturbations) affect the overall topology and composition of the cellular interactome.

## Usage Guidelines

### Core Simulation Workflow

The primary command for running simulations is `cpinsim simulate`. This requires a preprocessed protein input file (typically a CSV representing the network).

**Basic Simulation Pattern:**
```bash
cpinsim simulate <input_file> -n <copies_per_protein> -og <output_graph.gz> -ol <log_file.log>
```
*   `-n`: Sets the initial number of copies for every protein in the simulation.
*   `-og`: Specifies the path for the resulting simulation graph (saved as a gzipped pickle file).
*   `-ol`: Specifies the path for the simulation log.

### Simulating Perturbations

CPINSim excels at "what-if" scenarios involving genetic or chemical changes to protein levels. Use the `-p` flag to define perturbations.

*   **Protein Knockout:** Set the factor to `0`.
    ```bash
    cpinsim simulate input.csv -n 100 -og output.gz -p GENE_NAME 0
    ```
*   **Protein Overexpression:** Set the factor to a value greater than `1`.
    ```bash
    cpinsim simulate input.csv -n 100 -og output.gz -p GENE_NAME 5
    ```
*   **Multiple Perturbations:** You can chain multiple `-p` flags to simulate complex phenotypes (e.g., double knockouts or a knockout combined with overexpression).

### Analyzing Results

The output graph (`-og`) is a gzipped Python pickle object containing a `networkx` graph. Each connected component in this graph represents a single protein complex.

To extract and inspect the results, use a Python script:
1.  Load the graph using `pickle` and `gzip`.
2.  Identify complexes using `networkx.connected_component_subgraphs(graph)`.
3.  Access protein names via the `"name"` attribute on the nodes.

### Best Practices
*   **Preprocessing:** Ensure interactions and constraints are properly annotated with domains before simulation. CPINSim provides internal methods to infer domains from known data or assign unique artificial domains where data is missing.
*   **Scaling:** Start with a smaller number of copies (`-n`) to verify the network logic before running large-scale simulations, as computational complexity increases with protein count and interaction density.
*   **Environment:** Since CPINSim relies on specific versions of `networkx` (1.11) and `bitarray`, it is highly recommended to run it within a dedicated Conda environment.



## Subcommands

| Command | Description |
|---------|-------------|
| cpinsim simulate | Simulates protein interaction networks. |
| cpinsim_annotate | Annotates interaction, competition, and allosteric effect files based on provided constraints and network information. |
| cpinsim_parse | Parse protein interaction data from various file formats. |

## Reference documentation
- [CPINSim README](./references/github_com_BiancaStoecker_cpinsim_blob_master_README.rst.md)
- [CPINSim Setup and Dependencies](./references/github_com_BiancaStoecker_cpinsim_blob_master_setup.py.md)