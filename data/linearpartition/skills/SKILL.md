---
name: linearpartition
description: LinearPartition is the first linear-time algorithm for calculating RNA folding partition functions and base-pairing probabilities.
homepage: https://github.com/LinearFold/LinearPartition
---

# linearpartition

## Overview
LinearPartition is the first linear-time algorithm for calculating RNA folding partition functions and base-pairing probabilities. By employing a beam search heuristic, it reduces the complexity from $O(n^3)$ to $O(n \cdot b^2)$ (where $b$ is the beam size), making it possible to analyze sequences with tens of thousands of nucleotides. Use this tool for high-throughput RNA structural analysis, ensemble free energy estimation, and generating probability matrices for downstream visualization or sampling.

## Installation and Setup
The tool is available via Bioconda or can be compiled from source:
- **Conda**: `conda install bioconda::linearpartition`
- **Source**: Run `make` in the repository root to generate the `linearpartition` executable.

## Common CLI Patterns

### Basic Partition Function Calculation
To calculate the ensemble free energy or log partition coefficient for a sequence:
```bash
echo "GCUUCUGAUGAGUCCGUGAGGACGAAACGGUGAAAGCCGC" | ./linearpartition -V --verbose
```
*Note: `-V` (or `--Vienna`) switches to the Vienna RNA thermodynamic parameters, which is generally preferred for biological accuracy.*

### Predicting Secondary Structures
LinearPartition supports two main types of structure prediction based on the partition function:

**1. MEA (Maximum Expected Accuracy) Structure:**
```bash
echo "SEQUENCE" | ./linearpartition -V -M -g 3.0
```
*Use `-g` (gamma) to control the trade-off between sensitivity and specificity.*

**2. ThreshKnot Structure (supports pseudoknots):**
```bash
echo "SEQUENCE" | ./linearpartition -V -T --threshold 0.3
```

### Generating Base-Pairing Probability (BPP) Matrices
To output the probability of every possible base pair to a file:
```bash
cat input.fasta | ./linearpartition --fasta -o output_bpp.txt -c 0.001
```
*The `-c` (cutoff) flag is critical for large sequences to prevent massive output files by only recording pairs above a specific probability threshold.*

### Evaluating a Specific Structure
To calculate the probability $p(y|x)$ of a specific structure $y$ given sequence $x$:
```bash
echo -ne "CCCAAAGGG" | ./linearpartition -V --evaly "(((...)))"
```

## Expert Tips and Best Practices
- **Beam Size Management**: The default beam size is 100. For very complex structures or when higher accuracy is needed, increase this using `-b`. Use `-b 0` for an infinite beam (exact calculation), though this reverts the complexity to cubic $O(n^3)$.
- **Input Formats**: The tool accepts raw sequences or FASTA files. When using FASTA, always include the `--fasta` flag.
- **SHAPE Data Integration**: If experimental SHAPE reactivity data is available, use the `--shape` flag (requires `-V` mode) to constrain the partition function calculation with empirical evidence.
- **Visualization**: 
    - Use `draw_bpp_plot` for circular plots (requires LaTeX).
    - Use `draw_heatmap` for matrix-style probability visualizations (requires Python with seaborn/matplotlib).

## Reference documentation
- [LinearPartition GitHub README](./references/github_com_LinearFold_LinearPartition.md)
- [Bioconda LinearPartition Overview](./references/anaconda_org_channels_bioconda_packages_linearpartition_overview.md)