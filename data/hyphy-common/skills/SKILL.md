---
name: hyphy-common
description: HyPhy is a comprehensive software suite designed for the analysis of genetic sequences using stochastic evolutionary models.
homepage: http://hyphy.org/
---

# hyphy-common

## Overview
HyPhy is a comprehensive software suite designed for the analysis of genetic sequences using stochastic evolutionary models. This skill enables the efficient execution of phylogenetic analyses to detect signatures of natural selection at the site, branch, or gene-wide level. It focuses on the modern HyPhy CLI (version 2.4+), which utilizes keyword arguments and provides JSON outputs compatible with the HyPhy Vision web-based visualizer.

## Core CLI Usage
The primary executable is `hyphy` (multi-threaded). For cluster environments, `HYPHYMPI` is used.

### Basic Command Structure
```bash
hyphy <method> --alignment <path_to_alignment> --tree <path_to_tree> [options]
```
*Note: If the tree is embedded in the alignment file (e.g., NEXUS or FASTA with trailing Newick), the `--tree` flag can be omitted.*

### Common Global Options
- `--code`: Genetic code (default is `Universal`). Options include `Vertebrate-mtDNA`, `Yeast-mtDNA`, etc.
- `--output`: Path to save the resulting JSON file.
- `-i`: Enables interactive mode for any parameters not specified via CLI flags.

## Selection Analysis Methods
Choose the method based on the specific evolutionary hypothesis being tested:

### 1. Gene-Wide Selection (BUSTED)
Tests if a gene has experienced positive selection at at least one site on at least one branch.
```bash
hyphy busted --alignment data.fna --tree data.tre --branches All
```

### 2. Branch-Specific Selection (aBSREL)
Identifies specific lineages that have experienced episodic diversifying selection.
```bash
hyphy absrel --alignment data.fna --tree data.tre --branches All
```

### 3. Site-Specific Selection
- **MEME**: Detects both pervasive and episodic selection at individual sites (Preferred for most site-level searches).
- **FEL**: Detects pervasive selection at sites (Best for small-to-medium datasets).
- **FUBAR**: Fast Bayesian approach for pervasive selection (Best for large datasets).
- **SLAC**: Approximate method for very large datasets.

Example for MEME:
```bash
hyphy meme --alignment data.fna --tree data.tre
```

### 4. Selection Pressure Comparison (RELAX)
Tests if selection pressure has been relaxed or intensified on a set of "test" branches compared to "reference" branches. Requires a labeled tree.
```bash
hyphy relax --alignment data.fna --tree labeled_data.tre --test TestLabel --reference ReferenceLabel
```

## Expert Tips & Best Practices
- **Recombination Screening**: Always run **GARD** before selection analyses. Recombination can cause false positives in selection detection.
- **Synonymous Rate Variation**: Ensure synonymous rate variation is enabled (default in most modern methods) to avoid biases in dN/dS estimation.
- **Tree Labeling**: Use the [Phylotree Widget](https://veg.github.io/phylotree.js/) to label branches for methods like BUSTED, aBSREL, or RELAX.
- **Visualization**: All CLI runs produce a `.json` file. Upload this file to [vision.hyphy.org](https://vision.hyphy.org) for interactive results exploration.
- **Resource Management**: HyPhy automatically detects available CPU cores. To limit cores, use environment variables or MPI-specific launchers (e.g., `mpirun -np 4 HYPHYMPI ...`).

## Reference documentation
- [HyPhy Methods Overview](./references/hyphy_org_methods_general.md)
- [Selection Methods Guide](./references/hyphy_org_methods_selection-methods.md)
- [CLI Tutorial](./references/hyphy_org_tutorials_CLI-tutorial.md)
- [Installation and Environment](./references/hyphy_org_installation.md)