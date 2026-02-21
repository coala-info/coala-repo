---
name: mypmfs_py
description: The `mypmfs_py` package provides tools to generate statistical potentials from user-defined lists of protein structures.
homepage: https://github.com/bibip-impmc/mypmfs
---

# mypmfs_py

## Overview
The `mypmfs_py` package provides tools to generate statistical potentials from user-defined lists of protein structures. It is primarily used in structural biology to develop custom energy functions and to assess the quality of protein models. The toolset consists of two main components: `training`, which derives potentials from a training set of PDB files, and `scoring`, which applies those potentials to evaluate a query structure's pseudo-energy and statistical significance (Z-score).

## Command-Line Usage

### Training Potentials
The `training` command generates `.nrg` files (potentials) and statistics.

*   **Basic Training**:
    `training -l list.txt -d ./pdb_directory/ -o output_dir`
    *   `-l`: List of PDB codes (requires native structures).
    *   `-L`: List of filenames (use this for decoys or non-standard names).
    *   `-d`: Path to the directory containing PDB files.
    *   `-o`: Output directory for potentials and statistics.

*   **Advanced Training Options**:
    *   **Residue Representation (`-r`)**: Choose between `CA` (Carbon Alpha, default), `CB` (Carbon Beta), `allatom`, or `backbone`.
    *   **Kernel Density Estimation (KDE)**: Use `-k e` for Epanechnikov kernel and `-b SJ-dpi` for Sheather-Jones direct plug-in bandwidth selection.
    *   **Visualization**: Use `-p` to generate SVG plots of the potentials.
    *   **Reference State**: Use `-W` to train a reference state separately (creates `frequencies.ref`), and `-R` to load a specific reference state during potential training.

### Scoring Structures
The `scoring` command evaluates a protein structure against a set of trained potentials.

*   **Basic Scoring**:
    `scoring -i structure.pdb -d potentials_dir/`
    *   `-i`: Input PDB file to score.
    *   `-d`: Directory containing the trained `.nrg` files.

*   **Quality Assessment and Analysis**:
    *   **Z-score (`-z`)**: Calculate a Z-score to evaluate absolute structural quality. Combine with `-s <number>` (e.g., `-s 2000`) to define the number of random sequence decoys used for the calculation.
    *   **Interpolation (`-c`)**: Use cubic-interpolated potentials for smoother energy calculations.
    *   **Residue Range (`-q`)**: Score only specific residues (e.g., `-q 10A,11A,12A`).
    *   **Detailed Output (`-w`)**: Write TSV files containing pseudo-energy per residue and per atomic pair. Use `-o` to specify the results directory.

## Expert Tips
*   **Dataset Statistics**: Training automatically generates `top_energies.tsv`, `top_occurrences.tsv`, and `top_distances.tsv`. Review these to understand the distribution and frequency of atomic pairs in your training set.
*   **Model Quality**: When evaluating models, a more negative Z-score indicates a better, more native-like structure.
*   **Representation Consistency**: Ensure the representation used in `scoring` matches the one used in `training`. The tool reads `parameters.log` in the potentials directory to maintain consistency by default.

## Reference documentation
- [MyPMFs GitHub Repository](./references/github_com_bibip-impmc_mypmfs.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_mypmfs_py_overview.md)