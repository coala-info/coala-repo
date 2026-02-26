---
name: cpinsim
description: "cpinsim simulates the formation of protein complexes based on constrained interaction networks and domain-specific dependencies. Use when user asks to simulate protein complex formation, model protein knockouts or overexpression, and analyze the impact of concentration perturbations on protein assemblies."
homepage: https://github.com/BiancaStoecker/cpinsim
---


# cpinsim

## Overview

cpinsim is a specialized simulation framework designed to model how protein complexes form in a cellular environment based on constrained interaction networks. Unlike simple interaction models, it accounts for domain-specific constraints and dependencies. Use this skill to execute simulations of complex formation, prepare interaction data through domain annotation, and perform "what-if" analyses by perturbing protein levels to observe changes in the resulting protein assemblies.

## Installation and Setup

The preferred method for using cpinsim is via Bioconda to ensure all dependencies (networkx, scipy, bitarray) are correctly managed.

```bash
conda create -n cpinsim -c bioconda cpinsim
source activate cpinsim
```

## Command Line Usage

The primary interface for the tool is the `cpinsim` command, specifically the `simulate` sub-command.

### Basic Simulation
To simulate complex formation with a specific number of copies for each protein:

```bash
cpinsim simulate <input_file.csv> -n 100 -og simulated_graph.gz -ol simulation.log
```
- `-n`: Number of copies per protein.
- `-og`: Path to save the resulting simulated graph (gzipped pickle).
- `-ol`: Path to save the simulation log.

### Simulating Perturbations
You can model the biological impact of protein concentration changes using the `-p` flag followed by the protein name and a multiplier.

- **Knockout (KO):** Set the multiplier to 0.
- **Overexpression:** Set the multiplier to a value greater than 1.

```bash
# Knockout FYN and overexpress ABL1 by 5x
cpinsim simulate input.csv -n 100 -p FYN 0 -p ABL1 5 -og output.gz
```

## Processing Results

The output graph (`-og`) is a gzipped Python pickle containing a NetworkX graph object. Each connected component in this graph represents a formed protein complex.

### Result Extraction Script
To analyze the complexes, use the following Python pattern:

```python
import pickle, gzip
import networkx as nx

with gzip.open("simulated_graph.gz", "rb") as f:
    graph = pickle.load(f)

# Extract complexes as subgraphs, sorted by size
complexes = sorted(list(nx.connected_component_subgraphs(graph)), key=len, reverse=True)

# Access protein names within a complex
for c in complexes[:5]:
    print([c.node[node]["name"] for node in c])
```

## Best Practices

- **Data Preprocessing:** Before simulation, ensure interactions are annotated with domains. cpinsim can infer domains from known data or assign unique artificial domains to satisfy the constraint logic.
- **Input Format:** The tool expects a protein-wise text representation. If starting from raw interaction lists, use the cpinsim parser to generate the required input format.
- **Scaling:** Start with a lower number of copies (`-n`) to validate the network logic before running large-scale simulations, as computational complexity increases with the number of protein copies and interaction density.
- **Graph Analysis:** Since the output is a standard NetworkX object, you can leverage the full NetworkX API to calculate complex statistics, such as diameter, density, or specific motif distributions within the simulated assemblies.

## Reference documentation
- [CPINSim GitHub Repository](./references/github_com_BiancaStoecker_cpinsim.md)
- [CPINSim Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cpinsim_overview.md)