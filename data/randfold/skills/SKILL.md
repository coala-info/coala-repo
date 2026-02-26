---
name: randfold
description: Randfold evaluates the statistical significance of RNA secondary structure stability by comparing the minimum free energy of a sequence to that of its shuffled counterparts. Use when user asks to calculate p-values for RNA folding stability, perform dinucleotide shuffling on sequences, or assess if a sequence has a significantly stable structure characteristic of a microRNA.
homepage: https://github.com/erbon7/randfold
---


# randfold

## Overview

The `randfold` skill enables the statistical evaluation of RNA secondary structure stability. While many RNA sequences can fold into structures, functional microRNAs (miRNAs) are characterized by having a folding energy that is significantly lower (more stable) than would be expected by chance for a sequence of the same nucleotide composition. This tool automates the process of generating shuffled sequences, calculating their MFEs using the ViennaRNA algorithm, and producing a p-value (probability) that indicates the significance of the original sequence's stability.

## Usage Instructions

### Command Syntax
The basic command structure for `randfold` is:
`randfold <method> <fasta_file> <number_of_randomizations>`

### Shuffling Methods
Choose a method based on the level of sequence composition preservation required:
- `-s`: Simple mononucleotide shuffling. Preserves only the base composition (A, C, G, U counts).
- `-d`: Dinucleotide shuffling. Preserves both base composition and dinucleotide frequencies. **This is the recommended method for microRNA analysis** to account for stacking energy biases.
- `-m`: Markov chain order 1 shuffling.

### Common CLI Patterns
- **Standard miRNA Analysis**: To test a sequence with 999 randomizations using dinucleotide shuffling:
  `randfold -d input_sequences.fasta 999`
- **High Sensitivity Testing**: For more precise p-values (e.g., to detect significance at the 0.001 level), increase the randomization count:
  `randfold -d input_sequences.fasta 9999`

### Interpreting Output
The tool outputs three tab-separated columns:
1. `sequence_name`: The ID from the FASTA header.
2. `mfe`: The minimum free energy of the original sequence (kcal/mol).
3. `probability`: The p-value.

**Expert Tip**: A probability value < 0.05 or < 0.01 is typically used as a threshold to indicate that the sequence has a "significantly" stable secondary structure characteristic of a functional miRNA precursor.

### Input Requirements
- Input files must be in FASTA format.
- Ensure the sequences are relatively short (pre-miRNA length, typically 60-120nt) for optimal performance and biological relevance.

## Reference documentation
- [randfold README](./references/github_com_erbon7_randfold.md)