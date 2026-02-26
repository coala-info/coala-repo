---
name: 2pg_cartesian
description: 2pg_cartesian is an evolutionary computation framework designed for protein structure prediction and structural biology optimization. Use when user asks to predict protein structures, renumber PDB residues, or prepare structural data from CASP submissions.
homepage: https://github.com/rodrigofaccioli/2pg_cartesian
---


# 2pg_cartesian

## Overview

2pg_cartesian is an evolutionary computation framework specifically tailored for physical biology and structural biology optimization. It is primarily used for Protein Structure Prediction (PSP) and was notably applied in CASP11 and WeFold2. The framework provides a set of C-based optimization algorithms and Python-based utility scripts to handle PDB file manipulation and structural preparation.

## Installation and Setup

The framework uses a standard CMake build system. To install:

1. Create a build directory: `mkdir build && cd build`
2. Configure with CMake: `cmake ..`
   - To specify a custom path: `cmake .. -DCMAKE_INSTALL_PREFIX=/your/path/`
3. Compile and install: `make && make install`

After installation, the `bin` and `scripts` directories will contain the executable tools and helper utilities.

## Utility Scripts and CLI Patterns

The framework includes several Python scripts in the `scripts/` directory for preprocessing structural data:

### PDB Preparation
- **Renumbering Residues**: Use `residue_renumber_all_pdbs.py` to standardize residue numbering across multiple PDB files.
- **CASP Processing**: Use `prepare_structures_from_casp_submit.py` to format and prepare structural data from CASP submission formats for use within the 2pg_cartesian optimization pipeline.

### Evolutionary Parameters
While specific binary flags are determined by the built optimization algorithm, the framework logic typically involves:
- **Crossover**: Supports 1-point crossover (`1_crossover_Point`).
- **Mutations**: Mutation rates are typically handled within the `apply_mutation` function; ensure input angles are in radians as the framework defaults to radian-based calculations for dihedral rotations.
- **Objective Functions**: Objectives are generally stored in output files rather than displayed in real-time to optimize performance during large-scale evolutionary runs.

## Best Practices

- **PDB Formatting**: Ensure PDB files are strictly formatted. The framework has known sensitivities to PDB file format variations (refer to Issue #2 in the repository).
- **Coordinate System**: The tool operates in Cartesian space for structural manipulations.
- **Multi-Objective Optimization**: The framework includes DIMO (Distributed Multi-Objective) support for complex optimization landscapes.
- **Memory Management**: When running large populations in evolutionary algorithms, monitor memory allocation, as the framework uses C-based memory management for the core optimization engine.

## Reference documentation
- [GitHub README](./references/github_com_rodrigofaccioli_2pg_cartesian.md)
- [Commit History and Script Names](./references/github_com_rodrigofaccioli_2pg_cartesian_commits_master.md)