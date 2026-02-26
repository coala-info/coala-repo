---
name: barriers
description: The barriers tool identifies the hierarchical structure of local minima and saddle points within energy landscapes to visualize topology via barrier trees. Use when user asks to analyze RNA folding landscapes, identify local minima, generate rate matrices for kinetics simulations, or visualize landscape connectivity.
homepage: https://www.tbi.univie.ac.at/RNA/Barriers/
---


# barriers

## Overview
The `barriers` tool is a specialized utility for landscape analysis. It processes a list of states—sorted by energy—to identify the hierarchical structure of local minima and the energy heights that separate them. While primarily used in bioinformatics for RNA folding landscapes, it supports various configuration spaces including Hamming graphs and permutations. It is essential for researchers needing to visualize landscape topology via barrier trees or generate rate matrices for kinetics simulations (e.g., with `treekin`).

## Core CLI Patterns

### Basic RNA Landscape Analysis
The most common workflow involves piping energy-sorted structures from `RNAsubopt` into `barriers`.
```bash
RNAsubopt -e 10 -s < input.fa | barriers [OPTIONS]
```
*Note: The input must be sorted by energy (lowest to highest). `RNAsubopt -s` handles this automatically.*

### Common Configuration Options
- **Limit Minima**: Use `--max <int>` to restrict output to the lowest N local minima (default is 100).
- **Filter by Barrier Height**: Use `--minh <delta>` to ignore "shallow" minima with a barrier height less than delta.
- **Saddle Points**: Add `--saddle` to include the specific conformation of the saddle point connecting basins.
- **Basin Sizes**: Use `--bsize` to output the number of states belonging to each local minimum's basin.

### Transition Rate Generation
To prepare data for kinetic folding simulations:
```bash
barriers --rates --temp 37.0 < sorted_conformations.txt
```
This generates `rates.out` (ASCII) and `rates.bin` (binary), which are the standard inputs for the `treekin` program.

### Graph and Move Set Selection
If working with non-standard landscapes, specify the graph type:
- **RNA (Default)**: `-G RNA`. Note that since version 1.7.0, "noShift" is the default. Use `-M Shift` to include shift moves.
- **Canonical RNA**: `-G RNA-noLP` (no lonely pairs).
- **Spin Glass**: `-G Q2` (binary strings).
- **Permutations**: `-G P` (comma-separated lists).

## Expert Tips
- **Memory Management**: For very long sequences or large landscapes, `barriers` requires significant RAM for its hash table. If you encounter memory errors, the tool may need to be recompiled with a higher `--with-hash-bits` value.
- **Connected Components**: If your landscape is fragmented, use `--connected` to restrict analysis to the component containing the global minimum. This is often required to ensure the resulting rate matrix is ergodic for kinetics.
- **Structure Mapping**: Use `--mapstruc <filename>` to take an external list of conformations and determine which basin in the previously computed tree they belong to.
- **Visualizing Results**: The tool automatically produces `tree.ps`. This PostScript file represents the barrier tree (or "connectivity tree") where leaves are local minima and internal nodes are saddle points.

## Reference documentation
- [Barriers Manpage](./references/www_tbi_univie_ac_at_RNA_Barriers_barriers.1.html.md)
- [Barriers Documentation](./references/www_tbi_univie_ac_at_RNA_Barriers_documentation.html.md)
- [Barriers Changelog](./references/www_tbi_univie_ac_at_RNA_Barriers_changelog.html.md)