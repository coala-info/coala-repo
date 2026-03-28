---
name: conus
description: The conus tool analyzes RNA secondary structures by training and applying various stochastic context-free grammar models. Use when user asks to train probabilistic RNA models, predict secondary structures from sequences, or evaluate grammar performance and ambiguity.
homepage: http://eddylab.org/software/conus/
---

# conus

## Overview
The `conus` skill enables the analysis of RNA secondary structures through various SCFG designs. It provides a suite of tools to train probabilistic models on known RNA alignments, predict structures for new sequences, and evaluate the performance of different grammar architectures (e.g., G1-G8). This is particularly useful for researchers comparing grammar complexity against prediction accuracy.

## Core Workflows

### Model Training
Use `conus_train` to create a model file from a training dataset.
```bash
conus_train -g <GRAMMAR_CODE> -s <OUTPUT_MODEL>.mod <TRAINING_DATA>.stk
```
*   **Grammar Codes**: NUS (G1), YRN (G2), UNA (G3), RUN (G4), IVO (G5), BJK (G6), UYN (G7), RY3 (G8).
*   **Input**: Stockholm 1.0 formatted file.

### Structure Prediction (Folding)
Use `conus_fold` to predict the secondary structure of sequences using a trained model or a specific grammar.
```bash
conus_fold -q -w 2 -m <TRAINED_MODEL>.mod <INPUT_DATA>.stk > <OUTPUT>.stk
```
*   `-q`: Quiet mode.
*   `-w 2`: Standard window/algorithm setting for performance.
*   `-m`: Path to the trained `.mod` file.

### Evaluation and Comparison
Compare predicted structures against a trusted benchmark to calculate accuracy metrics.
```bash
conus_compare -w 2 -m <TRAINED_MODEL>.mod <BENCHMARK_DATA>.stk
```

### Ambiguity and Consistency Testing
*   **Ambiguity Test**: Verify if a grammar/model can uniquely or correctly parse sequences.
    ```bash
    ambtest -i -m <MODEL>.mod <DATA>.stk
    ```
*   **Plus One Check**: Verify grammar equivalence under a simple +1 scoring scheme.
    ```bash
    pocheck -m <MODEL>.mod <DATA>.stk
    ```

## Data Handling
CONUS uses a specific variation of the **Stockholm 1.0** format for single sequences.
*   **Structure Notation**: Uses `<` and `>` symbols where the brackets point toward each other to indicate base pairing.
*   **Utility Tools**:
    *   `weedamb`: Removes sequences containing ambiguous bases (N, R, Y, etc.).
    *   `stk2ct`: Converts Stockholm files to CT (Connect Table) format.
    *   `scheck`: Performs basic structural integrity validation.

## Expert Tips
*   **Grammar Selection**: For most general purposes, the `NUS` (G1) or `UNA` (G3) grammars provide a good balance of complexity and accuracy as described in the Dowell & Eddy (2004) reference.
*   **Data Cleaning**: Always run `weedamb` on new datasets before training, as CONUS tools are sensitive to ambiguous base calls.
*   **Post-Processing**: Predicted output often requires "wussification" (secondary structure notation cleanup) using external tools like `sreformat` before final comparison.



## Subcommands

| Command | Description |
|---------|-------------|
| ambtest | Test ambiguity in sequence models using a model file and sequence file. |
| conus_compare | Single Sequence SCFG algorithms for comparing test files. |
| conus_fold | Single Sequence SCFG algorithms for RNA structure prediction |
| conus_train | Single Sequence SCFG algorithms for training models |
| givect | A tool to process sequence files, likely converting or extracting vector information from sequence alignment files. |
| reorder | Reorder suboptimals for a sequence file using specified grammar or model parameters. |
| weedamb | Identify and optionally save ambiguous sequences from a sequence file. |

## Reference documentation
- [Software/Paper Guide](./references/eddylab_org_software_conus_paperguide.txt.md)
- [CONUS README](./references/eddylab_org_software_conus_README.md)
- [Installation Guide](./references/eddylab_org_software_conus_INSTALL.md)
- [Dataset Notes](./references/eddylab_org_software_conus_notes.txt.md)