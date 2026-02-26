---
name: constava
description: Constava performs statistical analysis of protein backbone dihedral angles to categorize residues into conformational states. Use when user asks to extract dihedral angles from structural ensembles, analyze conformational state propensities, or train custom probabilistic models for protein flexibility.
homepage: https://github.com/bio2byte/constava
---


# constava

## Overview
Constava is a specialized tool for the statistical analysis of protein backbone dihedrals (phi and psi angles). It transforms raw structural ensemble data into probabilistic insights, categorizing residues into six distinct states ranging from stable "Core" structures to high-dynamic "Surrounding" or "Turn" regions. It is particularly useful for researchers looking to move beyond simple RMSF/RMSD metrics to understand the specific conformational landscape of a protein.

## Core Workflow

The standard workflow consists of two primary steps: extracting dihedral angles and then analyzing them to infer state propensities.

### 1. Extracting Dihedrals
Use the `dihedrals` submodule to process structural files (PDB, GRO, XTC, TRR, etc.).

```bash
# Extract dihedrals from a PDB ensemble or MD trajectory
constava dihedrals -i input_ensemble.pdb -o dihedrals.csv
```

**Expert Tips:**
- If using GROMACS, you can alternatively use `gmx chi` with the `--input-format=xvg` flag to generate compatible input.
- Ensure your input ensemble contains enough frames to provide a statistically significant distribution of angles.

### 2. Analyzing Conformational States
Once you have the dihedral angles, use the `analyze` submodule to calculate propensities and variability.

```bash
# Analyze the extracted dihedrals using default models
constava analyze -i dihedrals.csv -o output_directory
```

**Output Interpretation:**
- **Propensity:** The probability (0 to 1) of a residue being in a specific state.
- **Variability:** A measure of the residue's flexibility and its tendency to switch between states.

### 3. Custom Model Fitting
If the default NMR-derived models are not suitable for your specific system, you can train a custom probabilistic model.

```bash
# Train a custom model based on specific dihedral data
constava fit-model -i training_dihedrals.csv -o custom_model.pkl
```

## Default Conformational States
Constava categorizes residues into these six predefined states:
1. **Core Helix**: Low dynamics, strictly alpha-helical.
2. **Surrounding Helix**: High dynamics, mostly alpha-helical.
3. **Core Sheet**: Low dynamics, strictly beta-sheet.
4. **Surrounding Sheet**: High dynamics, extended conformation.
5. **Turn**: High dynamics, mostly turn.
6. **Other**: High dynamics, mostly coil.

## Troubleshooting and Best Practices
- **Library Issues:** If you encounter `libtiff` errors on macOS/Linux, install the dependency via conda: `conda install libtiff`.
- **Input Validation:** Use `constava test` after installation to verify the environment is correctly configured.
- **Large Datasets:** For very large MD trajectories, consider pre-filtering or striding the frames to reduce the computational load during the `dihedrals` extraction phase.

## Reference documentation
- [Constava GitHub Repository](./references/github_com_Bio2Byte_constava.md)
- [Constava Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_constava_overview.md)