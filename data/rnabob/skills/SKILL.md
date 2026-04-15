---
name: rnabob
description: rnabob is a bioinformatics tool for RNA structure analysis and prediction. Use when user asks to predict RNA secondary structures, calculate thermodynamic stability, analyze structural motifs, or generate dot-bracket notation.
homepage: https://github.com/JPSieg/KertisThesis2021
metadata:
  docker_image: "quay.io/biocontainers/rnabob:2.2.1--h470a237_1"
---

# rnabob

yaml
name: rnabob
description: |
  A bioinformatics tool for RNA structure analysis and prediction.
  Use when Claude needs to perform tasks related to RNA secondary structure,
  including:
  - Predicting RNA secondary structures from sequences.
  - Calculating thermodynamic stability of RNA structures.
  - Analyzing RNA structural motifs.
  - Generating dot-bracket notation from sequences or structures.
```
## Overview
rnabob is a bioinformatics tool designed for the analysis and prediction of RNA secondary structures. It allows users to predict the most stable structures for RNA sequences, calculate their thermodynamic properties, and analyze structural features. This tool is particularly useful for researchers working with RNA sequences who need to understand their folding patterns and stability.

## Usage Instructions

rnabob is primarily a command-line tool. The core functionality revolves around predicting RNA secondary structures and analyzing their properties.

### Basic Structure Prediction

To predict the secondary structure of an RNA sequence, use the `predict` command.

**Command:**
```bash
rnabob predict <sequence> [options]
```

**Example:**
```bash
rnabob predict AUGCGUACGU
```

This will output the predicted secondary structure in dot-bracket notation.

### Thermodynamic Stability Calculation

rnabob can calculate the free energy of an RNA structure, which is a measure of its thermodynamic stability.

**Command:**
```bash
rnabob stability <sequence> [options]
```

**Example:**
```bash
rnabob stability AUGCGUACGU --model thermodynamic_model.txt
```
*Note: Replace `thermodynamic_model.txt` with the actual path to a thermodynamic model file if available and required for specific calculations.*

### Generating Dot-Bracket Notation

If you have a sequence and want to generate its dot-bracket representation, or if you have a structure and want to visualize it in dot-bracket format.

**Command:**
```bash
rnabob dotbracket <input> [options]
```
The `<input>` can be a sequence or a structure file.

**Example (from sequence):**
```bash
rnabob dotbracket AUGCGUACGU --output structure.db
```

### Common Options and Considerations

*   **Sequence Input**: Sequences should typically be provided as strings of valid RNA bases (A, U, G, C). Ensure correct formatting.
*   **Output**: By default, output is usually printed to standard output. Use redirection (`>`) to save to files.
*   **Thermodynamic Models**: For accurate thermodynamic calculations, specifying an appropriate model file might be necessary. Consult rnabob's documentation for available models or how to create custom ones.
*   **Help Command**: For a full list of commands and options, use the `--help` flag:
    ```bash
    rnabob --help
    rnabob predict --help
    ```

## Expert Tips

*   **Batch Processing**: For multiple sequences, consider scripting `rnabob` calls within a shell script to automate predictions and analyses.
*   **Thermodynamic Model Selection**: The choice of thermodynamic model can significantly impact stability predictions. If available, use models that are validated for the specific type of RNA or organism you are studying.
*   **Structure Validation**: Always visually inspect the predicted dot-bracket structures, especially for longer or more complex sequences, to ensure they are biologically plausible. Tools that visualize dot-bracket notation can be helpful here.

## Reference documentation
- [rnabob Overview](./references/anaconda_org_channels_bioconda_packages_rnabob_overview.md)