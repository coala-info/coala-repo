---
name: pourrna
description: pourRNA maps the energy landscape of an RNA sequence by identifying local minima and calculating transition rates between structures. Use when user asks to map RNA energy landscapes, identify representative structures, calculate thermodynamic equilibrium densities, or generate transition rate matrices for kinetic simulations.
homepage: https://github.com/ViennaRNA/pourRNA
---


# pourrna

## Overview

The `pourRNA` tool is a specialized utility within the ViennaRNA ecosystem designed to map the energy landscape of a given RNA sequence. Unlike exhaustive state-space explorers, it utilizes efficient local flooding techniques and heuristics to identify representative structures (local minima) and the transition rates between them. It is particularly useful for researchers needing to understand the dynamic folding behavior of RNA or to calculate thermodynamic equilibrium densities without simulating every possible configuration.

## Basic Usage

The tool accepts RNA sequences via standard input or direct command-line arguments.

### Input Methods
- **FASTA Input**:
  `cat rna.fasta | pourRNA`
- **Direct Sequence**:
  `pourRNA --sequence="CUAGUUAGGAACGGAAUUAAUUAGGAAAAAGCUGAUUAG"`

### Core Parameters
- `--max-threads=N`: Distributes the flooding of basins across multiple CPU cores to speed up computation.
- `--max-energy=VALUE`: Sets an absolute energy threshold for exploration.
- `--help`: Displays all available parameters, including micro-state filters.

## Common CLI Patterns

### Extracting Thermodynamic Equilibrium
If you only require the final equilibrium state of the Markov process:
`cat rna.fasta | pourRNA | grep "Equilibrium Densities:" -A1`

### Generating Barriers-Compatible Output
To use downstream tools like `treekin` for kinetic simulations, you must generate output in the "barriers" format:
`cat rna.fasta | pourRNA --barriers-like-output=output_prefix`

This command generates:
- `output_prefix_states.out`: List of local minima and their energies.
- `output_prefix_rates.out`: Transition rate matrix.

### Kinetic Folding Workflow
To visualize the folding process over time:
1. **Generate rates**: `cat rna.fasta | pourRNA --barriers-like-output=rna_barriers`
2. **Identify start state**: Find the index of the open chain or specific structure in `rna_barriers_states.out`.
3. **Run treekin**: `cat rna_barriers_rates.out | treekin -m I --bar=rna_barriers_states.out --p0 <index>=1.0 > treekin.out`
4. **Visualize**: Use `gracebat` or the provided R scripts in the `scripts/` directory to plot the population densities.

## Expert Tips

### Comparison with 'barriers'
To ensure `pourRNA` results match the classic `barriers` tool:
- Set `--minh 0` in `barriers`.
- Use `--max-energy` in `pourRNA` (absolute value) and `-e` in `RNAsubopt` (relative value) to cover the same state space.
- Note that `pourRNA` and `barriers` may calculate the diagonal of the rate matrix differently; however, tools like `treekin` typically recompute the diagonal automatically.

### Performance Tuning
For long sequences, the state space grows exponentially. Use `--max-basins` (formerly dynamic minh) to limit the number of explored gradient basins and prevent memory exhaustion while maintaining a representative view of the landscape.

## Reference documentation
- [pourRNA README](./references/github_com_ViennaRNA_pourRNA.md)
- [Commit History (Feature Updates)](./references/github_com_ViennaRNA_pourRNA_commits_master.md)