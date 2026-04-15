---
name: dligand2
description: DLIGAND2 estimates the binding affinity of protein-ligand complexes using a knowledge-based scoring function. Use when user asks to calculate binding energy, rank different ligands against a target protein, or evaluate docking poses.
homepage: https://github.com/sysu-yanglab/DLIGAND2
metadata:
  docker_image: "quay.io/biocontainers/dligand2:0.1.0--h9948957_5"
---

# dligand2

## Overview

DLIGAND2 is a specialized tool for estimating the binding affinity of protein-ligand complexes. It utilizes a distance-scaled, finite, ideal-gas reference (DFIRE) state to calculate a knowledge-based score. This method is effective for ranking different ligands against a target protein or evaluating various docking poses of the same ligand. The tool requires a protein structure in PDB format and a ligand structure in MOL2 format.

## Environment Setup

Before running the tool, you must set the `DATAPATH` environment variable so the executable can locate the required parameter files (`amino.mol2` and `dfire.2`).

```bash
export DATAPATH=/path/to/dligand2/bin/
```

## Command Line Usage

The tool provides two executable versions: `dligand2.intel` (optimized for Intel compilers) and `dligand2.gnu`.

### Basic Syntax
```bash
dligand2.intel -P <protein.pdb> -L <ligand.mol2>
```

### Options and Parameters
- `-P <file>`: Path to the protein file in **PDB** format.
- `-L <file>`: Path to the ligand file in **MOL2** format.
- `-etype <1|2>`: Selects the potential version based on protein atom typing:
    - `1`: Subdivides protein atoms into 167 atom types (more detailed).
    - `2`: Subdivides protein atoms into 13 atom types (coarser).
- `-s <file>`: Specify a custom reference state file (defaults to `dfire.2`).
- `-v`: Enable verbose output for detailed calculation logs.

## Common CLI Patterns

### Standard Affinity Prediction
To get a standard binding score using the default detailed atom typing:
```bash
dligand2.intel -etype 1 -P protein.pdb -L ligand.mol2
```

### Coarse-Grained Scoring
For a faster or less specific scoring run:
```bash
dligand2.intel -etype 2 -P protein.pdb -L ligand.mol2
```

## Expert Tips and Best Practices

- **File Preparation**: Ensure the ligand MOL2 file has correct atom types and charges, as knowledge-based potentials are sensitive to atom definitions.
- **Interpreting Results**: The output is a numerical value representing the binding energy. Lower (more negative) values typically indicate stronger predicted binding affinity.
- **Executable Choice**: If running on a system with Intel processors, `dligand2.intel` generally offers better performance than the GNU version.
- **Data Files**: If you encounter errors regarding missing `amino.mol2` or `dfire.2` files, verify that your `DATAPATH` points to the directory containing these specific assets.

## Reference documentation
- [DLIGAND2 GitHub Repository](./references/github_com_yuedongyang_DLIGAND2.md)
- [Bioconda dligand2 Package](./references/anaconda_org_channels_bioconda_packages_dligand2_overview.md)