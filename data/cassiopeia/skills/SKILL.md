---
name: cassiopeia
description: Cassiopeia is a computational pipeline for processing single-cell lineage tracing data and reconstructing cellular phylogenies. Use when user asks to align sequences, generate molecule tables, reconstruct phylogenetic trees using various solvers, or simulate Cas9 mutation processes.
homepage: https://github.com/YosefLab/Cassiopeia
metadata:
  docker_image: "quay.io/biocontainers/cassiopeia:2.0.0--py311h93dcfea_2"
---

# cassiopeia

## Overview
Cassiopeia is an end-to-end computational pipeline designed for single-cell lineage tracing. It manages the complex workflow of transforming raw fastq files into reconstructed cellular phylogenies. The tool is modular, allowing users to perform preprocessing (alignment and molecule integration), tree reconstruction using various algorithmic solvers (e.g., ILP, Neighbor-Joining), and downstream analysis including tree plotting and benchmarking via simulation.

## Installation and Setup
To use the latest features, install directly from the master branch:
```bash
pip install git+https://github.com/YosefLab/Cassiopeia@master#egg=cassiopeia-lineage
```

### Optional Dependencies
*   **Gurobi**: Required for the `CassiopeiaILP` solver. Ensure `gurobi.sh` is in your path.
*   **CCPhylo**: Required for high-performance Neighbor-Joining and UPGMA. Requires a `config.ini` in your cassiopeia directory pointing to the CCPhylo path.
*   **Spatial Tools**: Install with `pip install .[spatial]` for analyzing spatial lineage tracing datasets.

## Core Workflow Patterns

### 1. Preprocessing (cas.pp)
The preprocessing module handles the conversion of raw reads into a molecule table.
*   **Sequence Alignment**: Use `cas.pp.align_sequences` to align reads to the target scaffold.
*   **Molecule Table**: Generate a table that summarizes the observed mutations (indels) for each cell and integration barcode (intBC).

### 2. Tree Reconstruction (cas.solver)
Cassiopeia supports multiple solvers depending on the scale and nature of the data:
*   **CassiopeiaILP**: Best for small, high-accuracy trees (requires Gurobi).
*   **NeighborJoiningSolver / UPGMASolver**: Faster alternatives for larger datasets.
*   **MaxCutSolver / SpectralSolver**: Heuristic approaches for complex topologies.

Example Python pattern:
```python
import cassiopeia as cas

# Initialize a solver
solver = cas.solver.NeighborJoiningSolver(dissimilarity_function=cas.solver.dissimilarity.weighted_hamming)

# Reconstruct the tree from a CassiopeiaTree object
solver.solve(cas_tree)
```

### 3. Simulation (cas.sim)
Use the simulation module to generate ground-truth trees for benchmarking new algorithms or experimental designs.
*   `cas.sim.Cas9LineageTracingSimulator`: Simulates the Cas9 mutation process over a given tree topology.

### 4. Visualization (cas.pl)
Visualize reconstructed trees with metadata overlays:
*   Use the local plotting library to generate trees where branch colors represent specific lineages or mutation patterns.

## Expert Tips
*   **Python Version**: Ensure you are using Python >= 3.10. Support for 3.9 and below is not guaranteed due to dependency constraints, especially for spatial and 3D visualization features.
*   **Memory Management**: For very large datasets, prefer the `CCPhylo` integrated solvers to reduce the memory footprint of distance matrix calculations.
*   **Validation**: Always run `pytest` after installation to ensure the Cython extensions and solvers are correctly compiled and linked.

## Reference documentation
- [Cassiopeia GitHub Repository](./references/github_com_YosefLab_Cassiopeia.md)
- [Bioconda Cassiopeia Overview](./references/anaconda_org_channels_bioconda_packages_cassiopeia_overview.md)