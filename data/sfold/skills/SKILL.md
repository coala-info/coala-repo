---
name: sfold
description: Performs statistical folding of nucleic acids to predict secondary structures. Use when user asks to predict nucleic acid secondary structures.
homepage: https://github.com/Ding-RNA-Lab/Sfold
metadata:
  docker_image: "quay.io/biocontainers/sfold:2.2--pl5321r44h7b50bb2_4"
---

# sfold

sfold/
├── SKILL.md
└── references/
    └── RUNNING_SFOLD.md
```

sfold/SKILL.md:
```yaml
name: sfold
description: |
  Performs statistical folding of nucleic acids to predict secondary structures.
  Use when you need to analyze RNA or DNA sequences for their structural properties,
  predict folding patterns, or identify potential binding sites. This skill is
  particularly useful for researchers in molecular biology and bioinformatics.
```
## Overview
The sfold tool is designed for the statistical folding of nucleic acids, enabling the prediction of secondary structures. It's a valuable resource for researchers needing to analyze RNA and DNA sequences, understand their folding patterns, and identify potential interaction sites.

## Usage Instructions

sfold is a command-line tool. The primary executable is `sfold`.

### Basic Usage

The most common way to use sfold is by providing an input sequence file.

```bash
sfold -i <input_sequence_file> -o <output_file> [options]
```

- `-i <input_sequence_file>`: Specifies the input file containing the nucleic acid sequence(s). The file should be in FASTA format.
- `-o <output_file>`: Specifies the output file where the predicted secondary structures and associated information will be saved.

### Key Options and Parameters

Consult the `RUNNING_SFOLD` document for a comprehensive list of options and detailed explanations. Here are some commonly used parameters:

*   **`-t <temperature>`**: Set the folding temperature. Default is 37.0.
*   **`-n <num_structures>`**: Specify the number of structures to predict.
*   **`-p <prob_threshold>`**: Set the probability threshold for reporting base pairs.
*   **`-m <mode>`**: Choose the prediction mode (e.g., 'Viterbi', 'Stochastic').
*   **`-s <seed>`**: Set the random seed for stochastic predictions.

### STarMir Sub-tool

The STarMir scripts are located in the `STarMir` subfolder and are used for binding site prediction and ranking. These programs typically run under Linux.

```bash
STarMir/starmir <options>
```

Refer to the `README` file within the `STarMir` directory for specific usage instructions for STarMir.

### Important Notes

*   sfold and its associated tools are primarily designed to run on Linux systems.
*   Always refer to the `RUNNING_SFOLD` file for the most up-to-date and detailed usage instructions, including installation and environment setup.

## Reference documentation
- [Running sfold](./references/RUNNING_SFOLD.md)