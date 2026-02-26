---
name: spp-dcj
description: spp-dcj uses integer linear programming to reconstruct ancestral gene orders by minimizing rearrangement distances across a phylogeny. Use when user asks to find internal node gene orders, generate ILP formulations for genome rearrangements, or visualize ancestral adjacencies in natural genomes.
homepage: https://github.com/codialab/spp-dcj
---


# spp-dcj

## Overview
The `spp-dcj` tool implements an Integer Linear Programming (ILP) approach to find gene orders at internal nodes of a phylogeny that minimize the total rearrangement distance. It is specifically designed for "natural genomes" which may contain unique or duplicated markers. The workflow involves generating an ILP formulation, solving it using the Gurobi optimizer, and then processing the results back into biological adjacencies and visualizations.

## Core Workflow

### 1. Prepare Input Data
Ensure you have the following three files in tab-separated format:
- **Phylogeny (`tree.txt`)**: A table with columns `#Child` and `Parent`.
- **Adjacencies (`adjacencies.txt`)**: A table with columns `#Species`, `Gene_1`, `Ext_1`, `Species`, `Gene_2`, `Ext_2`, and `Weight`.
- **ID Map (`idmap.txt`)**: Mapping of gene identifiers.

### 2. Generate the ILP Formulation
Use the `ilp` command to create the mathematical model. The `-a` parameter controls the objective function weight (typically set to 1).
```bash
spp-dcj ilp -a 1 -m idmap.txt tree.txt adjacencies.txt > model.ilp
```

### 3. Heuristic Warm-Start (Optional)
For complex trees or large genomes, generate an initial solution to speed up the ILP solver.
```bash
spp-dcj heuristic -a 1 tree.txt adjacencies.txt idmap.txt > initial_sol.sol
```

### 4. Solve with Gurobi
Run the Gurobi command-line solver. This step requires `gurobi_cl` to be installed and licensed.
```bash
gurobi_cl InputFile=initial_sol.sol ResultFile=solution.sol model.ilp
```

### 5. Post-Processing and Visualization
Convert the solver's output back into a readable adjacency format and generate a PDF visualization.
```bash
# Extract adjacencies
spp-dcj sol2adj solution.sol idmap.txt > resolved_adjacencies.txt

# Visualize results
spp-dcj draw -i resolved_adjacencies.txt adjacencies.txt > visualization.pdf
```

## Expert Tips
- **Objective Function**: The `-a` parameter in `ilp` and `heuristic` commands is critical for balancing different types of rearrangement events. Consult the DCJ-indel model documentation if the default value of 1 does not suit your specific evolutionary assumptions.
- **Solver Performance**: If Gurobi takes too long to reach an optimal solution, consider using the `heuristic` command for a warm start or setting a time limit/MIP gap in Gurobi.
- **Natural Genomes**: Unlike tools restricted to unichromosomal or single-copy genomes, `spp-dcj` handles duplicated markers. Ensure your `adjacencies.txt` file correctly weights candidate adjacencies if multiple possibilities exist for duplicated genes.

## Reference documentation
- [SPP-DCJ GitHub Repository](./references/github_com_codialab_spp-dcj.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_spp-dcj_overview.md)