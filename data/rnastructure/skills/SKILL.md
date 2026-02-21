---
name: rnastructure
description: This skill provides guidance for utilizing the RNAstructure software suite to model nucleic acid folding.
homepage: http://rna.urmc.rochester.edu/RNAstructure.html
---

# rnastructure

## Overview
This skill provides guidance for utilizing the RNAstructure software suite to model nucleic acid folding. It enables the prediction of minimum free energy (MFE) structures, the generation of Boltzmann ensembles, and the identification of common structures between unaligned sequences. It is particularly effective when high-accuracy folding is required by integrating experimental constraints or when analyzing the equilibrium binding affinity of oligonucleotides to structured targets.

## Common CLI Patterns
The RNAstructure package consists of several distinct executable programs. Below are the primary tools and their typical usage patterns:

### Single Sequence Folding
Predict the secondary structure of a single RNA or DNA sequence.
- **Fold**: Predicts the lowest free energy structure and a set of low energy structures.
  - `Fold <input_sequence.fasta> <output_ct_file.ct>`
- **Partition**: Calculates the partition function, which is required for base pairing probabilities.
  - `partition <input_sequence.fasta> <pfs_file.pfs>`
- **ProbabilityPlot**: Generates a dot plot of base pairing probabilities from a partition function file.
  - `ProbabilityPlot <pfs_file.pfs> <output_plot.ps>`

### Bimolecular Folding and Binding
Analyze interactions between two sequences, such as siRNA or antisense oligonucleotides.
- **bifold**: Predicts the secondary structure of two sequences folding together.
  - `bifold <seq1.fasta> <seq2.fasta> <output.ct>`
- **Oligowalk**: Predicts the binding affinity of an oligonucleotide to a target RNA.
  - `Oligowalk <target.ct> <output_report.txt>`

### Comparative Analysis
Find common structures between two sequences without prior alignment.
- **Dynalign**: Predicts a common structure for two sequences and calculates their lowest free energy.
  - `dynalign <seq1.fasta> <seq2.fasta> <output.ct>`

### Experimental Constraints
Improve prediction accuracy by incorporating experimental data.
- **SHAPE Constraints**: Use the `-sh` or `--SHAPE` flag with `Fold` or `partition` to provide a file of SHAPE reactivities.
  - `Fold <seq.fasta> <out.ct> -sh <shape_data.txt>`
- **Constraint Files**: Use the `-c` flag to provide a constraint file (e.g., forcing or forbidding specific base pairs).

## Expert Tips
- **DNA vs. RNA**: By default, most tools assume RNA. Use the `-d` or `--DNA` flag when working with DNA sequences to ensure the correct thermodynamic parameters are applied.
- **Temperature**: If your experiment is not at the default 310.15 K (37°C), use the `-t` or `--temperature` flag to adjust the folding temperature.
- **CT Files**: The `.ct` (Connectivity Table) format is the standard output for structures. Use the `ct2dot` utility to convert these to the more common dot-bracket notation if needed for downstream tools.
- **Maximum Distance**: For very long sequences, you can limit the maximum distance between paired bases using the `-m` or `--maxdistance` flag to reduce computation time.

## Reference documentation
- [RNAstructure Overview](./references/rna_urmc_rochester_edu_RNAstructure.html.md)
- [Bioconda RNAstructure Package](./references/anaconda_org_channels_bioconda_packages_rnastructure_overview.md)