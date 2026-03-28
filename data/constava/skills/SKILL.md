---
name: constava
description: Constava quantifies protein residue conformational state propensities and variability within structural ensembles by analyzing backbone dihedral angles. Use when user asks to extract backbone dihedrals, analyze ensemble conformational states, or generate custom structural models.
homepage: https://github.com/bio2byte/constava
---

# constava

## Overview

Constava is a specialized tool for structural biology that quantifies the behavior of protein residues within a structural ensemble. It operates by analyzing backbone dihedral angles (phi and psi) against statistical models derived from NMR data and chemical shifts. The tool provides two primary metrics:
1. **Conformational State Propensities**: The probability that a residue exists in a specific structural state.
2. **Conformational State Variability**: A measure of a residue's flexibility or its capacity to shift between different states.

This skill provides guidance on using the `constava` command-line interface to process trajectories, perform ensemble analysis, and manage conformational state models.

## CLI Usage and Patterns

### 1. Extracting Dihedrals
Before analysis, you must extract phi and psi angles. Constava supports various MD and structure formats.

```bash
# Extract dihedrals from a structure or trajectory file
constava dihedrals --input protein_ensemble.pdb --output dihedrals.csv
```

*Note: You can also use GROMACS `gmx chi` with the `--input-format=xvg` flag if you already have GROMACS-processed data.*

### 2. Analyzing the Ensemble
Once dihedrals are extracted, run the core analysis to get propensities and variability.

```bash
# Standard analysis using default models
constava analyze --input dihedrals.csv --output_dir ./results/
```

### 3. Custom Model Generation
If the default NMR-based models are not suitable for your specific protein type, you can generate custom conformational state models.

```bash
# Generate a custom model from a specific dataset
constava model-gen --input training_data.csv --output custom_model.pkl
```

### 4. Verification
Always verify your installation and environment before running long-duration ensemble analyses.

```bash
# Run internal tests
constava test
```

## Expert Tips

- **Input Formats**: While PDB is common, the `dihedrals` submodule is designed to handle a wide range of trajectory formats. If working with large MD trajectories, ensure you have the necessary dependencies (like MDAnalysis or MDTraj) installed in the environment where `constava` is running.
- **Library Integration**: For complex workflows, `constava` can be imported as a Python library. This is preferred when you need to manipulate the dihedrals DataFrame directly before calculating propensities.
- **Residue Mapping**: Ensure your input dihedral file correctly maps residue numbers to the sequence, especially when comparing ensembles from different sources (e.g., AlphaFold ensembles vs. Experimental NMR).



## Subcommands

| Command | Description |
|---------|-------------|
| constava analyze | The `constava analyze` submodule analyzes the provided backbone dihedral angles and infers the propensities for each residue to reside in a given conformational state. |
| constava dihedrals | The `constava dihedrals` submodule is used to extract the backbone dihedrals needed for the analysis from conformational ensembles. By default the results are written out in radians as this is the preferred format for `constava analyze`. |
| constava fit-model | The `constava fit-model` submodule is used to generate the probabilistic conformational state models used in the analysis. By default, when running `constava analyze` these models are generated on-the-fly. In selected cases generating a model beforehand and loading it can be useful, though. |
| constava test | The `constava test` submodule runs a couple of test cases to check, if consistent results are achieved. This should be done once after installation and takes about a minute. |

## Reference documentation
- [Constava README](./references/github_com_Bio2Byte_constava_blob_main_README.md)
- [Constava Repository Overview](./references/github_com_Bio2Byte_constava.md)