---
name: conus
description: CONUS is a toolkit for implementing and evaluating lightweight Stochastic Context-Free Grammars for RNA secondary structure prediction. Use when user asks to train RNA models from Stockholm files, predict secondary structures via CYK folding, or benchmark grammar performance against known datasets.
homepage: http://eddylab.org/software/conus/
---


# conus

## Overview
CONUS is a specialized toolkit for exploring and implementing lightweight Stochastic Context-Free Grammars (SCFG) for RNA secondary structure prediction. It allows researchers to evaluate different grammar designs (e.g., NUS, YRN, UNA) to understand how grammar complexity affects prediction accuracy. Use this skill to automate the training of RNA models from Stockholm files, predict structures via CYK folding, and perform benchmarking against known datasets.

## Core Workflows

### 1. Model Training
To create a trained model from a dataset of known RNA structures:
```bash
conus_train -g <GRAMMAR_CODE> -s <OUTPUT_MODEL>.mod <INPUT_DATA>.stk
```
*   **Grammar Codes**: Common options include `NUS` (G1), `YRN` (G2), `UNA` (G3), and `RUN` (G4).
*   **Input**: Must be in Stockholm 1.0 format.

### 2. Structure Prediction (Folding)
To predict the secondary structure of a sequence using a trained model:
```bash
conus_fold -q -w 2 -m <MODEL>.mod <INPUT>.stk > <OUTPUT>.stk
```
*   `-q`: Quiet mode (suppresses verbose output).
*   `-w 2`: Standard windowing/algorithm setting for performance.
*   **Post-processing**: Predicted structures often need "wussification" (formatting) for comparison tools:
    ```bash
    sreformat --wussify stockholm <OUTPUT>.stk > <FORMATTED_OUTPUT>.stk
    ```

### 3. Performance Evaluation
To compare predicted structures against a trusted benchmark:
```bash
conus_compare -w 2 -m <MODEL>.mod <BENCHMARK_DATA>.stk
```
Alternatively, use `compstruct` after folding to get detailed sensitivity and specificity metrics.

### 4. Ambiguity and Grammar Testing
*   **Ambiguity Testing**: Verify if a grammar can generate a specific sequence/structure pair:
    ```bash
    ambtest -i -m <MODEL>.mod <DATA>.stk
    ```
*   **Suboptimal Sampling**: Generate $N$ suboptimal structures to test grammar density:
    ```bash
    reorder -m <MODEL>.mod -b <N> <DATA>.stk
    ```

## Data Handling Tips
*   **Format**: CONUS uses Stockholm 1.0. Even for single sequences, it expects the `#=GC SS_cons` or `#=GR SS` markup for structure lines.
*   **Cleaning Data**: Use `weedamb` to remove sequences containing ambiguous bases (N, R, Y, etc.) which can interfere with certain SCFG calculations.
*   **Conversion**: Use `stk2ct` to convert CONUS Stockholm files into CT (Connect Table) files for use with other RNA visualization software.

## Reference documentation
- [CONUS Paper Guide](./references/eddylab_org_software_conus_paperguide.txt.md)
- [CONUS README](./references/eddylab_org_software_conus_README.md)
- [CONUS Installation](./references/eddylab_org_software_conus_INSTALL.md)
- [Usage Notes](./references/eddylab_org_software_conus_notes.txt.md)