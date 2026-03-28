---
name: rnastructure
description: RNAstructure models nucleic acid secondary structures, calculates base pairing probabilities, and predicts bimolecular interactions for RNA and DNA sequences. Use when user asks to predict secondary structures, incorporate SHAPE experimental data, calculate partition functions, model bimolecular folding, or find consensus structures for unaligned sequences.
homepage: http://rna.urmc.rochester.edu/RNAstructure.html
---

# rnastructure

## Overview
This skill provides guidance for using the RNAstructure software package to model nucleic acid folding. It enables the prediction of secondary structures for single or multiple unaligned sequences, determination of equilibrium binding affinities for oligonucleotides, and the refinement of models using experimental constraints. It is particularly useful for researchers designing RNA-based therapeutics or studying RNA regulatory elements where structural accuracy is paramount.

## Common CLI Patterns
RNAstructure consists of several distinct executable programs. Below are the most frequent usage patterns:

### Single Sequence Folding
To predict the lowest free energy structure and a set of low energy structures:
`Fold <input_sequence_file> <output_ct_file>`
*   Use `-m` or `--maximum` to specify the maximum number of structures generated.
*   Use `-p` or `--percent` to specify the maximum percent energy difference for suboptimal structures.

### Incorporating Experimental Data
To improve prediction accuracy using SHAPE data:
`Fold <input_seq> <output_ct> -sh <shape_file>`
*   The SHAPE file should contain sequence indices and normalized reactivity values.
*   Use `-si` and `-sm` to adjust the intercept and slope parameters for the SHAPE pseudo-energy term if necessary.

### Partition Function and Probabilities
To calculate the partition function and base pairing probabilities:
`partition <input_seq> <output_pfs_file>`
*   Follow this with `ProbabilityPlot <output_pfs_file> <output_plot_file>` to visualize pairing confidence.

### Bimolecular Folding (RNA-RNA or RNA-DNA)
To predict the structure of two interacting strands:
`bifold <seq_file_1> <seq_file_2> <output_ct>`
*   Useful for modeling antisense oligonucleotides or siRNA binding to a target.

### Consensus Structure Prediction
To find a common structure for two unaligned sequences (more accurate than single-sequence folding):
`Dynalign <seq_file_1> <seq_file_2> <output_ct>`

## Expert Tips
*   **File Formats**: Ensure input sequences are in FASTA or .seq format. Output .ct (Connectivity Table) files can be converted to dot-bracket notation using the `ct2dot` utility.
*   **Temperature Scaling**: Use the `-t` or `--temperature` flag to perform calculations at temperatures other than the default 310.15 K (37°C).
*   **Constraint Files**: For known structural features, use a constraint file (.con) with the `-c` flag to force or prohibit specific base pairs.
*   **Memory Management**: For very long sequences (>3000 nucleotides), the memory requirements for `partition` and `Fold` increase quadratically; ensure your environment has sufficient RAM or use the `MaxDistance` constraint to limit the span of base pairs.



## Subcommands

| Command | Description |
|---------|-------------|
| Fold | Predicts the secondary structure of a nucleic acid sequence using the RNAstructure library. |
| ProbabilityPlot | Generates plots from base pairing probability data. |
| bifold | Calculates the secondary structure of two RNA or DNA sequences. |
| ct2dot | Convert a CT structure file to dot-bracket format. |
| partition | Partition function calculation for RNA/DNA sequences. |

## Reference documentation
- [RNAstructure Software Overview](./references/rna_urmc_rochester_edu_RNAstructure.html.md)
- [Bioconda RNAstructure Package](./references/anaconda_org_channels_bioconda_packages_rnastructure_overview.md)