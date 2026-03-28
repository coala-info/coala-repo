---
name: spp-dcj
description: spp-dcj implements an Integer Linear Program algorithm to minimize genome rearrangement distances across a phylogeny for genomes with unique and duplicated markers. Use when user asks to generate ILP formulations for genome rearrangements, compute heuristic warm-starts for solvers, extract resolved ancestral adjacencies, or visualize predicted genomic adjacencies.
homepage: https://github.com/codialab/spp-dcj
---

# spp-dcj

## Overview
The `spp-dcj` tool implements an Integer Linear Program (ILP) based algorithm to minimize genome rearrangement distances across a phylogeny. It is specifically designed for "natural" genomes that include conserved, unique, and duplicated markers. The workflow typically involves generating an ILP formulation, optionally computing a heuristic warm-start, solving the optimization problem via Gurobi, and then extracting and visualizing the resolved ancestral adjacencies.

## Core Workflow and CLI Patterns

### 1. Input Preparation
Ensure your input files follow the required tabular formats:
- **Phylogeny (`tree.txt`)**: A two-column table: `#Child Parent`.
- **Adjacencies (`adjacencies.txt`)**: A seven-column table: `#Species Gene_1 Ext_1 Species Gene_2 Ext_2 Weight`.
- **ID Map (`idmap.txt`)**: Mapping of gene identifiers.

### 2. Generate the ILP
The primary step is creating the optimization model. The `-a` parameter controls the objective function weight (typically set to 1).

```bash
spp-dcj ilp -a 1 -m idmap.txt tree.txt adjacencies.txt > model.ilp
```

### 3. Heuristic Warm-Starting (Recommended)
For complex phylogenies, providing an initial feasible solution significantly speeds up the Gurobi solver.

```bash
spp-dcj heuristic -a 1 tree.txt adjacencies.txt idmap.txt > initial_sol.sol
```

### 4. Solving with Gurobi
`spp-dcj` relies on the external `gurobi_cl` solver. You must have Gurobi installed and licensed.

```bash
# With warm start
gurobi_cl InputFile=initial_sol.sol ResultFile=solution.sol model.ilp

# Without warm start
gurobi_cl ResultFile=solution.sol model.ilp
```

### 5. Extracting Results
Convert the solver's `.sol` output back into a readable adjacency format.

```bash
spp-dcj sol2adj solution.sol idmap.txt > resolved_adjacencies.txt
```

### 6. Visualization
Generate a PDF visualization comparing candidate and predicted adjacencies.

```bash
spp-dcj draw -i resolved_adjacencies.txt adjacencies.txt > visualization.pdf
```

## Expert Tips and Best Practices
- **Objective Weighting**: The `-a` parameter in `ilp` and `heuristic` commands balances the DCJ operations against indels. Adjust this if your biological model assumes a higher or lower cost for rearrangements relative to segment gains/losses.
- **Solver Performance**: If the ILP takes too long to converge, always ensure you are using the `heuristic` command to generate a warm start. Additionally, you can pass Gurobi-specific parameters (like `TimeLimit` or `MIPGap`) to `gurobi_cl` to get a "good enough" solution within a fixed timeframe.
- **Marker Uniquifying**: If your dataset uses specific separators between gene families and unique identifiers, use the appropriate parameters (if available in your version) to ensure markers are parsed correctly.
- **Dependency Check**: Ensure `networkx` and `matplotlib` are updated in your environment, as `spp-dcj draw` relies on these for graph processing and rendering.



## Subcommands

| Command | Description |
|---------|-------------|
| spp-dcj draw | Draws candidate adjacencies of the genomes in the phylogeny. |
| spp-dcj ilp | Solves the Double-Cut-and-Join problem using Integer Linear Programming. |
| spp-dcj newick2table | Converts a Newick tree to a table format. |
| spp-dcj sol2adj | Converts a GUROBI solution file to an adjacency list representation. |
| spp-dcj_heuristic | heuristic |

## Reference documentation
- [SPP-DCJ GitHub README](./references/github_com_codialab_spp-dcj_blob_main_README.md)
- [Project Configuration and Dependencies](./references/github_com_codialab_spp-dcj_blob_main_pyproject.toml.md)