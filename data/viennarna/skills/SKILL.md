---
name: viennarna
description: The ViennaRNA Package predicts RNA secondary structures using thermodynamic models. Use when user asks to 'predict RNA secondary structures', 'generate suboptimal structures', 'predict consensus structures for alignments', 'predict RNA-RNA interactions', or 'design RNA sequences'.
homepage: http://www.tbi.univie.ac.at/RNA/
---


# viennarna

## Overview

The ViennaRNA Package is the standard suite for computational RNA secondary structure analysis. It utilizes thermodynamic models to predict how RNA molecules fold. This skill enables the execution of core workflows including single-sequence folding, suboptimal structure generation, consensus folding for multiple sequence alignments, and inverse folding (sequence design). It is essential for bioinformatics tasks involving RNA stability, regulatory element identification, and structural biology.

## Core CLI Patterns

### Single Sequence Folding (RNAfold)
The primary tool for predicting MFE structures and base pair probabilities.
- **Basic MFE prediction**: `RNAfold < sequence.fa`
- **Partition function and dot plot**: `RNAfold -p < sequence.fa`
  - Generates a `.ps` file containing the base pair probability matrix.
- **Constraint folding**: `RNAfold -C < sequence_with_constraints.fa`
  - Use symbols like `.` (no constraint), `(` (paired), `)` (paired), or `x` (unpaired) in the input.

### Consensus Structure Prediction (RNAalifold)
Predicts a common structure for a set of aligned sequences.
- **Standard alignment folding**: `RNAalifold alignment.clustal`
- **Include ribosites/covariation**: `RNAalifold --color --aln`
  - Produces a color-coded alignment showing structural conservation.

### Suboptimal Folding (RNAsubopt)
Generates structures within a specific energy range of the MFE.
- **Energy range**: `RNAsubopt -e 5.0 < sequence.fa`
  - Lists all structures within 5 kcal/mol of the optimum.
- **Stochastic sampling**: `RNAsubopt -p 100 < sequence.fa`
  - Samples 100 structures from the Boltzmann ensemble.

### RNA-RNA Interactions (RNAcofold & RNAmultifold)
Predicts the hybridization of two or more RNA strands.
- **Dimer folding**: `RNAcofold < input.fa`
  - Input sequences must be separated by an ampersand (`&`).
- **Multi-strand complexes**: `RNAmultifold < input.fa`
  - Successor to RNAcofold for more than two strands.

### Local Folding (RNALfold)
Used for long sequences (e.g., whole genomes) where base pairs are restricted by distance.
- **Sliding window**: `RNALfold -L 150 < genome.fa`
  - Restricts the maximum base pair span to 150 nucleotides.

## Expert Tips and Best Practices

- **Temperature Adjustment**: By default, ViennaRNA uses 37°C. Use the `-T` flag (e.g., `-T 25`) to model folding at different temperatures, which is critical for environmental or experimental samples.
- **Dangling Ends**: Use `-d2` (the default in newer versions) to ensure all dangling end energies are treated properly in the partition function.
- **G-Quadruplexes**: For sequences rich in Guanine, enable G-quadruplex prediction using the `-g` or `--gquad` flag in `RNAfold`, `RNAalifold`, or `RNAeval`.
- **Energy Parameters**: If working with non-standard conditions or modified bases (like Inosine or Pseudouridine), ensure you are using version 2.6+ which supports modified base parameters via the `--paramFile` flag.
- **Visualization**: Use `RNAplot` to generate secondary structure layouts from the output of other tools. For example: `RNAplot < fold_output.txt`.

## Reference documentation

- [ViennaRNA Package Home](./references/www_tbi_univie_ac_at_RNA.md)
- [ViennaRNA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_viennarna_overview.md)